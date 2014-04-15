From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 03/20] cpufreq: stats: Use cpufreq_for_each_valid_entry
 macro for iteration
Date: Tue, 15 Apr 2014 11:05:17 +0530
Message-ID: <CAKohpo=25ed_2azaiUFtou75j_yNeP-QN=t5ZWTdgTtDV1DBpg@mail.gmail.com>
References: <534C4E48.9080601@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <534C4E48.9080601@semaphore.gr>
Sender: cpufreq-owner@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 15 April 2014 02:38, Stratos Karafotis <stratosk@semaphore.gr> wrote:
> The cpufreq core supports the cpufreq_for_each_valid_entry macro
> helper for iteration over the cpufreq_frequency_table, so use it.
>
> It should have no functional changes.
>
> Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
> ---
>  drivers/cpufreq/cpufreq_stats.c | 22 ++++++++--------------
>  1 file changed, 8 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> index ecaaebf..223078d 100644
> --- a/drivers/cpufreq/cpufreq_stats.c
> +++ b/drivers/cpufreq/cpufreq_stats.c
> @@ -182,11 +182,11 @@ static void cpufreq_stats_free_table(unsigned int cpu)
>
>  static int __cpufreq_stats_create_table(struct cpufreq_policy *policy)
>  {
> -       unsigned int i, j, count = 0, ret = 0;
> +       unsigned int i, count = 0, ret = 0;
>         struct cpufreq_stats *stat;
>         unsigned int alloc_size;
>         unsigned int cpu = policy->cpu;
> -       struct cpufreq_frequency_table *table;
> +       struct cpufreq_frequency_table *pos, *table;
>
>         table = cpufreq_frequency_get_table(cpu);
>         if (unlikely(!table))
> @@ -205,10 +205,7 @@ static int __cpufreq_stats_create_table(struct cpufreq_policy *policy)
>         stat->cpu = cpu;
>         per_cpu(cpufreq_stats_table, cpu) = stat;
>
> -       for (i = 0; table[i].frequency != CPUFREQ_TABLE_END; i++) {
> -               unsigned int freq = table[i].frequency;
> -               if (freq == CPUFREQ_ENTRY_INVALID)
> -                       continue;
> +       cpufreq_for_each_valid_entry(pos, table) {
>                 count++;
>         }

Remove {} as well..
