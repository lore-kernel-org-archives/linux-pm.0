From: Steve Longerbeam <slongerbeam@gmail.com>
Subject: Re: How to remove warn msg "cache: parent cpui should not be
 sleeping" i=1, 2, 3...
Date: Mon, 20 Aug 2018 10:46:34 -0700
Message-ID: <2da4c81c-883c-6bc4-5fb0-cb17cd21fdce@gmail.com>
References: <20161221193703.6eac880c@xhacker>
 <a793d088-2faf-3ea8-41b6-f0b614a71e19@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <a793d088-2faf-3ea8-41b6-f0b614a71e19@arm.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sudeep Holla <sudeep.holla@arm.com>, Jisheng Zhang <jszhang@marvell.com>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

Hi Sudeep,


On 12/21/2016 08:54 AM, Sudeep Holla wrote:
>
> On 21/12/16 11:37, Jisheng Zhang wrote:
>> Hi all,
>>
>> I'm not sure this is a bug, when wake up from s2ram, I could get something
>> like:
>>
>> [  313.271464] Enabling non-boot CPUs ...
>> [  313.271551] CPU1: Booted secondary processor
>> [  313.271556] Detected VIPT I-cache on CPU1
>> [  313.301378]  cache: parent cpu1 should not be sleeping
>> [  313.301504] CPU1 is up
>> [  313.301582] CPU2: Booted secondary processor
>> [  313.301585] Detected VIPT I-cache on CPU2
>> [  313.331485]  cache: parent cpu2 should not be sleeping
>> [  313.331605] CPU2 is up
>> [  313.331683] CPU3: Booted secondary processor
>> [  313.331686] Detected VIPT I-cache on CPU3
>> [  313.361599]  cache: parent cpu3 should not be sleeping
>> [  313.361719] CPU3 is up
>>
>> This is because we call cpu_device_create() when secondary cpu is brought
>> online, the cpu_cache device's parent device: cpu device isn't already
>> resumed, all device resume will resume after secondary cores are brought
>> up.
>>
>> What's the elegant solution to remove this warning msg?
>>
> It is not a serious warning as you can see a comment in the code:
> "/*
>   * This is a fib.  But we'll allow new children to be added below
>   * a resumed device, even if the device hasn't been completed yet.
>   */"
>
> But if we think it needs to be removed, I have something like below in
> my mind. I am not sure if this is hacky or not(completely untested, not
> even compiled).

This is an old thread, but this warning still exists in the code and 
still occurs
on resume from suspend-to-ram, as of 4.18-rc2.

I have tested the below patch on a Renesas Salvator-X ES2.0 and it does
indeed remove this warning on S2RAM resume.

I agree it is not serious, but the text of the warning does not sound 
harmless.
So IMHO the text should be modified or the below patch should be submitted
for review/merge.

Thanks,
Steve


> Regards,
> Sudeep
>
> -->8
>
> diff --git i/drivers/base/cpu.c w/drivers/base/cpu.c
> index 4c28e1a09786..2a5c04377adf 100644
> --- i/drivers/base/cpu.c
> +++ w/drivers/base/cpu.c
> @@ -344,6 +344,14 @@ static int cpu_uevent(struct device *dev, struct
> kobj_uevent_env *env)
>   }
>   #endif
>
> +static int cpu_dev_pm_unset_is_prepared(unsigned int cpu)
> +{
> +       struct device *cpu_dev = get_cpu_device(cpu);
> +
> +       if(cpu_dev)
> +               cpu_dev->power.is_prepared = false;
> +       return 0;
> +}
>   /*
>    * register_cpu - Setup a sysfs device for a CPU.
>    * @cpu - cpu->hotpluggable field set to 1 will generate a control file in
> @@ -377,7 +385,9 @@ int register_cpu(struct cpu *cpu, int num)
>          per_cpu(cpu_sys_devices, num) = &cpu->dev;
>          register_cpu_under_node(num, cpu_to_node(num));
>
> -       return 0;
> +       return cpuhp_setup_state_nocalls(CPUHP_CPUDEV_PM_PREPARE,
> +                                "base/cpu/dev_pm:prepare",
> +                                cpu_dev_pm_unset_is_prepared, NULL);
>   }
>
>   struct device *get_cpu_device(unsigned cpu)
> diff --git i/include/linux/cpuhotplug.h w/include/linux/cpuhotplug.h
> index 2ab7bf53d529..5bfe3c1aa148 100644
> --- i/include/linux/cpuhotplug.h
> +++ w/include/linux/cpuhotplug.h
> @@ -51,6 +51,7 @@ enum cpuhp_state {
>          CPUHP_SLAB_PREPARE,
>          CPUHP_MD_RAID5_PREPARE,
>          CPUHP_RCUTREE_PREP,
> +       CPUHP_CPUDEV_PM_PREPARE,
>          CPUHP_CPUIDLE_COUPLED_PREPARE,
>          CPUHP_POWERPC_PMAC_PREPARE,
>          CPUHP_POWERPC_MMU_CTX_PREPARE,
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
