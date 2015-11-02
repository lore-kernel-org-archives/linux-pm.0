From: ville.syrjala@linux.intel.com
Subject: [PATCH] intel_idle: Don't use on Lenovo Ideapad S10-3t
Date: Mon,  2 Nov 2015 23:22:40 +0200
Message-ID: <1446499360-31984-1-git-send-email-ville.syrjala@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:35051 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754036AbbKBVWn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 2 Nov 2015 16:22:43 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>

=46rom: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>

Lenovo Ideapad S10-3t hangs coming out of S3 with intel_idle.
The two workaround that seem to help are "intel_idle.max_cstate=3D0"
or "nohz=3Doff highres=3Doff".

At a first glance quirk_tigerpoint_bm_sts() seemed promising, but
even when moved to early_resume it didn't do anything.

I have no idea what's wrong here, so let's just disable intel_idle
for these machines using a DMI match.

Cc: Len Brown <len.brown@intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
---
If anyone has any better ideas, I can try out some patches.

 drivers/idle/intel_idle.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index cd4510a..c4a6888 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -61,6 +61,7 @@
 #include <linux/notifier.h>
 #include <linux/cpu.h>
 #include <linux/module.h>
+#include <linux/dmi.h>
 #include <asm/cpu_device_id.h>
 #include <asm/mwait.h>
 #include <asm/msr.h>
@@ -925,6 +926,25 @@ static const struct x86_cpu_id intel_idle_ids[] __=
initconst =3D {
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_idle_ids);
=20
+static int intel_idle_disable_callback(const struct dmi_system_id *id)
+{
+	pr_debug(PREFIX "problematic system (%s), disabling\n", id->ident);
+	return 1;
+}
+
+static const struct dmi_system_id intel_idle_disable_dmi[] =3D {
+	{
+		/* Lenovo Ideapad S10-3t, hangs coming out of S3 */
+		.callback =3D intel_idle_disable_callback,
+		.ident =3D "Lenovo Ideapad S10-3t",
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo Ideapad S10-3t"),
+		},
+	},
+	{}
+};
+
 /*
  * intel_idle_probe()
  */
@@ -957,6 +977,9 @@ static int __init intel_idle_probe(void)
 	    !mwait_substates)
 			return -ENODEV;
=20
+	if (dmi_check_system(intel_idle_disable_dmi))
+		return -ENODEV;
+
 	pr_debug(PREFIX "MWAIT substates: 0x%x\n", mwait_substates);
=20
 	icpu =3D (const struct idle_cpu *)id->driver_data;
--=20
2.4.10

