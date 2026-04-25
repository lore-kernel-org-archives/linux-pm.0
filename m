Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3036037FF74;
	Sat, 25 Apr 2026 18:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777142877; cv=none; b=gjPVrtjPkA40L++wOCEGPKbOA0cnS0e9p7dyLLcu+vPPvN5gv4PltdZvRGZcawJlA4E22gCCQQl1AGv5AeO0BcJ2uw4uzysTuWbbGNfDUR7dtpr3zDwoMUCzJ487OtJRW29BA6qeW8NmQ1WnajjOSoQKvqozk+Gj8WiYXZ0fP9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777142877; c=relaxed/simple;
	bh=L8bYEUIlL4l0eMUxpPQOM1UNRsDPUzrltdJguKZsFrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F5XpDKh1iomlDkB4lzwLI+3PqCJZRrLUG0DpxBxMggD9fhH+abc0P5cUGPpHPX/GAqN8zLW5IjpnCEh1V6faRkQSPv8AolcHt+DJgdM4r4UOMMpZeARPSVQgpQX9go42sYdqggNcFFosMCs5mMuNB4yRgwsRLNJyw9ET6JKWqco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pWL5DT4P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pWL5DT4P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEFCBC2BCB3;
	Sat, 25 Apr 2026 18:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777142877;
	bh=L8bYEUIlL4l0eMUxpPQOM1UNRsDPUzrltdJguKZsFrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=pWL5DT4Pey1LmV3OTigCRL6HoMRMrwVfqaOd+rWz3CxpMNVq37NPUTN0T7X+GGPM5
	 a+AkBf4dR4rpmo/DEuTHNM/qT0h5/IiL1Sw05Piyrn0fvzXSlK7824V3DsGg/9e3Nr
	 veMVdk3ri05E+63PdXvM1acj1C3ATsS8F/4LacJkJBtqIcFHXtZMyMg/IW0EsiR/Di
	 VMBP/gI2K+qOuKK45M14QSweJ63lfpi7AjP0MON7chkg8iVV8Axzf8XQr4BQu3fH3S
	 GhlWwbve9Lv8vWb650fI8Nud7e2AlXn5uhqqhkr9csadIFT2aLwa0m3uj6tGRrXlRu
	 W1M0KqfF7Vnvg==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 09/13] tools/power turbostat: Process HT siblings in CPU order
Date: Sat, 25 Apr 2026 14:42:12 -0400
Message-ID: <58839fdbd441dc079800f2575013f2c438159d5a.1777141988.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <feffac1874820d501e51cd8dcee697063b792c82.1777141988.git.len.brown@intel.com>
References: <feffac1874820d501e51cd8dcee697063b792c82.1777141988.git.len.brown@intel.com>
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

On large systems with HT sibling cpu#'s more than 32 apart,
HT siblings were processed and displayed in reverse order.

This was due to how set_thread_siblings() parsed the
sibling-bit-mask.

Update set_thread_siblings to instead parse the sibling-list,
like other cpu lists, and to thus order HT siblings
by ascending CPU number, no matter the size of the system.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 80 +++++++++++----------------
 1 file changed, 31 insertions(+), 49 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index f8e9aa8c9e54..d46878c63a80 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -6219,55 +6219,6 @@ static int parse_cpu_str(char *cpu_str, cpu_set_t *cpu_set, int cpu_set_size)
 	return 0;
 }
 
-int set_thread_siblings(struct cpu_topology *thiscpu)
-{
-	char path[80], character;
-	FILE *filep;
-	unsigned long map;
-	int so, shift, sib_core;
-	int cpu = thiscpu->cpu_id;
-	int offset = topo.max_cpu_num + 1;
-	size_t size;
-	int ht_id = 0;
-
-	thiscpu->put_ids = CPU_ALLOC((topo.max_cpu_num + 1));
-	if (thiscpu->ht_id < 0)
-		thiscpu->ht_id = 0;	/* first CPU in core */
-	if (!thiscpu->put_ids)
-		return -1;
-
-	size = CPU_ALLOC_SIZE((topo.max_cpu_num + 1));
-	CPU_ZERO_S(size, thiscpu->put_ids);
-
-	sprintf(path, "/sys/devices/system/cpu/cpu%d/topology/thread_siblings", cpu);
-	filep = fopen(path, "r");
-
-	if (!filep) {
-		warnx("%s: open failed", path);
-		return -1;
-	}
-	do {
-		offset -= BITMASK_SIZE;
-		if (fscanf(filep, "%lx%c", &map, &character) != 2)
-			err(1, "%s: failed to parse file", path);
-		for (shift = 0; shift < BITMASK_SIZE; shift++) {
-			if ((map >> shift) & 0x1) {
-				so = shift + offset;
-				sib_core = get_core_id(so);
-				if (sib_core == thiscpu->core_id) {
-					CPU_SET_S(so, size, thiscpu->put_ids);
-					cpus[so].ht_id = ht_id;
-					cpus[cpu].ht_sibling_cpu_id[ht_id] = so;
-					ht_id += 1;
-				}
-			}
-		}
-	} while (character == ',');
-	fclose(filep);
-
-	return CPU_COUNT_S(size, thiscpu->put_ids);
-}
-
 /*
  * run func(thread, core, package) in topology order
  * skip non-present cpus
@@ -9539,6 +9490,37 @@ int dir_filter(const struct dirent *dirp)
 		return 0;
 }
 
+int set_thread_siblings(struct cpu_topology *thiscpu)
+{
+	char path[80];
+	int cpu = thiscpu->cpu_id;
+	size_t size;
+	int ht_id = 0;
+	int i;
+
+	thiscpu->put_ids = CPU_ALLOC((topo.max_cpu_num + 1));
+	if (thiscpu->ht_id < 0)
+		thiscpu->ht_id = 0;	/* first CPU in core */
+	if (!thiscpu->put_ids)
+		return -1;
+
+	size = CPU_ALLOC_SIZE((topo.max_cpu_num + 1));
+	CPU_ZERO_S(size, thiscpu->put_ids);
+
+	sprintf(path, "/sys/devices/system/cpu/cpu%d/topology", cpu);
+
+	initialize_cpu_set_from_sysfs(thiscpu->put_ids, path, "thread_siblings_list");
+
+	for (i = 0; i <= topo.max_cpu_num; ++i)
+		if (CPU_ISSET_S(i, size, thiscpu->put_ids)) {
+			cpus[i].ht_id = ht_id;
+			cpus[cpu].ht_sibling_cpu_id[ht_id] = i;
+			ht_id += 1;
+		}
+
+	return (ht_id - 1);
+}
+
 void topology_probe(bool startup)
 {
 	int i;
-- 
2.45.2

