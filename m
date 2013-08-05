From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq-stats: fix time_in_state statistics
Date: Mon, 5 Aug 2013 12:15:33 +0530
Message-ID: <CAOh2x=nSvuyimdxhhjQgGdhK7EZmLfGD9Weh2bB+-werZDtGEA@mail.gmail.com>
References: <87vc3o3pxn.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <87vc3o3pxn.fsf@igel.home>
Sender: cpufreq-owner@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Please see MAINTAINERS file to get list of people/lists you need
to send your patch to.

On Sat, Aug 3, 2013 at 12:01 AM, Andreas Schwab <schwab@linux-m68k.org> wrote:
> The time_in_state numbers are in units of jiffies, not cputime.
>
> Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
> ---
>  drivers/cpufreq/cpufreq_stats.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> index d37568c..10e6138 100644
> --- a/drivers/cpufreq/cpufreq_stats.c
> +++ b/drivers/cpufreq/cpufreq_stats.c
> @@ -81,7 +81,7 @@ static ssize_t show_time_in_state(struct cpufreq_policy *policy, char *buf)
>         for (i = 0; i < stat->state_num; i++) {
>                 len += sprintf(buf + len, "%u %llu\n", stat->freq_table[i],
>                         (unsigned long long)
> -                       cputime64_to_clock_t(stat->time_in_state[i]));
> +                       jiffies_64_to_clock_t(stat->time_in_state[i]));

I tried to go to the history a bit but really couldn't make out what was
the real intention initially:

Following patches did this change:

-               stat->time_in_state[stat->last_index] +=
-                       delta_time(stat->last_time, jiffies);
-       stat->last_time = jiffies;
+               stat->time_in_state[stat->last_index] =
+                       cputime64_add(stat->time_in_state[stat->last_index],
+                                     cputime_sub(cur_time, stat->last_time));

commit 58f1df25403988b73d7129fcd2c4d4c24017f1af
Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Date:   Wed May 25 14:46:50 2005 -0700

    [PATCH] cpufreq-stats driver updates


And it was then simplified by:

commit 648616343cdbe904c585a6c12e323d3b3c72e46f
Author: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date:   Thu Dec 15 14:56:09 2011 +0100

    [S390] cputime: add sparse checking and cleanup

-               stat->time_in_state[stat->last_index] =
-                       cputime64_add(stat->time_in_state[stat->last_index],
-                                     cputime_sub(cur_time, stat->last_time));
+               stat->time_in_state[stat->last_index] +=
+                       cur_time - stat->last_time;


And obviously cur_time is in jiffies... I am okay with your patch
if Rafael doesn't see any issues with it...

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
