From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [BUG] schedutil governor produces regular max freq spikes because of lockup detector watchdog threads
Date: Sat, 6 Jan 2018 08:12:52 -0800
Message-ID: <000001d38709$363d5180$a2b7f480$@net>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
References: XYkGesLZd7WleXYkHe0H9k
In-Reply-To: XYkGesLZd7WleXYkHe0H9k
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
To: 'Leonard Crestez' <leonard.crestez@nxp.com>, linux-pm@vger.kernel.org, 'Viresh Kumar' <viresh.kumar@linaro.org>, "'Rafael J. Wysocki'" <rafael@kernel.org>, 'Steve Muckle' <smuckle@linaro.org>
Cc: 'Anson Huang' <anson.huang@nxp.com>, linux-kernel@vger.kernel.org, Doug Smythies <dsmythies@telus.net>
List-Id: linux-pm@vger.kernel.org

On 2018.01.05 12:38 Leonard Crestez wrote:

> When using the schedutil governor together with the softlockup detector
> all CPUs go to their maximum frequency on a regular basis. This seems
> to be because the watchdog creates a RT thread on each CPU and this
> causes regular kicks with:
>
>    cpufreq_update_this_cpu(rq, SCHED_CPUFREQ_RT);
>
> The schedutil governor responds to this by immediately setting the
> maximum cpu frequency, this is very undesirable.
>
> The issue can be fixed by this patch from android:
>     https://patchwork.kernel.org/patch/9301909/
>
> The patch stalled in a long discussion about how it's difficult for
> cpufreq to deal with RT and how some RT users might just disable
> cpufreq. It is indeed hard but if the system experiences regular power
> kicks from a common debug feature they will end up disabling schedutil
> instead. No other governors behave this way, perhaps the current
> behavior should be considered a bug in schedutil.
>
> That patch now has conflicts with latest upstream. Perhaps a modified
> variant should be reconsidered for inclusion, or is there some other
> solution pending?
>
> Alternatively the watchdog threads could be somehow marked as to never
> cause increased cpufreq.

Your e-mail was very timely for me. In mid December, while testing the
minimum sampling rate change commit, I also did a reference test using
intel-cpufreq driver and schedutil governor. Under a range of
conditions 79% more package power was consumed by schedutil when compared
to: ondemand, sample rate 2 mSec; ondemand, sample rate 20 mSec;
intel_pstate driver.

I did not know about the thread and patch you referred to. Thanks.

Additionally, on otherwise mostly idle CPUs, sometimes I observe that after
the setting of max pstate, it gets left there with no update at all for
over a hundred seconds. Examples:

CPU3: 165 seconds since change to max pstate; Load 0.07%; new pstate = minimum
CPU5: 121 seconds since change to max pstate; Load 0.47%; new pstate = mid range

Reference (for me only): trace_stuff/results/pass24 samples 59797 and 59803

... Doug
