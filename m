Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792428732;
	b=xh1oGyxGkcSM2o1QfxKKlMNaTN0O8khYqHu0gABdmNn8Tkt7sUZSRxJXKTpy2W1RYCkN
	 gy6rxZ3o+xjoQTbR8j2qZAmV9y417Dt0dRJ0GQhCTZpikmlVhj+ktFi0ueHNbq2itFPCU
	 17dm7TJTMCGHZIM6CN59WyhLy6WUHmE38wwaeyPDTEma2AK0snwCKM2kQA8ykUNmc1Bh9
	 gEjFfrugqmNdZD0g+WAR91FPedVjtGX6sWTooHMhg2QHshC4fIGAZDY8n2VIwlPgkni2g
	 z8eXAHhBrD0mka6YO4k/vxc/Xt8+S7OEL37NdQxuVjZgjwmXOzUFk6C7UcFOI6iGTKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792428732;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Reply-To:Organization:
	 Content-Transfer-Encoding;
	bh=my2Rp5Z8o5YkGX9INQ6H15Qf7JukJ1AdlChlD+yOjY8=;
	b=Afmk1wYORlRD/q9rh/BZPbpiJsz1kNekYeUlNhP2f19rERgcEI8Cjb15s6Wz/Zbd7eug
	 ruD6cgbWDD5dA7WEIjmsbo2eKDtT3xG7ohEeCbLEIenwt0WGbo5gTPBD1Pek7D+JBYncJ
	 cahK+Ypj0ia9phDvBf7UQiz1KRJtgNfP6XY/frKr9zvK3OwgVHWXT1/pvcfKjiXD4HkeM
	 a8d53HyWEtjMNuDfa7QPYGeufAgAew6RMOKGyf/jKmOxXeR+D5vIqd9tZhF6p7kxPXNBK
	 yIkAadKp1r06t5U52iOO9RGVKT0i1+WxwqdPzbNWtENUF+FPJ2zYmhO7a+B5k76MICQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KmUNhuDH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF90606A31E
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 16:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KmUNhuDH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0651B1F000CC;
	Mon, 19 Oct 2026 16:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792428732;
	bh=my2Rp5Z8o5YkGX9INQ6H15Qf7JukJ1AdlChlD+yOjY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=KmUNhuDHQnULPWGtldynnIIOEf9Hsk4f/8mO/eb1dsl/TJ41u6diR4eYP3qJqF12V
	 CUvHa4vRBODeSZdG2V+c/+800wpDdRcO6gMDS6FOsuVFehMvM7Bqfx8PwDVfTSx38W
	 mYDUg09HxkL8PpM+X+EfiRnSwCmtT9meEpyUgLITXwAuqYIMPFU4yS0JKzfQPqLTmT
	 UQy5Cc0DAnCX6x5yv0mZF+E/Cw9a7aD27I00pj3TK2uAUh9fu3X2I8AG7/YkjTHh9a
	 7f82g0hmbaGIyxJx++fUDsrXFJbGrAyEzKSvkLGQNu8rRkBTU5z+4rAyZcinaSkRhD
	 DRpvkEQRypxug==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 08/18] x86_energy_perf_policy: Bound package iteration
Date: Mon, 19 Oct 2026 12:43:29 -0400
Message-ID: <a9747d6a5342266267b4a4ce424c03b286206cb3.1792428130.git.len.brown@intel.com>
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

Add explicit bounds checking against MAX_PACKAGES in for_packages()
to prevent potential out-of-bounds bit shift operations.

Assisted-by: GitHub-Copilot:Claude-Sonnet-4.6
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index 6b0079a0b36c..5c54cf9e0fcf 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -532,7 +532,7 @@ void for_packages(unsigned long long pkg_set, int (func) (int))
 {
 	int pkg_num;
 
-	for (pkg_num = 0; pkg_num <= max_pkg_num; ++pkg_num) {
+	for (pkg_num = 0; pkg_num <= max_pkg_num && pkg_num < MAX_PACKAGES; ++pkg_num) {
 		if (pkg_set & (1UL << pkg_num))
 			func(pkg_num);
 	}
-- 
2.45.2

