From: Dirk Brandewie <dirk.brandewie@gmail.com>
Subject: Re: BUG in bleeding edge c560f3d
Date: Tue, 05 Feb 2013 10:45:03 -0800
Message-ID: <5111532F.1060606@gmail.com>
References: <511033EA.7090604@gmail.com> <3463348.tWNCISaOfi@vostro.rjw.lan> <51104CC7.8030800@gmail.com> <2585398.78DPBR35EF@vostro.rjw.lan> <CAKohpo=-A+VTxsrMQk5SthHZLywrO-E3EHQnSs3_jG593cJzUw@mail.gmail.com> <CAKohpomDLWFP5tTnhTidOOrkEhW_z5Ht_MzbbnzDaq-i+-1aEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpomDLWFP5tTnhTidOOrkEhW_z5Ht_MzbbnzDaq-i+-1aEg@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Dirk Brandewie <dirk.brandewie@gmail.com>, cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 02/04/2013 11:08 PM, Viresh Kumar wrote:
> @Dirk: Please give this one a try. Atleast on my system with various
> configurations, i
> couldn't see any different this patch has made, but is more logical to me.
>

Tested works fine with and without my driver present.

I added it to my patch set with my Tested-by tag it seems gmail decided
to swallow it :-(

Please feel to add my Tested-by:

--Dirk
> commit 9bdd6d47403e696d05953870019e791806f8d6bf
> Author: Viresh Kumar <viresh.kumar@linaro.org>
> Date:   Tue Feb 5 12:28:18 2013 +0530
>
>      cpufreq: Don't remove sysfs link for policy->cpu
>
>      "cpufreq" directory in policy->cpu is never created using
> sysfs_create_link(),
>      but using kobject_init_and_add(). And so we shouldn't call
> sysfs_remove_link()
>      for policy->cpu(). sysfs stuff for policy->cpu is automatically
> removed when we
>      call kobject_put() for dying policy.
>
>      Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>   drivers/cpufreq/cpufreq.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 7aacfbf..9567451 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1047,7 +1047,9 @@ static int __cpufreq_remove_dev(struct device
> *dev, struct subsys_interface *sif
>          cpus = cpumask_weight(data->cpus);
>          cpumask_clear_cpu(cpu, data->cpus);
>
> -       if (unlikely((cpu == data->cpu) && (cpus > 1))) {
> +       if (cpu != data->cpu) {
> +               sysfs_remove_link(&dev->kobj, "cpufreq");
> +       } else if (cpus > 1) {
>                  /* first sibling now owns the new sysfs dir */
>                  cpu_dev = get_cpu_device(cpumask_first(data->cpus));
>                  sysfs_remove_link(&cpu_dev->kobj, "cpufreq");
> @@ -1072,7 +1074,6 @@ static int __cpufreq_remove_dev(struct device
> *dev, struct subsys_interface *sif
>          pr_debug("%s: removing link, cpu: %d\n", __func__, cpu);
>          cpufreq_cpu_put(data);
>          unlock_policy_rwsem_write(cpu);
> -       sysfs_remove_link(&dev->kobj, "cpufreq");
>
>          /* If cpu is last user of policy, free policy */
>          if (cpus == 1) {
>

