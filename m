From: Mohammad Merajul Islam Molla <meraj.enigma@gmail.com>
Subject: Need help understanding the logic of __cpuidle_set_driver
Date: Fri, 15 Aug 2014 16:20:37 +0600
Message-ID: <CAHu9=sOwSuw5igPp0UQWJe8fwMb_vt3PPrc1A9nK4pJB5QmXDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:49734 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917AbaHOKU5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 15 Aug 2014 06:20:57 -0400
Received: by mail-ig0-f182.google.com with SMTP id c1so1424936igq.3
        for <linux-pm@vger.kernel.org>; Fri, 15 Aug 2014 03:20:57 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kernelnewbies <kernelnewbies@kernelnewbies.org>, linux-pm@vger.kernel.org

Hello,

I was looking into the code of drivers/cpuidle/driver.c. I have some
doubts regarding the implementation of __cpuidle_set_driver function
when CONFIG_CPU_IDLE_MULTIPLE_DRIVERS is defined.

If CONFIG_CPU_IDLE_MULTIPLE_DRIVERS is defined, the code for
__cpuidle_set_driver/__cpuidle_unset_driver looks as -

 39  * __cpuidle_unset_driver - unset per CPU driver variables.
 40  * @drv: a valid pointer to a struct cpuidle_driver
 41  *
 42  * For each CPU in the driver's CPU mask, unset the registered
driver per CPU
 43  * variable. If @drv is different from the registered driver, the
corresponding
 44  * variable is not cleared.
 45  */
 46 static inline void __cpuidle_unset_driver(struct cpuidle_driver *drv)
 47 {
 48         int cpu;
 49
 50         for_each_cpu(cpu, drv->cpumask) {
 51
 52                 if (drv != __cpuidle_get_cpu_driver(cpu))
 53                         continue;
 54
 55                 per_cpu(cpuidle_drivers, cpu) = NULL;
 56         }
 57 }
 58
 59 /**
 60  * __cpuidle_set_driver - set per CPU driver variables for the given driver.
 61  * @drv: a valid pointer to a struct cpuidle_driver
 62  *
 63  * For each CPU in the driver's cpumask, unset the registered driver per CPU
 64  * to @drv.
 65  *
 66  * Returns 0 on success, -EBUSY if the CPUs have driver(s) already.
 67  */
 68 static inline int __cpuidle_set_driver(struct cpuidle_driver *drv)
 69 {
 70         int cpu;
 71
 72         for_each_cpu(cpu, drv->cpumask) {
 73
 74                 if (__cpuidle_get_cpu_driver(cpu)) {
 75                         __cpuidle_unset_driver(drv);
 76                         return -EBUSY;
 77                 }
 78
 79                 per_cpu(cpuidle_drivers, cpu) = drv;
 80         }
 81
 82         return 0;
 83 }

Apparently, the comment should be - "set/register the driver per CPU
to @drv" instead of "unset the registered driver per CPU to @drv" in
case of __cpuidle_set_driver.

However, regarding the logic, I have a few doubts -

1. for each cpu in drv->cpumask, if there is already a driver
registered, its calling __cpuidle_unset_driver which loops over for
each cpu in drv->cpumask again. Isn't it unnecessary to do this nested
calls?

2. after calling __cpuidle_unset_driver, if drv equals already
registered driver, it sets per_cpu driver to null? Isn't it wrong when
we are trying to set to a new driver? Why do we need to unset and make
the driver null when we are returning EBUSY from __cpuidle_set_driver?

Would it be correct and cleaner if the code is written as below -

 static inline int __cpuidle_set_driver(struct cpuidle_driver *drv)
 {
         int ret = -EBUSY;
         int cpu;

        for_each_cpu(cpu, drv->cpumask) {
                if (drv == __cpuidle_get_cpu_driver(cpu))    [if drv
is already the registered driver, do nothing]
                         continue;

                 per_cpu(cpuidle_drivers, cpu) = drv;  [if only drv !=
already registered driver, set per_cpu driver to drv and set ret 0]
                 ret = 0;
         }

         return ret;     [only if all cpus already had drv as
registered driver, return -EBUSY. Otherwise return 0]
 }


Please let me know your views.

--
Thanks,
-Meraj
