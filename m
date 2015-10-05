From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] cpufreq : powernv: Report Pmax throttling if capped below nominal frequency
Date: Mon, 05 Oct 2015 22:50:58 +0200
Message-ID: <2149242.U2nasEWuDM@vostro.rjw.lan>
References: <1442207874-5016-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com> <1442219507-6499-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com> <20150914102809.GD32551@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:46034 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751382AbbJEUW2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 5 Oct 2015 16:22:28 -0400
In-Reply-To: <20150914102809.GD32551@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Monday, September 14, 2015 03:58:09 PM Viresh Kumar wrote:
> On 14-09-15, 14:01, Shilpasri G Bhat wrote:
> > Log a 'critical' message if the max frequency is reduced below nominal
> > frequency. We already log 'info' message if the max frequency is
> > capped below turbo frequency. CPU should guarantee atleast nominal
> > frequency, but not turbo frequency in all system configurations and
> > environments. So report the pmax throttling with severity when Pmax is
> > dipped below nominal frequency.
> > 
> > Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> > ---
> > Changes from v1:
> > - Modified the printk messages as per Viresh's suggestion.
> > 
> >  drivers/cpufreq/powernv-cpufreq.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> > index 64994e1..cb50138 100644
> > --- a/drivers/cpufreq/powernv-cpufreq.c
> > +++ b/drivers/cpufreq/powernv-cpufreq.c
> > @@ -327,8 +327,14 @@ static void powernv_cpufreq_throttle_check(void *data)
> >  		if (chips[i].throttled)
> >  			goto next;
> >  		chips[i].throttled = true;
> > -		pr_info("CPU %d on Chip %u has Pmax reduced to %d\n", cpu,
> > -			chips[i].id, pmsr_pmax);
> > +		if (pmsr_pmax < powernv_pstate_info.nominal)
> > +			pr_crit("CPU %d on Chip %u has Pmax reduced below nominal frequency (%d < %d)\n",
> > +				cpu, chips[i].id, pmsr_pmax,
> > +				powernv_pstate_info.nominal);
> > +		else
> > +			pr_info("CPU %d on Chip %u has Pmax reduced below turbo frequency (%d < %d)\n",
> > +				cpu, chips[i].id, pmsr_pmax,
> > +				powernv_pstate_info.max);
> >  	} else if (chips[i].throttled) {
> >  		chips[i].throttled = false;
> >  		pr_info("CPU %d on Chip %u has Pmax restored to %d\n", cpu,
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied, thanks!

Rafael

