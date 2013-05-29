From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC PATCH] cpufreq: ondemand: Increase frequency to any value proportional to load
Date: Thu, 30 May 2013 00:29:49 +0200
Message-ID: <3000308.Hi6zX8my0D@vostro.rjw.lan>
References: <51A3C6CF.6080104@semaphore.gr> <1567913.u8NiyqJmvF@vostro.rjw.lan> <51A61BAC.2050203@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <51A61BAC.2050203@semaphore.gr>
Sender: cpufreq-owner@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, May 29, 2013 06:15:56 PM Stratos Karafotis wrote:
> On 05/28/2013 11:54 PM, Rafael J. Wysocki wrote:
> > On Tuesday, May 28, 2013 08:03:19 PM Stratos Karafotis wrote:
> >> I mean any value of freq table. Please let me know if you want me to rephrase
> >> it in description.
> > 
> > Yes, it would be nice to be more precise.
> 
> OK sure, I will add a more precise description.
> 
> 
> > Which is equivalent to saying that __cpufreq_driver_getavg() is not useful and
> > may be removed (but the patch doesn't do that and I wonder why?), but surely
> > the developer who added it wouldn't agree.
> > 
> > So, please explain: why can we drop __cpufreq_driver_getavg()?
> > 
> 
> With the new proposed method the next frequency is not dependent from current
> or average frequency. The next frequency is dependent only from load.
> So, we don't need support for freq feedback from hardware anymore.

OK, but that's a more significant change than the changelog suggests.
The changelog should tell the whole story and explain the rationale. :-)

So, please explain that in fact it is not necessary to use the current or
average frequency to compute the target and why that is the case.

Also the patch should remove __cpufreq_driver_getavg() and the callback used by
it, since that code will be dead after applying it anyway.

> Even if, due to underlying hardware coordination mechanism, CPU runs in different 
> frequency than the actual, the calculation of load and of target frequency will
> remain the unaffected, with this patch.
> 
> With full respect to ondemand coauthor, and if the new method is acceptable,
> I could send a patch to revert the original one about the IA32_APERF and
> IA32_MPERF MSR support.

I'm not sure what you mean by "revert", but please do as I said above.

> >> Thus, in the comparison with up_threshold to increase frequency we actually
> >> do this (in cases that getavg is not implemented):
> >> if (load > up_theshold)
> >> 	increase to max
> >>
> >> So, after the patch we keep the same comparison to decide about the max frequency.
> >> I thought, that below up_threshold is 'fair' to decide about the next
> >> frequency with formula that frequency is proportional to load.
> >> For example in a CPU with min freq 100MHz and max 1000MHz with a
> >> load 50 target frequency should be 500MHz.
> > 
> > Well, that sounds reasonable, but the patch actually does more than that.
> 
> I'm sorry, but I didn't understand your last point.

Please see above.

The changelog doesn't even mention that the code is being switched from using
measured past frequencies to not using them, because you think that there's a
better way of computing the target (which by the way I can agree with :-)).

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
