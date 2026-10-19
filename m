Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792428723;
	b=R/tAwovb6qbEEkmLptlP8wY1+fs6LyUa9oICIFQ6PO9byKvBX8veZOZy0gA94ZoHhapi
	 wFvVmi4d3fNk70edn0/Wx4ejZwF6WeJ/kdrkjcSp9h2Af+Iu9/mLukmA73awveg/dfaiA
	 +TEW124BGhZUCEUIubKMOJIHDuJ32CxBP1C3cRqmXPGTgEkeLu4e5yVmlLKDOUnZiBspo
	 30QuZ4mCtiyWIlcROoE39O4quWr0V8MkKHwcV32UaDJ/cUVSWehXCvS+FlGJDcMqq7OeJ
	 coy3++FrUyow/C7Cjw8oRFAzR8/vkF7QFlsqZNVjjZusoi/e50p7TNeElTLvfJDcf7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792428723;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Reply-To:Organization:
	 Content-Transfer-Encoding;
	bh=2RIs+avDh53ZrTzpFW2TS+0tJ+VVuXvuxh4I/PWEIaQ=;
	b=gul7JBfgCcQrEXMZK68GfIa3SbqAax2mvalBwfFRBNyzD1MSVFBjJnx1e8NBJHoiBj9T
	 dR7t4sAUWhzZcvaw0Xay8v6fBvFV88IIjayUUjO6uC6KQoHckMyoQY0OxHqDSoEW4auXd
	 T56OQehBFk5ZqiPXIaxSJp9JNsHntJzR3Ks6OnoP3pMHywRuTZsSaYI0x2GQIfdB/vpEn
	 1hOq4VeuZiK/QlKW1uFWSTEH5oEgxEGzYph2QGlLNu1MUoOlVPHD/hQLQxSfE4Dt/WkHl
	 RMWjTAp7DQXs/uCpFAS0+sDi40NL65vztLCrBoJ4WXw+31cu80EHnG0ja9kRo6AS2KA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UanqtxiH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D9A606A31D
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 16:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UanqtxiH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C0DE1F000CF;
	Mon, 19 Oct 2026 16:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792428723;
	bh=2RIs+avDh53ZrTzpFW2TS+0tJ+VVuXvuxh4I/PWEIaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=UanqtxiHG1mwKN5cwSsdZcV5RkIsdF/5xy/FrjlEfSqDuFyTChTdgyNezfSjdFwcc
	 Ckmwcxy7OqeWDZerqSxNfMzzqWmS5uxx5vystZNOnHR5zp5AYV7ilySygVzR3AT2Hm
	 TFeu7FkHOouapv6fIh8b1D9lLU1usqoD8M5qHaVHCM2Klpb6mSw5e8hpsOyfsAr3zt
	 YRfkHbT+1ZvPlSI+PkSNHWdutd23g1ZaHx/bcNyDDnAjs05Wo6U7s8gycxV1jCymJH
	 4QwM8anbb6EJWTJbOmee5hh7wNbfuLlQGapdtN78KrSIumb372QwOhIXRvjP96xBAR
	 uIhLeRKr6MxsA==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 02/18] x86_energy_perf_policy: Enhance MSR probe
Date: Mon, 19 Oct 2026 12:43:23 -0400
Message-ID: <8a047427531a00a7ceeaa389657c2d7bd1e2dbf4.1792428130.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <e160a0ae497702e1c32ab163faa63c0043ea9298.1792428130.git.len.brown@intel.com>
References: <e160a0ae497702e1c32ab163faa63c0043ea9298.1792428130.git.len.brown@intel.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Len Brown <len.brown@intel.com>

If Linux MSR driver isn't running,
modprobe and try the Linux path again.
If still no joy, try Android path.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 .../x86_energy_perf_policy.c                  | 40 ++++++++++++-------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index a963c0430794..abd3cf2fdd39 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -15,6 +15,7 @@
 #include <sys/types.h>
 #include <sched.h>
 #include <sys/stat.h>
+#include <sys/wait.h>
 #include <sys/resource.h>
 #include <getopt.h>
 #include <err.h>
@@ -1611,30 +1612,41 @@ void set_base_cpu(void)
 		err(-ENODEV, "No valid cpus found");
 }
 
-static void probe_android_msr_path(void)
+/* return 0 if path exists */
+static int check_msr_path(void)
 {
 	struct stat sb;
 
-	set_msr_path(base_cpu);	/* called with use_android_path = 0, to probe Linux path */
-	if (stat(msr_path, &sb))
-		use_android_msr_path = 1;
+	return stat(msr_path, &sb);
 }
 
+/*
+ * Check Linux MSR path
+ * If it fails, try modprobe and check it again
+ * If still no joy, enable Android path and try again
+ */
 void probe_dev_msr(void)
 {
-	struct stat sb;
+	int retval;
+
+	use_android_msr_path = 0;
+	set_msr_path(base_cpu);
+	if (check_msr_path() == 0)
+		return;
 
-	probe_android_msr_path();
+	retval = system("/sbin/modprobe msr > /dev/null 2>&1");
 
+	if (check_msr_path() == 0)
+		return;
+
+	use_android_msr_path = 1;
 	set_msr_path(base_cpu);
-	if (stat(msr_path, &sb)) {
-		if (system("/sbin/modprobe msr > /dev/null 2>&1")) {
-			if (use_android_msr_path)
-				err(-5, "no /dev/msr0, Try \"# modprobe msr\" ");
-			else
-				err(-5, "no /dev/cpu/0/msr, Try \"# modprobe msr\" ");
-		}
-	}
+	if (check_msr_path() == 0)
+		return;
+
+	if (WIFEXITED(retval))
+		retval = WEXITSTATUS(retval);
+	err(-1, "\"msr\" driver support required, modprobe msr returned %d", retval);
 }
 
 static void get_cpuid_or_exit(unsigned int leaf, unsigned int *eax, unsigned int *ebx, unsigned int *ecx, unsigned int *edx)
-- 
2.45.2

