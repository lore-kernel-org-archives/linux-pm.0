From: amit kachhap <amit.kachhap@gmail.com>
Subject: Re: [PATCH 2/5] Thermal: Introduce cpu cooling table
Date: Thu, 7 Feb 2013 15:18:41 -0800
Message-ID: <CADGdYn70n+izsp21JXzsTJt+04TuEdH5GRL4KV-GZ6U0+Ozcnw@mail.gmail.com>
References: <CADGdYn6ehM36k1O3O6mXnHRJBy42N5iACnbOB+bwjPx+RAqQTw@mail.gmail.com>
	<CADGdYn6ztQ99vOGiHRGirQTx1-Zgk4-xLGwiwGV=JtVLTFOXbg@mail.gmail.com>
	<1360205598.2982.109.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ia0-f180.google.com ([209.85.210.180]:63752 "EHLO
	mail-ia0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759492Ab3BGXSl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 Feb 2013 18:18:41 -0500
Received: by mail-ia0-f180.google.com with SMTP id f27so3486354iae.25
        for <linux-pm@vger.kernel.org>; Thu, 07 Feb 2013 15:18:41 -0800 (PST)
In-Reply-To: <1360205598.2982.109.camel@rzhang1-mobl4>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org, Gu1 <gu1@aeroxteam.fr>, Hongbo Zhang <hongbo.zhang@linaro.org>

On Wed, Feb 6, 2013 at 6:53 PM, Zhang Rui <rui.zhang@intel.com> wrote:
> On Wed, 2013-02-06 at 17:56 -0800, amit daniel kachhap wrote:
>> Hi Rui,
>>
>> I tested this code and after 2 changes it started working.
Oh sorry I didn't explained it . Actually I replied the problems to
their corresponding patches.
>>
> which two changes?
>
>> Also calling memory allocation for getting cpufreq table is quite
>> expensive and might also fail.
>> Storing the frequency again in a new
>> table can be avoided
>
> you mean it is not worth creating a cpu cooling table?
>
> do you mean this memory allocation is quite expensive for SOC?
> Sorry I do not have too much experience on SOC.
>
>>  and only required frequency or level can be
>> returned.
>>
> Sorry, I do not understand.
> But it is true that we do not have to allocate a new table to get the
> level/frequency.

I meant the same that it is unnecessary to allocate the cpufreq table
and then free them.

Thanks.
Amit Daniel
> I just want to make the cooling state <-> frequency transition clear and
> consistent for cpufreq cooling.
> I can work out another version without memory allocation, if that's what
> you want.

>
> thanks,
> rui
>> Thanks,
>> Amit Daniel
>>
>> On Wed, Feb 6, 2013 at 5:46 PM, amit kachhap <amit.kachhap@gmail.com> wrote:
>> > CPU cooling table is a cleaned cpufreq_frequency_table that
>> > 1. each entry represents a cooling state,
>> >    aka, each entry has a different frequency.
>> > 2. does not have invalid entry.
>> > 3. does not have duplicate entry.
>> > 4. the frequencies of all the entries are in descending order.
>> >
>> > we should use this table inside thermal layer and thermal drivers.
>> >
>> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
>> > ---
>> >  drivers/thermal/cpu_cooling.c |   63 +++++++++++++++++++++++++++++++++++++++++
>> >  1 file changed, 63 insertions(+)
>> >
>> > diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
>> > index 455c77a..08f12c7 100644
>> > --- a/drivers/thermal/cpu_cooling.c
>> > +++ b/drivers/thermal/cpu_cooling.c
>> > @@ -115,6 +115,69 @@ static int is_cpufreq_valid(int cpu)
>> >         return !cpufreq_get_policy(&policy, cpu);
>> >  }
>> >
>> > +/*
>> > + * get the cleaned cpufreq_frequency_table that
>> > + * 1) does not have invalid entries
>> > + * 2) does not have duplicate entries
>> > + * 3) the frequency of the entries are in descending order
>> > + */
>> > +static struct cpufreq_frequency_table *
>> > +get_cpu_cooling_table(unsigned int cpu)
>> > +{
>> > +       int i = 0;
>> > +       int level;
>> > +       struct cpufreq_frequency_table *old, *new;
>> > +       unsigned int freq = CPUFREQ_ENTRY_INVALID;
>> > +       int descend = -1;
>> > +
>> > +       old = cpufreq_frequency_get_table(cpu);
>> > +       if (!old)
>> > +               return ERR_PTR(-EINVAL);
>> > +
>> > +       while (old[i].frequency != CPUFREQ_TABLE_END)
>> > +               i++;
>> > +
>> > +       i++; /* one more entry for CPUFREQ_TABLE_END */
>> > +
>> > +       new = kzalloc(i * sizeof(struct cpufreq_frequency_table), GFP_KERNEL);
>> > +       if (!new)
>> > +               return ERR_PTR(-ENOMEM);
>> > +
>> > +       for (i = 0, level = 0; old[i].frequency != CPUFREQ_TABLE_END; i++) {
>> > +               /* ignore invalid entry */
>> > +               if (old[i].frequency == CPUFREQ_ENTRY_INVALID)
>> > +                       continue;
>> > +
>> > +               /* ignore duplicate entry */
>> > +               if (freq == old[i].frequency)
>> > +                       continue;
>> > +
>> > +               /* found an valid entry */
>> > +               new[level].frequency = old[i].frequency;
>> > +
>> > +               if (freq != CPUFREQ_ENTRY_INVALID && descend == -1)
>> > +                       descend = !!(freq > old[i].frequency);
>> > +
>> > +               /* freq always equals the last valid frequency */
>> > +               freq = new[level].frequency;
>> > +
>> > +               level++;
>> > +       }
>> > +       new[level].frequency = CPUFREQ_ENTRY_INVALID;
>> > +
>> > +       /* convert to decending if in ascending order */
>> > +       if (!descend) {
>> > +               for(i = 0; i < (level - i - 1); i++) {
>> > +                       int j = level - i - 1;
>> > +                       freq = new[i].frequency;
>> > +                       new[i].frequency = new[j].frequency;
>> > +                       new[j].frequency = freq;
>> > +               }
>> > +       }
>> > +
>> > +       return new;
>> > +}
>> > +
>> >  /**
>> >   * get_cpu_frequency - get the absolute value of frequency from level.
>> >   * @cpu: cpu for which frequency is fetched.
>> > --
>> > 1.7.9.5
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
