Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7278D3ACA5C;
	Wed, 19 Aug 2026 17:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787161231; cv=none; b=Nulf4Qt2aGjdEGFL/4cM/jkEQI8aPb96FrDnVqGbBleDIrHn+vv3B52W5nGZnD4dVcnF/h6sCCYI8WbQFiXGWgbnXIzw1HWbW4sP0zfFhAhbqfDuIcgw7TkoysJcSbzkjPOomeyVmxZ2XS7J8wwoCOQBMB9OCjRpn4rAVqd5UG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787161231; c=relaxed/simple;
	bh=SMY1+gPNLk/N91g/HxRrWM7AqmEuJMIikMRgAyU6bUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qEKu4F3JrfXqyJ8JEVUfvDIsColt2jeWPImV3wUrPgwlg8CuQVZRczGOkdUxc53MRvRUYNpgy1FqPlf0CN2CRRvgbFDfWoFStKHEyG7sosxkfmFW457r5fnVVhqrkXqxvcXA+2mX8S7CgnlDvsuGFZzEf699h83swn0DuT5vESU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CmDZWfZx; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CmDZWfZx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787161230; x=1818697230;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SMY1+gPNLk/N91g/HxRrWM7AqmEuJMIikMRgAyU6bUw=;
  b=CmDZWfZxm3pd34KWD9QqGCedLQCyPx+YL7F02sd2lwQJ0yZtdxx6Nj3i
   5Fzxxl3rVB3TRasABB7hQRyA3Sl7pREbcNdOSlRVBZ8NhcJonTg2JCGaY
   iedUlWUNop5Cz1tD1UWvNnC3dwwN0vQU0V4KmMahdgX0BBftkd+7rorqP
   pn+H4tPDqKy/Lo0Kfh+bHDJkhq5E+6tKM1tR72ZyUc9zOCcJRn6J64190
   TVRd6T1IulH+7L2wrPo1akInREEj27u9XF+Vw0fhCdMcdLt8ALBYeGx4Z
   X/KA9SH+c7JtrE4eH/n8qXTXK9f3kUTZgEAxq+PnnvXWIgyzJ6ktjw9cQ
   A==;
X-CSE-ConnectionGUID: IBUm54nVRVemX4mlJITwkQ==
X-CSE-MsgGUID: tdL4yov9T06IM0akZXxB6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="87448205"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="87448205"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 10:40:29 -0700
X-CSE-ConnectionGUID: fE0u7w2CTV6TE5RHXGXW/Q==
X-CSE-MsgGUID: c89AFSXRTFyF/8BoCoFrZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="267570811"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 10:40:28 -0700
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v1] powercap: intel_rapl: Add rugged Panther Lake support
Date: Wed, 19 Aug 2026 10:40:20 -0700
Message-ID: <20260819174020.1184329-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Add RAPL support for rugged Panther Lake.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/powercap/intel_rapl_msr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index a34543e66446..2c1b799d3c54 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -456,6 +456,7 @@ static const struct x86_cpu_id rapl_ids[]  = {
 	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X,		&rapl_defaults_spr_server),
 	X86_MATCH_VFM(INTEL_LUNARLAKE_M,		&rapl_defaults_core),
 	X86_MATCH_VFM(INTEL_PANTHERLAKE_L,		&rapl_defaults_core_pl4_pmu),
+	X86_MATCH_VFM(INTEL_PANTHERLAKE_R,		&rapl_defaults_core_pl4_pmu),
 	X86_MATCH_VFM(INTEL_WILDCATLAKE_L,		&rapl_defaults_core_pl4_pmu),
 	X86_MATCH_VFM(INTEL_NOVALAKE,			&rapl_defaults_core_pl4),
 	X86_MATCH_VFM(INTEL_NOVALAKE_L,			&rapl_defaults_core_pl4),
-- 
2.43.0

