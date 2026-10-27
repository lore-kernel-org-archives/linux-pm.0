Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793128559;
	b=2JduzeSnPXXiKh5f2B3lCLmcN5dyrSop8PjsrZGs4cg5mrIFiNaNo91HWxQRYJk1Bm/A
	 IIQnbie+kJi1Og1HCXVXhemuC/sbQA9HA08oOrVEWCTAy9BzjIBg9lIM4FoitiHz9R0ko
	 MabigFORosg5tVtDTip647DUbxJ6mVKxT6LBZbGdESF56Hef3vlIMZQyGV4fDmhi8SxWS
	 mJTWDQBs3rsGv35aSlPL0YlwUPQJc9SowMOrHtvgbzJVySWlH04CTCfRUUM7qa6CeNf+K
	 Sd53pKsapDlyO8cCfa6XUTmXv0QLWSgUv9ba9Kh/nfr1I7tiaE+qnEv9qRlrBTtSP8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793128559;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Reply-To:Organization:
	 Content-Transfer-Encoding;
	bh=CT2dclR715FMT4BSvWqh6xbTqLmw2ZVo2s8GXFdAR+s=;
	b=JDJMh3BQO1XLISneXuaWQzNKKJTWhe+ljUo2w81OGSHENXYaC5teTpwEjH/+VUezRcNp
	 NpNb092+XtOEasnqkESI7LUf/bRvQCmj9mOZs4515iM4Xn9bmsrXfpE8v0a/R3FJ5Mj4w
	 O3Q3tKvMDEE2JsDas4i05YtKuxVDFpxI9wympEYjyeBwULep5guUAMTHgRXZCX6tTD4ps
	 i/EEgpw3eiH2wq5q+KZVVKol2WjyQEXjF6I1qlroDUGbURTZZNGg92DLxNx4Rx+flnwB7
	 YGl6fAbRZQlU55Ux2042ON/z8KQZvq10ZeVBUFO+nb/7vSCiaZnhP0Q7ctqoc4vLLhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kYQqN6K0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8366D606A31A
	for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 19:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kYQqN6K0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 278501F031E1;
	Tue, 27 Oct 2026 19:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793128559;
	bh=CT2dclR715FMT4BSvWqh6xbTqLmw2ZVo2s8GXFdAR+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=kYQqN6K0RItYrS6Jvonzn8V2Mg5HEfijYoLVvZLaJb1IKPeOluEl9fGM/OJ133W2g
	 OE2snNznFvZwlKQQnci7Hv028aXSzGFz1c79C8302wzbkNdd8Gnwj6IRhqKN7alq+u
	 lWMweWxyFg16G0qQqLnpwOVA+Kg2LaxTl5bSLdP6qv+VlqSrYA1JsRH5LFEiJbW9iT
	 9LK+Bck0O5vpij0xvllPcN8WC9jbX9LIlPrwOzl/VZ5ZZ/mAyTA8xOKVDMzMCJgeZ/
	 02mgyS5jRSHMMdd2gl31Us/OZZmhpHwbEkP9lKtflIKBYrm8iHueoLFlbA/5FOvUbg
	 I5jO2WgeEbJgA==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 03/16] x86_energy_perf_policy: Harden with strtol()
Date: Tue, 27 Oct 2026 15:01:56 -0400
Message-ID: <9ba78b0197903c2191a047068ba13bd90ab13a73.1793124601.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <481006fbcb22ba1f134283c017aa3ae8a67e0d59.1793124601.git.len.brown@intel.com>
References: <481006fbcb22ba1f134283c017aa3ae8a67e0d59.1793124601.git.len.brown@intel.com>
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

Add explicit check that value is in valid range [0, 1].

Update associated error message strings.

parse_optarg_string() now returns long, as returned from strtol().

Assisted-by: GitHub-Copilot:Claude-Sonnet-4.6
Signed-off-by: Len Brown <len.brown@intel.com>
---
 .../x86_energy_perf_policy.c                  | 71 ++++++++++---------
 1 file changed, 39 insertions(+), 32 deletions(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index da89b267f357..d53427a059f3 100644
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
@@ -332,9 +332,9 @@ int parse_cmdline_turbo(int i)
 	return i;
 }
 
