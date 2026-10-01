Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF60E3502A8;
	Thu,  1 Oct 2026 17:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790875847; cv=none; b=O7VX2DZaw8XSxL4c0vberF9knZgRYjbtQCbhy8LT/ajmQqa2VVvEIWNQdJgXdaWDhVaYin/I2Mxui0so/Ennjw2Yru0WuBb9OZC93UJo3NiXU8+ult13VbcD0riqJvQPSgSiM/m2Jlf+HsCm+XToeN0jUM3+UjeREtAGDIDHsuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790875847; c=relaxed/simple;
	bh=toAioNIiQ6jtfev8hb2IJt5DS40U6qkmjYJw450NlmI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ffZx3QJtUtYfl0JYLUQ+GM3F5evjBoydRRQvBEpCud8201XCdC5KGBFRsrkrqtt2Se3ax9igcydJxuB3SWa+rH2Euj2R+ujX8aeK2sO/YNFD57X9vHdvlnRJDPU3q/ANI6gZ4ZcL1PEEZmzDXCViMCSx3kwAxELSua+sBgeLtlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dwg0IC0P; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dwg0IC0P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790875846; x=1822411846;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=toAioNIiQ6jtfev8hb2IJt5DS40U6qkmjYJw450NlmI=;
  b=Dwg0IC0PGu2jcI6cy0yzrSD+x/K6RtAHiOF4yWohpHyyvaDJ2DSaAXgd
   hRnA4nHzW2ZVUX8WQfAzkbUAba1HijgP7iSXGiXD8sro0NJdxUhrveulj
   aua9YKImQuQrwkGzDhQzfl5ETiYr8O39y/64yDjjxo0FACP9d3z11zi+G
   r1shbbX1KvLxyfxTkgN6Ri8gJDuKrsS4xBNNpKyn8YIHh+7CzUyl+AJit
   1pyoq9DAe9pMschn+btRoJiOX6mSu4IYvM34xxdrsCiScHK9f6HdpsfBR
   xQqbt9urg3Zq16p6XubTm6P+VFU1o+riOTvKheteb00GhSxfz7aleXiBI
   Q==;
X-CSE-ConnectionGUID: 97aVCkDlR4aW3c1oQN9CCw==
X-CSE-MsgGUID: E56oIGeKT2+Hyz1VCe17yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="102316918"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="102316918"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 10:30:45 -0700
X-CSE-ConnectionGUID: 2TPq4XInT+GVy/vJhukDiw==
X-CSE-MsgGUID: GcpQnMiMRY6h1TgGFzPpAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="302291121"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 10:30:45 -0700
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: Len Brown <lenb@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] tools/power turbostat: Add rugged Panther Lake support
Date: Thu,  1 Oct 2026 10:30:39 -0700
Message-ID: <20261001173039.934398-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add CPU model for rugged Panther Lake to the platform and perf model
tables. It uses the same cores as Panther Lake, so use the same settings.

Co-developed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
Changes since v1:
 * Add rugged Panther Lake to the perf model table (turbostat_perf_model_support[])
   as suggested by Len Brown.

v1: https://lore.kernel.org/all/20260819174154.1184393-1-sathyanarayanan.kuppuswamy@linux.intel.com/

 tools/power/x86/turbostat/turbostat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 920694c3c1ec..1a2b8cc469cd 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1229,6 +1229,7 @@ static const struct platform_data turbostat_pdata[] = {
 	{ INTEL_ARROWLAKE, &adl_features },
 	{ INTEL_LUNARLAKE_M, &lnl_features },
 	{ INTEL_PANTHERLAKE_L, &lnl_features },
+	{ INTEL_PANTHERLAKE_R, &lnl_features },
 	{ INTEL_NOVALAKE, &lnl_features },
 	{ INTEL_NOVALAKE_L, &lnl_features },
 	{ INTEL_WILDCATLAKE_L, &lnl_features },
@@ -1327,6 +1328,7 @@ static struct perf_model_support turbostat_perf_model_support[] = {
 	{ INTEL_ARROWLAKE, { PCE(0x00, 0xFF), PCE(0x00, 0x5F)}, { PCE(0x00, 0x07), PCE(0x00, 0x02)}, {} },
 
 	{ INTEL_PANTHERLAKE_L, { PCE(0x00, 0xFF), PCE(0x00, 0x5F)}, { PCE(0x01, 0xFF), PCE(0x01, 0xBF)}, {} },
+	{ INTEL_PANTHERLAKE_R, { PCE(0x00, 0xFF), PCE(0x00, 0x5F)}, { PCE(0x01, 0xFF), PCE(0x01, 0xBF)}, {} },
 	{ INTEL_WILDCATLAKE_L, { PCE(0x00, 0xFF), PCE(0x00, 0x5F)}, { PCE(0x01, 0xFF), PCE(0x01, 0xBF)}, {} },
 
 	{ INTEL_NOVALAKE, { PCE(0x00, 0xFF), PCE(0x00, 0x5F)}, { PCE(0x01, 0xFF), PCE(0x01, 0xBF)}, {} },

base-commit: 93f51579e7df248780214094418f205253383cc5
-- 
2.43.0

