Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6D4390990
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 22:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774392056; cv=none; b=aNA5nwMK+kiWulRLNammFiL7uJf8tjiJDbdquG53tijYWbUh82YQfw705Lxdkqjvye+ScHJGioRkXBi1NNREgCRh+v2IEjVAwd6ppJylCfauVTYjcIkB4qEbiFAzqRBhvwQQElwOl8cUxZTTT7dS9HMW6iwUPWe7SKN4Es3qviU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774392056; c=relaxed/simple;
	bh=2UFRZFYy9T7eGDsgUZwk9KPZ3EHFBhaPmr0uoLRCdoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C5KEYCERdA3DpeIeK8i8fsvR3Tae6dXb1BV9zpf1B+1bHl6TU5xlCv1LVn5bTQ8jKeEu6zhzqPpQhUMQgk54h2pjabo6/1TUwsBxZ2n4UmNvUe6NvpH2VbheFqOhkG10b8+hnUj4tnmm+89EpDeaV85qlAzj6+I+fm5ns5qzh9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it; spf=pass smtp.mailfrom=r-ricci.it; dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b=wDRuYp0A; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b="wDRuYp0A"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-ricci.it; s=key1;
	t=1774392053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QVu83NgSB5chJ/xrN7IzHb2wcuwckFdNqtyOmrtAXns=;
	b=wDRuYp0A30DQ+M1XwpdphuUpV8/c/ke02dJtbh4AB6HtAZMdfVfwcvoxn5WW1n9Tfwz/Oe
	Sm90ZZb/aCyrZ8Rt+GJEWIeQnmoT0fqa2D3pINLRohvACPr0bRmoQOINv/TDe3dIn85j1N
	89Ga+6dvfuaXwgDOGPns8Rc+9bPuc5JjLTrnSJAvro8dEl13xXkG/Wh2JpjFe5cbYeYhm1
	PJQPKiJM9UgmmbNSBnh3RvS4MnZ68Z98gwY0Yd97f7T63PHW14cbe3JhO67ayetS0dF6KY
	GsVAgaF3HIY48Oh5PAP/NuBaO8eTD6iey0mZthUR1Sx+pspnQ0nc+iHUUV2ouA==
From: Roberto Ricci <io@r-ricci.it>
To: Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Roberto Ricci <io@r-ricci.it>
Subject: [PATCH v5 3/4] cpupower-frequency-info.1: document --boost and --epp options
Date: Tue, 24 Mar 2026 23:39:03 +0100
Message-ID: <20260324223921.14317-4-io@r-ricci.it>
In-Reply-To: <20260324223921.14317-1-io@r-ricci.it>
References: <20260324223921.14317-1-io@r-ricci.it>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

`cpupower frequency-info` supports the '--boost' option since the program
was first added with commit 7fe2f6399a84 ("cpupowerutils - cpufrequtils
extended with quite some features"), but the man page lacks it.

'--epp' has been added with commit 5f567afc283f ("cpupower: Add support for
showing energy performance preference") but it has never been added to the
man page.

cpufreq-info.c:
	{"boost",	 no_argument,		 NULL,	 'b'},
	...
	{"epp",		 no_argument,		 NULL,	 'z'},

Signed-off-by: Roberto Ricci <io@r-ricci.it>
---
 tools/power/cpupower/man/cpupower-frequency-info.1 | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/power/cpupower/man/cpupower-frequency-info.1 b/tools/power/cpupower/man/cpupower-frequency-info.1
index 1173d4f31e69..b0d69c9adcbd 100644
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

