From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH/RFC] PCI prepare/activate instead of enable to
	avoid IRQ storm and rogue DMA access
Date: Thu, 15 Mar 2007 00:23:02 +0900
Message-ID: <20070314152302.GB15600@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: gregkh@suse.de, Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, michal.k.k.piotrowski@gmail.com, linux-ide@vger.kernel.org, tglx@linutronix.de, shemminger@linux-foundation.org, mlord@pobox.com, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hello, all.

This patch started off from the following thread.

  http://thread.gmane.org/gmane.linux.ide/16899

The problem is that a PCI device can be in any arbitrary when it gets
enabled and the device has to be enabled for its driver to
initialize/reset it.  The most common case this causes headache is as
follows.

Let's assume there's a device which shares its INTX IRQ line with
another device and the other one is already initialized.  During boot,
due to BIOS's fault, bad hardware design or sheer bad luck, the device
has got a pending IRQ.  When its driver enables the device, the
pending IRQ hits INTX.  The IRQ line has been enabled by the other
driver sharing the IRQ but IRQ handler for this device hasn't been
registered yet.  So, screaming interrupts.  IRQ subsystem shuts up the
IRQ line in an attempt to save the machine from complete lockup and
both devices end up dead.

There seem to be other scenarios that this can be triggered as,
reportedly, similar behavior is also observed when IRQ line is not
shared.  I suspect similar thing can and is more likely to happen
while resuming as the device can really be in any random state.

The dilemma here is that 1. the device needs to be enabled to be
initialized/reset 2. enabling the device may cause all hell to break
loose.  Note that bus mastering has similar risks and we are currently
dealing with that by doing pci_set_master() from each driver after
certain initialization steps are taken.

This patch expands the pci_set_master() approach.  Instead of enabling
the device in one go, it's done in two steps - prepare and activate.
'prepare' enables access to PCI configuration, IO, MMIO but prohibits
the device from bus mastering or raising IRQ by adjusting respective
PCI control bits prior to enabling the device.  The second step
'activate' allows the device to bus master and raise IRQs.  Typical
initialization would look like the following.

  static int __devinit my_init_one(blah blah)
  {
	...

	rc =3D pcim_prepare_device(pdev);
	if (rc)
		return rc;

	/*
	 * reset the controller and initialize msi/msix, whatnot
	 */

	rc =3D devm_request_irq(&pdev->dev, blah blah);
	if (rc)
		return rc;

	rc =3D pcim_activate_device(pdev);
	if (rc)
		return rc;

	/*
	 * register to upper layer, probe sub devices, etc...
	 */

	return 0;
}

I've implemented it only as part of resource managed interface because
I didn't want to multiply interface functions with permutations && PCI
devres already has some of the needed feature.  If non-managed
interface is ever necessary, that should be doable.

Anyways, pcim_prepare_device() makes sure bus master is off, INTX (see
gotchas below), MSI and MSIX are disabled, then enables the device.
When it returns, the driver can access the device to initialize it but
the device can't havoc the rest of the system during initialization.

After most things are set up and IRQ handler is registered, the driver
calls pcim_activate_device() which allows the device to master bus and
raise IRQs.  Note that PCI layer keeps track of which IRQ mechanism is
in use and enable only that one.

Similar thing is done during resume.  pci_restore_state() restores PCI
configuration space but makes sure bus master and IRQ mechanisms are
disabled.  Driver has to call pcim_activate_device() after it has
restored the device into sane state.

This change makes init and resume more safe & robust without adding
too much complexity and easily applicable to existing drivers.

I've converted skge and sky2 as example.  skge is only compile tested
and sky2 is lightly tested.

** GOTCHAS

* DISABLE_INTX is relatively new thing.  Older devices don't support
  the bit and there seems to be no way whether to determine this bit
  is implemented or not.

* Currently bus master bit is set unconditonally on activation.  Is
  this okay?

* MSI IRQ masking isn't considered during activation.  Can be fixed
  easily.

* Hmmm... prepare/activate?  Any better names?