-int parse_optarg_string(char *s)
+long parse_optarg_string(char *s)
 {
-	int i;
+	long i;
 	char *endptr;
 
 	if (!strncmp(s, "default", 7))
@@ -355,19 +355,13 @@ int parse_optarg_string(char *s)
 	if (!strncmp(s, "performance", 11))
 		return OPTARG_PERFORMANCE;
 
+	errno = 0;
 	i = strtol(s, &endptr, 0);
-	if (s == endptr) {
-		fprintf(stderr, "no digits in \"%s\"\n", s);
+	if (endptr == s || errno == ERANGE || i < 0 || i > 255) {
+		warnx("bad value \"%s\"", s);
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
 
@@ -424,9 +418,10 @@ void parse_cmdline_cpu(char *s)
 			int end_cpu;
 
 			startp++;
+			errno = 0;
 			end_cpu = strtol(startp, &endp, 10);
-			if (startp == endp)
-				continue;
+			if (startp == endp || errno == ERANGE)
+				errx(1, "Confused by end_cpu '%s'", startp);
 
 			while (cpu <= end_cpu) {
 				if (cpu > max_cpu_num)
@@ -469,11 +464,11 @@ void parse_cmdline_cpu(char *s)
 				break;
 		}
 
+		errno = 0;
 		cpu = strtol(startp, &endp, 10);
-		if (startp == endp)
+		if (startp == endp || errno == ERANGE || cpu < 0 || cpu > max_cpu_num)
 			errx(1, "--cpu cpu-set: confused by '%s'", startp);
-		if (cpu > max_cpu_num)
-			errx(1, "Requested cpu%d exceeds max cpu%d", cpu, max_cpu_num);
+
 		CPU_SET_S(cpu, cpu_setsize, cpu_selected_set);
 		startp = endp;
 	}
@@ -504,9 +499,10 @@ void parse_cmdline_pkg(char *s)
 			int end_pkg;
 
 			startp++;
+			errno = 0;
 			end_pkg = strtol(startp, &endp, 10);
-			if (startp == endp)
-				continue;
+			if (startp == endp || errno == ERANGE)
+				errx(1, "Confused by end_pkg '%s'", startp);
 
 			while (pkg <= end_pkg) {
 				if (pkg > max_pkg_num)
@@ -523,9 +519,11 @@ void parse_cmdline_pkg(char *s)
 			return;
 		}
 
+		errno = 0;
 		pkg = strtol(startp, &endp, 10);
-		if (pkg > max_pkg_num)
-			errx(1, "Requested pkg%d Exceeds max pkg%d", pkg, max_pkg_num);
+		if (startp == endp || errno == ERANGE || pkg < 0 || pkg > max_pkg_num)
+			errx(1, "Confused by pkg '%s'", startp);
+
 		pkg_selected_set |= 1 << pkg;
 		startp = endp;
 	}
@@ -546,6 +544,7 @@ static int parse_cmdline_int(const char *s, int *out)
 	char *endp;
 	long val;
 
+	errno = 0;
 	val = strtol(s, &endp, 0);
 	if (endp == s || errno == ERANGE)
 		return -1;
@@ -714,13 +713,19 @@ void cmdline(int argc, char **argv)
 		case 't':
 			turbo_update_value = parse_cmdline_turbo(parse_optarg_string(optarg));
 			break;
-		case 'u':
-			update_hwp_use_pkg++;
-			if (atoi(optarg) == 0)
-				req_update.hwp_use_pkg = 0;
-			else
-				req_update.hwp_use_pkg = 1;
-			break;
+		case 'u': {
+				char *endp;
+				long val;
+
+				update_hwp_use_pkg++;
+
+				errno = 0;
+				val = strtol(optarg, &endp, 10);
+				if (endp == optarg || errno == ERANGE || val < 0 || val > 1)
+					errx(1, "--hwp-use-pkg: must be 0 or 1");
+				req_update.hwp_use_pkg = val;
+				break;
+			}
 		case 'v':
 			print_version();
 			exit(0);
@@ -1016,8 +1021,9 @@ static int get_epb_sysfs(int cpu)
 	if (!read_sysfs(path, linebuf, 3))
 		return -1;
 
+	errno = 0;
 	val = strtol(linebuf, &endp, 0);
-	if (endp == linebuf || errno == ERANGE)
+	if (endp == linebuf || errno == ERANGE || val < 0 || val > 15)
 		return -1;
 
 	return (int)val;
@@ -1040,8 +1046,9 @@ static int set_epb_sysfs(int cpu, int val)
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

