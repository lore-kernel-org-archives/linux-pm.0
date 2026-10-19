Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792428726;
	b=qJojedsvuKMOzLaLr3vj9x3w89ZeoXRsbTOrFPiIRhtlEPlcVS4qER4BcnAZsWw1rEyH
	 TCNoROq3CmkJOQSeNGjY44D20I56/AAPDLVnhlOAjEszeIkyp3m7HM3q6sypbvOB7rlkX
	 y2hIf2oRie+PmNLLCWrX4o7dAq5t5/N0zPSTWpqrocLU882ZKmJQ25fRCNso/xd4zAO7a
	 8T/bPW/4VPxbVarWpwHA99DjjkwRM+xBi9yMI4fuS4MwI0PuRyXqqq8D95mZXeiyLDcB2
	 GT3rBV7x8iJkhEZ5EqPLoYYd3xSuaU8mR0SvoeI4Nf5bksoFIoiL/7cwE9HVgjyATZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792428726;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Reply-To:Organization:
	 Content-Transfer-Encoding;
	bh=KLaruZsC710KGpoKGkfTENngXHZMKrvFT9ZMQYX5DFE=;
	b=f/Vyu1AA0DqBM2EvVwRJ/6n0gGZxVNWbfCWdooBfboUb8xxEkPvi7LnJFlYZlJlVgvcb
	 FBV8nQ6dLUqLm0iwSD/U8/XzPAudbF9QtSehYq7rFeBhpCMPpp4IJKu4WO4gmFHhNLaow
	 ZtuxxT0meNYcUCNKsDY79eIFS6WCUC5kG01p0QOBNMkoZAvq5DGH2bwk2NW37YBr0QG2m
	 bvPszMjdaAXN6c2BCyJy+FpDZs3OM9+4w2jxeu5MbnQ9aNAIX+NHpI7S2cqgRv9A63+a/
	 IeSBgiblzsn1SvtQXCDPpvnYJLslq7+AwF3G5Dz2SApoVbyz/+C8Kmjytuqv/Wq6xTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="lmkmL/Wd";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75453606A319
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 16:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lmkmL/Wd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F2311F00AE3;
	Mon, 19 Oct 2026 16:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792428726;
	bh=KLaruZsC710KGpoKGkfTENngXHZMKrvFT9ZMQYX5DFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=lmkmL/Wd5nzTZEKGrrDQLSklhQ1GcErvvIncYC6CuU36AgX6eQiYmBgJfcVHddZI0
	 LptYPaiPIIrRrXhv8k7WXie77G2XzUoeXoqFhETrbIuwD72+jsbbF7h3oc1Ht+Wf+8
	 /l/k4My1O1MaK0zmQqOGKckJt1K4WM2Ex3fn0vLNL0h8bONF4a324HgiFgRJrxLS33
	 SYxxYifN2BeOWhVQZSohFpZszonq++S8iMm185wHPlEIV/BnHNF/KPlBKIRqJI9xML
	 Sg1ySjz8CYENcHy0PXDcwFob0CgbgEElaUdvINJaSFHkaP+Q4LZtERfC4mVQU1ndzL
	 cm+td8fot1CTg==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 04/18] x86_energy_perf_policy: Cleanup: Harden with strtol()
Date: Mon, 19 Oct 2026 12:43:25 -0400
Message-ID: <4a9e2fb9f00e2ead8dc9af9e285c19eb21b5f9a4.1792428130.git.len.brown@intel.com>
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

Replace atoi() with strtol() and proper error checking when parsing the
--hwp-use-pkg command-line argument value, and other spots.

Also add explicit check that value is in valid range [0, 1].

Assisted-by: GitHub-Copilot:Claude-Sonnet-4.6
Signed-off-by: Len Brown <len.brown@intel.com>
---
 .../x86_energy_perf_policy.c                  | 46 +++++++++++--------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index 3c4e376f6c77..98e5aa9aec51 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -191,7 +191,7 @@ int parse_cmdline_epb(int i)
 		return ENERGY_PERF_BIAS_PERFORMANCE;
 	}
 	if (i < 0 || i > ENERGY_PERF_BIAS_POWERSAVE)
-		errx(1, "--epb must be from 0 to 15");
+		errx(1, "--epb must be 0 through 15");
 	return i;
 }
 
@@ -305,8 +305,8 @@ int parse_cmdline_hwp_epp(int i)
 	case OPTARG_PERFORMANCE:
 		return HWP_EPP_PERFORMANCE;
 	}
