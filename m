Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522ED3AEF55;
	Wed, 19 Aug 2026 17:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787161291; cv=none; b=OznjNjfP/GmELjwx3xq6KfOaow/6aRyn4bLhlO0Ijm0+ky1woQE2ZOVLfAJeUCeFOU9flYWVuuFywZyYlSLcxXSoWPI6cfkeHM11kxJrp++PTXAeGHGJKZcALKQl1ivBQysJ9R98/um0/aT9ylYfX87dsFbUzf14tMdLi4tvwDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787161291; c=relaxed/simple;
	bh=rq2SnJfulz2JvaM+Axnm11gH/wER3q8IFVHzFUxF11Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FhKPwXSLNLOs98U9OPh0KMVK88NAM7sxHyxbfpkzUllot8l5KamYQ6DTU2ZpiRcQosnWKfn0naT+74HFxH/89+92Djva3F3XFBA32eNgKhe+oGCOKiFlb1SskARd8WBrDZyeUJzb499HNnsqAFwnyfe0FJQ5cBMeZ5cH3MKkUKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PO/WTnc/; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PO/WTnc/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787161291; x=1818697291;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rq2SnJfulz2JvaM+Axnm11gH/wER3q8IFVHzFUxF11Q=;
  b=PO/WTnc/nB5omXsa4rs8Ev+WwPwcC4aCotQbtOjzobg3t+7PQ0mXTf2t
   +wCSH7IhVet3Erkbjxvhqj641NfF9ckw+nScIsGlYJNN/4JCj3LOEbnfM
   2G4J6If6vS8tt96S21myUbKrauFGq8YCawxvGn/89sdilvltoWeLkE/MN
   jZgYNPqbHzmkB432cnGYyW3Pj9iEygzK87YcKzRuZ/as/cXzyBKHFDZWT
   1oldc1jlZqDpiz0N53DkeERC+TztBjQx7swuOJ72Vsc9Bb60wtCirKCyR
   2kZ5WrIEbhHP6DCFVyODkLi1OjGBgf70e0sRldQq7t17udtP7+eMROvDh
   g==;
X-CSE-ConnectionGUID: NBrmltB4TUKttkPYm+aWfA==
X-CSE-MsgGUID: 8lKQzotvREOvW0C+4PEZsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="99211953"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="99211953"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 10:41:30 -0700
X-CSE-ConnectionGUID: bxG3O+ouSSmFgOMU2DOWWA==
X-CSE-MsgGUID: zUwyxazAQeqAuSe7wgQIKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="266227877"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 10:41:29 -0700
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: Daniel Lezcano <daniel.lezcano@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Lukasz Luba <lukasz.luba@arm.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Zhang Rui <rui.zhang@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v1] thermal: intel: intel_tcc_cooling: Add rugged Panther Lake support
Date: Wed, 19 Aug 2026 10:41:22 -0700
Message-ID: <20260819174122.1184364-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Add TCC cooling support to rugged Panther Lake.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/intel/intel_tcc_cooling.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/intel/intel_tcc_cooling.c b/drivers/thermal/intel/intel_tcc_cooling.c
index 52ea4f7fc9f9..75f6fbec2530 100644
--- a/drivers/thermal/intel/intel_tcc_cooling.c
+++ b/drivers/thermal/intel/intel_tcc_cooling.c
@@ -69,6 +69,7 @@ static const struct x86_cpu_id tcc_ids[] __initconst = {
 	X86_MATCH_VFM(INTEL_ARROWLAKE_U, NULL),
 	X86_MATCH_VFM(INTEL_ARROWLAKE_H, NULL),
 	X86_MATCH_VFM(INTEL_PANTHERLAKE_L, NULL),
+	X86_MATCH_VFM(INTEL_PANTHERLAKE_R, NULL),
 	X86_MATCH_VFM(INTEL_WILDCATLAKE_L, NULL),
 	X86_MATCH_VFM(INTEL_NOVALAKE, NULL),
 	X86_MATCH_VFM(INTEL_NOVALAKE_L, NULL),
-- 
2.43.0

