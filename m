From: Brian King <brking@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/1] PM: Add arch_suspend_disable_nonboot_cpus
Date: Sun, 21 Feb 2010 16:46:29 -0600
Message-ID: <4B81B7C5.5060301@linux.vnet.ibm.com>
References: <201002211631.o1LGVsw8022630@d01av02.pok.ibm.com>
	<201002212327.13399.rjw@sisk.pl>
	<4B81B3A4.7040209@linux.vnet.ibm.com>
	<201002212337.10462.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201002212337.10462.rjw@sisk.pl>
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

On 02/21/2010 04:37 PM, Rafael J. Wysocki wrote:
> On Sunday 21 February 2010, Brian King wrote:
>> On 02/21/2010 04:27 PM, Rafael J. Wysocki wrote:
>>> On Sunday 21 February 2010, Brian King wrote:
>>>> On 02/21/2010 04:08 PM, Rafael J. Wysocki wrote:
>>>>> I'm not a big fan of __attribute__ ((weak)), though.  While we already use that
>>>>> in the suspend code, I'm not particularly comfortable with it.
>>>>>
>>>>> Have you considered any alternative approaches?
>>>>
>>>> I suppose another option would be to implement this similar to how
>>>> arch_free_page and arch_alloc_page do. Something like this:
>>>>
>>>> #ifndef CONFIG_HAVE_ARCH_SUSPEND_CPUS
>>>> static inline int arch_suspend_disable_nonboot_cpus(void)
>>>> {
>>>> 	return disable_nonboot_cpus();
>>>> }
>>>>
>>>> static inline void arch_suspend_enable_nonboot_cpus(void)
>>>> {
>>>> 	return enable_nonboot_cpus()'
>>>> }
>>>> #else
>>>> extern int arch_suspend_disable_nonboot_cpus(void);
>>>> extern void arch_suspend_enable_nonboot_cpus(void);
>>>> #endif
>>>>
>>>> I figured I would just be consistent with arch_suspend_disable_irqs /
>>>> arch_suspend_enable_irqs.
>>>
>>> I just think that doing arch_suspend_[enable|disable]_irqs() this way was
>>> a mistake.
>>
>> Do you prefer the example above? I can send an updated patch. If not,
>> any other suggestions you might have as to the way you would like this
>> done would be greatly appreciated.
> 
> disable_nonboot_cpus() is also called by kernel_power_off().  Is that fine
> with your architecture?

Yes. We only need a different behavior for the suspend/resume path.
Here is an alternative implementation of the patch. My test machine is
currently unavailable, so it is not yet been tested. How does this one look?

Thanks,

Brian

-- 
Brian King
Linux on Power Virtualization
IBM Linux Technology Center

Rather than calling disable_nonboot_cpus and enable_nonboot_cpus
directly, wrapper the calls in arch_suspend_disable_nonboot_cpus
and arch_suspend_enable_nonboot_cpus that can be overridden by
architectures that require different handling of suspending processors
at suspend time than these functions provide. This is needed to enable
suspend/resume on IBM Power servers.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---

 include/linux/suspend.h |   27 +++++++++++++++++++++++++++
 kernel/power/suspend.c  |    4 ++--
 2 files changed, 29 insertions(+), 2 deletions(-)

diff -puN include/linux/suspend.h~suspend_new_arch_smp include/linux/suspend.h
--- linux-2.6/include/linux/suspend.h~suspend_new_arch_smp	2010-02-21 16:32:04.000000000 -0600
+++ linux-2.6-bjking1/include/linux/suspend.h	2010-02-21 16:45:36.000000000 -0600
@@ -141,6 +141,33 @@ extern void arch_suspend_disable_irqs(vo
  */
 extern void arch_suspend_enable_irqs(void);
 
+#ifdef CONFIG_HAVE_ARCH_SUSPEND_CPUS
+extern int arch_suspend_disable_nonboot_cpus(void);
+extern void arch_suspend_enable_nonboot_cpus(void);
+#else
+/**
+ * arch_suspend_disable_nonboot_cpus - disable non boot for suspend
+ *
+ * Disables non boot CPUs (in the default case). Architectures can
+ * override this if more needs to be done. Not called for suspend to disk.
+ */
+static inline int arch_suspend_disable_nonboot_cpus(void)
+{
+	return disable_nonboot_cpus();
+}
+
+/**
+ * arch_suspend_enable_nonboot_cpus - enable non boot after suspend
+ *
+ * Enables non boot CPUs (in the default case). Architectures can
+ * override this if more needs to be done. Not called for suspend to disk.
+ */
+static inline void arch_suspend_enable_nonboot_cpus(void)
+{
+	enable_nonboot_cpus();
+}
+#endif
+
 extern int pm_suspend(suspend_state_t state);
 #else /* !CONFIG_SUSPEND */
 #define suspend_valid_only_mem	NULL
diff -puN kernel/power/suspend.c~suspend_new_arch_smp kernel/power/suspend.c
--- linux-2.6/kernel/power/suspend.c~suspend_new_arch_smp	2010-02-21 16:34:00.000000000 -0600
+++ linux-2.6-bjking1/kernel/power/suspend.c	2010-02-21 16:34:35.000000000 -0600
@@ -147,7 +147,7 @@ static int suspend_enter(suspend_state_t
 	if (suspend_test(TEST_PLATFORM))
 		goto Platform_wake;
 
-	error = disable_nonboot_cpus();
+	error = arch_suspend_disable_nonboot_cpus();
 	if (error || suspend_test(TEST_CPUS))
 		goto Enable_cpus;
 
@@ -165,7 +165,7 @@ static int suspend_enter(suspend_state_t
 	BUG_ON(irqs_disabled());
 
  Enable_cpus:
-	enable_nonboot_cpus();
+	arch_suspend_enable_nonboot_cpus();
 
  Platform_wake:
 	if (suspend_ops->wake)
_
