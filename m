Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEE13CBE80;
	Fri,  4 Sep 2026 07:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788507494; cv=none; b=N7Yo1fZ+h79oLqoItfnZsDevgpZ4P6rnMgAHTsg9sMTSzE54zMfMHgOr2d5oBYOxk4zjJXiYzeRRpD2Kd+k1pFQLYJO+u/UGQMva37OEvGcgvh2eOpPPTnY/+KiaunyjKnEXpljAh5Csye0u5NqyDqbjBRx9Kr6tCEj1ipYNpAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788507494; c=relaxed/simple;
	bh=l0EPpfNkaiNtCICSpDydo6nmVZq8IYPhlOLDpKHrpoc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HHgS11p3zW+bYBZjQtlaJ/U7d7eKhfCQQOlgR1WGpBhf2ulztpXWIg6CkenI8Niqq7GJmFy+fs2+Fw/CBmJ7x2+w2QbR3YperJm5sKCQfotlaeGLgfBzQg57ohtfCagDxrwyrrg05IGpBnckZTpxqWJNALVwEIBkwF0ljmciwu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OLAzCrcK; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OLAzCrcK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788507491; x=1820043491;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=l0EPpfNkaiNtCICSpDydo6nmVZq8IYPhlOLDpKHrpoc=;
  b=OLAzCrcKkkYyn1oG3D8hmQxzStq5T9jVnhdMKKHjbMgMLGtQNcX3lJ5F
   w4i4wQTIRsdHshDCZom1vJFo7T1JsFZJEJP6hEQm42iGZOrCA0mai1Rd7
   HRi0vGayLJc6VIRK/qgW2ZHgZUN1cEjexNmjGDrjVTvs+DjF8FqXZH5ek
   ug2CMk1hpKYwsqhF12YMrt3nkRukz8OFoKZs4NeqS0WdFVC5FLQDia3uQ
   91FW2e3TjNo0XUkVUMuKD8PE9o2shrPVz+/W/m5jdxE/Z6XlIYp0EQ8E9
   tGuXmaK5U67UKfPXdHKgffJpQOiF3eCb3UtftHO8O6KHbinAk2TXC2Msy
   Q==;
X-CSE-ConnectionGUID: g8feQfwjSYykAcSXfQOpqw==
X-CSE-MsgGUID: /GXIOTDcSBWn3vdt7ykIWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="100523371"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="100523371"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 00:38:08 -0700
X-CSE-ConnectionGUID: OjpRpL4iQTyhJhi0oZMK6g==
X-CSE-MsgGUID: qzRLKEXjRpum1do7o+pIWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="263769418"
Received: from senthil-nuc10i7fnh.iind.intel.com ([10.223.163.42])
  by fmviesa009.fm.intel.com with ESMTP; 04 Sep 2026 00:38:07 -0700
From: Saranya Gopal <saranya.gopal@intel.com>
To: linux-acpi@vger.kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rafael.j.wysocki@intel.com
Subject: [PATCH] ACPI: s2idle: Add _Ixx GPE wake indicator support
Date: Fri,  4 Sep 2026 13:08:44 +0530
Message-Id: <20260904073844.2740931-1-saranya.gopal@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ACPI 6.6 defines _Ixx indicator objects under \_GPE to mark GPEs that
should remain wake-enabled in s2idle without a _PRW association.
To support them, add new function acpi_setup_ixx_gpes() that looks for
_Ixx objects for all GPEs in the FADT 0/1 blocks and if it finds any, it
marks the corresponding GPE as wake-capable, in which case the GPE is
also enabled so long as it has a handler method because marking it as
wake-capable causes acpi_update_all_gpes() to skip it. Since that only
needs to be done if suspend-to-idle is enabled, make acpi_s2idle_setup()
call that new function.

For now, this is limited to x86 systems and it assumes that the GPEs
with _Ixx will not cause spurious wakeups to occur while suspended.

Signed-off-by: Saranya Gopal <saranya.gopal@intel.com>
---
 drivers/acpi/x86/s2idle.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index b6b1dd76a06b..ac49f9e75fae 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -24,6 +24,31 @@
 
 #ifdef CONFIG_SUSPEND
 
+static void acpi_setup_ixx_gpes(void)
+{
+	acpi_handle gpe_root;
+	unsigned int i;
+	char gpe_nr_str[5];
+
+	if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_GPE", &gpe_root)))
+		return;
+
+	for (i = 0; i <= 0xff; i++) {
+		scnprintf(gpe_nr_str, sizeof(gpe_nr_str), "_I%02X", i);
+		if (!acpi_has_method(gpe_root, gpe_nr_str))
+			continue;
+		/*
+		 * Enable the GPE if it has a handler method because marking it
+		 * as wake-capable causes acpi_update_all_gpes() to skip it.
+		 */
+		if (ACPI_FAILURE(acpi_enable_gpe_cond(NULL, i, ACPI_GPE_DISPATCH_METHOD)))
+			continue;
+		acpi_mark_gpe_for_wake(NULL, i);
+		acpi_set_gpe_wake_mask(NULL, i, ACPI_GPE_ENABLE);
+		pm_pr_dbg("ACPI: GPE 0x%02x armed for wake via %s\n", i, gpe_nr_str);
+	}
+}
+
 static bool sleep_no_lps0 __read_mostly;
 module_param(sleep_no_lps0, bool, 0644);
 MODULE_PARM_DESC(sleep_no_lps0, "Do not use the special LPS0 device interface");
@@ -649,6 +674,7 @@ void __init acpi_s2idle_setup(void)
 {
 	acpi_scan_add_handler(&lps0_handler);
 	s2idle_set_ops(&acpi_s2idle_ops_lps0);
+	acpi_setup_ixx_gpes();
 }
 
 int acpi_register_lps0_dev(struct acpi_s2idle_dev_ops *arg)
-- 
2.34.1

