From: Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 2/2] ACPI / PM: Runtime resume devices when waking from
 hibernate
Date: Wed, 23 Mar 2016 00:11:20 +0100
Message-ID: <74b1e7106699a677a2a6cb8e7700fd7770d346d8.1458641423.git.lukas@wunner.de>
References: <cover.1458641423.git.lukas@wunner.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:42924 "EHLO
	mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752178AbcCVXKC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 22 Mar 2016 19:10:02 -0400
In-Reply-To: <cover.1458641423.git.lukas@wunner.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org

Commit 58a1fbbb2ee8 ("PM / PCI / ACPI: Kick devices that might have been
reset by firmware") added a runtime resume for devices that were runtime
suspended when the system entered suspend-to-RAM.

Briefly, the motivation was to ensure that devices did not remain in a
reset-power-on state after resume, potentially preventing deep SoC-wide
low-power states from being entered on idle.

Currently we're not doing the same when leaving suspend-to-disk and this
asymmetry is a problem if drivers rely on the automatic resume triggered
by pm_complete_with_resume_check(). Fix it.

Fixes: 58a1fbbb2ee8 ("PM / PCI / ACPI: Kick devices that might have been
    reset by firmware")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/acpi/sleep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index fbfcce3..2a8b596 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -748,6 +748,7 @@ static int acpi_hibernation_enter(void)
 
 static void acpi_hibernation_leave(void)
 {
+	pm_set_resume_via_firmware();
 	/*
 	 * If ACPI is not enabled by the BIOS and the boot kernel, we need to
 	 * enable it here.
-- 
1.8.5.2 (Apple Git-48)

