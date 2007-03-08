From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [PATCH 1/2] msi: Safer state caching.
Date: Thu, 08 Mar 2007 13:04:57 -0700
Message-ID: <m1ps7j5wnq.fsf_-_@ebiederm.dsl.xmission.com>
References: <20070227103021.GA2250@kernel.dk> <20070227103407.GA17819@elte.hu>
	<20070227105922.GD2250@kernel.dk> <20070227111515.GA4271@kernel.dk>
	<20070301093450.GA8508@elte.hu> <20070302100704.GB2293@elf.ucw.cz>
	<20070305084257.GA4464@mellanox.co.il>
	<20070305101120.GA23032@elte.hu> <45ECFC5F.7000102@garzik.org>
	<45ED0BBF.1050000@intel.com> <20070306090444.GA25409@elte.hu>
	<45ED8A12.5040803@intel.com>
	<m1ejo1elj6.fsf@ebiederm.dsl.xmission.com>
	<45EEE8CF.1060803@intel.com> <45EEEC2C.5090609@intel.com>
	<m1649cdfas.fsf@ebiederm.dsl.xmission.com>
	<20070307185317.5601d452.akpm@linux-foundation.org>
	<m1wt1s6x2p.fsf@ebiederm.dsl.xmission.com>
	<45EFDD8C.3070702@garzik.org>
	<m1abyn7iin.fsf@ebiederm.dsl.xmission.com>
	<m1tzwv5wz9.fsf_-_@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <m1tzwv5wz9.fsf_-_@ebiederm.dsl.xmission.com> (Eric
	W. Biederman's message of "Thu, 08 Mar 2007 12:58:02 -0700")
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Kok, Auke" <auke-jan.h.kok@intel.com>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Jeff Garzik <jeff@garzik.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, michael@ellerman.id.au, linux-pci@atrey.karlin.mff.cuni.cz, Pavel Machek <pavel@ucw.cz>, Jens Axboe <jens.axboe@oracle.com>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org


There are two ways pci_save_state and pci_restore_state are used.  As
helper functions during suspend/resume, and as helper functions around
a hardware reset event.  When used as helper functions around a hardware
reset event there is no reason to believe the calls will be paired, nor
is there a good reason to believe that if we restore the msi state from
before the reset that it will match the current msi state.  Since arch
code may change the msi message without going through the driver, drivers
currently do not have enough information to even know when to call
pci_save_state to ensure they will have msi state in sync with the other
kernel irq reception data structures.

It turns out the solution is straight forward, cache the state in the
existing msi data structures (not the magic pci saved things) and
have the msi code update the cached state each time we write to the hardwar=
e.
This means we never need to read the hardware to figure out what the hardwa=
re
state should be.

By modifying the caching in this manner we get to remove our save_state
routines and only need to provide restore_state routines.

The only fields that were at all tricky to regenerate were the msi and msi-x
control registers and the way we regenerate them currently is a bit depende=
nt
upon assumptions on how we use the allow msi registers to be configured and=
 used
making the code a little bit brittle.  If we ever change what cases we allow
or how we configure the msi bits we can address the fragility then.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 drivers/pci/msi.c        |  150 ++++++++----------------------------------=
----
 drivers/pci/pci.c        |    2 -
 drivers/pci/pci.h        |    2 -
 include/linux/msi.h      |    8 +--
 include/linux/pci_regs.h |    1 +
 5 files changed, 29 insertions(+), 134 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 01869b1..ad33e01 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -100,6 +100,7 @@ static void msi_set_mask_bit(unsigned int irq, int flag)
 		BUG();
 		break;
 	}
+	entry->msi_attrib.masked =3D !!flag;
 }
 =

 void read_msi_msg(unsigned int irq, struct msi_msg *msg)
@@ -179,6 +180,7 @@ void write_msi_msg(unsigned int irq, struct msi_msg *ms=
g)
 	default:
 		BUG();
 	}
