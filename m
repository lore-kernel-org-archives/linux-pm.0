From: amit daniel kachhap <amit.daniel@samsung.com>
Subject: Re: [PATCH 3/5] Thermal: Get cpu frequency via cpu cooling table
Date: Wed, 6 Feb 2013 17:44:05 -0800
Message-ID: <CADGdYn6hGhFg7gYsw2oLPZo2Kks9c2GCgFttOLLPR96QSTjW2Q@mail.gmail.com>
References: <CADGdYn4uusfk5gQ+tf8=VvaTLzTHkkfZJ9cLBojTwy8fT7vPoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ia0-f178.google.com ([209.85.210.178]:35354 "EHLO
	mail-ia0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755964Ab3BGBoG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Feb 2013 20:44:06 -0500
Received: by mail-ia0-f178.google.com with SMTP id y26so2385542iab.23
        for <linux-pm@vger.kernel.org>; Wed, 06 Feb 2013 17:44:05 -0800 (PST)
In-Reply-To: <CADGdYn4uusfk5gQ+tf8=VvaTLzTHkkfZJ9cLBojTwy8fT7vPoA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org, Gu1 <gu1@aeroxteam.fr>, Hongbo Zhang <hongbo.zhang@linaro.org>, amit kachhap <amit.kachhap@gmail.com>

Few comments below,

On Wed, Feb 6, 2013 at 5:41 PM, amit kachhap <amit.kachhap@gmail.com> wrote:
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/thermal/cpu_cooling.c |   45 ++++++++---------------------------------
>  1 file changed, 8 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index 08f12c7..57bb669 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -186,46 +186,17 @@ get_cpu_cooling_table(unsigned int cpu)
>   */
>  static unsigned int get_cpu_frequency(unsigned int cpu, unsigned long level)
>  {
> -       int ret = 0, i = 0;
> -       unsigned long level_index;
> -       bool descend = false;
> -       struct cpufreq_frequency_table *table =
> -                                       cpufreq_frequency_get_table(cpu);
> -       if (!table)
> -               return ret;
> -
> -       while (table[i].frequency != CPUFREQ_TABLE_END) {
> -               if (table[i].frequency == CPUFREQ_ENTRY_INVALID)
> -                       continue;
> -
> -               /*check if table in ascending or descending order*/
> -               if ((table[i + 1].frequency != CPUFREQ_TABLE_END) &&
> -                       (table[i + 1].frequency < table[i].frequency)
> -                       && !descend) {
> -                       descend = true;
> -               }
> +       struct cpufreq_frequency_table *table;
> +       unsigned int freq;
>
> -               /*return if level matched and table in descending order*/
> -               if (descend && i == level)
> -                       return table[i].frequency;
> -               i++;
> -       }
> -       i--;
> +       table = get_cpu_cooling_table(cpu);
> +       if (IS_ERR(table))
> +               return -EINVAL;
>
> -       if (level > i || descend)
> -               return ret;
> -       level_index = i - level;
> +       freq = table[level].frequency;
>
> -       /*Scan the table in reverse order and match the level*/
> -       while (i >= 0) {
> -               if (table[i].frequency == CPUFREQ_ENTRY_INVALID)
> -                       continue;
> -               /*return if level matched*/
> -               if (i == level_index)
> -                       return table[i].frequency;
> -               i--;
> -       }
> -       return ret;
> +       kfree(table);
> +       return 0;
return freq instead of return 0.

>  }
>
>  /**
> --
> 1.7.9.5
