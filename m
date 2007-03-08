From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: SATA resume slowness, e1000 MSI warning
Date: Thu, 8 Mar 2007 12:23:54 +0200
Message-ID: <20070308102354.GC5149@mellanox.co.il>
References: <20070227103021.GA2250@kernel.dk>
	<m1wt1s6x2p.fsf@ebiederm.dsl.xmission.com>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <m1wt1s6x2p.fsf@ebiederm.dsl.xmission.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Kok, Auke" <auke-jan.h.kok@intel.com>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Jeff Garzik <jeff@garzik.org>, Ingo Molnar <mingo@elte.hu>, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, Pavel Machek <pavel@ucw.cz>, Jens Axboe <jens.axboe@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

> The only case I can see which might trigger this is if we saved
> pci-X state and then didn't restore it because we could not find
> the capability on restore.

Hmm. pci_save_pcix_state/pci_restore_pcix_state seem to only handle
regular devices and seem to ignore the fact that for bridge PCI-X
capability has a different structure.

Is this intentional? If not, here's a patch to fix this.
Warning: completely untested.


PCI: restore bridge PCI-X capability registers after PM event

Restore PCI-X bridge up/downstream capability registers
after PM event.  This includes maxumum split transaction
commitment limit which might be vital for PCI X.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index df49530..4b788ef 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -597,14 +597,19 @@ static int pci_save_pcix_state(struct pci_dev *dev)
 	if (pos <=3D 0)
 		return 0;
 =

-	save_state =3D kzalloc(sizeof(*save_state) + sizeof(u16), GFP_KERNEL);
+	save_state =3D kzalloc(sizeof(*save_state) + sizeof(u16) * 2, GFP_KERNEL);
 	if (!save_state) {
-		dev_err(&dev->dev, "Out of memory in pci_save_pcie_state\n");
+		dev_err(&dev->dev, "Out of memory in pci_save_pcix_state\n");
 		return -ENOMEM;
 	}
 	cap =3D (u16 *)&save_state->data[0];
 =

-	pci_read_config_word(dev, pos + PCI_X_CMD, &cap[i++]);
+	if (dev->hdr_type =3D=3D PCI_HEADER_TYPE_BRIDGE) {
+		pci_read_config_word(dev, pos + PCI_X_BRIDGE_UP_SPL_CTL, &cap[i++]);
+		pci_read_config_word(dev, pos + PCI_X_BRIDGE_DN_SPL_CTL, &cap[i++]);
+	} else
+		pci_read_config_word(dev, pos + PCI_X_CMD, &cap[i++]);
+
 	pci_add_saved_cap(dev, save_state);
 	return 0;
 }
@@ -621,7 +626,11 @@ static void pci_restore_pcix_state(struct pci_dev *dev)
 		return;
 	cap =3D (u16 *)&save_state->data[0];
 =

-	pci_write_config_word(dev, pos + PCI_X_CMD, cap[i++]);
+	if (dev->hdr_type =3D=3D PCI_HEADER_TYPE_BRIDGE) {
+		pci_write_config_word(dev, pos + PCI_X_BRIDGE_UP_SPL_CTL, cap[i++]);
+		pci_write_config_word(dev, pos + PCI_X_BRIDGE_DN_SPL_CTL, cap[i++]);
+	} else
+		pci_write_config_word(dev, pos + PCI_X_CMD, cap[i++]);
 	pci_remove_saved_cap(save_state);
 	kfree(save_state);
 }
diff --git a/include/linux/pci_regs.h b/include/linux/pci_regs.h
index f09cce2..fb7eefd 100644
--- a/include/linux/pci_regs.h
+++ b/include/linux/pci_regs.h
@@ -332,6 +332,8 @@
 #define  PCI_X_STATUS_SPL_ERR	0x20000000	/* Rcvd Split Completion Error Ms=
g */
 #define  PCI_X_STATUS_266MHZ	0x40000000	/* 266 MHz capable */
 #define  PCI_X_STATUS_533MHZ	0x80000000	/* 533 MHz capable */
+#define PCI_X_BRIDGE_UP_SPL_CTL 10	/* PCI-X upstream split transaction lim=
it */
+#define PCI_X_BRIDGE_DN_SPL_CTL 14	/* PCI-X downstream split transaction l=
imit */
 =

 /* PCI Express capability registers */
 =



-- =

MST
