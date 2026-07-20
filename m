Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3146143846C;
	Mon, 20 Jul 2026 23:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784589151; cv=none; b=D0w5wlm4NfBVabeATzzfb4+oUWToSzJmDyFjlqQfu/shIup9k/EHh9LksR3u5mz+7uBFqB2wJh/v2BJookgGYckH5zFUnBrlIvBNkIwBa8DpllfShVsKRgsyMhYvsBd4uhOgafhfAbjFgjecl7Sh1TuwUSubaVYQbufWuErzIlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784589151; c=relaxed/simple;
	bh=HyP43Mkp3GpAnBOOEvncuUhBvaLcGvJeTHAlEqL95Y8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=qzM8spMPw1oJyj7VyYyDnNbQrtxTmQKaCddb/AXEgd+OVLWgt5ZqLgVirKc3feS4jv913j0nhqkhu46GmCz++PE1oToCyUauAjUWqR4FQHDcvN0CFpzbL0J/4laIOAvOreuzgrHoKToFlWyi/oFeBi44TiWhjYsCzg2vb/Zx8z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m9zV74+W; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m9zV74+W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784589148; x=1816125148;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HyP43Mkp3GpAnBOOEvncuUhBvaLcGvJeTHAlEqL95Y8=;
  b=m9zV74+WDyqF+8S+D9UYDICJ1BF80XQCEeU2QJWGTfHGx0/gUEmSGuD8
   GI5UlPxsGWv/R0K5pmgHFZbXJn9iEh9YCA+4edpS2j8bX66EAQCEuvfrK
   dVqU893roHezqP4coItjTQ+B7nzzKVKKk/ZQSXq1yqK0cfR+hWNjatxat
   NWf9Y4o283/GnP3eNtggB0N7qmR49TVA1fHSUMIgutZ2YVYj9ahuubesY
   azU+9nIHmdwo8M+uwhBcHb141xSJi5Un9NTJ+WHPVv+jWQ5nrUaGNUOF4
   Q+MTy5m31qgKohrcSpPGx8MoguTKd4/a6L9ZqPpElCXRULibowAYbkrQl
   w==;
X-CSE-ConnectionGUID: FjiR5rC4TRe4KCJKPqwpBg==
X-CSE-MsgGUID: SeFNVP2tQQibvYsVu6n1pQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="95776088"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="95776088"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 16:12:27 -0700
X-CSE-ConnectionGUID: gAu4egYwR52oeqmV6e4FYA==
X-CSE-MsgGUID: Q6DfXGwARASboENC3aliNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="280861458"
Received: from vverma7-desk1.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.125.109.207])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 16:12:27 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH] platform/x86/intel/pmc: Update NVLS PCDS LPM request GUID
Date: Mon, 20 Jul 2026 16:12:10 -0700
Message-ID: <20260720231219.1278923-1-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that NVL support is available, update the PCDS_LPM_REQ_GUID for
Nova Lake S (NVLS) from 0x01091102 to 0x01091103. The PMC core driver
requires the correct GUID to load successfully.

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

