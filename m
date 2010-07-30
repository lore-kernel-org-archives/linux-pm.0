From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: [PATCH 3/6] ACPI/PCI: optimize checks in
	acpi_pci_osc_control_set()
Date: Fri, 30 Jul 2010 15:22:14 +0900
Message-ID: <4C526F96.2090409__7207.35602449185$1280471789$gmane$org@jp.fujitsu.com>
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

Check for ACPI _OSC object is heavier than other checks in
acpi_pci_osc_control_set(). So move it after the other checks.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

---
 drivers/acpi/pci_root.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux-2.6.35-rc6/drivers/acpi/pci_root.c
===================================================================
--- linux-2.6.35-rc6.orig/drivers/acpi/pci_root.c
+++ linux-2.6.35-rc6/drivers/acpi/pci_root.c
@@ -388,10 +388,6 @@ acpi_status acpi_pci_osc_control_set(acp
 	acpi_handle tmp;
 	struct acpi_pci_root *root;
 
-	status = acpi_get_handle(handle, "_OSC", &tmp);
-	if (ACPI_FAILURE(status))
-		return status;
-
 	control_req = (flags & OSC_PCI_CONTROL_MASKS);
 	if (!control_req)
 		return AE_TYPE;
@@ -400,6 +396,10 @@ acpi_status acpi_pci_osc_control_set(acp
 	if (!root)
 		return AE_NOT_EXIST;
 
+	status = acpi_get_handle(handle, "_OSC", &tmp);
+	if (ACPI_FAILURE(status))
+		return status;
+
 	mutex_lock(&osc_lock);
 	/* No need to evaluate _OSC if the control was already granted. */
 	if ((root->osc_control_set & control_req) == control_req)
