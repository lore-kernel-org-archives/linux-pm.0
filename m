From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: [PATCH] cpufreq: Avoid calling cpufreq driver's target() routine
	if target_freq == policy->cur
Date: Wed, 31 Oct 2012 01:44:50 +0100
Message-ID: <11869950.r5dVYWTkdx@vostro.rjw.lan>
References: <1d7b6e421a335255da956804b43ce3517538409c.1351244153.git.viresh.kumar@linaro.org>
	<5056958.0bPciFrxt5@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <5056958.0bPciFrxt5-sKB8Sp2ER+y1GS7QM15AGw@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pdsw-power-team-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Friday, October 26, 2012 01:17:12 PM Rafael J. Wysocki wrote:
> On Friday, October 26, 2012 03:06:26 PM Viresh Kumar wrote:
> > Avoid calling cpufreq driver's target() routine if new frequency is same as
> > policies current frequency.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> 
> Looks reasonable.
> 
> Any objection from anyone?

OK, no objections.

Applied to the linux-next branch of linux-pm.git as v3.8 material.

Thanks,
Rafael


> > ---
> >  drivers/cpufreq/cpufreq.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 261ef65..28dc134 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -1476,6 +1476,10 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
> >  
> >  	pr_debug("target for CPU %u: %u kHz, relation %u\n", policy->cpu,
> >  		target_freq, relation);
> > +
> > +	if (target_freq == policy->cur)
> > +		return 0;
> > +
> >  	if (cpu_online(policy->cpu) && cpufreq_driver->target)
> >  		retval = cpufreq_driver->target(policy, target_freq, relation);
> >  
> > 
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
