From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: [PATCH 7/9] intel: cpuidle: remove stop/start critical timings
Date: Mon, 08 Apr 2013 21:27:40 +0200
Message-ID: <6514915.cyFSTtqpte@vostro.rjw.lan>
References: <1364991322-20585-1-git-send-email-daniel.lezcano@linaro.org> <5161DC9C.3020703@linaro.org> <51630115.6040205@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51630115.6040205-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, deepthi-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Monday, April 08, 2013 07:40:37 PM Daniel Lezcano wrote:
> On 04/07/2013 10:52 PM, Daniel Lezcano wrote:
> > On 04/05/2013 12:31 AM, Rafael J. Wysocki wrote:
> >> On Wednesday, April 03, 2013 02:15:20 PM Daniel Lezcano wrote:
> >>> The start/stop_critical_timings are called from arch/x86/kernel/process.c
> >>> in the cpu_idle loop function.
> >>>
> >>> Remove the ones in the cpuidle driver.
> >>>
> >>> Signed-off-by: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> >> For this one I need an ACK from Len.
> >>
> >> Len, any objections?
> >
> > Len ? ping ...
> 
> Rafael,
> 
> this patch is not dependent from any patch in the series, is it possible
> you apply the patchset except this patch ?
> 
> May be you can apply it later when Len acks it, or I can resend it, no ?
> 
> I have a lot of code consolidation patches awaiting for this patchset to
> be merged.

OK, I'll take the rest of your patches in this series (except for [1/9]
which also is not depended on by anything AFAICS).

Thanks,
Rafael


> > ---
> >  drivers/idle/intel_idle.c |    3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> > index 5d66750..c99c31e 100644
> > --- a/drivers/idle/intel_idle.c
> > +++ b/drivers/idle/intel_idle.c
> > @@ -339,7 +339,6 @@ static int intel_idle(struct cpuidle_device *dev,
> >  	if (!(lapic_timer_reliable_states & (1 << (cstate))))
> >  		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &cpu);
> >  
> > -	stop_critical_timings();
> >  	if (!need_resched()) {
> >  
> >  		__monitor((void *)&current_thread_info()->flags, 0, 0);
> > @@ -348,8 +347,6 @@ static int intel_idle(struct cpuidle_device *dev,
> >  			__mwait(eax, ecx);
> >  	}
> >  
> > -	start_critical_timings();
> > -
> >  	if (!(lapic_timer_reliable_states & (1 << (cstate))))
> >  		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &cpu);
> >  
> >
> >
> 
> 
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
