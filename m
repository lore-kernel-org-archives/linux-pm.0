From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 01/20] cpufreq: Introduce macros for cpufreq_frequency_table
 iteration
Date: Tue, 15 Apr 2014 11:00:53 +0530
Message-ID: <CAKohpomsXSGARKmc5hamXb7joPp+8M8CyEKAbkZ0z7bJboHCdA@mail.gmail.com>
References: <534C4E29.2020605@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <534C4E29.2020605@semaphore.gr>
Sender: linux-doc-owner@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "David S. Miller" <davem@davemloft.net>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Dirk Brandewie <dirk.j.brandewie@intel.com>, Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 15 April 2014 02:37, Stratos Karafotis <stratosk@semaphore.gr> wrote:
> diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
> @@ -193,9 +191,9 @@ int cpufreq_frequency_table_get_index(struct cpufreq_policy *policy,
>                 return -ENOENT;
>         }
>
> -       for (i = 0; table[i].frequency != CPUFREQ_TABLE_END; i++) {
> -               if (table[i].frequency == freq)
> -                       return i;
> +       cpufreq_for_each_entry(pos, table) {
> +               if (pos->frequency == freq)
> +                       return pos - table;
>         }

I asked you to do this in V1:

use cpufreq_for_each_valid_entry() here as well.
