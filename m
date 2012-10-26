From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 8/8] cpufreq: db8500: Use armss clk to update frequency
Date: Fri, 26 Oct 2012 13:20:38 +0200
Message-ID: <2835962.VLrrN08061@vostro.rjw.lan>
References: <1349869349-8070-1-git-send-email-ulf.hansson@stericsson.com> <1349869349-8070-9-git-send-email-ulf.hansson@stericsson.com> <CAPDyKFp8OVn1kXzQB_PVxb4PBYCdvE7QGzCiqN+Zmm9LsX3HDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:39102 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755731Ab2JZLQk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 26 Oct 2012 07:16:40 -0400
In-Reply-To: <CAPDyKFp8OVn1kXzQB_PVxb4PBYCdvE7QGzCiqN+Zmm9LsX3HDg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, Mike Turquette <mturquette@ti.com>, Mike Turquette <mturquette@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee.jones@linaro.org>, Philippe Begnic <philippe.begnic@st.com>, Rickard Andersson <rickard.andersson@stericsson.com>, Jonas Aberg <jonas.aberg@stericsson.com>, Vincent Guittot <vincent.guittot@linaro.org>

On Friday, October 26, 2012 10:10:40 AM Ulf Hansson wrote:
> On 10 October 2012 13:42, Ulf Hansson <ulf.hansson@stericsson.com> wrote:
> > From: Ulf Hansson <ulf.hansson@linaro.org>
> >
> > Using the armss clk to update the frequency makes the driver no more
> > directly dependant on the prmcu API.
> >
> > Cc: Rafael J. Wysocki <rjw@sisk.pl>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  drivers/cpufreq/db8500-cpufreq.c |   24 ++++++++++++++++--------
> >  1 file changed, 16 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/cpufreq/db8500-cpufreq.c b/drivers/cpufreq/db8500-cpufreq.c
> > index dea9a49..4f154bc 100644
> > --- a/drivers/cpufreq/db8500-cpufreq.c
> > +++ b/drivers/cpufreq/db8500-cpufreq.c
> > @@ -14,10 +14,11 @@
> >  #include <linux/delay.h>
> >  #include <linux/slab.h>
> >  #include <linux/platform_device.h>
> > -#include <linux/mfd/dbx500-prcmu.h>
> > +#include <linux/clk.h>
> >  #include <mach/id.h>
> >
> >  static struct cpufreq_frequency_table *freq_table;
> > +static struct clk *armss_clk;
> >
> >  static struct freq_attr *db8500_cpufreq_attr[] = {
> >         &cpufreq_freq_attr_scaling_available_freqs,
> > @@ -58,9 +59,9 @@ static int db8500_cpufreq_target(struct cpufreq_policy *policy,
> >         for_each_cpu(freqs.cpu, policy->cpus)
> >                 cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
> >
> > -       /* request the PRCM unit for opp change */
> > -       if (prcmu_set_arm_opp(freq_table[idx].index)) {
> > -               pr_err("db8500-cpufreq:  Failed to set OPP level\n");
> > +       /* update armss clk frequency */
> > +       if (clk_set_rate(armss_clk, freq_table[idx].frequency * 1000)) {
> > +               pr_err("db8500-cpufreq: Failed to update armss clk\n");
> >                 return -EINVAL;
> >         }
> >
> > @@ -74,16 +75,16 @@ static int db8500_cpufreq_target(struct cpufreq_policy *policy,
> >  static unsigned int db8500_cpufreq_getspeed(unsigned int cpu)
> >  {
> >         int i = 0;
> > -       /* request the prcm to get the current ARM opp */
> > -       int opp = prcmu_get_arm_opp();
> > +       unsigned long freq = clk_get_rate(armss_clk) / 1000;
> >
> >         while (freq_table[i].frequency != CPUFREQ_TABLE_END) {
> > -               if (opp == freq_table[i].index)
> > +               if (freq <= freq_table[i].frequency)
> >                         return freq_table[i].frequency;
> >                 i++;
> >         }
> >
> > -       /* We could not find a corresponding opp frequency. */
> > +       /* We could not find a corresponding frequency. */
> > +       pr_err("db8500-cpufreq: Failed to find cpufreq speed\n");
> >         return 0;
> >  }
> >
> > @@ -92,6 +93,12 @@ static int __cpuinit db8500_cpufreq_init(struct cpufreq_policy *policy)
> >         int i = 0;
> >         int res;
> >
> > +       armss_clk = clk_get(NULL, "armss");
> > +       if (IS_ERR(armss_clk)) {
> > +               pr_err("db8500-cpufreq : Failed to get armss clk\n");
> > +               return PTR_ERR(armss_clk);
> > +       }
> > +
> >         pr_info("db8500-cpufreq : Available frequencies:\n");
> >         while (freq_table[i].frequency != CPUFREQ_TABLE_END) {
> >                 pr_info("  %d Mhz\n", freq_table[i].frequency/1000);
> > @@ -104,6 +111,7 @@ static int __cpuinit db8500_cpufreq_init(struct cpufreq_policy *policy)
> >                 cpufreq_frequency_table_get_attr(freq_table, policy->cpu);
> >         else {
> >                 pr_err("db8500-cpufreq : Failed to read policy table\n");
> > +               clk_put(armss_clk);
> >                 return res;
> >         }
> >
> > --
> > 1.7.10
> >
> 
> Just a kind reminder on this Rafael; trying to collect acks, do you
> think we can advise Mike to merge this though his clk tree?

Yes, please.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
