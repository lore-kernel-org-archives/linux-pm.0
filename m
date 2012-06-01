From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFT] PCI changes related to wakeup (was: Re: [linux-pm] ehci_hcd
 related S3 lockup on ASUS laptops, again)
Date: Fri, 1 Jun 2012 11:13:30 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1206011046460.1610-100000@iolanthe.rowland.org>
References: <201205312329.15523.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <201205312329.15523.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Oleksij Rempel (fishor)" <bug-track@fisher-privat.net>, =?utf-8?q?D=C3=A2niel_Fraga?= <fragabr@gmail.com>, Andrey Rahmatullin <wrar@wrar.name>, Steven Rostedt <rostedt@goodmis.org>, linux-pm@lists.linux-foundation.org, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 31 May 2012, Rafael J. Wysocki wrote:

> > @@ -1743,6 +1743,11 @@ int pci_prepare_to_sleep(struct pci_dev
> >  	if (target_state == PCI_POWER_ERROR)
> >  		return -EIO;
> >  
> > +	/* Some devices mustn't be in D3 during system sleep */
> > +	if (target_state == PCI_D3hot &&
> > +			(dev->dev_flags & PCI_DEV_FLAGS_NO_D3_DURING_SLEEP))
> > +		return 0;
> > +
> 
> Why do you want to skip the wakeup setting in that case?

Because that's what the 151b61284776 commit did.  Also, the quirk marks 
the controller as not wakeup-capable.

Still, it's worth testing.  Andrey and Steve, here's an updated patch 
which should leave wakeup enabled on your EHCI controllers.  If you 
don't have a USB keyboard handy for generating a wakeup signal, you 
can test the wakeup functionality by doing:

	echo enabled >/sys/bus/usb/devices/usb1/power/wakeup
	echo enabled >/sys/bus/usb/devices/usb2/power/wakeup

before suspending.  (In fact you need only one of those two lines, but
at the moment I forget which -- probably the usb2 one.)  Then while
the system is asleep, either plugging or unplugging a USB device
directly into the computer should cause it to wake up.

Alan Stern



Index: usb-3.4/drivers/pci/pci.c
===================================================================
--- usb-3.4.orig/drivers/pci/pci.c
+++ usb-3.4/drivers/pci/pci.c
@@ -1745,6 +1745,11 @@ int pci_prepare_to_sleep(struct pci_dev
 
 	pci_enable_wake(dev, target_state, device_may_wakeup(&dev->dev));
 
+	/* Some devices mustn't be in D3 during system sleep */
+	if (target_state == PCI_D3hot &&
+			(dev->dev_flags & PCI_DEV_FLAGS_NO_D3_DURING_SLEEP))
+		return 0;
+
 	error = pci_set_power_state(dev, target_state);
 
 	if (error)
Index: usb-3.4/drivers/pci/quirks.c
===================================================================
--- usb-3.4.orig/drivers/pci/quirks.c
+++ usb-3.4/drivers/pci/quirks.c
@@ -2917,6 +2917,31 @@ static void __devinit disable_igfx_irq(s
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0102, disable_igfx_irq);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x010a, disable_igfx_irq);
 
+/*
+ * The Intel 6 Series/C200 Series chipset's EHCI controllers on many
+ * ASUS motherboards will cause memory corruption or a system crash
+ * if they are in D3 while the system is put into S3 sleep.
+ */
+static void __devinit asus_ehci_no_d3(struct pci_dev *dev)
+{
+	const char *sys_info;
+	static const char good_Asus_board[] = "P8Z68-V";
+
+	if (dev->dev_flags & PCI_DEV_FLAGS_NO_D3_DURING_SLEEP)
+		return;
+	if (dev->subsystem_vendor != PCI_VENDOR_ID_ASUSTEK)
+		return;
+	sys_info = dmi_get_system_info(DMI_BOARD_NAME);
+	if (sys_info && memcmp(sys_info, good_Asus_board,
+			sizeof(good_Asus_board) - 1) == 0)
+		return;
+
+	dev_info(&dev->dev, "broken D3 during system sleep on ASUS\n");
+	dev->dev_flags |= PCI_DEV_FLAGS_NO_D3_DURING_SLEEP;
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1c26, asus_ehci_no_d3);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1c2d, asus_ehci_no_d3);
+
 static void pci_do_fixups(struct pci_dev *dev, struct pci_fixup *f,
 			  struct pci_fixup *end)
 {
Index: usb-3.4/include/linux/pci.h
===================================================================
--- usb-3.4.orig/include/linux/pci.h
+++ usb-3.4/include/linux/pci.h
@@ -176,6 +176,8 @@ enum pci_dev_flags {
 	PCI_DEV_FLAGS_NO_D3 = (__force pci_dev_flags_t) 2,
 	/* Provide indication device is assigned by a Virtual Machine Manager */
 	PCI_DEV_FLAGS_ASSIGNED = (__force pci_dev_flags_t) 4,
+	/* Device causes system crash if in D3 during S3 sleep */
+	PCI_DEV_FLAGS_NO_D3_DURING_SLEEP = (__force pci_dev_flags_t) 8,
 };
 
 enum pci_irq_reroute_variant {

