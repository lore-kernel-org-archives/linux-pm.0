Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DBA37B416
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 01:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774316189; cv=none; b=JMf47VJXbLZ5ie0QlWVDlKDwmWm47ES3p6vtZChDIXI4SBsCOBhusqIX0CxJMQbY02e7o0RAl0Mpvc0txi42ET+3RD0ugo/5lhFXAqmvRndxJ1Yelzji090VnKx1CpqdcUiiRgA6MGQALgDvdKSaZE7itb6FBFw5h53hGQRtG+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774316189; c=relaxed/simple;
	bh=Nf+WuoTyB5nvjd4svuOO0RVl3reyaE6Tadgc1mStt9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jZONyiAXc5CwKAOc3m67Zc36UC3qPbZXb36TvCYqAvYDmylVxph1SswXlAS/+95WLFkcbi3MnshgUos4SMocXP/jdMI/PQvRChZAsZJaHNovtY5jCGG35fIBVrX3zRgmMu7e8icarqy+0xKtyCP68MTWH/w4A/VWI7QQ1vYmQGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it; spf=pass smtp.mailfrom=r-ricci.it; dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b=rpGJ2G+3; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b="rpGJ2G+3"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-ricci.it; s=key1;
	t=1774316186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cPLJbKy97M9BvZ7sUPTtq6hwdFKmp5ucWsT6BCogeJE=;
	b=rpGJ2G+3OMTKWKp9NTrvv5v2nxO04Gw3/AeXALbPijQLvqN+UME67177qKFxdwxmmuIaEo
	q9kvJFwYO6QD8ztvFZL1dVvBF92yAKtt+Z0QR7EzWWz6TdIvzOIUkomLCtPkbP1IgoDbvA
	qpvByxaof6fEa9vxlFaP26GsXvrdiBJPG409H05lCigDQDkDwGWEE7jI62EuSV+n0LRiK8
	efi5QGLSsm9O2AC34sgJRohzbZpSEzgbn0S+BWXwoW1tFD5RjBe6BkB9sI5c8gQoBwSp9Z
	AKAippX9Lf5tGdgvdvxS0cPqGERYe2blVevx1I0w2Trfes+J9slRW2B3v2FLSQ==
From: Roberto Ricci <io@r-ricci.it>
To: Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Roberto Ricci <io@r-ricci.it>
Subject: [PATCH v4 5/6] cpupower-frequency-info.1: document --boost and --epp options
Date: Tue, 24 Mar 2026 02:35:42 +0100
Message-ID: <20260324013543.4776-6-io@r-ricci.it>
In-Reply-To: <20260324013543.4776-1-io@r-ricci.it>
References: <20260324013543.4776-1-io@r-ricci.it>
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
index 7fce2b2e0506..346c2a6e40f4 100644
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

