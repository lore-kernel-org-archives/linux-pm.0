Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719743C277E
	for <linux-pm@vger.kernel.org>; Thu,  2 Apr 2026 16:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775146753; cv=none; b=hhG5zaM1Df4UM4H/QRP8d7Eb7lq2sp3RILTsw0tC8V826rhdpYGIcgNYyh2E312GE1x/IpzqqSP5R5cy6jFtcyDOqFKTHQiABBtFS5RCeL6N0W0Jg8e8dN5j+nVk9mj3ytUDyoCUxYptQgReNAv/FfPEj3wHzo4iKY2lXEgwFXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775146753; c=relaxed/simple;
	bh=pl6+IK4tU+7sxQdhLdqilfLwftIKLaNjkHq7/1O/Baw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Gm6oO+Yjrwjb01qn9zwAbtv1dwkyzzMEoWE28b8kMJ22repPcB6EPu0CMWs/WlyxT6YyYfl7IRLzXb0+PMXRg92aG7w3TMHJvlsiu9B969Ixesxxck4B3Px7Zb3BV9tui9c+Ues7pRMi5I2d+hcMPJakO/p1a2ggBzumsxLQ4s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J1f3FR50; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J1f3FR50"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775146751; x=1806682751;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pl6+IK4tU+7sxQdhLdqilfLwftIKLaNjkHq7/1O/Baw=;
  b=J1f3FR50vAzZk1kY6JQ8jzJ7tzMSH6P8bWDPGAcewWM5SZxEH2F7ebrF
   ClsTXtGAHuP6CxOmf/ciqUodyaM0gk6Q6Jd3jthCrUMi9CaS5qMJx+0Ol
   bCkOd13ivilEIGBiLaN6+nNKxmcxYgFWgrLVJ7H7W0xbic3aqvjylzMM6
   SKWxOTo/p+gL3RXF8CNfA7shnOllzcLEwgfOqDILSqnKjbhSnhHzsEbZv
   NjMVMKe9hga8O183iPs9hMDtiQVFQxTiaWojQ0tKSL0d79gWcdXno2nl/
   1gT+V7aCV2z1D3RG8rHFLpkG0Nb6OxtCVSJcKNuMhQqAUUCXHe7Quue8C
   w==;
X-CSE-ConnectionGUID: z2OfFVRUTBO5U9expgWZ9A==
X-CSE-MsgGUID: hl+oVfBPSrmMR3WS1V1h5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="76327967"
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="76327967"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 09:19:10 -0700
X-CSE-ConnectionGUID: w+9jf3xUTqCKh4qL3I8BoQ==
X-CSE-MsgGUID: JgibKTOlQJy+Ha/3YuU7Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="226190352"
Received: from baandr0id001.iind.intel.com ([10.49.109.195])
  by orviesa010.jf.intel.com with ESMTP; 02 Apr 2026 09:19:09 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: shuah@kernel.org,
	jwyatt@redhat.com,
	jkacur@redhat.com
Cc: linux-pm@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH v2] cpupower: remove extern declarations in cmd functions
Date: Thu,  2 Apr 2026 21:45:32 +0530
Message-Id: <20260402161532.3301452-1-kaushlendra.kumar@intel.com>
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
v2: Extended the fix to all cmd functions across cpupower utils

 tools/power/cpupower/utils/cpufreq-info.c  | 2 --
 tools/power/cpupower/utils/cpufreq-set.c   | 2 --
 tools/power/cpupower/utils/cpuidle-info.c  | 2 --
 tools/power/cpupower/utils/cpuidle-set.c   | 2 --
 tools/power/cpupower/utils/cpupower-info.c | 2 --
 tools/power/cpupower/utils/cpupower-set.c  | 2 --
 6 files changed, 12 deletions(-)

