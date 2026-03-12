Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E6A3B47EA
	for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 10:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773310875; cv=none; b=KVl/2Z2syYDb0aeVNfGLFnTBr/YIYWRYfT9kntbI9dsatTObriFBlIXvONPuMCWe7husfAUOZHbtic3KWgdQ7ccLpLAUjZwmhvGfrnrgxsKScuXt9yRKl/gWsdvS6UJPuw8beFOOg+kYrWMz0XysjoxphKo6AC2+QVo6YTsuZcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773310875; c=relaxed/simple;
	bh=2BGOVvgD1y7CUJujC4/Cpkd3+qrsu69katONGa2d6Rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=prbFfqJbF0swwnzv47ArMU9+/7FUZ2wSmoOxoG0bT81XxkCXstTVXjjPzAL0FXPFlqMS/xCTk1jXYxQiA/mkcFq/U7+Y5UU1gnzkDK+Y28DLGMD3fvGRz1rjkHGb3T5VJf5FiUgTh4fcN/K+mp3wovBQoiN7jfYMG7+N7zxiM3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it; spf=pass smtp.mailfrom=r-ricci.it; dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b=OgYSdI/3; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b="OgYSdI/3"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-ricci.it; s=key1;
	t=1773310871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NzJxoBbrkuRpcHca1TAkRSRi9A8ggu8ESulnlrHLWno=;
	b=OgYSdI/3XOaXwbXKke5eOJt0ICtZByAA0m8Gxqpeac9GdOT3vapHPyyef/Or7MKAVDUrWU
	INIpFkbtfAo3FBoDLa0qpcUC1QjDgRWllb5g4bKPONcI8stXKLvoY6Kw78SLRw4WAt6YFc
	1zTaKtfbKyM9QwXHvDglId8n9X+Riq/5AQNSfitYNtSEhAW9GY6CSDmDViPrC0mFAsoqpH
	rZwOPAIsL6WQnOoUdZZfMuSdLMNnSY+1joeXCGPA2bW0cLZYO/Dbuqrey5scR0vYu0927F
	Omj1t1AVG763h55dHPH+77ypYqYdk+2v5zyV5k47w6pkgV4iHeYAVv7AwR4Abg==
From: Roberto Ricci <io@r-ricci.it>
To: Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Roberto Ricci <io@r-ricci.it>
Subject: [PATCH v3 3/4] cpupower-frequency-info.1: document --boost and --epp options
Date: Thu, 12 Mar 2026 11:20:28 +0100
Message-ID: <20260312102029.14980-3-io@r-ricci.it>
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

`cpupower frequency-info` supports the '--boost' option since the
program was first added with commit
7fe2f6399a84 ("cpupowerutils - cpufrequtils extended with quite some features")
but the man page lacks it.

'--epp' has been added with commit
5f567afc283f ("cpupower: Add support for showing energy performance preference")
but it has never been added to the man page.

cpufreq-info.c:
	{"boost",	 no_argument,		 NULL,	 'b'},
	...
	{"epp",		 no_argument,		 NULL,	 'z'},

Fixes 7fe2f6399a84760a9af8896ac152728250f82adb ("cpupowerutils - cpufrequtils extended with quite some features")
Fixes 5f567afc283fc9e7c6a34d013c4fc6c5e8d6afae ("cpupower: Add support for showing energy performance preference")

Signed-off-by: Roberto Ricci <io@r-ricci.it>
---
 tools/power/cpupower/man/cpupower-frequency-info.1 | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/power/cpupower/man/cpupower-frequency-info.1 b/tools/power/cpupower/man/cpupower-frequency-info.1
index 1173d4f31e69..1dc7536e13ab 100644
--- a/tools/power/cpupower/man/cpupower-frequency-info.1
+++ b/tools/power/cpupower/man/cpupower-frequency-info.1
@@ -32,6 +32,12 @@ Gets the currently used cpufreq policy.
 \fB\-g\fR \fB\-\-governors\fR
 Determines available cpufreq governors.
 .TP  
+\fB\-b\fR \fB\-\-boost\fR
+Gets the current boost state support.
+.TP  
+\fB\-z\fR \fB\-\-epp\fR
+Gets the current EPP (energy performance preference).
+.TP  
 \fB\-r\fR \fB\-\-related\-cpus\fR
 Determines which CPUs run at the same hardware frequency.
 .TP  
-- 
2.53.0

