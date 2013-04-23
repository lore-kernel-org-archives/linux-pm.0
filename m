From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [V4 patch 03/15] cpuidle: make a single register function for all
Date: Tue, 23 Apr 2013 18:34:11 +0530
Message-ID: <517686CB.7080909@ti.com>
References: <1366707285-12179-1-git-send-email-daniel.lezcano@linaro.org>
 <1366707285-12179-4-git-send-email-daniel.lezcano@linaro.org>
 <51767F57.7060809@ti.com> <517683DD.6060805@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <517683DD.6060805@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: andrew@lunn.ch, khilman@deeprootsystems.com, nsekhar@ti.com, josephl@nvidia.com, kgene.kim@samsung.com, patches@linaro.org, magnus.damm@gmail.com, tony@atomide.com, plagnioj@jcrosoft.com, linaro-kernel@lists.linaro.org, jason@lakedaemon.net, swarren@wwwdotorg.org, rob.herring@calxeda.com, rjw@sisk.pl, horms@verge.net.au, linux@maxim.org.za, linux-arm-kernel@lists.infradead.org, deepthi@linux.vnet.ibm.com, jkosina@suse.cz, linux-pm@vger.kernel.org, lethal@linux-sh.org, kernel@pengutronix.de
List-Id: linux-pm@vger.kernel.org

On Tuesday 23 April 2013 06:21 PM, Daniel Lezcano wrote:
> On 04/23/2013 02:32 PM, Santosh Shilimkar wrote:
>> On Tuesday 23 April 2013 02:24 PM, Daniel Lezcano wrote:
>>> The usual scheme to initialize a cpuidle driver on a SMP is:
>>>
>>> 	cpuidle_register_driver(drv);
>>> 	for_each_possible_cpu(cpu) {
>>> 		device = &per_cpu(cpuidle_dev, cpu);
>>> 		cpuidle_register_device(device);
>>> 	}
>>>
>>> This code is duplicated in each cpuidle driver.
>>>
>>> On UP systems, it is done this way:
>>>
>>> 	cpuidle_register_driver(drv);
>>> 	device = &per_cpu(cpuidle_dev, cpu);
>>> 	cpuidle_register_device(device);
>>>
>>> On UP, the macro 'for_each_cpu' does one iteration:
>>>
>>> #define for_each_cpu(cpu, mask)                 \
>>>         for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask)
>>>
>>> Hence, the initialization loop is the same for UP than SMP.
>>>
>>> Beside, we saw different bugs / mis-initialization / return code unchecked in
>>> the different drivers, the code is duplicated including bugs. After fixing all
>>> these ones, it appears the initialization pattern is the same for everyone.
>>>
>>> Please note, some drivers are doing dev->state_count = drv->state_count. This is
>>> not necessary because it is done by the cpuidle_enable_device function in the
>>> cpuidle framework. This is true, until you have the same states for all your
>>> devices. Otherwise, the 'low level' API should be used instead with the specific
>>> initialization for the driver.
>>>
>>> Let's add a wrapper function doing this initialization with a cpumask parameter
>>> for the coupled idle states and use it for all the drivers.
>>>
>>> That will save a lot of LOC, consolidate the code, and the modifications in the
>>> future could be done in a single place. Another benefit is the consolidation of
>>> the cpuidle_device variable which is now in the cpuidle framework and no longer
>>> spread accross the different arch specific drivers.
>>>
>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> ---
>>
>> I don't see you have addressed the comment on V3 [1] i gave for the subject patch
>> Any reason ?
> 
> Yes, sorry for not answering.
> 
> This modification should be handled in the __cpuidle_register_device
> function.
> 
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 49e8d30..936d862 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -372,7 +372,7 @@ static int __cpuidle_register_device(struct
> cpuidle_device *dev)
>         int ret;
>         struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
> 
> -       if (!try_module_get(drv->owner))
> +       if (!drv || !try_module_get(drv->owner))
>                 return -EINVAL;
> 
>         per_cpu(cpuidle_devices, dev->cpu) = dev;
> 
> Thus, the cpuidle_register function is not impacted by this as it will
> always do cpuidle_register_driver, followed by cpuidle_register_device.
> 
I still don't follow you. I know the fix will be needed but in the subject
patch sequence as well, the device registration should be done first and
then the driver registration. Below hunk I mean.

----
+int cpuidle_register(struct cpuidle_driver *drv,
+		     const struct cpumask *const coupled_cpus)
+{
+	int ret, cpu;
+	struct cpuidle_device *device;
+
+	ret = cpuidle_register_driver(drv);
+	if (ret) {
+		pr_err("failed to register cpuidle driver\n");
+		return ret;
+	}
+
+	for_each_possible_cpu(cpu) {
+		device = &per_cpu(cpuidle_dev, cpu);
+		device->cpu = cpu;
+
+#ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
+		/*
+		 * On multiplatform for ARM, the coupled idle states could
+		 * enabled in the kernel even if the cpuidle driver does not
+		 * use it. Note, coupled_cpus is a struct copy.
+		 */
+		if (coupled_cpus)
+			device->coupled_cpus = *coupled_cpus;
+#endif
+		ret = cpuidle_register_device(device);
+		if (!ret)
+			continue;
+
+		pr_err("Failed to register cpuidle device for cpu%d\n", cpu);
+
+		cpuidle_unregister(drv);
+		break;
+	}
------

I also had a comment on kernel doc for both of these new functions.
Out of curiosity I have seen this patch again o.w I would have assumed
that you did address the comments.

Regards,
Santosh
