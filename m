Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8912138551D;
	Sat, 25 Apr 2026 18:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777142873; cv=none; b=dGvax1ui/ZXJw887zh7de7OoCk7WHEoNRyA6ak3uqYEz/gKDSxYNGrCM1Y+PwXP/h+y451hnvnOw9VF5FqV62C5Q0rToPVmaHjWpbkfGdz80AHxo/xPS9X6iXXys3jxCI1ABY9YnThGaDxynM231P20UcxC9zf56m2e3nvNx+BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777142873; c=relaxed/simple;
	bh=OLsw9FoU1Um9gFNlCXhOXsHDEwe1Oi4JtAEYZ6eS6Ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OzjfPzXQG67esQh+OcZCdGbdNRgdFW6xnzzGqCRvmCyeECe/FcQhbYqnJQs3LWpJ6S/WWVqNO8h4cMGaMKxf6JsshUuePb0t4113nDatSB/e4CBkPeLSB7B3XJOTJ1KT/tzOkt8bIwQ9po3hjGlbdr6E+CK3DsH/278GBAcX4wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t2aHeU5O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t2aHeU5O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E201FC2BCB3;
	Sat, 25 Apr 2026 18:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777142873;
	bh=OLsw9FoU1Um9gFNlCXhOXsHDEwe1Oi4JtAEYZ6eS6Ww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=t2aHeU5O1EvexASOOo8F+DcsHNySy7ui82GlR72q9o/F7zEur3PrpXBPnlkEUzWBs
	 ZgXfxAi+DL5qnV9tWpJda5dUafpT6C9o/b8+JSOJILDZT3RHD0V9NChvzlbIgeVpAi
	 7mrHFMqoHExl903XPrgnEH8RvQvdRdyS3o5TzXi9JxJF/KtKpLnnyUfVdIPoTleUsD
	 gBssgfk8Pmjjb+UU8vA7yJAH/XUPBsaOQXe/8Jw0cjNUwmgQ7tcEkvS83Ir/igv71F
	 amhh2wyJRyd7LyVUFXMg7n9EE5qmq7RWP/r5I9rJECfoKhXat1zDVct+TYvr7w2CfT
	 gqIyDoK+waCnQ==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 04/13] tools/power turbostat: Fix --cpu-set 0 regression on HT systems
Date: Sat, 25 Apr 2026 14:42:07 -0400
Message-ID: <2c52f942fcf21c8e09c7dac669fca591cec2692b.1777141988.git.len.brown@intel.com>
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

"turbostat --cpu-set 0" appears to hang if cpu0 has an HT sibling.

This is because the initialization code recognizes that it does not
have to open perf files for the HT sibling, but the HT support
in the collection code sees the HT sibling and tries to read
from an uninitialized file descriptor, 0 (standard input).

Access HT siblings only when they are in the allowed set.

Fixes: a2b4d0f8bf07 ("tools/power turbostat: Favor cpu# over core#")
Signed-off-by: Len Brown <len.brown@intel.com>
Reported-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index d6b4fd17c5f3..7f61f07ceb31 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2427,11 +2427,17 @@ char *sys_lpi_file_debugfs = "/sys/kernel/debug/pmc_core/slp_s0_residency_usec";
 
 int cpu_is_not_present(int cpu)
 {
+	if (cpu < 0)
+		return 1;
+
 	return !CPU_ISSET_S(cpu, cpu_present_setsize, cpu_present_set);
 }
 
 int cpu_is_not_allowed(int cpu)
 {
+	if (cpu < 0)
+		return 1;
+
 	return !CPU_ISSET_S(cpu, cpu_allowed_setsize, cpu_allowed_set);
 }
 
@@ -2473,9 +2479,12 @@ int for_all_cpus(int (func) (struct thread_data *, struct core_data *, struct pk
 		int i;
 
 		for (i = MAX_HT_ID; i > 0; --i) {	/* ht_id 0 is self */
-			if (cpus[cpu].ht_sibling_cpu_id[i] <= 0)
+			int sibling_cpu_id = cpus[cpu].ht_sibling_cpu_id[i];
+
+			if (cpu_is_not_allowed(sibling_cpu_id))
 				continue;
-			t = &thread_base[cpus[cpu].ht_sibling_cpu_id[i]];
+
+			t = &thread_base[sibling_cpu_id];
 
 			retval |= func(t, c, p);
 		}
@@ -6252,10 +6261,13 @@ int for_all_cpus_2(int (func) (struct thread_data *, struct core_data *,
 		int i;
 
 		for (i = MAX_HT_ID; i > 0; --i) {	/* ht_id 0 is self */
-			if (cpus[cpu].ht_sibling_cpu_id[i] <= 0)
+			int sibling_cpu_id = cpus[cpu].ht_sibling_cpu_id[i];
+
+			if (cpu_is_not_allowed(sibling_cpu_id))
 				continue;
-			t = &thread_base[cpus[cpu].ht_sibling_cpu_id[i]];
-			t2 = &thread_base2[cpus[cpu].ht_sibling_cpu_id[i]];
+
+			t = &thread_base[sibling_cpu_id];
+			t2 = &thread_base2[sibling_cpu_id];
 
 			retval |= func(t, c, p, t2, c2, p2);
 		}
-- 
2.45.2

