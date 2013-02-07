From: amit daniel kachhap <amit.daniel@samsung.com>
Subject: Re: [PATCH 2/5] Thermal: Introduce cpu cooling table
Date: Wed, 6 Feb 2013 17:56:20 -0800
Message-ID: <CADGdYn6ztQ99vOGiHRGirQTx1-Zgk4-xLGwiwGV=JtVLTFOXbg@mail.gmail.com>
References: <CADGdYn6ehM36k1O3O6mXnHRJBy42N5iACnbOB+bwjPx+RAqQTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ia0-f178.google.com ([209.85.210.178]:37871 "EHLO
	mail-ia0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751750Ab3BGB4U (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Feb 2013 20:56:20 -0500
Received: by mail-ia0-f178.google.com with SMTP id y26so2393817iab.23
        for <linux-pm@vger.kernel.org>; Wed, 06 Feb 2013 17:56:20 -0800 (PST)
In-Reply-To: <CADGdYn6ehM36k1O3O6mXnHRJBy42N5iACnbOB+bwjPx+RAqQTw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org, Gu1 <gu1@aeroxteam.fr>, Hongbo Zhang <hongbo.zhang@linaro.org>, amit kachhap <amit.kachhap@gmail.com>

Hi Rui,

I tested this code and after 2 changes it started working.

Also calling memory allocation for getting cpufreq table is quite
expensive and might also fail. Storing the frequency again in a new
table can be avoided and only required frequency or level can be
returned.

Thanks,
Amit Daniel

On Wed, Feb 6, 2013 at 5:46 PM, amit kachhap <amit.kachhap@gmail.com> wrote:
> CPU cooling table is a cleaned cpufreq_frequency_table that
> 1. each entry represents a cooling state,
>    aka, each entry has a different frequency.
> 2. does not have invalid entry.
> 3. does not have duplicate entry.
> 4. the frequencies of all the entries are in descending order.
>
> we should use this table inside thermal layer and thermal drivers.
>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/thermal/cpu_cooling.c |   63 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index 455c77a..08f12c7 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -115,6 +115,69 @@ static int is_cpufreq_valid(int cpu)
>         return !cpufreq_get_policy(&policy, cpu);
>  }
>
> +/*
> + * get the cleaned cpufreq_frequency_table that
> + * 1) does not have invalid entries
> + * 2) does not have duplicate entries
> + * 3) the frequency of the entries are in descending order
> + */
> +static struct cpufreq_frequency_table *
> +get_cpu_cooling_table(unsigned int cpu)
> +{
> +       int i = 0;
> +       int level;
> +       struct cpufreq_frequency_table *old, *new;
> +       unsigned int freq = CPUFREQ_ENTRY_INVALID;
> +       int descend = -1;
> +
> +       old = cpufreq_frequency_get_table(cpu);
> +       if (!old)
> +               return ERR_PTR(-EINVAL);
> +
> +       while (old[i].frequency != CPUFREQ_TABLE_END)
> +               i++;
> +
> +       i++; /* one more entry for CPUFREQ_TABLE_END */
> +
> +       new = kzalloc(i * sizeof(struct cpufreq_frequency_table), GFP_KERNEL);
> +       if (!new)
> +               return ERR_PTR(-ENOMEM);
> +
> +       for (i = 0, level = 0; old[i].frequency != CPUFREQ_TABLE_END; i++) {
> +               /* ignore invalid entry */
> +               if (old[i].frequency == CPUFREQ_ENTRY_INVALID)
> +                       continue;
> +
> +               /* ignore duplicate entry */
> +               if (freq == old[i].frequency)
> +                       continue;
> +
> +               /* found an valid entry */
> +               new[level].frequency = old[i].frequency;
> +
> +               if (freq != CPUFREQ_ENTRY_INVALID && descend == -1)
> +                       descend = !!(freq > old[i].frequency);
> +
> +               /* freq always equals the last valid frequency */
> +               freq = new[level].frequency;
> +
> +               level++;
> +       }
> +       new[level].frequency = CPUFREQ_ENTRY_INVALID;
> +
> +       /* convert to decending if in ascending order */
> +       if (!descend) {
> +               for(i = 0; i < (level - i - 1); i++) {
> +                       int j = level - i - 1;
> +                       freq = new[i].frequency;
> +                       new[i].frequency = new[j].frequency;
> +                       new[j].frequency = freq;
> +               }
> +       }
> +
> +       return new;
> +}
> +
>  /**
>   * get_cpu_frequency - get the absolute value of frequency from level.
>   * @cpu: cpu for which frequency is fetched.
> --
> 1.7.9.5
