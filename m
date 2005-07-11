From: "John W. Linville" <linville@tuxdriver.com>
Subject: [patch 2.6.13-rc2] PCI: Add GPL symbol export for
	pci_restore_bars
Date: Mon, 11 Jul 2005 13:38:18 -0400
Message-ID: <20050711173815.GG23093@tuxdriver.com>
References: <20050707.233530.85417983.davem@davemloft.net>
	<20050708110358.A8491@jurassic.park.msu.ru>
	<20050708.003333.28789082.davem@davemloft.net>
	<20050708122043.A8779@jurassic.park.msu.ru>
	<20050708183452.GB13445@tuxdriver.com>
	<20050711144844.A16143@tin.liacs.nl>
	<20050711131518.GB23093@tuxdriver.com>
	<20050711131859.GC23093@tuxdriver.com>
	<20050711171830.GA31050@kroah.com>
	<20050711173635.GF23093@tuxdriver.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============41314299143957145=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050711173635.GF23093@tuxdriver.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Greg KH <greg@kroah.com>
Cc: rmk+lkml@arm.linux.org.uk, grundler@parisc-linux.org, matthew@wil.cx, Lennert Buytenhek <buytenh+lkml@liacs.nl>, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, herbertb@cs.vu.nl, "David S. Miller" <davem@davemloft.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-pci@atrey.karlin.mff.cuni.cz, byjac@matfyz.cz
List-Id: linux-pm@vger.kernel.org

--===============41314299143957145==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Globalize and add EXPORT_SYMBOL_GPL for pci_restore_bars.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---
Some have expressed interest in making general use of the the
pci_restore_bars function.

Revised to use EXPORT_SYMBOL_GPL instead of EXPORT_SYMBOL.

 drivers/pci/pci.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -228,7 +228,7 @@ pci_find_parent_resource(const struct pc
  * Restore the BAR values for a given device, so as to make it
  * accessible by its driver.
  */
-static void
+void
 pci_restore_bars(struct pci_dev *dev)
 {
 	int i, numres;
@@ -833,6 +833,7 @@ struct pci_dev *isa_bridge;
 EXPORT_SYMBOL(isa_bridge);
 #endif
 
+EXPORT_SYMBOL_GPL(pci_restore_bars);
 EXPORT_SYMBOL(pci_enable_device_bars);
 EXPORT_SYMBOL(pci_enable_device);
 EXPORT_SYMBOL(pci_disable_device);
-- 
John W. Linville
linville@tuxdriver.com

--===============41314299143957145==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============41314299143957145==--
