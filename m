From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpuidle: use high confidence factors only when
 considering polling
Date: Sat, 19 Mar 2016 00:40:01 +0100
Message-ID: <CAJZ5v0iZwhEer2F4wyY5P7FFfnnEMxs0pMdgmgLjLXbFngYPgw@mail.gmail.com>
References: <CAJvTdK=d-LngrEXavQKX9C2p=9qrZ-DhnBG_mRnP9RDVHjKhpA@mail.gmail.com>
	<CAJZ5v0iK=vO1HPKfbpMwNx_Tk-kjGEUKrCmehaK7nN+-Up7BoA@mail.gmail.com>
	<20160316121400.680a6a46@annuminas.surriel.com>
	<10828426.sI6CaBvZhk@vostro.rjw.lan>
	<000701d180df$e8a14340$b9e3c9c0$@net>
	<CAJZ5v0gLXE=sRxv35hKuX88L4tphSBtPb9Y2oLERuEhjsbTGJQ@mail.gmail.com>
	<003301d18144$87bb8df0$9732a9d0$@net>
	<20160318152957.5c3b91bc@annuminas.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f50.google.com ([209.85.215.50]:33154 "EHLO
	mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752704AbcCRXkD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Mar 2016 19:40:03 -0400
Received: by mail-lf0-f50.google.com with SMTP id h198so75442653lfh.0
        for <linux-pm@vger.kernel.org>; Fri, 18 Mar 2016 16:40:02 -0700 (PDT)
In-Reply-To: <20160318152957.5c3b91bc@annuminas.surriel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rik van Riel <riel@redhat.com>
Cc: Doug Smythies <dsmythies@telus.net>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Arto Jantunen <viiru@iki.fi>, Len Brown <lenb@kernel.org>

On Fri, Mar 18, 2016 at 8:29 PM, Rik van Riel <riel@redhat.com> wrote:
> On Fri, 18 Mar 2016 11:32:28 -0700
> "Doug Smythies" <dsmythies@telus.net> wrote:
>> On 2016.03.18 06:12 Rafael J. Wysocki wrote:
>
>> > I'm wondering what happens if you replace the expected_interval in the
>> > "expected_interval >
>> > drv->states[CPUIDLE_DRIVER_STATE_START].target_residency" test with
>> > data->next_timer_us (with the Rik's patch applied, of course).  Can
>> > you please try doing that?
>>
>> O.K. my reference: rvr6 is the above modification to rvr5
>> It works as well as "reverted"/
>>
>> State k45rc7-rjw10-rvr6 (mins)
>> 0.00  0.87
>> 1.00  24.20
>> 2.00  4.05
>> 3.00  1.72
>> 4.00  147.50
>>
>> total 178.34
>>
>> Energy:
>> Kernel 4.5-rc7-rjw10-rvr6: 55864 Joules
>>
>> Trace data (very crude summary):
>> Kernel 4.5-rc7-rjw10-rvr5: ~3049 long durations at high CPU load (idle state 0)
>> Kernel 4.5-rc7-rjw10-rvr5: ~183 long durations at high, but less, CPU load (not all idle state 0)
>
> What does "long duration" mean?
> Dozens of microseconds?
> Hundreds of microseconds?
> Milliseconds?
>
> Either way, it appears there is something wrong with the
> code in get_typical_interval.  One of the problems is
> that calculating in microseconds, when working with a
> threshold of 1-2 microseconds is not going to work well,
> and secondly the code declares success the moment the
> standard deviation is below 20 microseconds, which is
> also not the best idea when dealing with 1-2 microsecond
> thresholds :)
>
> Does the below patch help?
>
> If it does, we will probably want to change the values in
> the driver tables to nanoseconds too, so we can get rid of
> the multiplications :)
>
> ---8<---
>
> Subject: cpuidle: track time in nsecs not usecs
>
> The cpuidle code currently tracks time in microseconds, which
> has a few issues. For one, the kernel natively tracks time in
> nanoseconds, and we do a divide by 1000 when tracking how long
> the CPU spent in an idle state.
>
> Secondly, get_typical_interval in the menu governor cannot do
> very useful math when working with small numbers, while the
> HLT cutoff is only 1 or 2 microseconds on many CPUs.
>
> Converting to nanoseconds avoids the expensive divide, and
> also allows get_typical_interval to do calculations that
> may make more sense for smaller intervals.
>
> While we're there, also remove the code that allows
> get_typical_interval to return a value as soon as the
> standard deviation is under 20 microseconds.  That
> threshold makes little sense when C1 and C2 both
> have latencies much lower than that.
>
> Signed-off-by: Rik van Riel <riel@redhat.com>
> ---
>  drivers/cpuidle/cpuidle.c          | 10 ++---
>  drivers/cpuidle/governors/ladder.c |  2 +-
>  drivers/cpuidle/governors/menu.c   | 90 +++++++++++++++++---------------------
>  drivers/cpuidle/sysfs.c            |  8 +++-
>  include/linux/cpuidle.h            |  4 +-
>  5 files changed, 56 insertions(+), 58 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index f996efc56605..8a0673880fbe 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -217,18 +217,18 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
>         if (!cpuidle_state_is_coupled(drv, entered_state))
>                 local_irq_enable();
>
> -       diff = ktime_to_us(ktime_sub(time_end, time_start));
> -       if (diff > INT_MAX)
> -               diff = INT_MAX;
> +       diff = ktime_to_ns(ktime_sub(time_end, time_start));
> +       if (diff > LONG_MAX)
> +               diff = LONG_MAX;
>
> -       dev->last_residency = (int) diff;
> +       dev->last_residency = diff;
>
>         if (entered_state >= 0) {
>                 /* Update cpuidle counters */
>                 /* This can be moved to within driver enter routine
>                  * but that results in multiple copies of same code.
>                  */
> -               dev->states_usage[entered_state].time += dev->last_residency;
> +               dev->states_usage[entered_state].time += diff;
>                 dev->states_usage[entered_state].usage++;
>         } else {
>                 dev->last_residency = 0;
> diff --git a/drivers/cpuidle/governors/ladder.c b/drivers/cpuidle/governors/ladder.c
> index 63bd5a403e22..6b480a3a3a2e 100644
> --- a/drivers/cpuidle/governors/ladder.c
> +++ b/drivers/cpuidle/governors/ladder.c
> @@ -80,7 +80,7 @@ static int ladder_select_state(struct cpuidle_driver *drv,
>
>         last_state = &ldev->states[last_idx];
>
> -       last_residency = cpuidle_get_last_residency(dev) - drv->states[last_idx].exit_latency;
> +       last_residency = ktime_to_us(cpuidle_get_last_residency(dev)) - drv->states[last_idx].exit_latency;
>
>         /* consider promotion */
>         if (last_idx < drv->state_count - 1 &&
> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
> index fba867d917f7..69adb6ab7b8c 100644
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -33,9 +33,9 @@
>  #define BUCKETS 12
>  #define INTERVAL_SHIFT 3
>  #define INTERVALS (1UL << INTERVAL_SHIFT)
> -#define RESOLUTION 1024
> +#define RESOLUTION NSEC_PER_USEC
>  #define DECAY 8
> -#define MAX_INTERESTING 50000
> +#define MAX_INTERESTING 4000000
>
>
>  /*
> @@ -122,11 +122,11 @@ struct menu_device {
>         int             last_state_idx;
>         int             needs_update;
>
> -       unsigned int    next_timer_us;
> -       unsigned int    predicted_us;
> +       u64             next_timer_ns;
> +       u64             predicted_ns;
>         unsigned int    bucket;
>         unsigned int    correction_factor[BUCKETS];
> -       unsigned int    intervals[INTERVALS];
> +       u64             intervals[INTERVALS];
>         int             interval_ptr;
>  };
>
> @@ -152,15 +152,15 @@ static inline int which_bucket(unsigned int duration, unsigned long nr_iowaiters
>         if (nr_iowaiters)
>                 bucket = BUCKETS/2;
>
> -       if (duration < 10)
> +       if (duration < 10000)
>                 return bucket;
> -       if (duration < 100)
> +       if (duration < 100000)
>                 return bucket + 1;
> -       if (duration < 1000)
> +       if (duration < 1000000)
>                 return bucket + 2;
> -       if (duration < 10000)
> +       if (duration < 10000000)
>                 return bucket + 3;
> -       if (duration < 100000)
> +       if (duration < 100000000)
>                 return bucket + 4;
>         return bucket + 5;
>  }
> @@ -242,21 +242,12 @@ static unsigned int get_typical_interval(struct menu_device *data)
>          * The typical interval is obtained when standard deviation is small
>          * or standard deviation is small compared to the average interval.
>          *
> -        * int_sqrt() formal parameter type is unsigned long. When the
> -        * greatest difference to an outlier exceeds ~65 ms * sqrt(divisor)
> -        * the resulting squared standard deviation exceeds the input domain
> -        * of int_sqrt on platforms where unsigned long is 32 bits in size.
> -        * In such case reject the candidate average.
> -        *
> -        * Use this result only if there is no timer to wake us up sooner.
> +        * Instead of taking the square root of the standard deviation,
> +        * use the square of the average. Be careful to avoid overflow.
>          */
> -       if (likely(stddev <= ULONG_MAX)) {
> -               stddev = int_sqrt(stddev);
> -               if (((avg > stddev * 6) && (divisor * 4 >= INTERVALS * 3))
> -                                                       || stddev <= 20) {
> -                       return avg;
> -               }
> -       }
> +       if (avg < INT_MAX && (avg * avg) > stddev * 9 &&
> +                                       divisor * 4 >= INTERVALS * 3)
> +               return avg;
>
>         /*
>          * If we have outliers to the upside in our distribution, discard

This has to be rebased on top of the current Linus' tree.  It already
uses variance here.
