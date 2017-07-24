From: Gautham R Shenoy <ego.lkml@gmail.com>
Subject: Re: [PATCH] Fix header-name to read full state name and adjust column width
Date: Mon, 24 Jul 2017 15:41:11 +0530
Message-ID: <CAHZ_5WwfS52JVM_-Ws7yh2yuZYTn5T1vmhT=z1k9oN1yF_fdrA@mail.gmail.com>
References: <1499325264-15521-1-git-send-email-s1seetee@linux.vnet.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33247 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752201AbdGXKLM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jul 2017 06:11:12 -0400
In-Reply-To: <1499325264-15521-1-git-send-email-s1seetee@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, trenn@suse.com, ego@linux.vnet.ibm.com, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>

Hello Seeteena,

Thanks for this useful patch. Couple of suggestions below.

On Thu, Jul 6, 2017 at 12:44 PM, Seeteena Thoufeek
<s1seetee@linux.vnet.ibm.com> wrote:
> ---Steps to Reproduce---
>
> 1.Execute the cpupower monitor command to fetch all the Idle_Stats values.
>
> root:~# cpupower monitor
>               |Idle_Stats
> PKG |CORE|CPU | snoo | stop | stop
>    0|   8|   0|  0.00|  0.00|  2.79
>    0|   8|   1|  0.00|  0.00| 70.68
>
> User interpret it as 2 columns for stop Idle_stats.
>
> root:/sys/devices/system/cpu/cpu8/cpuidle# cat */name
> snooze
> stop0_lite
> stop1_lite
>
> cpupower monitor now shows full state name and adjust colomn width.
>
> root:~/linux/tools/power/cpupower# cpupower monitor
>               |Idle_Stats
> PKG |CORE|CPU |snooze|stop0_lite|stop1_lite
>    0|   8|   0|  0.00|      0.00|     99.83
>    0|   8|   1|  0.00|      0.00|     43.82
>    0|   8|   2|  0.00|      0.00|     102.1
>    0|   8|   3|  0.00|      0.00|     96.56
>
> tested on x86 as well.

Can you rewrite the commit log describing the problem and what you do
in this patch to mitigate the problem ?
Something along the lines of the following

"The names of the idle states in the output of cpupower monitor
command are truncated to 4 characters.
 Hence, On POWER9, since the states are named "stop0, stop1, stop2,
stop4, stop11" , this output is ambiguous

 root:~# cpupower monitor
               |Idle_Stats
 PKG |CORE|CPU | snoo | stop | stop
    0|   8|   0|  0.00|  0.00|  2.79
    0|   8|   1|  0.00|  0.00| 70.68

In this patch, we modify the output to print the full state name and
adjust the column width, that results in a
legible output.

 root:~/linux/tools/power/cpupower# cpupower monitor
               |Idle_Stats
 PKG |CORE|CPU |snooze|stop0_lite|stop1_lite
    0|   8|   0|  0.00|      0.00|     99.83
    0|   8|   1|  0.00|      0.00|     43.82
    0|   8|   2|  0.00|      0.00|     102.1
    0|   8|   3|  0.00|      0.00|     96.56


Tested on POWER8, POWER9 and x86."

> Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
> ---
>  .../cpupower/utils/idle_monitor/cpupower-monitor.c | 25 ++++++++++++++--------
>  .../cpupower/utils/idle_monitor/cpupower-monitor.h |  2 +-
>  2 files changed, 17 insertions(+), 10 deletions(-)
>
> diff --git a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
> index 05f953f..5e708d5 100644
> --- a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
> +++ b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
> @@ -88,7 +88,7 @@ void print_header(int topology_depth)
>         int state, need_len;
>         cstate_t s;
>         char buf[128] = "";
> -       int percent_width = 4;
> +       unsigned int percent_width = 6;

While you are at it, can we have these as #defines? i.e.

#define COL_WIDTH_MIN       6

>
>         fill_string_with_spaces(buf, topology_depth * 5 - 1);
>         printf("%s|", buf);
> @@ -116,17 +116,18 @@ void print_header(int topology_depth)
>         for (mon = 0; mon < avail_monitors; mon++) {
>                 if (mon != 0)
>                         printf("|| ");
> -               else
> -                       printf(" ");
>                 for (state = 0; state < monitors[mon]->hw_states_num; state++) {
>                         if (state != 0)
> -                               printf(" | ");
> +                               printf("|");
>                         s = monitors[mon]->hw_states[state];
>                         sprintf(buf, "%s", s.name);
> -                       fill_string_with_spaces(buf, percent_width);
> +                       if (strlen(s.name) > percent_width)
> +                               fill_string_with_spaces(buf, strlen(s.name));

When we have many states (and on POWER9 we can have upto 8 idle
states), printing the full name
may not be advisable. We can instead define COL_WIDTH_MAX along with
COL_WIDTH_MIN and set
the percent_width to the length of the state's name only when that
length is in the interval [COL_WIDTH_MIN, COL_WIDTH_MAX]
Something like the following?

#define COL_WIDTH_MIN      4
#define COL_WIDTH_MAX     8


name_len = strlen(s.name);
if (name_len < COL_WIDTH_MIN)
       percent_width = COL_WIDTH_MIN;
else if (name_len > COL_WIDTH_MAX )
       percent_width = COL_WIDTH_MAX;
else
       percent_width = name_len;

fill_string_with_spaces(buf, percent_width)
> +                       else
> +                               fill_string_with_spaces(buf, percent_width);
> +
>                         printf("%s", buf);
> -               }
> -               printf(" ");
> +                       }
>         }
>         printf("\n");
>  }
> @@ -139,7 +140,9 @@ void print_results(int topology_depth, int cpu)
>         double percent;
>         unsigned long long result;
>         cstate_t s;
> -
> +       char buf[128] = "";
> +       unsigned int percent_width = 6;
> +       unsigned int width;
>         /* Be careful CPUs may got resorted for pkg value do not just use cpu */
>         if (!bitmask_isbitset(cpus_chosen, cpu_top.core_info[cpu].cpu))
>                 return;
> @@ -163,7 +166,11 @@ void print_results(int topology_depth, int cpu)
>                                 printf("|");
>
>                         s = monitors[mon]->hw_states[state];
> -
> +                       if (strlen(s.name) > percent_width) {
> +                               width = strlen(s.name) - percent_width;
> +                               fill_string_with_spaces(buf, width);
> +                               printf("%s", buf);
> +                       }
>                         if (s.get_count_percent) {
>                                 ret = s.get_count_percent(s.id, &percent,
>                                                   cpu_top.core_info[cpu].cpu);
> diff --git a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.h b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.h
> index 9e43f33..c9179c6 100644
> --- a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.h
> +++ b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.h
> @@ -15,7 +15,7 @@
>
>  #define MONITORS_MAX 20
>  #define MONITOR_NAME_LEN 20
> -#define CSTATE_NAME_LEN 5
> +#define CSTATE_NAME_LEN 16

So, this is based on the CPUIDLE_NAME_LEN I suppose. You might want to
add a comment
about it here.


>  #define CSTATE_DESC_LEN 60
>
>  int cpu_count;
> --
> 1.8.3.1
>

Otherwise the patch looks good.

Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

-- 
Thanks and Regards
gautham.
