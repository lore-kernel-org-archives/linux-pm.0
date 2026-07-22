Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA07C353A76;
	Wed, 22 Jul 2026 21:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784757186; cv=none; b=c6ujCL6f5g7vHKav/8yZfVqR0fDNPxchVsKW4IfjhIe036YuTDYAFBn3RK0iWPKzGE8WpKj2wjpPDlDKFw+3QW0fb+YCkc/Lg9JNtDMv42LghqgojYiKwvtVIW3lOGumPab0fH6VNvyqksRMyp8J5uMsoDpG0m53oDfXJFBBP08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784757186; c=relaxed/simple;
	bh=orIRR2RUZyTC3XKAWPnc26m+AUhSAr89IqHGBXQ8bNA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=kUu6VRWNZLnVeIYh5ThlywTwOgdRZonXwAnnvxTcEeRAPE8u0/D+9aBx88pz4aexjbP8VmnZJgnhYeH1mpl1lKRXLX6bd51ZYpVjJmqQqWcFQnVcG0iDLDVoRww7NpWfUpNEb7eUWsd2tpL+AjjUw9yMVmISahTWX29YCux+K2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lJjFYGmb; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lJjFYGmb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784757184; x=1816293184;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=orIRR2RUZyTC3XKAWPnc26m+AUhSAr89IqHGBXQ8bNA=;
  b=lJjFYGmbpxCnRSszfds4u5zkxLekAhiyXe9NVeIcbNjxJYaD5k4TK3An
   DN0YgI71CmXarADhoPdYJgIeYo/uXSXAWCoHsWoCx9VUUoU96pTmt/I09
   cuC0C9WnCb/+uN/2spCaz6j24z2FW3FSONptSLIy1+ZrJpY4uJd633a5H
   Fd9gMM/oallabw88HYGTZ/2VHtHgPKr9Mmseor4IKo3xfzpIXpUwkDnMr
   ZBl2lXK/mo5GkRjHtWy73q6Cj+mV+XOFFij4dz1uIzquOE23qXTMR0uqz
   D0h5Ops9w8x3lMm17jclyOIW73dh+2JhEHuS2ufrpkctq+Y4qhV1FxLIB
   g==;
X-CSE-ConnectionGUID: dI0uyjc+RjyISDp4/CX6ZA==
X-CSE-MsgGUID: lWR9AsKJTbiPZ8JsQJkRPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="96063766"
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="96063766"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 14:53:03 -0700
X-CSE-ConnectionGUID: roWMGY0pTiSmcBj5HQG15g==
X-CSE-MsgGUID: yCMvhx7HQvSX8c8DWCCwmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="258904094"
Received: from schen9-mobl4.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.125.110.96])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 14:53:03 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2] platform/x86/intel/pmc: Update NVLS PCDS LPM request GUID
Date: Wed, 22 Jul 2026 14:52:57 -0700
Message-ID: <20260722215259.1382305-1-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PMC SSRAM PMT telemetry GUID for Nova Lake S (NVLS) PCDS die
changed due to a firmware version bump. The GUID is used by the PMC
core driver to locate the correct PMT telemetry entry in SSRAM; if it
doesn't match the firmware-reported value, the driver fails to find the
LPM (Low Power Mode) data and cannot load properly.

Update PCDS_LPM_REQ_GUID from 0x01091102 to 0x01091103 to match the
new firmware version.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/nvl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/pmc/nvl.c b/drivers/platform/x86/intel/pmc/nvl.c
index 8dabf2511dd9d..1ed02332dbfce 100644
--- a/drivers/platform/x86/intel/pmc/nvl.c
+++ b/drivers/platform/x86/intel/pmc/nvl.c
@@ -14,7 +14,7 @@
 /* PMC SSRAM PMT Telemetry GUIDS */
 #define PCDH_LPM_REQ_GUID 0x01093101
 #define PCHS_LPM_REQ_GUID 0x01092101
-#define PCDS_LPM_REQ_GUID 0x01091102
+#define PCDS_LPM_REQ_GUID 0x01091103
 
 /*
  * Die Mapping to Product.
-- 
2.43.0

