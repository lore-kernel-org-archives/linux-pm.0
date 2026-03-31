Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45BF2BD0B
	for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 05:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774933414; cv=none; b=XSfsCqcDtgFlvQ3qqvneUq3br7V9oQqHpRyBGHwoeDQWb1843Pjm+DhTGsvEi8ufxDVkKoO2M//SLshbgxwY5Y1fToRtkiOB8byHVnnwG1ce/PsmBc/yCwyql7GUlowCR7OOsm+q62nWzWC9LG253t+M8K96E5SRSgOUgyFDCH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774933414; c=relaxed/simple;
	bh=huNoTSLKkFPJCJtMRvOxe4lwMcPyo9ClYX8FP3rM7c8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bNLOD2ZMYoFJEsFnWHeA6xgH0vy1fUwzUmeBoUt36GjDsg7YnkYMbekbyDmwYdrY17BAZm0BWftG1X0cLTgXwWvPWeVnySYSpquWLX7AMarbBIb9sna4IRO2Mwm8wdJmB8hem/cjXR+YR2v88TAdcb/ShXoduLyaJHIhIZLmKn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O36uiFwG; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O36uiFwG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774933412; x=1806469412;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=huNoTSLKkFPJCJtMRvOxe4lwMcPyo9ClYX8FP3rM7c8=;
  b=O36uiFwG5vuGdlTW6B6thRWMI1OrF7/9bUm28TSLudsCKuIn/jBlM0VK
   BjV240vw/YKz4skeMvzDW1cGDVJmbBWNkId1pOTUzbr4J6STagGLP9nc0
   vJt5O8kx72x1MlPSwXsZeZH+aVvJYKr2Japs4oO41OBGFuCsJG0FaxECC
   kc9tguwSNoTZWG628zDwhPvMWFMiBQg/mXMazXsHSDbFkDLseNlZaxQYd
   DfLohjIOgT8Nngw37IsdArsJpBVEn9C1JHGE1uezkXI3NBuK2gc6bj4b9
   8oOkkxSKuxuVx/1PjGvXAR1ywRaLW6jFZTEMyt1PIVM8zyJ6ASFqnHPPU
   A==;
X-CSE-ConnectionGUID: epKknjzhTd2UyixVRetmBw==
X-CSE-MsgGUID: c+XEOW03T5C8FHZ6vQsZ2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="86628855"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="86628855"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 22:02:42 -0700
X-CSE-ConnectionGUID: Ss87S+/jSiqxlhN+n9fIzQ==
X-CSE-MsgGUID: 3tDG+6DBQVut1Z4sGgIJ4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="256756566"
Received: from baandr0id001.iind.intel.com ([10.49.109.195])
  by orviesa002.jf.intel.com with ESMTP; 30 Mar 2026 22:02:40 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: shuah@kernel.org,
	jwyatt@redhat.com,
	jkacur@redhat.com
Cc: linux-pm@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] cpupower: remove extern declarations in cmd_set()
Date: Tue, 31 Mar 2026 10:29:06 +0530
Message-Id: <20260331045906.1935188-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

extern char *optarg and extern int optind, opterr, optopt are
already declared by <getopt.h>, which is included at the top of
the file. Repeating extern declarations inside a function body
is misleading and unnecessary.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 tools/power/cpupower/utils/cpupower-set.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/power/cpupower/utils/cpupower-set.c b/tools/power/cpupower/utils/cpupower-set.c
index dcbdff5c9ae5..64d2d4b070b4 100644
--- a/tools/power/cpupower/utils/cpupower-set.c
+++ b/tools/power/cpupower/utils/cpupower-set.c
@@ -51,8 +51,6 @@ static int parse_int_range(const char *arg, int min, int max, int *out)
 
 int cmd_set(int argc, char **argv)
 {
-	extern char *optarg;
-	extern int optind, opterr, optopt;
 	unsigned int cpu;
 	struct utsname uts;
 
-- 
2.34.1