+	entry->msg =3D *msg;
 }
 =

 void mask_msi_irq(unsigned int irq)
@@ -225,164 +227,60 @@ static struct msi_desc* alloc_msi_entry(void)
 }
 =

 #ifdef CONFIG_PM
-static int __pci_save_msi_state(struct pci_dev *dev)
-{
-	int pos, i =3D 0;
-	u16 control;
-	struct pci_cap_saved_state *save_state;
-	u32 *cap;
-
-	if (!dev->msi_enabled)
-		return 0;
-
-	pos =3D pci_find_capability(dev, PCI_CAP_ID_MSI);
-	if (pos <=3D 0)
-		return 0;
-
-	save_state =3D kzalloc(sizeof(struct pci_cap_saved_state) + sizeof(u32) *=
 5,
-		GFP_KERNEL);
-	if (!save_state) {
-		printk(KERN_ERR "Out of memory in pci_save_msi_state\n");
-		return -ENOMEM;
-	}
-	cap =3D &save_state->data[0];
-
-	pci_read_config_dword(dev, pos, &cap[i++]);
-	control =3D cap[0] >> 16;
-	pci_read_config_dword(dev, pos + PCI_MSI_ADDRESS_LO, &cap[i++]);
-	if (control & PCI_MSI_FLAGS_64BIT) {
-		pci_read_config_dword(dev, pos + PCI_MSI_ADDRESS_HI, &cap[i++]);
-		pci_read_config_dword(dev, pos + PCI_MSI_DATA_64, &cap[i++]);
-	} else
-		pci_read_config_dword(dev, pos + PCI_MSI_DATA_32, &cap[i++]);
-	if (control & PCI_MSI_FLAGS_MASKBIT)
-		pci_read_config_dword(dev, pos + PCI_MSI_MASK_BIT, &cap[i++]);
-	save_state->cap_nr =3D PCI_CAP_ID_MSI;
-	pci_add_saved_cap(dev, save_state);
-	return 0;
-}
-
 static void __pci_restore_msi_state(struct pci_dev *dev)
 {
-	int i =3D 0, pos;
+	int pos;
 	u16 control;
-	struct pci_cap_saved_state *save_state;
-	u32 *cap;
+	struct msi_desc *entry;
 =

 	if (!dev->msi_enabled)
 		return;
 =

-	save_state =3D pci_find_saved_cap(dev, PCI_CAP_ID_MSI);
-	pos =3D pci_find_capability(dev, PCI_CAP_ID_MSI);
-	if (!save_state || pos <=3D 0)
-		return;
-	cap =3D &save_state->data[0];
+	entry =3D get_irq_msi(dev->irq);
+	pos =3D entry->msi_attrib.pos;
 =

 	pci_intx(dev, 0);		/* disable intx */
-	control =3D cap[i++] >> 16;
 	msi_set_enable(dev, 0);
-	pci_write_config_dword(dev, pos + PCI_MSI_ADDRESS_LO, cap[i++]);
-	if (control & PCI_MSI_FLAGS_64BIT) {
-		pci_write_config_dword(dev, pos + PCI_MSI_ADDRESS_HI, cap[i++]);
-		pci_write_config_dword(dev, pos + PCI_MSI_DATA_64, cap[i++]);
-	} else
-		pci_write_config_dword(dev, pos + PCI_MSI_DATA_32, cap[i++]);
-	if (control & PCI_MSI_FLAGS_MASKBIT)
-		pci_write_config_dword(dev, pos + PCI_MSI_MASK_BIT, cap[i++]);
+	write_msi_msg(dev->irq, &entry->msg);
+	if (entry->msi_attrib.maskbit)
+		msi_set_mask_bit(dev->irq, entry->msi_attrib.masked);
+
+	pci_read_config_word(dev, pos + PCI_MSI_FLAGS, &control);
+	control &=3D ~(PCI_MSI_FLAGS_QSIZE | PCI_MSI_FLAGS_ENABLE);
+	if (entry->msi_attrib.maskbit || !entry->msi_attrib.masked)
+		control |=3D PCI_MSI_FLAGS_ENABLE;
 	pci_write_config_word(dev, pos + PCI_MSI_FLAGS, control);
-	pci_remove_saved_cap(save_state);
-	kfree(save_state);
-}
-
-static int __pci_save_msix_state(struct pci_dev *dev)
-{
-	int pos;
-	int irq, head, tail =3D 0;
-	u16 control;
-	struct pci_cap_saved_state *save_state;
-
-	if (!dev->msix_enabled)
-		return 0;
-
-	pos =3D pci_find_capability(dev, PCI_CAP_ID_MSIX);
-	if (pos <=3D 0)
-		return 0;
-
-	/* save the capability */
-	pci_read_config_word(dev, msi_control_reg(pos), &control);
-	save_state =3D kzalloc(sizeof(struct pci_cap_saved_state) + sizeof(u16),
-		GFP_KERNEL);
-	if (!save_state) {
-		printk(KERN_ERR "Out of memory in pci_save_msix_state\n");
-		return -ENOMEM;
-	}
-	*((u16 *)&save_state->data[0]) =3D control;
-
-	/* save the table */
-	irq =3D head =3D dev->first_msi_irq;
-	while (head !=3D tail) {
-		struct msi_desc *entry;
-
-		entry =3D get_irq_msi(irq);
-		read_msi_msg(irq, &entry->msg_save);
-
-		tail =3D entry->link.tail;
-		irq =3D tail;
-	}
-
-	save_state->cap_nr =3D PCI_CAP_ID_MSIX;
-	pci_add_saved_cap(dev, save_state);
-	return 0;
-}
-
-int pci_save_msi_state(struct pci_dev *dev)
-{
-	int rc;
-
-	rc =3D __pci_save_msi_state(dev);
-	if (rc)
-		return rc;
-
-	rc =3D __pci_save_msix_state(dev);
-
-	return rc;
 }
 =

 static void __pci_restore_msix_state(struct pci_dev *dev)
 {
-	u16 save;
 	int pos;
 	int irq, head, tail =3D 0;
 	struct msi_desc *entry;
-	struct pci_cap_saved_state *save_state;
+	u16 control;
 =

 	if (!dev->msix_enabled)
 		return;
 =

-	save_state =3D pci_find_saved_cap(dev, PCI_CAP_ID_MSIX);
-	if (!save_state)
-		return;
-	save =3D *((u16 *)&save_state->data[0]);
-	pci_remove_saved_cap(save_state);
-	kfree(save_state);
-
-	pos =3D pci_find_capability(dev, PCI_CAP_ID_MSIX);
-	if (pos <=3D 0)
-		return;
-
 	/* route the table */
 	pci_intx(dev, 0);		/* disable intx */
 	msix_set_enable(dev, 0);
 	irq =3D head =3D dev->first_msi_irq;
+	entry =3D get_irq_msi(irq);
+	pos =3D entry->msi_attrib.pos;
 	while (head !=3D tail) {
 		entry =3D get_irq_msi(irq);
-		write_msi_msg(irq, &entry->msg_save);
+		write_msi_msg(irq, &entry->msg);
+		msi_set_mask_bit(irq, entry->msi_attrib.masked);
 =

 		tail =3D entry->link.tail;
 		irq =3D tail;
 	}
 =

-	pci_write_config_word(dev, msi_control_reg(pos), save);
+	pci_read_config_word(dev, pos + PCI_MSIX_FLAGS, &control);
+	control &=3D ~PCI_MSIX_FLAGS_MASKALL;
+	control |=3D PCI_MSIX_FLAGS_ENABLE;
+	pci_write_config_word(dev, pos + PCI_MSIX_FLAGS, control);
 }
 =

 void pci_restore_msi_state(struct pci_dev *dev)
