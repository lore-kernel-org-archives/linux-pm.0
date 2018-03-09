From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC/RFT][PATCH v2 0/6] sched/cpuidle: Idle loop rework
Date: Fri, 9 Mar 2018 10:58:56 +0100
Message-ID: <CAJZ5v0hWDA7T=xaNZ1uTEDL_BjRj9zeFZY45AhsUAK5FtRovjw@mail.gmail.com>
References: <2067762.1uWBf5RSRc@aspire.rjw.lan> <1520505099.7807.60.camel@suse.de>
 <CAJZ5v0gCi7bLL_r45qmoOKwh_dWF_RVs0U5UPe3qY45GbvtK9w@mail.gmail.com> <1520516417.7807.88.camel@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1520516417.7807.88.camel@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Galbraith <mgalbraith@suse.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Zijlstra <peterz@infradead.org>, Linux PM <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker <fweisbec@gmail.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Thomas Ilsche <thomas.ilsche@tu-dresden.de>, Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>, Aubrey Li <aubrey.li@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 8, 2018 at 2:40 PM, Mike Galbraith <mgalbraith@suse.de> wrote:
> On Thu, 2018-03-08 at 12:10 +0100, Rafael J. Wysocki wrote:
>> On Thu, Mar 8, 2018 at 11:31 AM, Mike Galbraith <mgalbraith@suse.de> wrote:
>>                               1     2     3
>> > 4.16.0.g1b88acc-master     6.95  7.03  6.91 (virgin)
>> > 4.16.0.g1b88acc-master     7.20  7.25  7.26 (+v2)
>> > 4.16.0.g1b88acc-master     6.90  7.06  6.95 (+local)
>> >
>> > Why would v2 charge the light firefox load a small but consistent fee?
>>
>> Two effects may come into play here I think.
>>
>> One is that allowing the tick to run biases the menu governor's
>> predictions towards the lower end, so we may use shallow states more
>> as a result then (Peter was talking about that).
>
> Hm, I'd expect that to show up in +local as well then, as it keeps the
> tick running when avg_idle < sched_migration_cost (convenient magic
> number), but the firefox load runs at the same wattage as virgin.  I'm
> also doing this...
>
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -335,7 +335,7 @@ static int menu_select(struct cpuidle_dr
>                  * C1's exit latency exceeds the user configured limit.
>                  */
>                 polling_threshold = max_t(unsigned int, 20, s->target_residency);
> -               if (data->next_timer_us > polling_threshold &&
> +               if (expected_interval > polling_threshold &&
>                     latency_req > s->exit_latency && !s->disabled &&
>                     !dev->states_usage[1].disable)
>                         first_idx = 1;
>
> ...to help out high frequency cross core throughput, but the firefox
> load apparently doesn't tickle that, as significant polling would
> surely show in the wattage.

OK, so the second reason sounds more likely to me.

Anyway, please retest with the v3 I've just posted.  The previous
iteration had a rather serious issue that might very well influence
the results (it was using stale values sometimes).
