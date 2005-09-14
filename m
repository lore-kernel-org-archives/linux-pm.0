From: "John W. Linville" <linville@tuxdriver.com>
Subject: [patch 2.6.14-rc1] pci: only call pci_restore_bars at
	boot
Date: Wed, 14 Sep 2005 09:52:42 -0400
Message-ID: <09142005095242.32027@bilbo.tuxdriver.com>
References: <20050727141942.GB22686@tuxdriver.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============40946940127079556=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050727141942.GB22686@tuxdriver.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, linux-pm@lists.osdl.org
Cc: akpm@osdl.org, kaos@sgi.com, torvalds@osdl.org, ink@jurassic.park.msu.ru, grundler@parisc-linux.org, matthew@wil.cx, rmk+lkml@arm.linux.org.uk, davem@davemloft.net
List-Id: linux-pm@vger.kernel.org

--===============40946940127079556==
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Certain (SGI?) ia64 boxes object to having their PCI BARs
restored unless absolutely necessary. This patch restricts calling
pci_restore_bars from pci_set_power_state unless the current state
is PCI_UNKNOWN, the actual (i.e. physical) state of the device is
PCI_D3hot, and the device indicates that it will lose its configuration
when transitioning to PCI_D0.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---
Many thanks to Keith Owens <kaos@sgi.com> for a) narrowing-down the
problem; and, b) quickly testing the fix and reporting the results.

 drivers/pci/pci.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -309,17 +309,25 @@ pci_set_power_state(struct pci_dev *dev,
 
 	pci_read_config_word(dev, pm + PCI_PM_CTRL, &pmcsr);
 
-	/* If we're in D3, force entire word to 0.
+	/* If we're (effectively) in D3, force entire word to 0.
 	 * This doesn't affect PME_Status, disables PME_En, and
 	 * sets PowerState to 0.
 	 */
-	if (dev->current_state >= PCI_D3hot) {
-		if (!(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET))
+	switch (dev->current_state) {
+	case PCI_UNKNOWN: /* Boot-up */
+		if ((pmcsr & PCI_PM_CTRL_STATE_MASK) == PCI_D3hot
+		 && !(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET))
 			need_restore = 1;
+		/* Fall-through: force to D0 */
+	case PCI_D3hot:
+	case PCI_D3cold:
+	case PCI_POWER_ERROR:
 		pmcsr = 0;
-	} else {
+		break;
+	default:
 		pmcsr &= ~PCI_PM_CTRL_STATE_MASK;
 		pmcsr |= state;
+		break;
 	}
 
 	/* enter specified state */

--===============40946940127079556==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============40946940127079556==--
