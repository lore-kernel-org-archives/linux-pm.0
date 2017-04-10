From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/3] ACPI/int340x_thermal: Improve size determinations in two
 functions
Date: Mon, 10 Apr 2017 22:19:40 +0200
Message-ID: <4a122a0b-ac75-4a89-c991-487cc0017c5a@users.sourceforge.net>
References: <3ba36cc1-8445-462c-ca75-2b0928f3290a@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.12]:60171 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751712AbdDJUUD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 10 Apr 2017 16:20:03 -0400
In-Reply-To: <3ba36cc1-8445-462c-ca75-2b0928f3290a@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 10 Apr 2017 21:42:44 +0200

Replace the specification of two data types by pointer dereferences
as the parameter for the operator "sizeof" to make the corresponding size
determinations a bit safer according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/thermal/int340x_thermal/acpi_thermal_rel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/int340x_thermal/acpi_thermal_rel.c b/drivers/thermal/int340x_thermal/acpi_thermal_rel.c
index 52a5fe0f81e8..d7791b1fec33 100644
--- a/drivers/thermal/int340x_thermal/acpi_thermal_rel.c
+++ b/drivers/thermal/int340x_thermal/acpi_thermal_rel.c
@@ -247,7 +247,7 @@ static int fill_art(char __user *ubuf)
 	ret = acpi_parse_art(acpi_thermal_rel_handle, &count, &arts, false);
 	if (ret)
 		goto free_art;
-	art_len = count * sizeof(union art_object);
+	art_len = count * sizeof(*art_user);
 	art_user = kzalloc(art_len, GFP_KERNEL);
 	if (!art_user) {
 		ret = -ENOMEM;
@@ -283,7 +283,7 @@ static int fill_trt(char __user *ubuf)
 	ret = acpi_parse_trt(acpi_thermal_rel_handle, &count, &trts, false);
 	if (ret)
 		goto free_trt;
-	trt_len = count * sizeof(union trt_object);
+	trt_len = count * sizeof(*trt_user);
 	trt_user = kzalloc(trt_len, GFP_KERNEL);
 	if (!trt_user) {
 		ret = -ENOMEM;
-- 
2.12.2
