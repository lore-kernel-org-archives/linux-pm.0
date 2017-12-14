From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: Ask for help on governor
Date: Wed, 13 Dec 2017 17:21:29 -0800
Message-ID: <000701d37479$e0570320$a1050960$@net>
References: <HE1PR0402MB282866171A847AE244A9F76CF3340@HE1PR0402MB2828.eurprd04.prod.outlook.com> <000801d37364$d48f6ed0$7dae4c70$@net> <000f01d373bf$deacca10$9c065e30$@net> <20171213061759.GT25177@vireshk-i7> P0QweRTHbuQ9TP0R1eouYx
Mime-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta20.telus.net ([209.171.16.93]:51246 "EHLO cmta20.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751641AbdLNBVe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 13 Dec 2017 20:21:34 -0500
In-Reply-To: P0QweRTHbuQ9TP0R1eouYx
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Andy Tang' <andy.tang@nxp.com>, 'Viresh Kumar' <viresh.kumar@linaro.org>, 'Stratos Karafotis' <stratosk@semaphore.gr>
Cc: "'Rafael J. Wysocki'" <rafael@kernel.org>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Linux PM' <linux-pm@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>

Note: adding Stratos, the commit author.
 
On 2017.12.12 22:22 Andy Tang wrote:

> Anyway I found the root cause myself.
>
> It was caused by commit: 00bfe05889e91b5112893b001e4a47b0a0f8bdd7.

Agreed.

Then why did my kernel bisection come to a different conclusion?
Because, in my case, the issue only manifested itself when the
sampling rate (which should really be called sampling period), became
low enough to bring the issue to the surface.

The other important thing to note for my system is that I use (O.K.,
steal) the Ubuntu kernel configuration and so my tick rate is 250 Hz, not
1000 Hz.

I think the math for the idle periods calculation breaks down here
(from drivers/cpufreq/cpufreq_governor.c):

                if (time_elapsed > 2 * sampling_rate) {
                        unsigned int periods = time_elapsed / sampling_rate;

                        if (periods < idle_periods)
                                idle_periods = periods;
                }

if 2 * sampling_rate is less than one jiffy.
I.E. isn't time_elapsed always exactly one jiffy for a fully loaded CPU?
Important note: on my system a jiffy is just over 4 milliseconds.
So, for my test which is 100% load on one CPU, basically, idle_periods is always 2,
maybe more and the conservative code is always resetting the target CPU frequency
to minimum.

For whatever reason, on my system, a frequency step of 5% will not raise the pstate,
even though it should (the math works out to 1790 MHz, or pstate 17, but I never see it.
If I raise the frequency step to anything else, the math makes complete sense. Example:
frequency step = 10% so 3800 * 0.1 + 1600 = 1980 which means I should see pstate 19 being
asked for. I do. However, it does not continue to increase because of the
idle_periods problem, driving it back as an intermediate calculation, so all I ever see is
requested pstate of 19.

O.K. so if all this is true, then a 1000 Hz kernel shouldn't have a problem. Sort of, it
doesn't. Why "sort of"? Because the default sample period of 500 usec is right
on the edge, and sometimes the requested pstate does drop as a result. I used this
command to watch the requested pstate:

watch -d -n 1 sudo rdmsr --bitfield 15:8 -d -a 0x199

(translation: watch the actual requested pstates for all CPUs, by reading the processor itself.)

and while for CPU 7, it should clamp at 38 (for my system) it doesn't. O.K. so just
increase the sampling period a little, to say 510 uSec, and then yes, it clamps at 38.

O.K. so finally, I reverted the commit (but in a cheating way):

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 58d4f4e..3493ca7 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -222,6 +222,7 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
                        max_load = load;
        }

+       idle_periods = 0;
        policy_dbs->idle_periods = idle_periods;

        return max_load;
 
And everything is fine.

... Doug
