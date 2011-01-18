From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Resume from Memory very slow on 2.6.37+
Date: Tue, 18 Jan 2011 21:20:16 +0100
Message-ID: <201101182120.16835.rjw__35171.5994337157$1295385658$gmane$org@sisk.pl>
References: <AANLkTimBEnKTuR5aQyXvpZX8grQPw1eCaVgP-k9yBXhv@mail.gmail.com>
	<201101180235.59498.rjw@sisk.pl>
	<AANLkTikB1f6QFO8nP3DDV+2JF2HWaaDao4N5b1XYBJL_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTikB1f6QFO8nP3DDV+2JF2HWaaDao4N5b1XYBJL_@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jeff Chua <jeff.chua.linux@gmail.com>
Cc: Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org, Jack Steiner <steiner@sgi.com>, Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, January 18, 2011, Jeff Chua wrote:
> On Tue, Jan 18, 2011 at 9:35 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > Do you have CONFIG_RCU_CPU_STALL_DETECTOR set?  If not, please set it.  Then,
> > set CONFIG_RCU_CPU_STALL_TIMEOUT to something like 10 (in either case), run
> > a suspend-resume cycle and see if there are any CPU stalls reported in the
> > logs.
> 
> Configured and see nothing specific. The 30 seconds delays is
> indicated below in the dmesg at resume ...
> 
> 2011-01-18T13:00:48.399866+08:00 boston kernel: PM: early resume of
> devices complete after 50.816 msecs
> 2011-01-18T13:00:48.399868+08:00 boston kernel: ehci_hcd 0000:00:1a.0:
> power state changed by ACPI to D0
> 2011-01-18T13:00:48.399871+08:00 boston kernel: ehci_hcd 0000:00:1a.0:
> power state changed by ACPI to D0
> 2011-01-18T13:00:48.399874+08:00 boston kernel: i915 0000:00:02.0:
> power state changed by ACPI to D0
> 2011-01-18T13:00:48.399877+08:00 boston kernel: i915 0000:00:02.0:
> power state changed by ACPI to D0
> 2011-01-18T13:00:48.399879+08:00 boston kernel: ehci_hcd 0000:00:1a.0:
> PCI INT D -> GSI 23 (level, low) -> IRQ 23
> 2011-01-18T13:00:48.399882+08:00 boston kernel: i915 0000:00:02.0:
> setting latency timer to 64
> 2011-01-18T13:00:48.399884+08:00 boston kernel: ehci_hcd 0000:00:1a.0:
> setting latency timer to 64
> 2011-01-18T13:00:48.399887+08:00 boston kernel: HDA Intel
> 0000:00:1b.0: PCI INT B -> GSI 17 (level, low) -> IRQ 17
> 2011-01-18T13:00:48.399889+08:00 boston kernel: HDA Intel
> 0000:00:1b.0: setting latency timer to 64
> 2011-01-18T13:00:48.399892+08:00 boston kernel: HDA Intel
> 0000:00:1b.0: irq 41 for MSI/MSI-X
> 2011-01-18T13:00:48.399894+08:00 boston kernel: ehci_hcd 0000:00:1d.0:
> power state changed by ACPI to D0
> 2011-01-18T13:00:48.399898+08:00 boston kernel: pci 0000:00:1e.0:
> setting latency timer to 64
> 2011-01-18T13:00:48.399901+08:00 boston kernel: ehci_hcd 0000:00:1d.0:
> power state changed by ACPI to D0
> 2011-01-18T13:00:48.399904+08:00 boston kernel: ehci_hcd 0000:00:1d.0:
> PCI INT D -> GSI 19 (level, low) -> IRQ 19
> 2011-01-18T13:00:48.399906+08:00 boston kernel: ehci_hcd 0000:00:1d.0:
> setting latency timer to 64
> 2011-01-18T13:00:48.399941+08:00 boston kernel: ahci 0000:00:1f.2:
> setting latency timer to 64
> 2011-01-18T13:00:48.399943+08:00 boston kernel: sd 0:0:0:0: [sda] Starting disk
> 2011-01-18T13:00:48.399946+08:00 boston kernel: ioremap error for
> 0xbb77e000-0xbb781000, requested 0x10, got 0x0

Hmm.  That's suspicious.

Do you see that ioremap failure with the patch posted previously?

> 2011-01-18T13:00:48.399949+08:00 boston kernel: ata1: SATA link up 3.0
> Gbps (SStatus 123 SControl 300)
> 2011-01-18T13:00:48.399953+08:00 boston kernel: ata1.00: ACPI cmd
> ef/02:00:00:00:00:a0 (unknown) succeeded
> 2011-01-18T13:00:48.399955+08:00 boston kernel: ata1.00: ACPI cmd
> f5/00:00:00:00:00:a0 (unknown) filtered out
> 2011-01-18T13:00:48.399958+08:00 boston kernel: ata1.00: ACPI cmd
> ef/10:03:00:00:00:a0 (unknown) filtered out
> 2011-01-18T13:00:48.399961+08:00 boston kernel: ata1.00: ACPI cmd
> ef/02:00:00:00:00:a0 (unknown) succeeded
> 2011-01-18T13:00:48.399963+08:00 boston kernel: ata1.00: ACPI cmd
> f5/00:00:00:00:00:a0 (unknown) filtered out
> 2011-01-18T13:00:48.399966+08:00 boston kernel: ata1.00: ACPI cmd
> ef/10:03:00:00:00:a0 (unknown) filtered out
> 2011-01-18T13:00:48.399968+08:00 boston kernel: ata1.00: configured for UDMA/100
> 2011-01-18T13:00:48.399970+08:00 boston kernel: ata5: SATA link down
> (SStatus 0 SControl 300)
> 2011-01-18T13:00:48.399973+08:00 boston kernel: ata6: SATA link down
> (SStatus 0 SControl 300)
> 2011-01-18T13:00:48.399975+08:00 boston kernel: PM: resume of devices
> complete after 407.508 msecs
> <============= 30 seconds delays here =============>
> 2011-01-18T13:00:48.399977+08:00 boston kernel: Restarting tasks ... done.

But the timestamp doesn't seem to reflect the delay, or am I missing anything?

Please apply the appended patch (without the previous one) and post a dmesg
log containing a suspend-resume cycle with the delay.  I wonder where exactly
the delay occurs.

> >> Now I have another problem which might be totally unrelated. Just
> >> realized that my notebook can't suspend to "disk" ... used to work
> >> last week. So, something has changed as well. May be someone has
> >> already reported/fixed this.
> >
> > Not that I know of.  What do you mean by "can't suspend"?
> 
> 
> echo platform >/sys/power/disk; echo disk >/sys/power/state
> 
> Last line I see is ... "Suspending console(s) (use no_console_suspend
> to debug)" .. and activity after that.

That may be related to the NVS code issue, though I'm not sure.

Thanks,
Rafael

---
 drivers/acpi/osl.c |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-2.6/drivers/acpi/osl.c
===================================================================
--- linux-2.6.orig/drivers/acpi/osl.c
+++ linux-2.6/drivers/acpi/osl.c
@@ -383,7 +383,10 @@ void __ref acpi_os_unmap_memory(void __i
 	if (!del)
 		return;
 
+	pr_info("%s: synchronize_rcu()\n", __func__);
 	synchronize_rcu();
+	pr_info("%s: iounmap(%p), physaddr: %llx, size: %u\n", __func__,
+		map->virt, map->phys, map->size);
 	iounmap(map->virt);
 	kfree(map);
 }
