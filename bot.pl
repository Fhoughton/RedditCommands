use warnings;
use strict;
use Reddit::Client;
use Syntax::Keyword::Try;

#connect to reddit and get auth
my $reddit = Reddit::Client->new(
    user_agent => "Test script 1.0 by /u/myusername",
    client_id  => "CLIENT_ID",
    secret     => "SECRET",
    username   => "MYUSERNAME",
    password   => "MYPASSWORD",
);

my $subs      = "test";
my $postcount = 30;

#main loop, scan posts -> if new then check comments for request -> if request then search google and find results -> else add to viewed posts and wait 30 mins then repeat
for ( ; ; ) {
    my $posts = $reddit->get_links( subreddit => $subs, limit => $postcount );

    #loop through posts and process comments
    foreach my $post (@$posts) {
        my $link     = $post->get_web_url();
        my $comments = $post->get_comments( permalink => $link );
        foreach my $comment (@$comments) {
            try {
                #print $comment->{body} . "\n";
                if ( $comment->{body} =~ /!test/ ) {
                    print "command found!!!! - ";
                    print $comment->{body} . "\n";
                }
            }
            catch {

            }
        }
    }

    print "scanned posts, resting...";
    sleep 1800;    #sleep 30 mins (1800 secs)
}
