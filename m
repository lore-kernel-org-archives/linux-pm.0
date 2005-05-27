From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: A reference implementation of PCI suspend/resume?
Date: Fri, 27 May 2005 14:49:13 +0800
Message-ID: <1117176553.3925.6.camel@linux-hp.sh.intel.com>
References: <1115861087.3817.23.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============45579751164966797=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1115861087.3817.23.camel@linux-hp.sh.intel.com>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm <linux-pm@lists.osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============45579751164966797==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

>
> Currently many drivers don't call 
> free_irq/request_irq/pci_disable_device, which makes unexpected 
> interrupt occur and even break suspend/resume in some systems. The 
> reason is we disable PIC/IOAPIC/irq router very later (they are
> treated 
> as a sysdev), so there is a window between when a device is suspend
> and 
> when its PIC/IOAPIC/irq router pin are disabled. The ideal way is 
> PIC/IOAPIC/irq router's pins are disabled soon after no device is 
> referencing them. I'm now working on disabling irq router if no 
> reference on it, but first I'd like to know your opinions about the 
> proposal (the reference .suspend/.resume implementation).
Hi Pavel,
Could this be put into your tree? We should fix many PCI drivers, this
possibly will help us.

Thanks,
Shaohua

---

 linux-2.6.11-rc5-mm1-root/Documentation/power/pci.txt |   38 ++++++++++++++++++
 1 files changed, 38 insertions(+)

diff -puN Documentation/power/pci.txt~int-doc Documentation/power/pci.txt
--- linux-2.6.11-rc5-mm1/Documentation/power/pci.txt~int-doc	2005-05-27 10:43:51.893015912 +0800
+++ linux-2.6.11-rc5-mm1-root/Documentation/power/pci.txt	2005-05-27 14:26:19.492872304 +0800
@@ -291,6 +291,44 @@ a request to enable wake events from D3,
 pci_enable_wake (one for both D3hot and D3cold).
 
 
+A reference implementation
+-------------------------
+.suspend()
+{
+	/* driver specific operations */
+
+	/* Disable IRQ */
+	free_irq();
+	/* If using MSI */
+	pci_disable_msi();
+
+	pci_save_state();
+	pci_enable_wake();
+	/* Disable IO/bus master/irq router */
+	pci_disable_device();
+	pci_set_power_state(pci_choose_state());
+}
+
+.resume()
+{
+	pci_set_power_state(PCI_D0);
+	pci_restore_state();
+	/* device's irq possibly is changed, driver should take care */
+	pci_enable_device();
+	pci_set_master();
+
+	/* if using MSI, device's vector possibly is changed */
+	pci_enable_msi();
+
+	request_irq();
+	/* driver specific operations; */
+}
+
+This is a typical implementation. Drivers can slightly change the order
+of the operations in the implementation, ignore some operations or add
+more deriver specific operations in it, but drivers should do something like
+this on the whole.
+
 5. Resources
 ~~~~~~~~~~~~
 
_



--===============45579751164966797==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============45579751164966797==--