The patch is against linus #master[M] as of today and converts skge
and sky2 to use new prepare/activate model.

So, what do you think?

[M] 2.6.21-rc3 baab1087c61d4506f2c9f4cdb7da162160de16c2

DO NOT APPLY

diff --git a/drivers/net/skge.c b/drivers/net/skge.c
index eea75a4..b7bf949 100644
--- a/drivers/net/skge.c
+++ b/drivers/net/skge.c
@@ -3585,9 +3585,9 @@ static int __devinit skge_probe(struct pci_dev *pdev,
 	struct skge_hw *hw;
 	int err, using_dac =3D 0;
 =

-	err =3D pci_enable_device(pdev);
+	err =3D pcim_prepare_device(pdev);
 	if (err) {
-		dev_err(&pdev->dev, "cannot enable PCI device\n");
+		dev_err(&pdev->dev, "cannot prepare PCI device\n");
 		goto err_out;
 	}
 =

@@ -3671,6 +3671,10 @@ static int __devinit skge_probe(struct pci_dev *pdev,
 	}
 	skge_show_addr(dev);
 =

+	err =3D pcim_activate_device(pdev);
+	if (err)
+		goto err_out_unregister;
+
 	if (hw->ports > 1 && (dev1 =3D skge_devinit(hw, 1, using_dac))) {
 		if (register_netdev(dev1) =3D=3D 0)
 			skge_show_addr(dev1);
@@ -3807,6 +3811,10 @@ static int skge_resume(struct pci_dev *pdev)
 	if (err)
 		goto out;
 =

+	err =3D pcim_activate_device(pdev);
+	if (err)
+		goto out;
+
 	for (i =3D 0; i < hw->ports; i++) {
 		struct net_device *dev =3D hw->dev[i];
 =

diff --git a/drivers/net/sky2.c b/drivers/net/sky2.c
index ab0ab92..7bf5926 100644
--- a/drivers/net/sky2.c
+++ b/drivers/net/sky2.c
@@ -3529,9 +3529,9 @@ static int __devinit sky2_probe(struct pci_dev *pdev,
 	struct sky2_hw *hw;
 	int err, using_dac =3D 0, wol_default;
 =

-	err =3D pci_enable_device(pdev);
+	err =3D pcim_prepare_device(pdev);
 	if (err) {
-		dev_err(&pdev->dev, "cannot enable PCI device\n");
+		dev_err(&pdev->dev, "cannot prepare PCI device\n");
 		goto err_out;
 	}
 =

@@ -3634,6 +3634,10 @@ static int __devinit sky2_probe(struct pci_dev *pdev,
 	}
 	sky2_write32(hw, B0_IMSK, Y2_IS_BASE);
 =

+	err =3D pcim_activate_device(pdev);
+	if (err)
+		goto err_out_unregister;
+
 	sky2_show_addr(dev);
 =

 	if (hw->ports > 1) {
@@ -3773,6 +3777,10 @@ static int sky2_resume(struct pci_dev *pdev)
 =

 	sky2_write32(hw, B0_IMSK, Y2_IS_BASE);
 =

+	err =3D pcim_activate_device(pdev);
+	if (err)
+		goto out;
+
 	for (i =3D 0; i < hw->ports; i++) {
 		struct net_device *dev =3D hw->dev[i];
 		if (netif_running(dev)) {
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index ad33e01..e5c5238 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -38,7 +38,7 @@ static int msi_cache_init(void)
 	return 0;
 }
 =

-static void msi_set_enable(struct pci_dev *dev, int enable)
+void msi_set_enable(struct pci_dev *dev, int enable)
 {
 	int pos;
 	u16 control;
@@ -53,7 +53,7 @@ static void msi_set_enable(struct pci_dev *dev, int enabl=
e)
 	}
 }
 =

-static void msix_set_enable(struct pci_dev *dev, int enable)
+void msix_set_enable(struct pci_dev *dev, int enable)
 {
 	int pos;
 	u16 control;
@@ -229,6 +229,7 @@ static struct msi_desc* alloc_msi_entry(void)
 #ifdef CONFIG_PM
 static void __pci_restore_msi_state(struct pci_dev *dev)
 {
+	int activation_used =3D pcim_activation_used(dev);
 	int pos;
 	u16 control;
 	struct msi_desc *entry;
@@ -239,7 +240,8 @@ static void __pci_restore_msi_state(struct pci_dev *dev)
 	entry =3D get_irq_msi(dev->irq);
 	pos =3D entry->msi_attrib.pos;
 =

-	pci_intx(dev, 0);		/* disable intx */
+	if (!activation_used)
+		pci_intx(dev, 0);	/* disable intx */
 	msi_set_enable(dev, 0);
 	write_msi_msg(dev->irq, &entry->msg);
 	if (entry->msi_attrib.maskbit)
@@ -247,7 +249,8 @@ static void __pci_restore_msi_state(struct pci_dev *dev)
 =

 	pci_read_config_word(dev, pos + PCI_MSI_FLAGS, &control);
 	control &=3D ~(PCI_MSI_FLAGS_QSIZE | PCI_MSI_FLAGS_ENABLE);
-	if (entry->msi_attrib.maskbit || !entry->msi_attrib.masked)
+	if (!activation_used &&
+	    (entry->msi_attrib.maskbit || !entry->msi_attrib.masked))
 		control |=3D PCI_MSI_FLAGS_ENABLE;
 	pci_write_config_word(dev, pos + PCI_MSI_FLAGS, control);
 }
@@ -263,7 +266,8 @@ static void __pci_restore_msix_state(struct pci_dev *de=
v)
 		return;
 =

 	/* route the table */
-	pci_intx(dev, 0);		/* disable intx */
+	if (!activation_used)
+		pci_intx(dev, 0);	/* disable intx */
 	msix_set_enable(dev, 0);
 	irq =3D head =3D dev->first_msi_irq;
 	entry =3D get_irq_msi(irq);
@@ -279,7 +283,8 @@ static void __pci_restore_msix_state(struct pci_dev *de=
v)
 =

 	pci_read_config_word(dev, pos + PCI_MSIX_FLAGS, &control);
 	control &=3D ~PCI_MSIX_FLAGS_MASKALL;
-	control |=3D PCI_MSIX_FLAGS_ENABLE;
+	if (!activation_used)
+		control |=3D PCI_MSIX_FLAGS_ENABLE;
 	pci_write_config_word(dev, pos + PCI_MSIX_FLAGS, control);
 }
 =

@@ -301,11 +306,14 @@ void pci_restore_msi_state(struct pci_dev *dev)
  **/
 static int msi_capability_init(struct pci_dev *dev)
 {
+	int activation_used =3D pcim_activation_used(dev);
 	struct msi_desc *entry;
 	int pos, irq;
 	u16 control;
 =

-	msi_set_enable(dev, 0);	/* Ensure msi is disabled as I set it up */
+	/* Ensure msi is disabled as I set it up */
+	if (!activation_used)
+		msi_set_enable(dev, 0);
 =

    	pos =3D pci_find_capability(dev, PCI_CAP_ID_MSI);
 	pci_read_config_word(dev, msi_control_reg(pos), &control);
@@ -351,8 +359,10 @@ static int msi_capability_init(struct pci_dev *dev)
 	set_irq_msi(irq, entry);
 =

 	/* Set MSI enabled bits	 */
-	pci_intx(dev, 0);		/* disable intx */
-	msi_set_enable(dev, 1);
+	if (!activation_used) {
+		pci_intx(dev, 0);		/* disable intx */
+		msi_set_enable(dev, 1);
+	}
 	dev->msi_enabled =3D 1;
 =

 	dev->irq =3D irq;
@@ -372,6 +382,7 @@ static int msi_capability_init(struct pci_dev *dev)
 static int msix_capability_init(struct pci_dev *dev,
 				struct msix_entry *entries, int nvec)
 {
+	int activation_used =3D pcim_activation_used(dev);
 	struct msi_desc *head =3D NULL, *tail =3D NULL, *entry =3D NULL;
 	int irq, pos, i, j, nr_entries, temp =3D 0;
 	unsigned long phys_addr;
@@ -380,7 +391,9 @@ static int msix_capability_init(struct pci_dev *dev,
 	u8 bir;
 	void __iomem *base;
 =

-	msix_set_enable(dev, 0);/* Ensure msix is disabled as I set it up */
+	/* Ensure msix is disabled as I set it up */
+	if (!activation_used)
+		msix_set_enable(dev, 0);
 =

    	pos =3D pci_find_capability(dev, PCI_CAP_ID_MSIX);
 	/* Request & Map MSI-X table region */
@@ -451,8 +464,10 @@ static int msix_capability_init(struct pci_dev *dev,
 	}
 	dev->first_msi_irq =3D entries[0].vector;
 	/* Set MSI-X enabled bits */
-	pci_intx(dev, 0);		/* disable intx */
-	msix_set_enable(dev, 1);
+	if (!activation_used) {
+		pci_intx(dev, 0);		/* disable intx */
+		msix_set_enable(dev, 1);
+	}
 	dev->msix_enabled =3D 1;
 =

 	return 0;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d3eab05..f58aab5 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -663,14 +663,20 @@ pci_restore_state(struct pci_dev *dev)
 	 * register(s)
 	 */
 	for (i =3D 15; i >=3D 0; i--) {
+		u32 saved_val =3D dev->saved_config_space[i];
+
+		if (i =3D=3D 1 && pcim_activation_used(dev)) {
+			saved_val |=3D PCI_COMMAND_INTX_DISABLE;
+			saved_val &=3D ~PCI_COMMAND_MASTER;
+		}
+
 		pci_read_config_dword(dev, i * 4, &val);
-		if (val !=3D dev->saved_config_space[i]) {
+		if (val !=3D saved_val) {
 			printk(KERN_DEBUG "PM: Writing back config space on "
 				"device %s at offset %x (was %x, writing %x)\n",
 				pci_name(dev), i,
-				val, (int)dev->saved_config_space[i]);
-			pci_write_config_dword(dev,i * 4,
-				dev->saved_config_space[i]);
+			        val, (int)saved_val);
+			pci_write_config_dword(dev, i * 4, saved_val);
 		}
 	}
 	pci_restore_pcix_state(dev);
@@ -755,6 +761,7 @@ int pci_enable_device(struct pci_dev *dev)
  * when a device is enabled using managed PCI device enable interface.
  */
 struct pci_devres {
+	unsigned int activation_used:1;
 	unsigned int enabled:1;
 	unsigned int pinned:1;
 	unsigned int orig_intx:1;
@@ -819,7 +826,7 @@ int pcim_enable_device(struct pci_dev *pdev)
 	dr =3D get_pci_dr(pdev);
 	if (unlikely(!dr))
 		return -ENOMEM;
-	WARN_ON(!!dr->enabled);
+	WARN_ON(!!dr->enabled || !!dr->activation_used);
 =

 	rc =3D pci_enable_device(pdev);
 	if (!rc) {
@@ -830,6 +837,84 @@ int pcim_enable_device(struct pci_dev *pdev)
 }
 =

 /**
+ * pcim_prepare_device - Prepare device for driver initialization
+ * @dev: PCI device to be prepare
+ *
+ *  Prepare device for driver initialization.  Turn off any PCI
+ *  feature which might cause rogue activity during initialization
+ *  including IRQs and bus master access; then, enable the device.
+ */
+int pcim_prepare_device(struct pci_dev *pdev)
+{
+	struct pci_devres *dr;
+	u16 pci_command;
+	int rc;
+
+	dr =3D get_pci_dr(pdev);
+	if (unlikely(!dr))
+		return -ENOMEM;
+	WARN_ON(!!dr->enabled);
+
+	pdev->is_managed =3D 1;
+
+	pci_intx(pdev, 0); /* FIXME: INTX_DISABLE bit used to be reserved */
+	msi_set_enable(pdev, 0);
+	msix_set_enable(pdev, 0);
+
+	pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
+	if (pci_command & PCI_COMMAND_MASTER) {
+		pci_command &=3D ~PCI_COMMAND_MASTER;
+		pci_write_config_word(pdev, PCI_COMMAND, pci_command);
+	}
+	pdev->is_busmaster =3D 0;
+
+	rc =3D pci_enable_device(pdev);
+	if (!rc)
+		dr->activation_used =3D 1;
+	else
+		pdev->is_managed =3D 0;
+
+	return rc;
+}
+
+/**
+ * pcim_activate_device - Activate prepared device
+ * @dev: PCI device to activate
+ *
+ *  Activate @pdev which should have been enabled using
+ *  pcim_prepare_device().  This function is to be called as a last
+ *  step of driver initialization and enables bus master access and
+ *  the configured IRQ method (MSIX, MSI or INTX).
+ */
+int pcim_activate_device(struct pci_dev *pdev)
+{
+	struct pci_devres *dr;
+
+	dr =3D find_pci_dr(pdev);
+	WARN_ON(!dr || !dr->activation_used);
+	if (!dr)
+		return -EINVAL;
+
+	pci_set_master(pdev);
+
+	if (pdev->msix_enabled)
+		msix_set_enable(pdev, 1);
+	else if (pdev->msi_enabled)
+		msi_set_enable(pdev, 1);
+	else
+		pci_intx(pdev, 1);
+
+	return 0;
+}
+
+int pcim_activation_used(struct pci_dev *pdev)
+{
+	struct pci_devres *dr =3D find_pci_dr(pdev);
+
+	return dr && dr->activation_used;
+}
+
+/**
  * pcim_pin_device - Pin managed PCI device
  * @pdev: PCI device to pin
  *
@@ -1379,6 +1464,8 @@ EXPORT_SYMBOL_GPL(pci_restore_bars);
 EXPORT_SYMBOL(pci_enable_device_bars);
 EXPORT_SYMBOL(pci_enable_device);
 EXPORT_SYMBOL(pcim_enable_device);
+EXPORT_SYMBOL(pcim_prepare_device);
+EXPORT_SYMBOL(pcim_activate_device);
 EXPORT_SYMBOL(pcim_pin_device);
 EXPORT_SYMBOL(pci_disable_device);
 EXPORT_SYMBOL(pci_find_capability);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 62ea04c..8b41c5f 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1,5 +1,6 @@
 /* Functions internal to the PCI core code */
 =

+extern int pcim_activation_used(struct pci_dev *pdev);
 extern int __must_check __pci_reenable_device(struct pci_dev *);
 extern int pci_uevent(struct device *dev, char **envp, int num_envp,
 		      char *buffer, int buffer_size);
@@ -46,8 +47,12 @@ extern struct rw_semaphore pci_bus_sem;
 extern unsigned int pci_pm_d3_delay;
 =

 #ifdef CONFIG_PCI_MSI
+void msi_set_enable(struct pci_dev *dev, int enable);
+void msix_set_enable(struct pci_dev *dev, int enable);
 void pci_no_msi(void);
 #else
+static inline void msi_set_enable(struct pci_dev *dev, int enable) { }
+static inline void msix_set_enable(struct pci_dev *dev, int enable) { }
 static inline void pci_no_msi(void) { }
 #endif
 =

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 481ea06..f2eb5e7 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -525,6 +525,8 @@ static inline int pci_write_config_dword(struct pci_dev=
 *dev, int where, u32 val
 int __must_check pci_enable_device(struct pci_dev *dev);
 int __must_check pci_enable_device_bars(struct pci_dev *dev, int mask);
 int __must_check pcim_enable_device(struct pci_dev *pdev);
+int __must_check pcim_prepare_device(struct pci_dev *pdev);
+int __must_check pcim_activate_device(struct pci_dev *pdev);
 void pcim_pin_device(struct pci_dev *pdev);
 =

 static inline int pci_is_managed(struct pci_dev *pdev)
