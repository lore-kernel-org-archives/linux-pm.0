From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/3] ACPI/int340x_thermal: Use kcalloc() in two functions
Date: Mon, 10 Apr 2017 22:18:20 +0200
Message-ID: <55405e33-2a1a-ea40-743f-eb8e53a1a399@users.sourceforge.net>
References: <3ba36cc1-8445-462c-ca75-2b0928f3290a@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3ba36cc1-8445-462c-ca75-2b0928f3290a@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 10 Apr 2017 21:30:47 +0200

* Multiplications for the size determination of memory allocations
  indicated that array data structures should be processed.
  Thus use the corresponding function "kcalloc".

  This issue was detected by using the Coccinelle software.

* Replace the specification of data structures by pointer dereferences
  to make the corresponding size determination a bit safer according to
  the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/thermal/int340x_thermal/acpi_thermal_rel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/int340x_thermal/acpi_thermal_rel.c b/drivers/thermal/int340x_thermal/acpi_thermal_rel.c
index 2c2ec7666eb1..52a5fe0f81e8 100644
--- a/drivers/thermal/int340x_thermal/acpi_thermal_rel.c
+++ b/drivers/thermal/int340x_thermal/acpi_thermal_rel.c
@@ -96,7 +96,7 @@ int acpi_parse_trt(acpi_handle handle, int *trt_count, struct trt **trtp,
 	}
 
 	*trt_count = p->package.count;
-	trts = kzalloc(*trt_count * sizeof(struct trt), GFP_KERNEL);
+	trts = kcalloc(*trt_count, sizeof(*trts), GFP_KERNEL);
 	if (!trts) {
 		result = -ENOMEM;
 		goto end;
@@ -178,7 +178,7 @@ int acpi_parse_art(acpi_handle handle, int *art_count, struct art **artp,
 
 	/* ignore p->package.elements[0], as this is _ART Revision field */
 	*art_count = p->package.count - 1;
-	arts = kzalloc(*art_count * sizeof(struct art), GFP_KERNEL);
+	arts = kcalloc(*art_count, sizeof(*arts), GFP_KERNEL);
 	if (!arts) {
 		result = -ENOMEM;
 		goto end;
-- 
2.12.2
