Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685E03CB571
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 12:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788525612; cv=none; b=kotxB3CZ9RpM3ZVMGkAjT+kaqJL3Xeb3GNg5HE8Jl10wLpagBUAVn0TyB9/cU0fKPwq0YOO0JgzTm43XXC5ilcAC1quRzF3lqL67HiH8zMXbx6XXoWJL4DDllPxdoTBE3VDmBPAnuX1KeLe7CTadDziavgraggvlpj9oC6J/fJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788525612; c=relaxed/simple;
	bh=uciYnRl0uPEr9p8I1LpuzJ9pEw6dFHOvU/IUnVUXIBk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PgqHasD9n3oXQoLniaKab3ZT4swFeZ0gKvAk9I4uLvX7VDzPEpIClFFwp4/pS+8cGRJGnm3e1t7/gU3pjI7lIVMVQgRdStAUgBkRefkFY4WKv+3KKjBsEmMGXpz3pJHwyxEmjHeQwYOQdW8miZUVAQyP8emHO/eLdyML8freWpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVclztb1; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVclztb1"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6b1b9c3af5cso779887eaf.2
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 05:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788525610; x=1789130410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MnWviPGJcuOpwc58xe8Mm1wrm70qy+paoU9rlvZTyTE=;
        b=YVclztb1c5sOzrhOaBIrLUA+ZfaX4foHimrnc+XUzr86F6iHGeB0DTo5+Jp/0rtbSH
         GlhJGSX3x0hb3lScoEOkmH7rYcxjItGv+EIKOxledGJnr8Dz7k+2OZQbvGBVrKXSWfqb
         umS2PGCEZfQf/YFh43W0pCw3Jypok59CNxURXsYGGGhPqH0TvQe4cyexuHjP8uWEu6YO
         pX5YRBFuTDeXjN10dSNX+MpZCH6prNmD86ubRGdcL0Kpf7OgwtVoDB56VqpNvCQgd/x5
         X/K5hNAA9MjePqVC9ZqKjdK9IgjLdCswO++8ZRGFVkAxuNGFsnvew4XuF+kkX2aLIHks
         WNBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788525610; x=1789130410;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MnWviPGJcuOpwc58xe8Mm1wrm70qy+paoU9rlvZTyTE=;
        b=pBB6eiVBsS5EvqjeyiO+4AIjnvLU6++VKcRc9y242GSJhtaoa3N+zOMtzyHHpsbl/k
         ii2Jfr/GfAaQ/VSu4qZg9vL5GybYtdgpbHEJw6j+lR0MtucfIqcBfOefXGF2cy0W7z1G
         Dv912iJ3XqVznKw2ucp/9YcmTDjAQKAzsTy6q2yKuhaeRzTZIpituqh4PHjJhuudIOF4
         OUyZzJjVWm8zuYYQkDzJjxJmvgFu8ik+aRiaGEVFxx7D8dpAdLP4Ce3kuO7b6rgw1xhU
         2yt65aBYDaa39RQ7Mrv+EfEEfiol/Q2G/fqIV3ltuyFuYoZre1VL1DOWX+hSjzEoa8RT
         dC1Q==
X-Forwarded-Encrypted: i=1; AKwUvBzHySGV9D7mWssNHNfrVRDhEuRHeS3Xqk4dcJhvOe+1uZE5cVFnagMGJBw3rtpzhg6V0tIT26aCAw==@vger.kernel.org
X-Gm-Message-State: AFuF++nyc66UEHx6R36fW9Ej0ArMmOjp8CytLwBIQ0D2Ik9K7nuO9Nv/
	Ipm7ZqzuFi96EQ6XjMIVNCOxP46gQqyy762iqluDzBgIFfIXuVUDBUTv
X-Gm-Gg: AYBFou1r7pBKJJK2JKg0iZlm5Le1LoLpOYqn7IX4fmIqRrM/wn4CXQOvCMAyV/4OTfH
	R1onPBW1wYQJbSEosF2jEHQrPNoC2J+s4a8/30TBjEEpcw24ElYyYghiWTSnl4Joz/03w2e6oyi
	T+YLZoN3xaWmDJt7OzF/jvINYR7bgFn38oDHmVUM0Qz+GYoFx/enHxlrBiXNiJR1IA2/+qYC4Ey
	8JDfEWOSgmOeS0sEDcMTmuE2+PFSD23Aw7VMktYwDq6Nl1Qlt8pwzNnAm2G+nck3xCCNopwkzat
	cnNY34iedxi1i9vFWhF+EmYP2xYaRrejpKSYLlXMtg4fS5cwB1Znrv2FJK6Ij2mgMTRFf2kk59I
	KSpaKTuyL+dpSrtVq+Q2V3uYIKo5G6HA8BmcVHDT42QT1841abbDkY7c00wVPInYJvQGbHxEQxq
	WKatKQ03qVR6JrS84z/cXCcT3cQzzaz/HjgjSiHmBDu08TeoWJV0HgxUEeZixpWGzVMLjyJlgVc
	eoz/l1aFr2YujQ=
X-Received: by 2002:a05:6820:c97:b0:6b3:5475:4861 with SMTP id 006d021491bc7-6b6fcbdf251mr3392454eaf.18.1788525610251;
        Fri, 04 Sep 2026 05:40:10 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1432438497csm6667107c88.8.2026.09.04.05.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 05:40:09 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH] cpupower: fix typos in comments
Date: Fri,  4 Sep 2026 18:10:03 +0530
Message-ID: <20260904124005.3270-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in comments, reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c | 4 ++--
 tools/power/cpupower/utils/idle_monitor/mperf_monitor.c    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
index e8b3841d5c0f..b15371e3e6bd 100644
--- a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
+++ b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
@@ -72,7 +72,7 @@ void print_n_spaces(int n)
 }
 
 /*s is filled with left and right spaces
- *to make its length atleast n+1
+ *to make its length at least n+1
  */
 int fill_string_with_spaces(char *s, int n)
 {
@@ -263,7 +263,7 @@ static void parse_monitor_param(char *param)
 			 "try -l option\n"), param);
 		exit(EXIT_FAILURE);
 	}
-	/* Override detected/registerd monitors array with requested one */
+	/* Override detected/registered monitors array with requested one */
 	memcpy(monitors, tmp_mons,
 		sizeof(struct cpuidle_monitor *) * MONITORS_MAX);
 	avail_monitors = hits;
diff --git a/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c b/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
index 5ae02c3d5b64..62b8cfb02040 100644
--- a/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
+++ b/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
@@ -276,7 +276,7 @@ static int init_maxfreq_mode(void)
 	    cpupower_cpu_info.vendor == X86_VENDOR_HYGON) {
 		/* MSR_AMD_HWCR tells us whether TSC runs at P0/mperf
 		 * freq.
-		 * A test whether hwcr is accessable/available would be:
+		 * A test whether hwcr is accessible/available would be:
 		 * (cpupower_cpu_info.family > 0x10 ||
 		 *   cpupower_cpu_info.family == 0x10 &&
 		 *   cpupower_cpu_info.model >= 0x2))
-- 
2.48.1

