Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E567C449997;
	Thu,  9 Jul 2026 22:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783635236; cv=none; b=Yel900C90lLpKyjeHloTKn+UhnXzTRtgiAH7JQ2jR+tLxEoYgJeDd2obdYGPA7UYbqv/l2GaO9zYFSgaiUPB+9Gr4JksxSlniSK0KQr2eI+NQrQTn3OWfNazv7SBoZo0El66ncGjdDJuh4Xj5rAN2usk90offi3GV5sTDXCM9II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783635236; c=relaxed/simple;
	bh=iL/HW5R8VC4E9H6N9UAhTc6qJyy2H5W+21lD1Hj7vDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EObhJXegHc7mKM8HyMHCh0GgsmmmNd5qG/3UlyuWXqygAQgnNtZzERcA6/otnaNH7XiHXCJ3PHizmOOfyp4zHISEgeEB5lwaeGJvTc+KcGzOFszt1t2BsSBRrwBf3ifnf1M2k8Zp/JyE7kbp9PERcmeMzBXB5naKErnJLXOWemU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fyhHxWLe; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fyhHxWLe"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38BEB24C0;
	Thu,  9 Jul 2026 15:13:49 -0700 (PDT)
Received: from u200865.usa.arm.com (U203867.austin.arm.com [10.118.30.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B4C63F66F;
	Thu,  9 Jul 2026 15:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783635233; bh=iL/HW5R8VC4E9H6N9UAhTc6qJyy2H5W+21lD1Hj7vDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fyhHxWLeeVR7WCv66flWW3cpjjTp8ZJjyjEP5g94iVn9z1feofEeNsW1CSiEmrdUn
	 wyGwZNOzXY/Sg1pAouzuZDgcHDYFYo1482AukUqflU7YHhsw/1bFeVBNBWYe7/8BiZ
	 yIJO+vfNxaukTlD94sFN304OqxRUUXd/eaOgbeUk=
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
Subject: [PATCH 3/3] cpupower: Print kernel and hardware frequency information
Date: Thu,  9 Jul 2026 17:13:44 -0500
Message-ID: <20260709221344.1919794-4-jeremy.linton@arm.com>
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

The kernel asserted frequency from scaling_cur_freq may not always match
the hardware reported frequency from cpuinfo_cur_freq.

Print both values when they are available, and only print the unavailable
message on x86 when the hardware frequency can't be read.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 tools/power/cpupower/utils/cpufreq-info.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/power/cpupower/utils/cpufreq-info.c b/tools/power/cpupower/utils/cpufreq-info.c
index 105f06e690cc..11629ae49f98 100644
--- a/tools/power/cpupower/utils/cpufreq-info.c
+++ b/tools/power/cpupower/utils/cpufreq-info.c
@@ -270,10 +270,10 @@ static int get_freq_hardware(unsigned int cpu, unsigned int human)
 {
 	unsigned long freq;
 
-	if (!(cpupower_cpu_info.caps & CPUPOWER_CAP_APERF))
+	freq = cpufreq_get_freq_hardware(cpu);
+	if (!(cpupower_cpu_info.caps & CPUPOWER_CAP_APERF) && !freq)
 		return -EINVAL;
 
-	freq = cpufreq_get_freq_hardware(cpu);
 	printf(_("  current CPU frequency: "));
 	if (!freq) {
 		printf("Unable to call hardware\n");
@@ -514,8 +514,8 @@ static void debug_output_one(unsigned int cpu)
 
 	get_available_governors(cpu);
 	get_policy(cpu);
-	if (get_freq_hardware(cpu, 1) < 0)
-		get_freq_kernel(cpu, 1);
+	get_freq_hardware(cpu, 1);
+	get_freq_kernel(cpu, 1);
 	get_boost_mode(cpu);
 	get_perf_cap(cpu);
 }
-- 
2.54.0

