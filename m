From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 3/3] PCI PM: Make warning in pci_legacy_suspend
	more useful
Date: Sun, 1 Feb 2009 22:34:24 +0100
Message-ID: <200902012234.25165.rjw__11345.2909085483$1233524728$gmane$org@sisk.pl>
References: <200902012229.27517.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902012229.27517.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

The warning in pci_legacy_suspend() would be much more useful if it
printed the name of the function that did the wrong thing.  Make it
do so.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci-driver.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/pci/pci-driver.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci-driver.c
+++ linux-2.6/drivers/pci/pci-driver.c
@@ -365,7 +365,9 @@ static int pci_legacy_suspend(struct dev
 		if (pci_dev->state_saved)
 			goto Fixup;
 
-		if (WARN_ON_ONCE(pci_dev->current_state != PCI_D0))
+		if (WARN_ONCE(pci_dev->current_state != PCI_D0,
+				"PCI PM: Device state not saved by %pF\n",
+				drv->suspend))
 			goto Fixup;
 	}
 
