From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 12/27] nouveau_acpi: convert acpi_get_handle() to acpi_has_method()
Date: Tue,  3 Sep 2013 08:32:00 +0800
Message-ID: <1378168335-22556-13-git-send-email-rui.zhang@intel.com>
References: <1378168335-22556-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:41183 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756447Ab3ICAbb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 2 Sep 2013 20:31:31 -0400
In-Reply-To: <1378168335-22556-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Ben Skeggs <bskeggs@redhat.com>, Dave Airlie <airlied@redhat.com>

acpi_has_method() is a new ACPI API introduced to check
the existence of an ACPI control method.

It can be used to replace acpi_get_handle() in the case that
1. the calling function doesn't need the ACPI handle of the control method.
and
2. the calling function doesn't care the reason why the method is unavailable.

Convert acpi_get_handle() to acpi_has_method()
in drivers/gpu/drm/nouveau/nouveau_acpi.c in this patch.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
CC: Ben Skeggs <bskeggs@redhat.com>
CC: Dave Airlie <airlied@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_acpi.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_acpi.c b/drivers/gpu/drm/nouveau/nouveau_acpi.c
index 4d70fb7..3cfb551 100644
--- a/drivers/gpu/drm/nouveau/nouveau_acpi.c
+++ b/drivers/gpu/drm/nouveau/nouveau_acpi.c
@@ -235,18 +235,15 @@ static struct vga_switcheroo_handler nouveau_dsm_handler = {
 
 static int nouveau_dsm_pci_probe(struct pci_dev *pdev)
 {
-	acpi_handle dhandle, nvidia_handle;
-	acpi_status status;
+	acpi_handle dhandle;
 	int retval = 0;
 
 	dhandle = DEVICE_ACPI_HANDLE(&pdev->dev);
 	if (!dhandle)
 		return false;
 
-	status = acpi_get_handle(dhandle, "_DSM", &nvidia_handle);
-	if (ACPI_FAILURE(status)) {
+	if (!acpi_has_method(dhandle, "_DSM"))
 		return false;
-	}
 
 	if (nouveau_test_dsm(dhandle, nouveau_dsm, NOUVEAU_DSM_POWER))
 		retval |= NOUVEAU_DSM_HAS_MUX;
-- 
1.8.1.2

