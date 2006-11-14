From: Stephen Hemminger <shemminger@osdl.org>
Subject: [RFC] ACPI vs device ordering on resume
Date: Tue, 14 Nov 2006 15:30:26 -0800
Message-ID: <20061114153026.730deb94@freekitty>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: len.brown@intel.com, Greg KH <greg@kroah.com>, Pavel Machek <pavel@suse.cz>
Cc: Andrew Morton <akpm@osdl.org>, linux-acpi@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

If I do a suspend-to-ram then resume on a Sony Vaio laptop with sky2 driver,
the first interrupt gets misrouted to the original shared IRQ, rather than
to the MSI irq expected.

During the pci_restore process, the MSI information and the PCI command reg=
ister =

are restored properly. But later during resume, inside the ACPI evaluation =
of
the WAK method, the PCI_COMMAND  INTX_DISABLE (0x400) flag is being cleared.
My guess is that the BIOS ends up doing some resetting of devices.

I may be able to workaround the problem for this one device, but it brings =
up
a more general issue about what the ordering should be during resume. If AC=
PI
evaluation (which I assume talks to the BIOS), might change device state, it
seems that ACPI code should execute before resuming devices not after. But =
changing
the order here seems drastic.

An alternate solution would be to have two pm_ops, one for early_resume
and another for late, and split the ACPI work.

--- 2.6.19-rc5.orig/kernel/power/main.c	2006-11-14 14:24:37.000000000 -0800
+++ 2.6.19-rc5/kernel/power/main.c	2006-11-14 14:25:23.000000000 -0800
@@ -132,12 +132,12 @@
 =

 static void suspend_finish(suspend_state_t state)
 {
+	if (pm_ops && pm_ops->finish)
+		pm_ops->finish(state);
 	device_resume();
 	resume_console();
 	thaw_processes();
 	enable_nonboot_cpus();
-	if (pm_ops && pm_ops->finish)
-		pm_ops->finish(state);
 	pm_restore_console();
 }
 =



-- =

Stephen Hemminger <shemminger@osdl.org>
