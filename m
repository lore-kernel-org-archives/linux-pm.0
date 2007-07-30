From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/2] Introduce CONFIG_HIBERNATION and
	CONFIG_SUSPEND (updated)
Date: Mon, 30 Jul 2007 09:25:59 +0200
Message-ID: <200707300926.00653.rjw__30257.9424148009$1185780097$gmane$org@sisk.pl>
References: <200707251238.50218.lenb@kernel.org>
	<200707292323.29601.rjw@sisk.pl>
	<alpine.LFD.0.999.0707291717410.3442@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.0.999.0707291717410.3442@woody.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: david@lang.hm, Nigel Cunningham <nigel@nigel.suspend2.net>, linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>, linux-acpi@vger.kernel.org, Stefan Richter <stefanr@s5r6.in-berlin.de>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, Andi Kleen <ak@suse.de>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday, 30 July 2007 02:21, Linus Torvalds wrote:
> 
> Ok, I took this, and modified Len's patch to re-introduce ACPI_SLEEP on 
> top of it (I took the easy way out, and just made PM_SLEEP imply 
> ACPI_SLEEP, which should make everything come out right. I could have 
> dropped ACPI_SLEEP entirely in favour of PM_SLEEP, but that would have 
> implied changing more of Len's patch than I was really comfy with).
> 
> Len, Rafael, please do check that the end result looks ok. 

I only found two really minor issues covered by the appended patch (on top of
the current -git).

> I suspect ACPI could now take the PM_SLEEP/SUSPEND/HIBERNATE details into 
> account, and that some of the code is not necessary when HIBERNATE is not 
> selected, for example, but I'm not at all sure that it's worth it being 
> very fine-grained.

Well, IMO, for now let's make sure everything works as is. :-)

Greetings,
Rafael


---
(1) I think it's better to use CONFIG_ACPI_SLEEP instead of CONFIG_PM_SLEEP in
    include/acpi/acpi_bus.h , too, for consistency.

(2) x86_64 defconfig is outdated

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/x86_64/defconfig   |    3 ---
 include/acpi/acpi_bus.h |    6 +++---
 2 files changed, 3 insertions(+), 6 deletions(-)

Index: linux-2.6/include/acpi/acpi_bus.h
===================================================================
--- linux-2.6.orig/include/acpi/acpi_bus.h	2007-07-30 07:58:48.000000000 +0200
+++ linux-2.6/include/acpi/acpi_bus.h	2007-07-30 08:25:32.000000000 +0200
@@ -366,16 +366,16 @@ acpi_handle acpi_get_child(acpi_handle, 
 acpi_handle acpi_get_pci_rootbridge_handle(unsigned int, unsigned int);
 #define DEVICE_ACPI_HANDLE(dev) ((acpi_handle)((dev)->archdata.acpi_handle))
 
-#ifdef CONFIG_PM_SLEEP
+#ifdef CONFIG_ACPI_SLEEP
 int acpi_pm_device_sleep_state(struct device *, int, int *);
-#else /* !CONFIG_PM_SLEEP */
+#else /* !CONFIG_ACPI_SLEEP */
 static inline int acpi_pm_device_sleep_state(struct device *d, int w, int *p)
 {
 	if (p)
 		*p = ACPI_STATE_D0;
 	return ACPI_STATE_D3;
 }
-#endif /* !CONFIG_PM_SLEEP */
+#endif /* !CONFIG_ACPI_SLEEP */
 
 #endif				/* CONFIG_ACPI */
 
Index: linux-2.6/arch/x86_64/defconfig
===================================================================
--- linux-2.6.orig/arch/x86_64/defconfig	2007-07-30 07:58:48.000000000 +0200
+++ linux-2.6/arch/x86_64/defconfig	2007-07-30 08:27:27.000000000 +0200
@@ -207,9 +207,6 @@ CONFIG_SUSPEND_SMP=y
 # ACPI (Advanced Configuration and Power Interface) Support
 #
 CONFIG_ACPI=y
-CONFIG_ACPI_SLEEP=y
-CONFIG_ACPI_SLEEP_PROC_FS=y
-CONFIG_ACPI_SLEEP_PROC_SLEEP=y
 CONFIG_ACPI_PROCFS=y
 CONFIG_ACPI_AC=y
 CONFIG_ACPI_BATTERY=y
