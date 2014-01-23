package DDG::Goodie::HelpLine;

use DDG::Goodie;

my @triggers = (
    'suicide',
    'suicide hotline',
    'kill myself',
    'suicidal thoughts',
    'end my life',
    'suicidal thoughts',
    'suicidal',
    'suicidal ideation',
    'i want to kill myself',
    'commit suicide',
    'suicide pills'
    'suicide pill',
    'suicide prevention',
    'kill myself',
);

triggers any => @triggers;

zci answer_type => 'helpline';

primary_example_queries 'suicide hotline';
description 'Checks if a query with the word "suicide" was made in the U.S. and returns a 24 hr suicide hotline.';
attribution github => ['https://github.com/conorfl', 'conorfl'],
twitter => '@areuhappylucia';
code_url 'https://github.com/duckduckgo/zeroclickinfo-goodies/blob/master/lib/DDG/Goodie/Helpline.pm';
topics 'everyday';
category 'special';
source 'https://en.wikipedia.org/wiki/List_of_suicide_crisis_lines';

my %helpline = (
    # http://www.lifeline.org.au/Get-Help/I-Need-Help-Now and http://www.kidshelp.com.au/grownups/about-this-site.php
    AU => '13 11 14 or 1800 55 1800 (kids)',
    # http://www.suicidepreventionlifeline.org/ and http://org.kidshelpphone.ca/en
    CA => '1-800-273-8255 or 1 800 668 6868 (kids)',
    # http://www.samaritans.org/how-we-can-help-you/contact-us
    IE => '1850 60 90 90',
    # http://www.lifeline.org.nz/corp_Home_378_2001.aspx
    NZ => '0800 543 354',
    # http://www.papyrus-uk.org/, http://www.samaritans.org/, and http://www.thecalmzone.net/help/helpline/helpline-nationwide/
    GB => '0800 068 41 41, 08457 90 90 90, or 0800 58 58 58',
    # http://www.suicidepreventionlifeline.org/
    US => '1-800-273-TALK (8255)',
);

handle query_lc => sub {
    my $query = shift;

    # Check if the query matches exatly the trigger word.
    my %suicide_phrases = map { $_ => 1 } @triggers;
    return unless exists $suicide_phrases{$query};

    # Display the result.
    return "24 Hour Suicide Hotline: $helpline{$loc->country_code}"
        if exists $helpline{$loc->country_code};
};

1;
