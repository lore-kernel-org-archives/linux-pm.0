Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8291285406
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 19:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771355282; cv=none; b=VSm3ZAI6/Cd9z/9/hW0PlYXCvpODVjMlEEWF/lrdcmUcJCVV4/hkgS/Z9KiEalPqiR5nK9eFmch7hIqWSQMxQt6hcjGnYAglzADGXMYRQxvSc0t/zGOuGo+tuwme1Di/tqk0MYutU1oCIpyBx7BlSw3QG8NaSKpbgglpmzVQrEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771355282; c=relaxed/simple;
	bh=caajyuqFVXTX+YAX3IbT9XD6IVu8yIfrSezMEAteeSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kx/CNEcown1qnEBD6eOUqcV9tZK3ad1FKobpA9yua3pLe1PURQQQZOn5h3nvM0QBB9YRpDfQJbvZrFehksUX3QhbCSaNSFr+sBgEX7MzwhVLGser393ijIQXn9nHeFopPlgZ5mWkSMGIP+cP1CCQCmTbElwAI25eGuQuWhfDeSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ThLcF0IV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThLcF0IV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86BC0C19421;
	Tue, 17 Feb 2026 19:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771355282;
	bh=caajyuqFVXTX+YAX3IbT9XD6IVu8yIfrSezMEAteeSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=ThLcF0IVIsRt32nqw2/TI6ThfJG85uYk//nB8j/+jGOxd8puo+URFQOMXd0eIUwBb
	 h6U7KxRAfA7jtyZgoBsl6jKc8jNR/t+js450otDRZSjo3yeFRUfDRB3j4iXXyXNadO
	 28Z3ow4pV6DE5HcaROChLWKQne9WyVPhqH7b2oSJRbx/6Z/UJ72xClTexOoFBBQRqK
	 oQt9V+eTunaGl2OtOrrHN75PZAxhxhAG5PO6TJRIDep+9WW+nwXgptL5yqZwVJyqJV
	 lQf2lIKTIchP6698Z8pT5YTBXs0nHpuJFc8+iOc/ZYaDWhEZlM8CkpamCQV95ZSFWV
	 XRbMngUU8+hNA==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 09/23] tools/power turbostat: Remove redundant newlines from err(3) strings
Date: Tue, 17 Feb 2026 13:04:00 -0600
Message-ID: <a9c7a1a292794e15fefe20a664898d57f685ced7.1771354332.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <16cc8f249c702b7cbb4c2c2be7cd8f4fdd5d1d0c.1771354332.git.len.brown@intel.com>
References: <16cc8f249c702b7cbb4c2c2be7cd8f4fdd5d1d0c.1771354332.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Len Brown <len.brown@intel.com>

err(3) supplies a newline at the end of the string.
No need to end err(3) strings with '\n'.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 75c865120656..c622b55c330c 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3150,7 +3150,7 @@ void get_perf_llc_stats(int cpu, struct llc_stats *llc)
 	actual_read_size = read(fd_llc_percpu[cpu], &r, expected_read_size);
 
 	if (actual_read_size == -1)
-		err(-1, "%s(cpu%d,) %d,,%ld\n", __func__, cpu, fd_llc_percpu[cpu], expected_read_size);
+		err(-1, "%s(cpu%d,) %d,,%ld", __func__, cpu, fd_llc_percpu[cpu], expected_read_size);
 
 	llc->references = r.llc.references;
 	llc->misses = r.llc.misses;
@@ -6134,7 +6134,7 @@ static int update_effective_str(bool startup)
 
 	pos = fgets(buf, 1024, fp);
 	if (!pos)
-		err(1, "%s: file read failed\n", PATH_EFFECTIVE_CPUS);
+		err(1, "%s: file read failed", PATH_EFFECTIVE_CPUS);
 
 	fclose(fp);
 
@@ -6151,7 +6151,7 @@ static void update_effective_set(bool startup)
 	update_effective_str(startup);
 
 	if (parse_cpu_str(cpu_effective_str, cpu_effective_set, cpu_effective_setsize))
-		err(1, "%s: cpu str malformat %s\n", PATH_EFFECTIVE_CPUS, cpu_effective_str);
+		err(1, "%s: cpu str malformat %s", PATH_EFFECTIVE_CPUS, cpu_effective_str);
 }
 
 void linux_perf_init(void);
@@ -6818,7 +6818,7 @@ int check_for_cap_sys_rawio(void)
 
 free_and_exit:
 	if (cap_free(caps) == -1)
-		err(-6, "cap_free\n");
+		err(-6, "cap_free");
 
 	return ret;
 }
@@ -7021,7 +7021,7 @@ static void probe_intel_uncore_frequency_cluster(void)
 		sprintf(path_base, "/sys/devices/system/cpu/intel_uncore_frequency/uncore%02d", i);
 
 		if (access(path_base, R_OK))
-			err(1, "%s: %s\n", __func__, path_base);
+			err(1, "%s: %s", __func__, path_base);
 
 		sprintf(path, "%s/package_id", path_base);
 		package_id = read_sysfs_int(path);
-- 
2.45.2

