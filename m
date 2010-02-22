From: Brian King <brking@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/1] PM: Add arch_suspend_disable_nonboot_cpus
Date: Mon, 22 Feb 2010 17:31:32 -0600
Message-ID: <4B8313D4.4050802@linux.vnet.ibm.com>
References: <201002211631.o1LGVsw8022630@d01av02.pok.ibm.com>
	<201002212337.10462.rjw@sisk.pl>
	<4B81B7C5.5060301@linux.vnet.ibm.com>
	<201002222014.07280.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201002222014.07280.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On 02/22/2010 01:14 PM, Rafael J. Wysocki wrote:
> On Sunday 21 February 2010, Brian King wrote:
>> On 02/21/2010 04:37 PM, Rafael J. Wysocki wrote:
>>> On Sunday 21 February 2010, Brian King wrote:
>>>> On 02/21/2010 04:27 PM, Rafael J. Wysocki wrote:
>>>>> On Sunday 21 February 2010, Brian King wrote:
>>>>>> On 02/21/2010 04:08 PM, Rafael J. Wysocki wrote:
>>>>>>> I'm not a big fan of __attribute__ ((weak)), though.  While we already use that
>>>>>>> in the suspend code, I'm not particularly comfortable with it.
>>>>>>>
>>>>>>> Have you considered any alternative approaches?
>>>>>>
>>>>>> I suppose another option would be to implement this similar to how
>>>>>> arch_free_page and arch_alloc_page do. Something like this:
>>>>>>
>>>>>> #ifndef CONFIG_HAVE_ARCH_SUSPEND_CPUS
>>>>>> static inline int arch_suspend_disable_nonboot_cpus(void)
>>>>>> {
>>>>>> 	return disable_nonboot_cpus();
>>>>>> }
>>>>>>
>>>>>> static inline void arch_suspend_enable_nonboot_cpus(void)
>>>>>> {
>>>>>> 	return enable_nonboot_cpus()'
>>>>>> }
>>>>>> #else
>>>>>> extern int arch_suspend_disable_nonboot_cpus(void);
>>>>>> extern void arch_suspend_enable_nonboot_cpus(void);
>>>>>> #endif
>>>>>>
>>>>>> I figured I would just be consistent with arch_suspend_disable_irqs /
>>>>>> arch_suspend_enable_irqs.
>>>>>
>>>>> I just think that doing arch_suspend_[enable|disable]_irqs() this way was
>>>>> a mistake.
>>>>
>>>> Do you prefer the example above? I can send an updated patch. If not,
>>>> any other suggestions you might have as to the way you would like this
>>>> done would be greatly appreciated.
>>>
>>> disable_nonboot_cpus() is also called by kernel_power_off().  Is that fine
>>> with your architecture?
>>
>> Yes. We only need a different behavior for the suspend/resume path.
> 
> OK
> 
>> Here is an alternative implementation of the patch. My test machine is
>> currently unavailable, so it is not yet been tested. How does this one look?
> 
> Well, I'd like to do that cleanly from the start.
> 
> Now, the problem is that PM_SLEEP_SMP selects HOTPLUG_CPU, because
> that's necessary for the other architectures to make SMP suspend work, but it's
> not necessary on your architecture.  Moreover, you don't need to compile
> enable_nonboot_cpus() at all.

At least for the architecture I am enabling this support for (PPC_PSERIES), upon looking closer, it looks like PM_SLEEP_SMP was never defined, so enable_nonboot_cpus and disable_nonboot_cpus were always nooped before, which I didn't previously realize. We probably want to retain this behavior.

So perhaps a better way to solve this might be to change the Kconfig rules so that PM_SLEEP_SMP is not defined for PPC_PSERIES and then use ->prepare_late to put the other CPUs in H_JOIN state and ->wake to send H_PROD to them to wake them up. In that case, I suppose a simple patch like the one below would suffice.


-- 
Brian King
Linux on Power Virtualization
IBM Linux Technology Center

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---

 kernel/power/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff -puN kernel/power/Kconfig~suspend_no_pm_sleep_smp kernel/power/Kconfig
--- linux-2.6/kernel/power/Kconfig~suspend_no_pm_sleep_smp	2010-02-22 17:05:25.000000000 -0600
+++ linux-2.6-bjking1/kernel/power/Kconfig	2010-02-22 17:07:00.000000000 -0600
@@ -77,6 +77,7 @@ config PM_SLEEP_SMP
 	depends on SMP
 	depends on ARCH_SUSPEND_POSSIBLE || ARCH_HIBERNATION_POSSIBLE
 	depends on PM_SLEEP
+	depends on !PPC_PSERIES
 	select HOTPLUG_CPU
 	default y
 
_
