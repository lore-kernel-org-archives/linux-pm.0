From: Boris Ostrovsky <boris.ostrovsky@amd.com>
Subject: [PATCH] x86: Use safe_halt() instead of halt() in acpi_idle_play_dead()
Date: Mon, 2 Apr 2012 20:56:17 +0200
Message-ID: <1333392977-26468-1-git-send-email-boris.ostrovsky@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: x86@kernel.org, len.brown@intel.com, tony.luck@gmail.com, konrad.wilk@oracle.com
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Boris Ostrovsky <boris.ostrovsky@amd.com>
List-Id: linux-pm@vger.kernel.org

Using halt() in acpi_idle_play_dead() breaks ia64 build. Use safe_halt()
instead.

Signed-off-by: Boris Ostrovsky <boris.ostrovsky@amd.com>
---
 drivers/acpi/processor_idle.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 6b1d32a..784f9a7 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -786,7 +786,7 @@ static int acpi_idle_play_dead(struct cpuidle_device *dev, int index)
 	while (1) {
 
 		if (cx->entry_method == ACPI_CSTATE_HALT)
-			halt();
+			safe_halt();
 		else if (cx->entry_method == ACPI_CSTATE_SYSTEMIO) {
 			inb(cx->address);
 			/* See comment in acpi_idle_do_entry() */
-- 
1.7.3.4


