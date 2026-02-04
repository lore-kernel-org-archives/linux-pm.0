Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEE78460
	for <linux-pm@vger.kernel.org>; Wed,  4 Feb 2026 05:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770182691; cv=none; b=M8Z2pskrh7RjNnPehMzGGiTg8hyODxgfJPF7JsZ1M/kRgGJQYxXv+ucDgADPmRucNTMD835ZdFSggci91fpRbnFazV5av92UVw0pqNRxUlpdiUR1GGTtOg83k7qgPzniJqdUUbqoYcjFfTpgmSQdTpX121NiEQLxPHVsbG+F/b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770182691; c=relaxed/simple;
	bh=wrVTu7/bl5objoMO0+XHfgbS1G/RjKQ3FLKm4ioAdr0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iR9jQwdK3kEKlOOxkx3b7r+c4JB49LT2oGaeEfLfmccvK7nggsW627E3L/88UfiFI8pDLJRID0fX+066l5H4bzlBUcGfrieVBxgaTfEWECC9rvXg4hxvyC6IFSmIjCvXORIwvEOVDgUJy8Dv3Dv4+qAQs4ni12xa/RTIruWOOAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ERBINUF2; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ERBINUF2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770182690; x=1801718690;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wrVTu7/bl5objoMO0+XHfgbS1G/RjKQ3FLKm4ioAdr0=;
  b=ERBINUF2diw1GERm02lGx2LpzV4Iw2VTDEFk/lJV1IHtrXvJilwb2+lN
   uSCq0jsMJP7Apf1wqgziT13ZBSOT/yCN+MGtpSOL59RlNHWOSUBzxoMM6
   XRH6/zy+uXVNyQ53T1q+FnIMer5VszvXsf7vFgZdpyHB3heOvq/xkcitf
   VX2Qxfhhmxhwmb2d2FyA3LRXjSYCoqFkAHVm0n8yFoHO2OtzwbGx9zZXB
   vuYBjMXpQoa9gLWvSxg6LDwUgnqK64lCtMKxoo9UYKg8iFDkPX/dIZ+9R
   +e/6luEEQKfh8SyV+Qi+dmD00qHdZjcl1SQDPT6iOmBIfOcE5W54VkEzI
   A==;
X-CSE-ConnectionGUID: /1pWlIRuSWCUXsxcOdlzSw==
X-CSE-MsgGUID: h27DmOZJQL6NsZD0PEbS8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="82795497"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="82795497"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 21:24:50 -0800
X-CSE-ConnectionGUID: rruQnTpfTDiXcq+D2axExA==
X-CSE-MsgGUID: P1+oKCDjQ2CVTkoheVGN8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="214543228"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by fmviesa005.fm.intel.com with ESMTP; 03 Feb 2026 21:24:48 -0800
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: shuah@kernel.org,
	trenn@suse.com,
	jwyatt@redhat.com,
	jkacur@redhat.com
Cc: linux-pm@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH 1/3] cpupower: fix swapped power/energy unit labels
Date: Wed,  4 Feb 2026 10:51:40 +0530
Message-Id: <20260204052143.3281063-2-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260204052143.3281063-1-kaushlendra.kumar@intel.com>
References: <20260204052143.3281063-1-kaushlendra.kumar@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix error where microWatts and microJoules units were interchanged.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 tools/power/cpupower/utils/powercap-info.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/power/cpupower/utils/powercap-info.c b/tools/power/cpupower/utils/powercap-info.c
index 3ea4486f1a0e..e53033488218 100644
--- a/tools/power/cpupower/utils/powercap-info.c
+++ b/tools/power/cpupower/utils/powercap-info.c
@@ -38,11 +38,11 @@ static int powercap_print_one_zone(struct powercap_zone *zone)
 	printf(" (%s)\n", mode ? "enabled" : "disabled");
 
 	if (zone->has_power_uw)
-		printf(_("%sPower can be monitored in micro Jules\n"),
+		printf(_("%sPower can be monitored in micro Watts\n"),
 		       pr_prefix);
 
 	if (zone->has_energy_uj)
-		printf(_("%sPower can be monitored in micro Watts\n"),
+		printf(_("%sPower can be monitored in micro Jules\n"),
 		       pr_prefix);
 
 	printf("\n");
-- 
2.34.1

