From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 2/5] Thermal: Introduce cpu cooling table
Date: Fri, 08 Feb 2013 11:30:45 +0800
Message-ID: <1360294245.2242.8.camel@rzhang1-mobl4>
References: <1360125006-25018-1-git-send-email-rui.zhang@intel.com>
	 <1360125006-25018-3-git-send-email-rui.zhang@intel.com>
	 <CAJLyvQwgKLt+oy=h1WsCPx+RvJX_w8J+ogEr=OTg0HSYvpbcVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:54237 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756584Ab3BHDas (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 7 Feb 2013 22:30:48 -0500
In-Reply-To: <CAJLyvQwgKLt+oy=h1WsCPx+RvJX_w8J+ogEr=OTg0HSYvpbcVA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hongbo Zhang <hongbo.zhang@linaro.org>
Cc: linux-pm@vger.kernel.org, amit.daniel@samsung.com, gu1@aeroxteam.fr

On Thu, 2013-02-07 at 17:36 +0800, Hongbo Zhang wrote:
> On 6 February 2013 12:30, Zhang Rui <rui.zhang@intel.com> wrote:
> > CPU cooling table is a cleaned cpufreq_frequency_table that
> > 1. each entry represents a cooling state,
> >    aka, each entry has a different frequency.
> > 2. does not have invalid entry.
> > 3. does not have duplicate entry.
> > 4. the frequencies of all the entries are in descending order.
> >
> This is a good idea, but we should consider more details, one tough
> issue is invalid frequencies:
> 1. some freq is invalid while freq table is creating, but after that
> the invalid freq becomes valid, we will miss cooling states.

when will the invalid freq becomes valid?
for ACPI platforms, the number of valid cpu frequency should not change
at runtime, but BIOS will indicate that only several of them can be used
dynamically.
I'm not sure if this may behave differently on other platforms.
if it is true, the max_state and cur_state may change from time to time.
and we should cache current frequency rather than cur_state in cpu
cooling code.

> 2. vice versa, all the freq is valid while freq table is creating, but
> become invalid later, thus some cooling state isn't valid either,
> should we consider such case?

> In fact, these should be considered even if this patch isn't sent out.
> 
> (We are assuming that all the CPU cores run at same freq and should be
> adjust freq simultaneously, if no affinity between CPU cores, it will
> be more complicated -- this seems not proper to be discussed in this
> patch)
> 
Agreed.
But I'll try to fix the duplicate/invalid entries and ascending order
issue in this patch set.

thanks,
rui

> > we should use this table inside thermal layer and thermal drivers.
> >
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  drivers/thermal/cpu_cooling.c |   63 +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 63 insertions(+)
> >
> > diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> > index 455c77a..08f12c7 100644
> > --- a/drivers/thermal/cpu_cooling.c
> > +++ b/drivers/thermal/cpu_cooling.c
> > @@ -115,6 +115,69 @@ static int is_cpufreq_valid(int cpu)
> >         return !cpufreq_get_policy(&policy, cpu);
> >  }
> >
> > +/*
> > + * get the cleaned cpufreq_frequency_table that
> > + * 1) does not have invalid entries
> > + * 2) does not have duplicate entries
> > + * 3) the frequency of the entries are in descending order
> > + */
> > +static struct cpufreq_frequency_table *
> > +get_cpu_cooling_table(unsigned int cpu)
> > +{
> > +       int i = 0;
> > +       int level;
> > +       struct cpufreq_frequency_table *old, *new;
> > +       unsigned int freq = CPUFREQ_ENTRY_INVALID;
> > +       int descend = -1;
> > +
> > +       old = cpufreq_frequency_get_table(cpu);
> > +       if (!old)
> > +               return ERR_PTR(-EINVAL);
> > +
> > +       while (old[i].frequency != CPUFREQ_TABLE_END)
> > +               i++;
> > +
> > +       i++; /* one more entry for CPUFREQ_TABLE_END */
> > +
> > +       new = kzalloc(i * sizeof(struct cpufreq_frequency_table), GFP_KERNEL);
> > +       if (!new)
> > +               return ERR_PTR(-ENOMEM);
> > +
> > +       for (i = 0, level = 0; old[i].frequency != CPUFREQ_TABLE_END; i++) {
> > +               /* ignore invalid entry */
> > +               if (old[i].frequency == CPUFREQ_ENTRY_INVALID)
> > +                       continue;
> > +
> > +               /* ignore duplicate entry */
> > +               if (freq == old[i].frequency)
> > +                       continue;
> > +
> > +               /* found an valid entry */
> > +               new[level].frequency = old[i].frequency;
> > +
> > +               if (freq != CPUFREQ_ENTRY_INVALID && descend == -1)
> > +                       descend = !!(freq > old[i].frequency);
> > +
> > +               /* freq always equals the last valid frequency */
> > +               freq = new[level].frequency;
> > +
> > +               level++;
> > +       }
> > +       new[level].frequency = CPUFREQ_ENTRY_INVALID;
> > +
> > +       /* convert to decending if in ascending order */
> > +       if (!descend) {
> > +               for(i = 0; i < (level - i - 1); i++) {
> > +                       int j = level - i - 1;
> > +                       freq = new[i].frequency;
> > +                       new[i].frequency = new[j].frequency;
> > +                       new[j].frequency = freq;
> > +               }
> > +       }
> > +
> > +       return new;
> > +}
> > +
> >  /**
> >   * get_cpu_frequency - get the absolute value of frequency from level.
> >   * @cpu: cpu for which frequency is fetched.
> > --
> > 1.7.9.5
> >


