From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: [PATCH 6/6] PCI: portdrv: remove module_exit
Date: Fri, 30 Jul 2010 15:25:06 +0900
Message-ID: <4C527042.6000806__17574.0195009441$1280472125$gmane$org@jp.fujitsu.com>
References: <201007282323.56351.rjw@sisk.pl>
	<20100728144358.5e2c12ce@virtuousgeek.org>
	<4C510B90.9070302@jp.fujitsu.com> <201007291745.39285.rjw@sisk.pl>
	<4C526A85.3070902@jp.fujitsu.com> <4C526E3E.3000600@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4C526E3E.3000600@jp.fujitsu.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, linux-pci@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Remove unnecessary pcie_portdrv_exit().

The PCIe port bus driver is built-in kernel module. So the module will
never be unloaded.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

---
 drivers/pci/pcie/portdrv_pci.c |    7 -------
 1 file changed, 7 deletions(-)

Index: linux-2.6.35-rc6/drivers/pci/pcie/portdrv_pci.c
===================================================================
--- linux-2.6.35-rc6.orig/drivers/pci/pcie/portdrv_pci.c
+++ linux-2.6.35-rc6/drivers/pci/pcie/portdrv_pci.c
@@ -345,11 +345,4 @@ static int __init pcie_portdrv_init(void
 	return retval;
 }
 
-static void __exit pcie_portdrv_exit(void)
-{
-	pci_unregister_driver(&pcie_portdriver);
-	pcie_port_bus_unregister();
-}
-
 module_init(pcie_portdrv_init);
-module_exit(pcie_portdrv_exit);
