Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793128561;
	b=J5CxjWySzW6VsNm6SIWaHVoUCoVYOBwVzmFkJyuFwGmHZ2DxsuSHkjF6M6r9w27Fq33j
	 kV9QS+U4w2WsiuroXKWcyBCMp0xbLEhv5QoZBX63kNn/tN54VPqZ2W5ZYZAeV7yN7Yxby
	 33MpuFbpX3S1VPIm1y7EbZFtIi/iChpENJNXy61wC9zRlQocK81tfVHgDE1ffnu1jhfX9
	 xLXVn8yPAGIAc39kxvMvXf8S6JD0Xr5uz3ELa7Fn4yGdnOihMHKROxKz/e7b2krbmzLag
	 RQAv0kWgy1ZaFKjTDwurmVBoWYuvtkwsEIkOCG+KGWkjSBVLUnjGj8cfGl4EFqIQpkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793128561;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Reply-To:Organization:
	 Content-Transfer-Encoding;
	bh=Ij91kBdtCJZgKGlvowXwCjgFDmVE3B6v8eh51pIgDtw=;
	b=GsPbsm3H96WqAxwOTPAe8rjwt1BA3lUlGwMtOkVOuho6n6ovntVEeOrumS44KQlD9BZr
	 8KwmObm3+ObbwqEGBrgJlKdZmmiBSIWqB6jBQg4sRs928VYwgd9ZCPDn3xlMNjHWwR3pY
	 7jrGC/ImfM5Pfm4XimgXh0MVWpk9YdyNsYaQRP0e/9z3Naj7bNCCfIqO6Y9wNBs0U39Ix
	 f0cWDyynp1xO7m73ghOm5jHaDH+7jH2o/SQEr8t72xGv9qRF6LyI+utn1mpwTbT/555lM
	 St/7siFJ9RkpyugAaKMLyWoXLjvh3sy5MO9LNkZiEBaB0giNgDO/l0gXDmRB8/sMq3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="OCUuww/c";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF8F606A326
	for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 19:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OCUuww/c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D09F1F031E5;
	Tue, 27 Oct 2026 19:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793128560;
	bh=Ij91kBdtCJZgKGlvowXwCjgFDmVE3B6v8eh51pIgDtw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=OCUuww/cuOYleG2eAQf1JIz9J9aHT8Z1TNbgC/pmWYCD0Ggi/ghGBPXY8hnp99rUw
	 RShZ39kyMk5EY3RpiFMTUD499vOM5iMmUzDCeDXapXqhoZfFKKv2ZJTLOBBVYdczMT
	 9FUh0P0e/HThu6VRuy8qPXl0vBpjULqpF9ABap3wPmSwwUv2tpvBgzyk/vmYzU+rOh
	 E0OZZ65vgZ8MBDLIheMO3foHPu916gwYEw/be/bqixq7yJh1gRW9Xn9Pg5Suh1oImU
	 euAZLAjT5vfUdqNfWyj5aV3wuJtuN+UPyPeqZ5Z97Hfa3PhfkAAM2NS4K6q9rQacpw
	 rom872i97S14w==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 07/16] x86_energy_perf_policy: Bound package iteration
Date: Tue, 27 Oct 2026 15:01:57 -0400
Message-ID: <1dc9d80317077000fe7989d20e09e4c3bed3d97a.1793124601.git.len.brown@intel.com>
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

Add explicit bounds checking against MAX_PACKAGES in for_packages()
to prevent potential out-of-bounds bit shift operations.
Also, use consistent shift idiom: (1ULL << pkg_num)

Assisted-by: GitHub-Copilot:Claude-Sonnet-4.6
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 .../x86/x86_energy_perf_policy/x86_energy_perf_policy.c   | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index e79462f93f3a..2d77f465f1ee 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -509,7 +509,7 @@ void parse_cmdline_pkg(char *s)
 			while (pkg <= end_pkg) {
 				if (pkg > max_pkg_num)
 					errx(1, "Requested pkg%d exceeds max pkg%d", pkg, max_pkg_num);
-				pkg_selected_set |= 1 << pkg;
+				pkg_selected_set |= 1ULL << pkg;
 				pkg++;
 			}
 			startp = endp;
@@ -526,7 +526,7 @@ void parse_cmdline_pkg(char *s)
 		if (startp == endp || errno == ERANGE || pkg < 0 || pkg > max_pkg_num)
 			errx(1, "Confused by pkg '%s'", startp);
 
-		pkg_selected_set |= 1 << pkg;
+		pkg_selected_set |= 1ULL << pkg;
 		startp = endp;
 	}
 }
@@ -535,8 +535,8 @@ void for_packages(unsigned long long pkg_set, int (func) (int))
 {
 	int pkg_num;
 
-	for (pkg_num = 0; pkg_num <= max_pkg_num; ++pkg_num) {
-		if (pkg_set & (1UL << pkg_num))
+	for (pkg_num = 0; pkg_num <= max_pkg_num && pkg_num < MAX_PACKAGES; ++pkg_num) {
+		if (pkg_set & (1ULL << pkg_num))
 			func(pkg_num);
 	}
 }
-- 
2.45.2

