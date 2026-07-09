Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7CD3DDAE2;
	Thu,  9 Jul 2026 22:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783635235; cv=none; b=j8cZTHF0nXA3adhTbofHpkncIuw1JsS0YMLnMVcbpYRGfethDQXssepZnR9JrGZZPE+elwSyVNZFwL76AniG9vKstUHjIcNr83CCTxs6F9q/JSs7cH00IF05b2OJGtXp4RCGeHhCA0328wyA/4Nu4/HW9jUihQ+iSlefb2UBWy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783635235; c=relaxed/simple;
	bh=/oPEzphlUo4U+yD0oDsf4VM19OsfUz2fs5VNHLjEXL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=riM+ufp/VhWNcD02+/iM9Sh0I6KPKxMn1y66WAP+KhdxUk6j+vO+KQ5GUnOHmuPZLCh341yHH2wtp3hE/0cmSahgiJ3YBviRVHMw00U1jSy7WsvSKSF0G0w6qYv3IviUAKfpOjuww2ShYnWmfuVKkuFq+rd20yCrkj9PqfdNF4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=t28v9Ped; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="t28v9Ped"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8EE0B1EA6;
	Thu,  9 Jul 2026 15:13:48 -0700 (PDT)
Received: from u200865.usa.arm.com (U203867.austin.arm.com [10.118.30.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFC353F66F;
	Thu,  9 Jul 2026 15:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783635232; bh=/oPEzphlUo4U+yD0oDsf4VM19OsfUz2fs5VNHLjEXL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t28v9PedyudEMiv7m1jTLKuazOdigDuhuhomd42fb/E2/pE4VopwwqfeVRa8yyW/h
	 2F5w6EgqgvqWF0DbkrBVwWf7RUfg1NSkUBsLfrZFcFh0PRlFc4HfaWgAxR6eXOKoFC
	 /VGOMmQryd41xz9Tl/dei5FhrIvdD6jZbo3sI4uU=
From: Jeremy Linton <jeremy.linton@arm.com>
To: linux-pm@vger.kernel.org
Cc: trenn@suse.com,
	shuah@kernel.org,
	jwyatt@redhat.com,
	jkacur@redhat.com,
	kaushlendra.kumar@intel.com,
	sashal@kernel.org,
	fj5851bi@fujitsu.com,
	rui.zhang@intel.com,
	linux-kernel@vger.kernel.org,
	Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH 2/3] cpupower: Build and call CPPC information on non-AMD processors
Date: Thu,  9 Jul 2026 17:13:43 -0500
Message-ID: <20260709221344.1919794-3-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709221344.1919794-1-jeremy.linton@arm.com>
References: <20260709221344.1919794-1-jeremy.linton@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we have a generic CPPC printout, call it on !AMD
processors. If it fails to detect CPPC, or the registers don't look
reasonable then it will exit without printing anything.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 tools/power/cpupower/Makefile                | 2 +-
 tools/power/cpupower/utils/cpufreq-info.c    | 3 ++-
 tools/power/cpupower/utils/helpers/helpers.h | 2 ++
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index 969716dfe8de..cd8b7315fe74 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -131,7 +131,7 @@ override CFLAGS += -DVERSION=\"$(VERSION)\" -DPACKAGE=\"$(PACKAGE)\" \
 
 UTIL_OBJS =  utils/helpers/amd.o utils/helpers/msr.o \
 	utils/helpers/sysfs.o utils/helpers/misc.o utils/helpers/cpuid.o \
-	utils/helpers/pci.o utils/helpers/bitmask.o \
+	utils/helpers/pci.o utils/helpers/bitmask.o utils/helpers/cppc.o \
 	utils/idle_monitor/nhm_idle.o utils/idle_monitor/snb_idle.o \
 	utils/idle_monitor/hsw_ext_idle.o \
 	utils/idle_monitor/amd_fam14h_idle.o utils/idle_monitor/cpuidle_sysfs.o \
diff --git a/tools/power/cpupower/utils/cpufreq-info.c b/tools/power/cpupower/utils/cpufreq-info.c
index 5a242b491a9d..105f06e690cc 100644
--- a/tools/power/cpupower/utils/cpufreq-info.c
+++ b/tools/power/cpupower/utils/cpufreq-info.c
@@ -477,12 +477,13 @@ static int get_latency(unsigned int cpu, unsigned int human)
 }
 
 /* --performance / -c */
-
 static int get_perf_cap(unsigned int cpu)
 {
 	if (cpupower_cpu_info.vendor == X86_VENDOR_AMD &&
 	    cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_PSTATE)
 		amd_pstate_show_perf_and_freq(cpu, no_rounding);
+	else
+		cppc_show_perf_and_freq(cpu, no_rounding);
 
 	return 0;
 }
diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
index a3ad80b9c2c2..9c5126b63966 100644
--- a/tools/power/cpupower/utils/helpers/helpers.h
+++ b/tools/power/cpupower/utils/helpers/helpers.h
@@ -221,4 +221,6 @@ void print_online_cpus(void);
 void print_offline_cpus(void);
 void print_speed(unsigned long speed, int no_rounding);
 
+void cppc_show_perf_and_freq(unsigned int cpu, int no_rounding);
+
 #endif /* __CPUPOWERUTILS_HELPERS__ */
-- 
2.54.0

