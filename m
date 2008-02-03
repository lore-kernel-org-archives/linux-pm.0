From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/3] PCI ACPI: Fix comment describing
	acpi_pci_choose_state
Date: Sun, 3 Feb 2008 22:53:31 +0100
Message-ID: <200802032253.31780.rjw__42891.0182360143$1202076263$gmane$org@sisk.pl>
References: <200802032252.04852.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200802032252.04852.rjw@sisk.pl>
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
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

The last line of the comment preceding the definition of
acpi_pci_choose_state() is incorrect.  Remove it.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci-acpi.c |    2 --
 1 file changed, 2 deletions(-)

Index: linux-2.6/drivers/pci/pci-acpi.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci-acpi.c
+++ linux-2.6/drivers/pci/pci-acpi.c
@@ -241,8 +241,6 @@ EXPORT_SYMBOL(pci_osc_control_set);
  *	choose from highest power _SxD to lowest power _SxW
  * else // no _PRW at S-state x
  * 	choose highest power _SxD or any lower power
- *
- * currently we simply return _SxD, if present.
  */
 
 static pci_power_t acpi_pci_choose_state(struct pci_dev *pdev,