diff --git a/tools/power/cpupower/utils/cpufreq-info.c b/tools/power/cpupower/utils/cpufreq-info.c
index 5fe01e516817..5a242b491a9d 100644
--- a/tools/power/cpupower/utils/cpufreq-info.c
+++ b/tools/power/cpupower/utils/cpufreq-info.c
@@ -542,8 +542,6 @@ static struct option info_opts[] = {
 
 int cmd_freq_info(int argc, char **argv)
 {
-	extern char *optarg;
-	extern int optind, opterr, optopt;
 	int ret = 0, cont = 1;
 	unsigned int cpu = 0;
 	unsigned int human = 0;
diff --git a/tools/power/cpupower/utils/cpufreq-set.c b/tools/power/cpupower/utils/cpufreq-set.c
index c5e60a39cfa6..06cd4b280132 100644
--- a/tools/power/cpupower/utils/cpufreq-set.c
+++ b/tools/power/cpupower/utils/cpufreq-set.c
@@ -195,8 +195,6 @@ static int do_one_cpu(unsigned int cpu, struct cpufreq_policy *new_pol,
 
 int cmd_freq_set(int argc, char **argv)
 {
-	extern char *optarg;
-	extern int optind, opterr, optopt;
 	int ret = 0, cont = 1;
 	int double_parm = 0, related = 0, policychange = 0;
 	unsigned long freq = 0;
diff --git a/tools/power/cpupower/utils/cpuidle-info.c b/tools/power/cpupower/utils/cpuidle-info.c
index 81b4763a97d6..ccb37125bd37 100644
--- a/tools/power/cpupower/utils/cpuidle-info.c
+++ b/tools/power/cpupower/utils/cpuidle-info.c
@@ -139,8 +139,6 @@ static inline void cpuidle_exit(int fail)
 
 int cmd_idle_info(int argc, char **argv)
 {
-	extern char *optarg;
-	extern int optind, opterr, optopt;
 	int ret = 0, cont = 1, output_param = 0, verbose = 1;
 	unsigned int cpu = 0;
 
diff --git a/tools/power/cpupower/utils/cpuidle-set.c b/tools/power/cpupower/utils/cpuidle-set.c
index a551d1d4ac51..703094f1343c 100644
--- a/tools/power/cpupower/utils/cpuidle-set.c
+++ b/tools/power/cpupower/utils/cpuidle-set.c
@@ -24,8 +24,6 @@ static struct option info_opts[] = {
 
 int cmd_idle_set(int argc, char **argv)
 {
-	extern char *optarg;
-	extern int optind, opterr, optopt;
 	int ret = 0, cont = 1, param = 0, disabled;
 	unsigned long long latency = 0, state_latency;
 	unsigned int cpu = 0, idlestate = 0, idlestates = 0;
diff --git a/tools/power/cpupower/utils/cpupower-info.c b/tools/power/cpupower/utils/cpupower-info.c
index 18fd7751f509..79154d71e498 100644
--- a/tools/power/cpupower/utils/cpupower-info.c
+++ b/tools/power/cpupower/utils/cpupower-info.c
@@ -28,8 +28,6 @@ static void print_wrong_arg_exit(void)
 
 int cmd_info(int argc, char **argv)
 {
-	extern char *optarg;
-	extern int optind, opterr, optopt;
 	unsigned int cpu;
 	struct utsname uts;
 
diff --git a/tools/power/cpupower/utils/cpupower-set.c b/tools/power/cpupower/utils/cpupower-set.c
index 550a942e72ce..c2176b9fa57d 100644
--- a/tools/power/cpupower/utils/cpupower-set.c
+++ b/tools/power/cpupower/utils/cpupower-set.c
@@ -33,8 +33,6 @@ static void print_wrong_arg_exit(void)
 
 int cmd_set(int argc, char **argv)
 {
-	extern char *optarg;
-	extern int optind, opterr, optopt;
 	unsigned int cpu;
 	struct utsname uts;
 
-- 
2.34.1

