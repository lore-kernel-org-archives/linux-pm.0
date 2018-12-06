From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC/RFT][PATCH v6] cpuidle: New timer events oriented governor
 for tickless systems
Date: Thu, 6 Dec 2018 10:11:39 +0100
Message-ID: <CAJZ5v0gShT9yS7dcM=6wYGgXf8=N0-AVkD83n3HtZQv+z_OAmg@mail.gmail.com>
References: <001901d48881$29ea59d0$7dbf0d70$@net> <CAJZ5v0j6AEjztoFfpQAc3NgQ5JtsWgRqscoE_u1eespVM-Cnmw@mail.gmail.com>
 <006801d48cef$1d476e80$57d64b80$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <006801d48cef$1d476e80$57d64b80$@net>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Giovanni Gherdovich <ggherdovich@suse.cz>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Mel Gorman <mgorman@suse.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Dec 6, 2018 at 12:06 AM Doug Smythies <dsmythies@telus.net> wrote:
>
> On 2018.12.03 03:48 Rafael J. Wysocki wrote:
>
> >>> There is an additional issue where if idle state 0 is disabled (with the above suggested code patch),
> >>> idle state usage seems to fall to deeper states than idle state 1.
> >>> This is not the expected behaviour.
> >>
> >> No, it isn't.
> >>
> >>> Kernel 4.20-rc3 works as expected.
> >>> I have not figured this issue out yet, in the code.
> >>>
> >>> Example (1 minute per sample. Number of entries/exits per state):
> >>>     State 0     State 1     State 2     State 3     State 4    Watts
> >>>    28235143,         83,         26,         17,        837,  64.900
> >>>     5583238,     657079,    5884941,    8498552,   30986831,  62.433 << Transition sample, after idle state 0 disabled
> >>>           0,     793517,    7186099,   10559878,   38485721,  61.900 << ?? should have all gone into Idle state 1
> >>>           0,     795414,    7340703,   10553117,   38513456,  62.050
> >>>           0,     807028,    7288195,   10574113,   38523524,  62.167
> >>>           0,     814983,    7403534,   10575108,   38571228,  62.167
> >>>           0,     838302,    7747127,   10552289,   38556054,  62.183
> >>>     9664999,     544473,    4914512,    6942037,   25295361,  63.633 << Transition sample, after idle state 0 enabled
> >>>    27893504,         96,         40,          9,        912,  66.500
> >>>    26556343,         83,         29,          7,        814,  66.683
> >>>    27929227,         64,         20,         10,        931,  66.683
> >>
> >> I see.
> >>
> >> OK, I'll look into this too, thanks!
> >
> > This probably is the artifact of the fix for the teo_find_shallower_state()
> > issue.
> >
> > Anyway, I'm not able to reproduce this with the teo_find_shallower_state() issue
> > fixed differently.
>
> I am not able to reproduce with your teo_find_shallower_state(), or teo V 7,
> either. Everything is graceful now, as states are disabled:
> (10 seconds per sample. Number of entries/exits per state):
>
>     State 0     State 1     State 2     State 3     State 4    Watts
>           0,          6,          4,          1,        414,   3.700
>           2,          4,         30,          3,        578,   3.700  << No load
>      168619,         37,         39,          4,        480,   5.600  << Transition sample
>     4643618,         45,          8,          1,        137,  61.200  << All idle states enabled
>     4736227,         40,          3,          5,        111,  61.800
>     1888417,    4369314,         25,          2,         89,  62.000  << Transition sample
>           0,    7266864,          9,          0,          0,  62.200  << state 0 disabled
>           0,    7193372,          9,          0,          0,  62.700
>           0,    5539898,    1744007,          0,          0,  63.500  << Transition sample
>           0,          0,    8152956,          0,          0,  63.700  << states 0,1 disabled
>           0,          0,    8015151,          0,          0,  63.900
>           0,          0,    4146806,    6349619,          0,  63.000  << Transition sample
>           0,          0,          0,   13252144,          0,  61.600  << states 0,1,2 disabled
>           0,          0,          0,   13258313,          0,  61.800
>           0,          0,          0,   10417428,    1984451,  61.200  << Transition sample
>           0,          0,          0,          0,    9247172,  58.500  << states 0,1,2,3 disabled
>           0,          0,          0,          0,    9242657,  58.500
>           0,          0,          0,          0,    9233749,  58.600
>           0,          0,          0,          0,    9238444,  58.700
>           0,          0,          0,          0,    9236345,  58.600
>
> For reference, this is kernel 4.20-rc5 (with your other proposed patches):
>
>     State 0     State 1     State 2     State 3     State 4    Watts
>           0,          4,          8,          6,        426,   3.700
>     1592870,        279,        149,         96,        831,  21.800
>     5071279,        154,         25,          6,        105,  61.200
>     5095090,         78,         21,          1,         86,  61.800
>     5001493,         94,         30,          4,        101,  62.200
>      616019,    5446924,          5,          3,         38,  62.500
>           0,    6249752,          0,          0,          0,  63.300
>           0,    6293671,          0,          0,          0,  63.800
>           0,    3751035,    2529964,          0,          0,  64.100
>           0,          0,    6101167,          0,          0,  64.500
>           0,          0,    6172526,          0,          0,  64.700
>           0,          0,    6163797,          0,          0,  64.900
>           0,          0,    1724841,    9567528,          0,  63.300
>           0,          0,          0,   13349668,          0,  62.700
>           0,          0,          0,   13360471,          0,  62.700
>           0,          0,          0,   13355424,          0,  62.700
>           0,          0,          0,    8854491,    3132640,  61.600
>           0,          0,          0,          0,    9302824,  59.000
>           0,          0,          0,          0,    9303561,  58.900
>           0,          0,          0,          0,    9313397,  59.000
>           0,          0,          0,          0,    9333944,  59.000
>
> Test kernel:
> 94a976a cpuidle: New timer events oriented governor for tickless systems  <<< V7
> 935be4e cpuidle: poll_state: Disregard disable idle states
> e3670df cpuidle: Add 'high' and 'low' idle state metrics
> dfa672c Documentation: admin-guide: PM: Add cpuidle document
> 2595646 Linux 4.20-rc5
>
> Reference kernel:
> f418681 cpuidle: poll_state: Disregard disable idle states
> 1be0e87 cpuidle: Add 'high' and 'low' idle state metrics
> 279ec1d Documentation: admin-guide: PM: Add cpuidle document
> 2595646 Linux 4.20-rc5

Thanks for the data!

I seem to see an improvement with teo as it draws less power in the
corresponding bins, roughly speaking.
