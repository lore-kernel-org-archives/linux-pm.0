From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH 2/3] cpufreq: pmac64: re-estimate G5 cpufreq transition
 latency
Date: Wed, 24 Jul 2013 13:18:32 +0300
Message-ID: <20130724101832.GA26943@blackmetal.musicnaut.iki.fi>
References: <1374611079-28091-1-git-send-email-aaro.koskinen@iki.fi>
 <1374611079-28091-2-git-send-email-aaro.koskinen@iki.fi>
 <CAKohpo=t0C63m_WuZA-dGiLDtBu8FbdM8tgJLNh_NSAALnf+fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:49165 "EHLO
	filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064Ab3GXKSp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jul 2013 06:18:45 -0400
Content-Disposition: inline
In-Reply-To: <CAKohpo=t0C63m_WuZA-dGiLDtBu8FbdM8tgJLNh_NSAALnf+fw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Nick Piggin <npiggin@suse.de>, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

Hi,

On Wed, Jul 24, 2013 at 11:04:50AM +0530, Viresh Kumar wrote:
> On 24 July 2013 01:54, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> > The patch also enables to use ondemand governor on the latter.
> 
> How? I can't see anything obvious here. :(

It replaces CPUFREQ_ETERNAL with a proper value on older PowerMacs.
ondemand does not accept CPUFREQ_ETERNAL transition latency.

A.

> 
> >
> > Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> > ---
> >  drivers/cpufreq/pmac64-cpufreq.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/cpufreq/pmac64-cpufreq.c b/drivers/cpufreq/pmac64-cpufreq.c
> > index 674807d..f9e399b 100644
> > --- a/drivers/cpufreq/pmac64-cpufreq.c
> > +++ b/drivers/cpufreq/pmac64-cpufreq.c
> > @@ -85,7 +85,8 @@ static int (*g5_query_freq)(void);
> >
> >  static DEFINE_MUTEX(g5_switch_mutex);
> >
> > -static unsigned long transition_latency;
> > +/* A conservative estimate, based on Xserve G5 and iMac G5 (iSight). */
> > +static const unsigned long transition_latency = 10 * NSEC_PER_MSEC;
> >
> >  #ifdef CONFIG_PMAC_SMU
> >
> > @@ -499,7 +500,6 @@ static int __init g5_neo2_cpufreq_init(struct device_node *cpus)
> >         g5_cpu_freqs[1].frequency = max_freq/2;
> >
> >         /* Set callbacks */
> > -       transition_latency = 12000;
> >         g5_switch_freq = g5_scom_switch_freq;
> >         g5_query_freq = g5_scom_query_freq;
> >         freq_method = "SCOM";
> > @@ -675,7 +675,6 @@ static int __init g5_pm72_cpufreq_init(struct device_node *cpus)
> >         g5_cpu_freqs[1].frequency = min_freq;
> >
> >         /* Set callbacks */
> > -       transition_latency = CPUFREQ_ETERNAL;
> >         g5_switch_volt = g5_pfunc_switch_volt;
> >         g5_switch_freq = g5_pfunc_switch_freq;
> >         g5_query_freq = g5_pfunc_query_freq;
> > --
> > 1.8.3.2
> >
