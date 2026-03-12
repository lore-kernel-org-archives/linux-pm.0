Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFF031F980
	for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 10:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773310871; cv=none; b=q8YG1jervOuGpsTT0VYMhjP0I5GMQULT1bM/2J0Wc4b/X54+6TQECvOxCpcx32lzUvp7e3fjTO1a4akDrqoJ8zwZ3qSZ2T74JJHqb9ecexBy7dPZgFcYCwf3d8ccWxZ2qkCCE61KlG65UebFK/n8ynTa2IvW84c2AL4oRdCofVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773310871; c=relaxed/simple;
	bh=aeIm2Y7m/uydcIStSXKbWbiJ9/IfGf/kMaYx0R0nCDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ex2hxr8nNMkIlo3rXZta1UJlVbcIYFaGVKoyJQr/zB1puLY9ywdJ42R97ilID96RHBvQemN1svh8n3is+5gZA0vMqSZlJrxZ26jXzQ3gtF1lmw2LiZiTPfhb5xqA/7so3sU83X5iZJkPxHg2zF7A+UVrwkA5iPMqCHRsjPRuFFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it; spf=pass smtp.mailfrom=r-ricci.it; dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b=LMIXcX4w; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b="LMIXcX4w"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-ricci.it; s=key1;
	t=1773310866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MmnMqo3dl+loDie4ChIdUh5USE6DeAOW5mCa/3t87iA=;
	b=LMIXcX4wSFyxEyA4OEbtMi4xKqrRPZ68KTbjptXhOtGoiR+9KTPH7U4hTHFXQ3mrDHmDwM
	SI4zrEnG+TTHXMn4JVfDF48kwEswJRLuUUwyCaywE3xGByMQ1kLzJU8QJ7jPwUVMUgdCYU
	z0V8z9X+N7Bf5FbNvZu+AHaE8aOZAxFQmdT1OJLNDEOdpURy7Uf53tXQJIpqJ1XZFMH9wP
	IlKIBI9Z8AVgUFVXwZB40Fi1Wx4FGF/kSwhqhGGV6L/6hRxsQ9CjkgFol/ysj9EQeVqHfd
	jhtqPO48uwc3KOjqRkjmIHRzZtoRPVNnsmhBIiL/VsxNNGPtJNsinUpRz9NDcg==
From: Roberto Ricci <io@r-ricci.it>
To: Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Roberto Ricci <io@r-ricci.it>
Subject: [PATCH v3 2/4] cpupower-frequency-info.1: use the proper name of the --perf option
Date: Thu, 12 Mar 2026 11:20:27 +0100
Message-ID: <20260312102029.14980-2-io@r-ricci.it>
In-Reply-To: <20260312102029.14980-1-io@r-ricci.it>
References: <20260312102029.14980-1-io@r-ricci.it>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The cpupower-frequency-info(1) man page describes a '--perf' option.
Even though this form is accepted by the program, its proper name is
'--performance'.

cpufreq-info.c:
	{"performance", no_argument,	 NULL,	 'c'},

Fixes 8382dce5e4835c045f33b8958a5f559d212cdd11 ("cpupower: Add "perf" option to print AMD P-State information")

Signed-off-by: Roberto Ricci <io@r-ricci.it>
---
 tools/power/cpupower/man/cpupower-frequency-info.1 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/cpupower/man/cpupower-frequency-info.1 b/tools/power/cpupower/man/cpupower-frequency-info.1
index 47fdd7218748..1173d4f31e69 100644
--- a/tools/power/cpupower/man/cpupower-frequency-info.1
+++ b/tools/power/cpupower/man/cpupower-frequency-info.1
@@ -53,7 +53,7 @@ human\-readable output for the \-f, \-w, \-s and \-y parameters.
 \fB\-n\fR \fB\-\-no-rounding\fR
 Output frequencies and latencies without rounding off values.
 .TP  
-\fB\-c\fR \fB\-\-perf\fR
+\fB\-c\fR \fB\-\-performance\fR
 Get performances and frequencies capabilities of CPPC, by reading it from hardware (only available on the hardware with CPPC).
 .TP
 .SH "REMARKS"
-- 
2.53.0

