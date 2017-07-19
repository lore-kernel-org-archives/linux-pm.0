From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
Subject: Re: [PATCH] PM / OPP: Don't check not plugged in CPUs to avoid error
Date: Wed, 19 Jul 2017 16:10:23 +0200
Message-ID: <CAHKzcENsE=So2omU2v27XoHEbvcpW1gmB5P0NM=Z-Bg=f_O_4g@mail.gmail.com>
References: <20170713122201.30048-1-waldemarx.rymarkiewicz@intel.com>
 <20170713234226.GE22780@codeaurora.org> <20170717071234.GK352@vireshk-i7>
 <CAHKzcEP5+btsJ1Tog4KQAynmmbBSixfWAxO9V0EFWeP5pP5M=w@mail.gmail.com> <20170718043536.GT352@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33351 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751400AbdGSOLF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jul 2017 10:11:05 -0400
Received: by mail-wm0-f68.google.com with SMTP id 65so255861wmf.0
        for <linux-pm@vger.kernel.org>; Wed, 19 Jul 2017 07:11:05 -0700 (PDT)
In-Reply-To: <20170718043536.GT352@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>
Cc: Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>, linux-pm@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>

On 18 July 2017 at 06:35, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 17-07-17, 15:03, Waldemar Rymarkiewicz wrote:
> init() is called only once for a cpufreq policy and it should fill
> policy->cpus with all the *possible* CPUs that share their
> clock/voltage rails. i.e. it includes the CPUs which aren't hotplugged
> in yet.
> Later on when the CPU gets hotplugged in, we check it in existing
> policies ->related_cpus field. If its their, then very minimal stuff
> is done, else a new policy is created.

I see. That is not obvious from the code what policy->cpus should
initially include. Now I understand.

policy->related_cpu contains online+offline cpus that share this policy
policy->cpus initially includes online+offline, but end the end it
keeps online cpus mask only that share this policy.

> So policy->init() sets policy->cpus to all online+offline CPUs. That
> is copied to related_cpus by core and then policy->cpus is capped to
> only have online CPUs.

>> I don't think so there is an up streamed code that uses opp framework
>> in such use case. I use MIPS platform which starts with maxcpu=4 but
>> it puts 2 cpus offline at boot up for some reason. Will try to check
>> how cpufreq behave if I hot-add a CPU in runtime.
>
> Ok.
Unfortunately, I failed to test this on my platform, seems like
hotplug is not fully supported yet.

Anyway, below a proposal how we can solve the problem of getting
shared CPUs when hotplug is used.


@@ -555,8 +576,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_of_cpumask_add_table);
 int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev,
                                   struct cpumask *cpumask)
 {
-       struct device_node *np, *tmp_np;
-       struct device *tcpu_dev;
+       struct device_node *np, *tmp_np, *cpu_np;
        int cpu, ret = 0;

        /* Get OPP descriptor node */
@@ -572,22 +592,16 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev,
        if (!of_property_read_bool(np, "opp-shared"))
                goto put_cpu_node;

-       for_each_possible_cpu(cpu) {
+       for_each_node_by_type(cpu_np, "cpu") {
+               cpu = of_device_node_get_cpu(cpu_np);
+
                if (cpu == cpu_dev->id)
                        continue;

-               tcpu_dev = get_cpu_device(cpu);
-               if (!tcpu_dev) {
-                       dev_err(cpu_dev, "%s: failed to get cpu%d device\n",
-                               __func__, cpu);
-                       ret = -ENODEV;
-                       goto put_cpu_node;
-               }
-
                /* Get OPP descriptor node */
-               tmp_np = _of_get_opp_desc_node(tcpu_dev);
+               tmp_np = of_parse_phandle(cpu_np, "operating-points-v2", 0);
                if (!tmp_np) {
-                       dev_err(tcpu_dev, "%s: Couldn't find tcpu_dev node.\n",
+                       dev_err(cpu_dev, "%s: Couldn't find tcpu_dev node.\n",
                                __func__);
                        ret = -ENOENT;
                        goto put_cpu_node;


the helper function
   of_device_node_get_cpu()
comes from ML  https://patchwork.kernel.org/patch/9830203/

What are your thoughts?

/Waldek