-	if (i < 0 || i > 0xff) {
-		fprintf(stderr, "--hwp-epp must be from 0 to 0xff\n");
+	if (i < 0 || i > 255) {
+		fprintf(stderr, "--hwp-epp must be 0 through 255\n");
 		usage();
 	}
 	return i;
@@ -355,19 +355,13 @@ int parse_optarg_string(char *s)
 	if (!strncmp(s, "performance", 11))
 		return OPTARG_PERFORMANCE;
 
+	errno = 0;
 	i = strtol(s, &endptr, 0);
-	if (s == endptr) {
-		fprintf(stderr, "no digits in \"%s\"\n", s);
+	if (endptr == s || errno == ERANGE || i < 0 || i > 256) {
+		warnx("bad value \"%s\"\n", s);
 		usage();
 	}
-	if (i == LONG_MIN || i == LONG_MAX)
-		errx(-1, "%s", s);
 
-	if (i > 0xFF)
-		errx(-1, "%d (0x%x) must be < 256", i, i);
-
-	if (i < 0)
-		errx(-1, "%d (0x%x) must be >= 0", i, i);
 	return i;
 }
 
@@ -425,7 +419,7 @@ void parse_cmdline_cpu(char *s)
 
 			startp++;
 			end_cpu = strtol(startp, &endp, 10);
-			if (startp == endp)
+			if (endp == startp)
 				continue;
 
 			while (cpu <= end_cpu) {
@@ -469,11 +463,11 @@ void parse_cmdline_cpu(char *s)
 				break;
 		}
 
+		errno = 0;
 		cpu = strtol(startp, &endp, 10);
-		if (startp == endp)
+		if (endp == startp || errno == ERANGE || cpu < 0 || cpu > max_cpu_num)
 			errx(1, "--cpu cpu-set: confused by '%s'", startp);
-		if (cpu > max_cpu_num)
-			errx(1, "Requested cpu%d exceeds max cpu%d", cpu, max_cpu_num);
+
 		CPU_SET_S(cpu, cpu_setsize, cpu_selected_set);
 		startp = endp;
 	}
@@ -505,7 +499,7 @@ void parse_cmdline_pkg(char *s)
 
 			startp++;
 			end_pkg = strtol(startp, &endp, 10);
-			if (startp == endp)
+			if (endp == startp)
 				continue;
 
 			while (pkg <= end_pkg) {
@@ -526,6 +520,7 @@ void parse_cmdline_pkg(char *s)
 		pkg = strtol(startp, &endp, 10);
 		if (pkg > max_pkg_num)
 			errx(1, "Requested pkg%d Exceeds max pkg%d", pkg, max_pkg_num);
+
 		pkg_selected_set |= 1 << pkg;
 		startp = endp;
 	}
@@ -546,6 +541,7 @@ static int parse_cmdline_int(const char *s, int *out)
 	char *endp;
 	long val;
 
+	errno = 0;
 	val = strtol(s, &endp, 0);
 	if (endp == s || errno == ERANGE)
 		return -1;
@@ -716,7 +712,15 @@ void cmdline(int argc, char **argv)
 			break;
 		case 'u':
 			update_hwp_use_pkg++;
-			if (atoi(optarg) == 0)
+			char *endp;
+			long val;
+
+			errno = 0;
+			val = strtol(optarg, &endp, 10);
+			if (endp == optarg || errno == ERANGE || val < 0 || val > 1)
+				errx(1, "--hwp-use-pkg: must be 0 or 1");
+
+			if (val == 0)
 				req_update.hwp_use_pkg = 0;
 			else
 				req_update.hwp_use_pkg = 1;
@@ -1015,8 +1019,9 @@ static int get_epb_sysfs(int cpu)
 	if (!read_sysfs(path, linebuf, 3))
 		return -1;
 
+	errno = 0;
 	val = strtol(linebuf, &endp, 0);
-	if (endp == linebuf || errno == ERANGE)
+	if (endp == linebuf || errno == ERANGE || val < 0 || val > 15)
 		return -1;
 
 	return (int)val;
@@ -1039,8 +1044,9 @@ static int set_epb_sysfs(int cpu, int val)
 	if (ret <= 0)
 		return -1;
 
+	errno = 0;
 	val = strtol(linebuf, &endp, 0);
-	if (endp == linebuf || errno == ERANGE)
+	if (endp == linebuf || errno == ERANGE || val < 0 || val > 15)
 		return -1;
 
 	return (int)val;
-- 
2.45.2

