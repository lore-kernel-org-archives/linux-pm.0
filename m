Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF322222C5;
	Sat, 20 Jun 2026 07:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781941356; cv=none; b=neXlNNVHwq6q2LgBo9ffpVpMtNje91LgtzjUha17WLpmIhQuC5Z3wFzyLGxkRolk6QV5anuANEfv0+qMZy9LYLrzQRRGdDVRE2OyYy9LUV9RHl50E5tRbhQGu1g399yOR/fo4WtMIFyOBv0wdW6z/rjuSwAn/CR9cQOyXEDqn+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781941356; c=relaxed/simple;
	bh=j1tMQZ5XBp9ItKhGcQUkyEybojrfnSi0mK10ozGDiRk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XtxdxsGDqFNyWtXA7kjFJdMdu096LqPHUtS3Gmsm0b8jhvkdCN+3wVveJV2p3C518rBnSwSMStIQcNpGNE0eU3FTjTUq+gv1gf0qjq+uyGBoo33G8tpOtfRZxSHjEMI8+peKNnZC/FLn3ru2pSKg8bmXoV/J0cAyw0lgdG8/bQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J/1ntiuw; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J/1ntiuw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781941355; x=1813477355;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=j1tMQZ5XBp9ItKhGcQUkyEybojrfnSi0mK10ozGDiRk=;
  b=J/1ntiuwKEtomPXqSdGWlNdkQvhw5bgdQY8VxvATmSWZimEkSAb/Dgeb
   YOsOOZE12eYRDlvQXotEvx5dK+BAwRPSOFD6zheozKV7t5aD6hTdZZyn1
   k6jmOd4sXnMFsFAR3H8Kews3pPSSx5hZQi+qxB2sGq5gU1UzB5eiaiCOS
   HqZ4ZCpRGpsFmTHureBMATdobeSOKN2tvIZFlxL2hbN43ybhmEzhetvn+
   2hjP/+zcCwTWdwB2IRPCCn1HKEQCoQ1w35AvHBvstfjm6Y+hFEpIXC2v8
   0RZcj+h8vqbYsu3KUB4I0uCYlDDUK01vySqKdNm3hlDu7x/co7ppyNbH6
   A==;
X-CSE-ConnectionGUID: DLjayYotQgC88NXSenIZxQ==
X-CSE-MsgGUID: O/z7AMv8Tj+v6j04/lTWYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11822"; a="82762599"
X-IronPort-AV: E=Sophos;i="6.24,214,1774335600"; 
   d="scan'208";a="82762599"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2026 00:42:34 -0700
X-CSE-ConnectionGUID: Od4kQjvhS0GDJBPj4YePBA==
X-CSE-MsgGUID: 3WWpSmd/S0KILV2gRyshHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,214,1774335600"; 
   d="scan'208";a="246447276"
Received: from intel-proliant-dl380-gen9.iind.intel.com ([10.49.109.61])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2026 00:42:32 -0700
From: amarjeet@intel.com
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tools/thermal/thermometer: close fd on realloc failure
Date: Sat, 20 Jun 2026 13:11:57 +0530
Message-Id: <20260620074157.1059161-1-amarjeet@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amarjeet <amarjeet@intel.com>

thermometer_add_tz() opens tz_path and then reallocates thermometer->tz.
If realloc fails, the function returns without closing fd.

Close fd before returning on realloc failure to avoid leaking a file descriptor.

Signed-off-by: Amarjeet <amarjeet@intel.com>
---
 tools/thermal/thermometer/thermometer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/thermal/thermometer/thermometer.c b/tools/thermal/thermometer/thermometer.c
index 022865da8e3c..103db7a2a8e4 100644
--- a/tools/thermal/thermometer/thermometer.c
+++ b/tools/thermal/thermometer/thermometer.c
@@ -266,6 +266,7 @@ static int thermometer_add_tz(const char *path, const char *name, int polling,
 	fd = open(tz_path, O_RDONLY);
 	if (fd < 0) {
 		ERROR("Failed to open '%s': %m\n", tz_path);
+		close(fd);
 		return -1;
 	}
 
-- 
2.34.1

