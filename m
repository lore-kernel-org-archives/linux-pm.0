From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH linux-pm] cpufreq: governors: Fix calculation of wall time
 in get_cpu_idle_time
Date: Fri, 22 Mar 2013 17:09:51 +0530
Message-ID: <CAOh2x=kwt918pdOMDYAVB7qEP2o57cnKH8AR6p_gwHOgc0AywA@mail.gmail.com>
References: <514C0555.1010806@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ve0-f170.google.com ([209.85.128.170]:46196 "EHLO
	mail-ve0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932160Ab3CVLjw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Mar 2013 07:39:52 -0400
In-Reply-To: <514C0555.1010806@semaphore.gr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Mar 22, 2013 at 12:46 PM, Stratos Karafotis
<stratosk@semaphore.gr> wrote:
> With commit 8755a8ae31ba213db196324011a0da2a85807f25 the wall in
> get_cpu_idle_time is not calculated, when we use ondemand with
> io_is_busy = 1, preventing the CPU to increase to max frequency.
>
> Properly, calculate wall time when we use io_is_busy.
>
> Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
> ---
>  drivers/cpufreq/cpufreq_governor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> index b49d45d..41e5e56 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -53,7 +53,7 @@ static inline u64 get_cpu_idle_time_jiffy(unsigned int cpu, u64 *wall)
>
>  u64 get_cpu_idle_time(unsigned int cpu, u64 *wall, int io_busy)
>  {
> -       u64 idle_time = get_cpu_idle_time_us(cpu, NULL);
> +       u64 idle_time = get_cpu_idle_time_us(cpu, io_busy ? wall : NULL);
>
>         if (idle_time == -1ULL)
>                 return get_cpu_idle_time_jiffy(cpu, wall);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
