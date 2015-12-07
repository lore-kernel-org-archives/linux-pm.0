From: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Subject: Re: [PATCH v2] cpufreq: mt8173: move resources allocation into ->probe()
Date: Mon, 7 Dec 2015 20:42:19 +0800
Message-ID: <CALx668XbV2CbuB0QL_3eV=JMTeOyjKP=s2mznadQxgGD_SGABg@mail.gmail.com>
References: <1448785898-17838-4-git-send-email-pi-cheng.chen@linaro.org>
	<1449295306-9222-1-git-send-email-pi-cheng.chen@linaro.org>
	<CAGS+omBwHVAARNA=ZwK+fAwfJye6eDnxoKW6qCaH_haqsw9PJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f177.google.com ([209.85.160.177]:33357 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753450AbbLGMmU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2015 07:42:20 -0500
Received: by ykdv3 with SMTP id v3so192371374ykd.0
        for <linux-pm@vger.kernel.org>; Mon, 07 Dec 2015 04:42:20 -0800 (PST)
In-Reply-To: <CAGS+omBwHVAARNA=ZwK+fAwfJye6eDnxoKW6qCaH_haqsw9PJA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Ricky Liang <jcliang@chromium.org>, "moderated list:ARM/Mediatek SoC..." <linux-mediatek@lists.infradead.org>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hi Daniel,

On Mon, Dec 7, 2015 at 10:44 AM, Daniel Kurtz <djkurtz@chromium.org> wrote:
> Hi Pi-Cheng,
>
> On Sat, Dec 5, 2015 at 2:01 PM, Pi-Cheng Chen <pi-cheng.chen@linaro.org> wrote:
>> Since the return value of ->init() of cpufreq driver is not propagated
>> to the device driver model now, move resources allocation into
>> ->probe() to handle -EPROBE_DEFER properly.
>>
>> Signed-off-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
>> ---
>> v1->v2:
>> - fix error handling path in ->probe()
>> ---
>>  drivers/cpufreq/mt8173-cpufreq.c | 98 ++++++++++++++++++++++++++++------------
>>  1 file changed, 70 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/cpufreq/mt8173-cpufreq.c b/drivers/cpufreq/mt8173-cpufreq.c
>> index 9d0fe37..257bcb9 100644
>> --- a/drivers/cpufreq/mt8173-cpufreq.c
>> +++ b/drivers/cpufreq/mt8173-cpufreq.c
>> @@ -41,16 +41,35 @@
>>   * the original PLL becomes stable at target frequency.
>>   */
>>  struct mtk_cpu_dvfs_info {
>> +       struct cpumask cpus;
>>         struct device *cpu_dev;
>>         struct regulator *proc_reg;
>>         struct regulator *sram_reg;
>>         struct clk *cpu_clk;
>>         struct clk *inter_clk;
>>         struct thermal_cooling_device *cdev;
>> +       struct list_head list_head;
>>         int intermediate_voltage;
>>         bool need_voltage_tracking;
>>  };
>>
>> +static LIST_HEAD(dvfs_info_list);
>
> This struct is specific to this driver, so:
>
> mtk_cpu_dvfs_info_list

That's fair. Both work for me.
But since it's a static variable, I prefer the shorter name since it won't
be misunderstood.

>
>> +
>> +struct mtk_cpu_dvfs_info *get_dvfs_info(int cpu)
>
> static

Will do it.

>
> Also, it would be clearer to name this function something like
> "mtk_cpu_dfs_info_lookup" since "mtk_cpu_dfs_info" is the type this
> function looks up in the list.
> It would also match the other functions such as "mtk_cpu_dvfs_info_init()".

mtk_cpu_dvfs_info_lookup() looks good to me.
WIll do it.

>
>> +{
>> +       struct mtk_cpu_dvfs_info *info;
>> +       struct list_head *list;
>> +
>> +       list_for_each(list, &dvfs_info_list) {
>> +               info = list_entry(list, struct mtk_cpu_dvfs_info, list_head);
>> +
>> +               if (cpumask_test_cpu(cpu, &info->cpus))
>> +                       return info;
>> +       }
>> +
>> +       return NULL;
>> +}
>> +
>>  static int mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info *info,
>>                                         int new_vproc)
>>  {
>> @@ -402,6 +421,9 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
>>          */
>>         info->need_voltage_tracking = !IS_ERR(sram_reg);
>>
>> +       /* CPUs in the same cluster share a clock and power domain. */
>> +       cpumask_copy(&info->cpus, &cpu_topology[cpu].core_sibling);
>> +
>>         return 0;
>>
>>  out_free_opp_table:
>> @@ -440,47 +462,32 @@ static int mtk_cpufreq_init(struct cpufreq_policy *policy)
>>         struct cpufreq_frequency_table *freq_table;
>>         int ret;
>>
>> -       info = kzalloc(sizeof(*info), GFP_KERNEL);
>> -       if (!info)
>> -               return -ENOMEM;
>> -
>> -       ret = mtk_cpu_dvfs_info_init(info, policy->cpu);
>> -       if (ret) {
>> -               pr_err("%s failed to initialize dvfs info for cpu%d\n",
>> -                      __func__, policy->cpu);
>> -               goto out_free_dvfs_info;
>> +       info = get_dvfs_info(policy->cpu);
>> +       if (!info) {
>> +               pr_err("dvfs info for cpu%d is not initialized.\n",
>> +                      policy->cpu);
>> +               return -EINVAL;
>>         }
>>
>>         ret = dev_pm_opp_init_cpufreq_table(info->cpu_dev, &freq_table);
>
> Hmm. Does this change at init() time?  Or can we move this to probe(), too?

It doesn't change at init() time for MT8173 since we don't add OPP
dynamically and I don't see any problem to move it. I will move it to probe().

>
>>         if (ret) {
>>                 pr_err("failed to init cpufreq table for cpu%d: %d\n",
>>                        policy->cpu, ret);
>> -               goto out_release_dvfs_info;
>> +               return ret;
>>         }
>>
>>         ret = cpufreq_table_validate_and_show(policy, freq_table);
>>         if (ret) {
>>                 pr_err("%s: invalid frequency table: %d\n", __func__, ret);
>> -               goto out_free_cpufreq_table;
>> +               dev_pm_opp_free_cpufreq_table(info->cpu_dev, &freq_table);
>> +               return ret;
>
> If dev_pm_opp_init_cpufreq_table() really is needed at init() time,
> then please don't change this; still use "goto out_free_cpufreq_table"
> here.
>
>>         }
>>
>> -       /* CPUs in the same cluster share a clock and power domain. */
>> -       cpumask_copy(policy->cpus, &cpu_topology[policy->cpu].core_sibling);
>> +       cpumask_copy(policy->cpus, &info->cpus);
>>         policy->driver_data = info;
>>         policy->clk = info->cpu_clk;
>>
>>         return 0;
>> -
>> -out_free_cpufreq_table:
>> -       dev_pm_opp_free_cpufreq_table(info->cpu_dev, &freq_table);
>> -
>> -out_release_dvfs_info:
>> -       mtk_cpu_dvfs_info_release(info);
>> -
>> -out_free_dvfs_info:
>> -       kfree(info);
>> -
>> -       return ret;
>>  }
>>
>>  static int mtk_cpufreq_exit(struct cpufreq_policy *policy)
>> @@ -489,8 +496,6 @@ static int mtk_cpufreq_exit(struct cpufreq_policy *policy)
>>
>>         cpufreq_cooling_unregister(info->cdev);
>>         dev_pm_opp_free_cpufreq_table(info->cpu_dev, &policy->freq_table);
>> -       mtk_cpu_dvfs_info_release(info);
>> -       kfree(info);
>>
>>         return 0;
>>  }
>> @@ -510,11 +515,48 @@ static struct cpufreq_driver mt8173_cpufreq_driver = {
>>
>>  static int mt8173_cpufreq_probe(struct platform_device *pdev)
>>  {
>> -       int ret;
>> +       struct mtk_cpu_dvfs_info *info;
>> +       struct list_head *list, *tmp;
>> +       int cpu, ret;
>> +
>> +       for_each_possible_cpu(cpu) {
>
> Is there an iterator for cpu clusters?  Would be useful here.
>
> Or, even better:
>  * Is there a way to way to map cpu to cpu cluster ID?
>  * Is there a way to count the number of clusters?
> If so you can just use an array of mtk_cpu_dvfs_info, and use a cpu's
> cluster ID as its index into the array.

As I originally planned, this driver should be easily extended support
for other
Mediatek platforms. For this reason, we should not assume there's a fixed
mapping for CPU ID and cluster ID and the CPU DVFS domain and cluster neither.
Furthermore, the CPU DVFS domain sharing information will be provided by
operating-points-v2 bindings on which I am working to migrate mt8173-cpufreq
driver. We should not put the same information in two different places.

>
>> +               info = get_dvfs_info(cpu);
>> +               if (info)
>> +                       continue;
>
> How could this ever return non-NULL?
> This is probe; it won't be called twice - not unless a prior probe()
> failed (and/or after .remove()), right?

Yes. it does return non-NULL for CPU1 and CPU3.
When it goes into the loop with cpu=0, mtk_cpu_dvfs_info_init() will copy the
cluster core_sibling mask to info->cpus:

cpumask_copy(&info->cpus, &cpu_topology[cpu].core_sibling);

which means cpu0 and cpu1 share this struct mtk_cpu_dvfs_info variable.
So when it goes into the loop with cpu=1, get_dvfs_info() will return the shared
data structure. Similar for CPU2 and CPU3.

BTW, the shared information from core_sibling cpumask will be replaced by
operating-points-v2 bindings later.

>
>> +
>> +               info = kzalloc(sizeof(*info), GFP_KERNEL);
>
> devm_kzalloc() (and you can then remove the kfree()'s below).

Yes. Will do it.

>
>> +               if (!info) {
>> +                       ret = -ENOMEM;
>> +                       goto release_dvfs_info_list;
>> +               }
>> +
>> +               ret = mtk_cpu_dvfs_info_init(info, cpu);
>> +               if (ret) {
>> +                       pr_err("%s failed to initialize dvfs info for cpu%d\n",
>> +                              __func__, cpu);
>
> dev_err(&pdev->dev, ) here and elsewhere.

Will do it.
Thanks for reviewing.

Pi-Cheng

>
> -Dan
>
>> +                       kfree(info);
>> +                       goto release_dvfs_info_list;
>> +               }
>> +
>> +               list_add(&info->list_head, &dvfs_info_list);
>> +       }
>>
>>         ret = cpufreq_register_driver(&mt8173_cpufreq_driver);
>> -       if (ret)
>> +       if (ret) {
>>                 pr_err("failed to register mtk cpufreq driver\n");
>> +               goto release_dvfs_info_list;
>> +       }
>> +
>> +       return 0;
>> +
>> +release_dvfs_info_list:
>> +       list_for_each_safe(list, tmp, &dvfs_info_list) {
>> +               info = list_entry(list, struct mtk_cpu_dvfs_info, list_head);
>> +
>> +               mtk_cpu_dvfs_info_release(info);
>> +               list_del(list);
>> +               kfree(info);
>> +       }
>>
>>         return ret;
>>  }
>> --
>> 1.9.1
>>
