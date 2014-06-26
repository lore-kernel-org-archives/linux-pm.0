From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: arm_big_little: set lowest frequcency for
 cluster when no cpus in it
Date: Thu, 26 Jun 2014 21:08:10 +0530
Message-ID: <CAKohpomv=0y30q09fuuRDOGQ_XtuKnerC830vFExNok9mAcyfw@mail.gmail.com>
References: <1403795313-6903-1-git-send-email-thomas.ab@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:43525 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757085AbaFZPiL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Jun 2014 11:38:11 -0400
Received: by mail-ob0-f178.google.com with SMTP id wn1so4082904obc.37
        for <linux-pm@vger.kernel.org>; Thu, 26 Jun 2014 08:38:10 -0700 (PDT)
In-Reply-To: <1403795313-6903-1-git-send-email-thomas.ab@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>, Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

On 26 June 2014 20:38, Thomas Abraham <thomas.ab@samsung.com> wrote:
> From: Thomas Abraham <thomas.ab@samsung.com>
>
> If there are no active cpus in a cluster, the clock frequency of the cluster
> can be lowered to the lowest possible frequency for that cluster. This can
> help reduce the output clock speed of the PLL clocking the cluster and
> save power.
>
> The get_table_min() function is also moved with this change to avoid forward
> declaration. The function get_table_max() is also moved along with
> get_table_min() so that these two functions are adjacent the code.

Makes sense as my poor mind also thought this over an year and
half back.

> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> ---
>  drivers/cpufreq/arm_big_little.c |   51 +++++++++++++++++++++-----------------
>  1 file changed, 28 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
> index 1f4d4e3..4b1431f 100644
> --- a/drivers/cpufreq/arm_big_little.c
> +++ b/drivers/cpufreq/arm_big_little.c
> @@ -75,6 +75,28 @@ static inline int cpu_to_cluster(int cpu)
>                 MAX_CLUSTERS : raw_cpu_to_cluster(cpu);
>  }
>
> +/* get the minimum frequency in the cpufreq_frequency_table */
> +static inline u32 get_table_min(struct cpufreq_frequency_table *table)
> +{
> +       struct cpufreq_frequency_table *pos;
> +       uint32_t min_freq = ~0;
> +       cpufreq_for_each_entry(pos, table)
> +               if (pos->frequency < min_freq)
> +                       min_freq = pos->frequency;
> +       return min_freq;
> +}
> +
> +/* get the maximum frequency in the cpufreq_frequency_table */
> +static inline u32 get_table_max(struct cpufreq_frequency_table *table)
> +{
> +       struct cpufreq_frequency_table *pos;
> +       uint32_t max_freq = 0;
> +       cpufreq_for_each_entry(pos, table)
> +               if (pos->frequency > max_freq)
> +                       max_freq = pos->frequency;
> +       return max_freq;
> +}
> +
>  static unsigned int find_cluster_maxfreq(int cluster)
>  {
>         int j;
> @@ -170,9 +192,14 @@ bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
>
>                 mutex_lock(&cluster_lock[old_cluster]);
>
> -               /* Set freq of old cluster if there are cpus left on it */
> +               /*
> +                * Set freq of old cluster. If there are no cpus left on it,
> +                * set the lowest possible frequency for that cluster.
> +                */
>                 new_rate = find_cluster_maxfreq(old_cluster);
>                 new_rate = ACTUAL_FREQ(old_cluster, new_rate);
> +               if (!new_rate)
> +                       new_rate = get_table_min(freq_table[old_cluster]);

Have you hit this code? How did you test it?

In case you have hit this code, you must be using IKS as in MP it
doesn't make sense.

Two things:
- First in case this patch gets in, you can check !new_rate just after
  find_cluster_maxfreq() as it will be zero there as well..

- The counter argument given to me from Sudeep at that time was,
  "it is just a waste of time". Because if we aren't using the cluster
  anymore, it will be switched off very soon and there is no point
  wasting time changing freq to lowest..

  And I somewhat agreed to it then..

Cc'ing Nico as he can throw some light from MCPM's perspective
here.

--
viresh
