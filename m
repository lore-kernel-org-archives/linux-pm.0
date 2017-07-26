From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V3 3/9] cpufreq: Cap the default transition delay value to 10 ms
Date: Wed, 26 Jul 2017 02:19:28 +0200
Message-ID: <1695188.JjXV8Km57D@aspire.rjw.lan>
References: <cover.1500373914.git.viresh.kumar@linaro.org> <1b93c94cb8b4914314e4f50304c3cb11c53d8b14.1500373914.git.viresh.kumar@linaro.org> <1500983686.30745.28.camel@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:65487 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751031AbdGZA11 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jul 2017 20:27:27 -0400
In-Reply-To: <1500983686.30745.28.camel@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux@dominikbrodowski.net, linux-kernel@vger.kernel.org

On Tuesday, July 25, 2017 02:54:46 PM Leonard Crestez wrote:
> On Wed, 2017-07-19 at 15:42 +0530, Viresh Kumar wrote:
> > If transition_delay_us isn't defined by the cpufreq driver, the default
> > value of transition delay (time after which the cpufreq governor will
> > try updating the frequency again) is currently calculated by multiplying
> > transition_latency (nsec) with LATENCY_MULTIPLIER (1000) and then
> > converting this time to usec. That gives the exact same value as
> > transition_latency, just that the time unit is usec instead of nsec.
> > 
> > With acpi-cpufreq for example, transition_latency is set to around 10
> > usec and we get transition delay as 10 ms. Which seems to be a
> > reasonable amount of time to reevaluate the frequency again.
> > 
> > But for platforms where frequency switching isn't that fast (like ARM),
> > the transition_latency varies from 500 usec to 3 ms, and the transition
> > delay becomes 500 ms to 3 seconds. Of course, that is a pretty bad
> > default value to start with.
> > 
> > We can try to come across a better formula (instead of multiplying with
> > LATENCY_MULTIPLIER) to solve this problem, but will that be worth it ?
> > 
> > This patch tries a simple approach and caps the maximum value of default
> > transition delay to 10 ms. Of course, userspace can still come in and
> > change this value anytime or individual drivers can rather provide
> > transition_delay_us instead.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  drivers/cpufreq/cpufreq.c | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index c426d21822f7..d00cde871c15 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -532,8 +532,19 @@ unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy)
> >  		return policy->transition_delay_us;
> >  
> >  	latency = policy->cpuinfo.transition_latency / NSEC_PER_USEC;
> > -	if (latency)
> > -		return latency * LATENCY_MULTIPLIER;
> > +	if (latency) {
> > +		/*
> > +		 * For platforms that can change the frequency very fast (< 10
> > +		 * us), the above formula gives a decent transition delay. But
> > +		 * for platforms where transition_latency is in milliseconds, it
> > +		 * ends up giving unrealistic values.
> > +		 *
> > +		 * Cap the default transition delay to 10 ms, which seems to be
> > +		 * a reasonable amount of time after which we should reevaluate
> > +		 * the frequency.
> > +		 */
> > +		return min(latency * LATENCY_MULTIPLIER, (unsigned int)10000);
> > +	}
> >  
> >  	return LATENCY_MULTIPLIER;
> >  }
> 
> This patch made it's way into linux-next and it seems to cause imx socs
> to almost always hang around their max frequency with the ondemand
> governor, even when almost completely idle. The lowest frequency is
> never reached. This seems wrong?
> 
> This driver calculates transition_latency at probe time, the value is
> not terribly accurate but it reaches values like latency = 109 us, so
> this patch clamps it at about 10% of the value.
> 
> It's worth noting that the default IMX config has HZ=100 and
> NO_HZ_IDLE=y, so maybe doing idle checks at a rate comparable to the
> jiffie tick screws stuff up? I don't understand what ondemand is trying
> to do.

I've dropped this commit from linux-next for now.

Thanks,
Rafael