@@ -420,6 +318,7 @@ static int msi_capability_init(struct pci_dev *dev)
 	entry->msi_attrib.is_64 =3D is_64bit_address(control);
 	entry->msi_attrib.entry_nr =3D 0;
 	entry->msi_attrib.maskbit =3D is_mask_bit_support(control);
+	entry->msi_attrib.masked =3D 1;
 	entry->msi_attrib.default_irq =3D dev->irq;	/* Save IOAPIC IRQ */
 	entry->msi_attrib.pos =3D pos;
 	if (is_mask_bit_support(control)) {
@@ -507,6 +406,7 @@ static int msix_capability_init(struct pci_dev *dev,
 		entry->msi_attrib.is_64 =3D 1;
 		entry->msi_attrib.entry_nr =3D j;
 		entry->msi_attrib.maskbit =3D 1;
+		entry->msi_attrib.masked =3D 1;
 		entry->msi_attrib.default_irq =3D dev->irq;
 		entry->msi_attrib.pos =3D pos;
 		entry->dev =3D dev;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index df49530..6fb78df 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -638,8 +638,6 @@ pci_save_state(struct pci_dev *dev)
 	/* XXX: 100% dword access ok here? */
 	for (i =3D 0; i < 16; i++)
 		pci_read_config_dword(dev, i * 4,&dev->saved_config_space[i]);
-	if ((i =3D pci_save_msi_state(dev)) !=3D 0)
-		return i;
 	if ((i =3D pci_save_pcie_state(dev)) !=3D 0)
 		return i;
 	if ((i =3D pci_save_pcix_state(dev)) !=3D 0)
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ae7a975..62ea04c 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -52,10 +52,8 @@ static inline void pci_no_msi(void) { }
 #endif
 =

 #if defined(CONFIG_PCI_MSI) && defined(CONFIG_PM)
-int pci_save_msi_state(struct pci_dev *dev);
 void pci_restore_msi_state(struct pci_dev *dev);
 #else
-static inline int pci_save_msi_state(struct pci_dev *dev) { return 0; }
 static inline void pci_restore_msi_state(struct pci_dev *dev) {}
 #endif
 =

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 74c8a2e..e38fe68 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -17,7 +17,7 @@ struct msi_desc {
 	struct {
 		__u8	type	: 5; 	/* {0: unused, 5h:MSI, 11h:MSI-X} */
 		__u8	maskbit	: 1; 	/* mask-pending bit supported ?   */
-		__u8	unused	: 1;
+		__u8	masked	: 1;
 		__u8	is_64	: 1;	/* Address size: 0=3D32bit 1=3D64bit  */
 		__u8	pos;	 	/* Location of the msi capability */
 		__u16	entry_nr;    	/* specific enabled entry 	  */
@@ -32,10 +32,8 @@ struct msi_desc {
 	void __iomem *mask_base;
 	struct pci_dev *dev;
 =

-#ifdef CONFIG_PM
-	/* PM save area for MSIX address/data */
-	struct msi_msg msg_save;
-#endif
+	/* Last set MSI message */
+	struct msi_msg msg;
 };
 =

 /*
diff --git a/include/linux/pci_regs.h b/include/linux/pci_regs.h
index f09cce2..495d368 100644
--- a/include/linux/pci_regs.h
+++ b/include/linux/pci_regs.h
@@ -296,6 +296,7 @@
 #define PCI_MSIX_FLAGS		2
 #define  PCI_MSIX_FLAGS_QSIZE	0x7FF
 #define  PCI_MSIX_FLAGS_ENABLE	(1 << 15)
+#define  PCI_MSIX_FLAGS_MASKALL	(1 << 14)
 #define PCI_MSIX_FLAGS_BIRMASK	(7 << 0)
 #define PCI_MSIX_FLAGS_BITMASK	(1 << 0)
 =

-- =

1.5.0.g53756
