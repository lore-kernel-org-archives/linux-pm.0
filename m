From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH V2 7/8] ARM: cpuidle: Register per cpuidle device
Date: Thu, 19 Mar 2015 09:42:47 -0600
Message-ID: <20150319154247.GB589@linaro.org>
References: <1426704372-20406-1-git-send-email-daniel.lezcano@linaro.org>
 <1426704372-20406-8-git-send-email-daniel.lezcano@linaro.org>
 <20150319153112.GA589@linaro.org>
 <550AEC3C.5090200@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <550AEC3C.5090200@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@rjwysocki.net, lorenzo.pieralisi@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Catalin.Marinas@arm.com, robherring2@gmail.com, arnd@arndb.de, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 19 2015 at 09:33 -0600, Daniel Lezcano wrote:
>On 03/19/2015 04:31 PM, Lina Iyer wrote:
>>On Wed, Mar 18 2015 at 12:46 -0600, Daniel Lezcano wrote:
>>>Some architectures have some cpus which does not support idle states=
=2E
>>>
>>>Let the underlying low level code to return -ENOSYS when it is not
>>>possible to set an idle state.
>>>
>>>Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>---
>>>drivers/cpuidle/cpuidle-arm.c | 45
>>>+++++++++++++++++++++++++++++++++++++++++--
>>>1 file changed, 43 insertions(+), 2 deletions(-)
>>>
>>>diff --git a/drivers/cpuidle/cpuidle-arm.c
>>>b/drivers/cpuidle/cpuidle-arm.c
>>>index 1c94b88..0682ed0 100644
>>>--- a/drivers/cpuidle/cpuidle-arm.c
>>>+++ b/drivers/cpuidle/cpuidle-arm.c
>>>@@ -17,11 +17,14 @@
>>>#include <linux/kernel.h>
>>>#include <linux/module.h>
>>>#include <linux/of.h>
>>>+#include <linux/slab.h>
>>>
>>>#include <asm/cpuidle.h>
>>>
>>>#include "dt_idle_states.h"
>>>
>>>+static DEFINE_PER_CPU(struct cpuidle_device, *cpuidle_arm_dev);
>>
>>Is a per-cpu variable needed? There seems to be no per-cpu access, ot=
her
>>than at init.
>
>:)
>
>Actually it is the cpuidle framework which is using the per cpu variab=
le.
>

But this is static pointer, I can see that struct cpuidle_device * bein=
g
used by cpuidle framework.

It gets stored here?

DEFINE_PER_CPU(struct cpuidle_device *, cpuidle_devices);

But we dont need to save it here, for in this file, there is no per-cpu
access, other than when the registration fails.


>>>+
>>>/*
>>> * arm_enter_idle_state - Programs CPU to enter the specified state
>>> *
>>>@@ -94,6 +97,7 @@ static int __init arm_idle_init(void)
>>>{
>>>    int cpu, ret;
>>>    struct cpuidle_driver *drv =3D &arm_idle_driver;
>>>+    struct cpuidle_device *dev;
>>>
>>>    /*
>>>     * Initialize idle states data, starting at index 1.
>>>@@ -105,18 +109,55 @@ static int __init arm_idle_init(void)
>>>    if (ret <=3D 0)
>>>        return ret ? : -ENODEV;
>>>
>>>+    ret =3D cpuidle_register_driver(drv);
>>>+    if (ret) {
>>>+        pr_err("Failed to register cpuidle driver\n");
>>>+        return ret;
>>>+    }
>>>+
>>>    /*
>>>     * Call arch CPU operations in order to initialize
>>>     * idle states suspend back-end specific data
>>>     */
>>>    for_each_possible_cpu(cpu) {
>>>        ret =3D arm_cpuidle_init(cpu);
>>>+
>>>+        /* This cpu does not support any idle states */
>>>+        if (ret =3D=3D -ENOSYS)
>>>+            continue;
>>>+
>>>        if (ret) {
>>>            pr_err("CPU %d failed to init idle CPU ops\n", cpu);
>>>-            return ret;
>>>+            goto out_fail;
>>>+        }
>>>+
>>>+        dev =3D kzalloc(sizeof(*dev), GFP_KERNEL);
>>>+        if (!dev) {
>>>+            pr_err("Failed to allocate cpuidle device\n");
>>>+            goto out_fail;
>>>+        }
>>>+
>>>+        dev->cpu =3D cpu;
>>>+        per_cpu(cpuidle_arm_dev, cpu) =3D dev;
>>>+
>>>+        ret =3D cpuidle_register_device(dev);
>>>+        if (ret) {
>>>+            pr_err("Failed to register cpuidle device for CPU %d\n"=
,
>>>+                   cpu);
>>>+            kfree(dev);
>>>+            goto out_fail;
>>>        }
>>>    }
>>>+out:
>>>+    return ret;
>>>
>>>-    return cpuidle_register(drv, NULL);
>>>+out_fail:
>>>+    for (cpu--; cpu <=3D 0; cpu--) {
>>>+        dev =3D per_cpu(cpuidle_arm_dev, cpu);
>>>+        cpuidle_unregister_device(dev);
>>>+        kfree(dev);
>>>+    }
>>>+    cpuidle_unregister_driver(drv);
>>>+    goto out;
>>>}
>>>device_initcall(arm_idle_init);
>>>--
>>>1.9.1
>>>
>
>
>--=20
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs
>
>Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
><http://twitter.com/#!/linaroorg> Twitter |
><http://www.linaro.org/linaro-blog/> Blog
>
