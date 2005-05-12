From: Shaohua Li <shaohua.li@intel.com>
Subject: A reference implementation of PCI suspend/resume?
Date: Thu, 12 May 2005 09:24:47 +0800
Message-ID: <1115861087.3817.23.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============018910089770027394=="
Return-path: <linux-pm-bounces@lists.osdl.org>
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
List-Id: linux-pm@vger.kernel.org

--===============018910089770027394==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,
There are still many PCI drivers don't implement their .suspend/.resume
methods correctly. I felt it would be quite helpful there is a reference
implementation. Here is my thought:

.suspend()
{
	driver specific operations;
	pci_save_state();
	pci_enable_wake();
	/* as a result, PIC/IOAPIC pin is disabled */
	free_irq();
	/* as a result, bus master/irq router are disabled */
	pci_disable_device();
	pci_set_power_state();
}

.resume()
{
	pci_set_power_state(PCI_D0);
	pci_restore_state();
	/* device's irq possibly is changed, driver should take care */
	pci_enable_device();
	pci_set_master();
	request_irq();
	driver specific operations;
}

Currently many drivers don't call
free_irq/request_irq/pci_disable_device, which makes unexpected
interrupt occur and even break suspend/resume in some systems. The
reason is we disable PIC/IOAPIC/irq router very later (they are treated
as a sysdev), so there is a window between when a device is suspend and
when its PIC/IOAPIC/irq router pin are disabled. The ideal way is
PIC/IOAPIC/irq router's pins are disabled soon after no device is
referencing them. I'm now working on disabling irq router if no
reference on it, but first I'd like to know your opinions about the
proposal (the reference .suspend/.resume implementation).

Thanks,
Shaohua


--===============018910089770027394==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============018910089770027394==--
