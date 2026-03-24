Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3654237AA6C
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 01:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774316187; cv=none; b=jKoS2WRQSgSp4T62SEqvSY2jenyCQVC40Q5p1FFPzlvJf0qFHMXJTdzWeiy5h6nIrIyJnyJucydLL0yzocv7Mn6doqHLErWUy3RZhrE74jD+6kcp+bbmE6QcTMYWJlGhxLD5Gq9L6B9/Vs+8BdRC8Tpwtb+rdWDQI5iWV8WpqlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774316187; c=relaxed/simple;
	bh=cW3ImtYIq1KFObLNro9Mxzqg0xA7GIyiN+W6GQ1Zc8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=il+/8YI1RhR5h/QMIVXz3c+pgx/CED2dPzyzv1jX7ZcMPytZuWyGGAp0BUznN9PAentN5tdUn+hYip/IfZ5ypQfn4xc463fWDhIDI0F4ge5kCMiKJ6QUdF3c8fjvi7n6CW/zpB1dWc4gd1UgR9d3YGoefLATCQ/IhdNhFksby8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it; spf=pass smtp.mailfrom=r-ricci.it; dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b=HGJVULkz; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b="HGJVULkz"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-ricci.it; s=key1;
	t=1774316184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wotuDlnOcq4d7B3CyfDImpira6rjdECn//izqpMdCrY=;
	b=HGJVULkzFwzSbr449G60uR4BtNSuNsPtpWAEQLTpZVlkRUhEqX4jQY+0spIM3wBheWafbD
	YsPbM/dnKs0JtiWQ+jWB++gkK6cgSLZKZLdAShmCShgOMATKs7jpUzpmrcmTtwBSGPbMFq
	yYoCeSqnW7oFnrae2zEklF216xrlXzCUPVeKWHkIAT81cakWtWAGxKlWvmVP0RUMsN/4pV
	DKUA6YO/rzZJsDwg4Bvg6SG7OMGxoQ/TaSAIviEMsB//fwzzZvFjtFKub+zBBDAQ6azrRb
	QDBvxOli20goBEYXwQMhtBKNNcRUyCBM/2Qk3ObFapM34tyRwgdh+tg86I4ZVg==
From: Roberto Ricci <io@r-ricci.it>
To: Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Roberto Ricci <io@r-ricci.it>
Subject: [PATCH v4 4/6] cpupower-frequency-info.1: use the proper name of the --perf option
Date: Tue, 24 Mar 2026 02:35:41 +0100
Message-ID: <20260324013543.4776-5-io@r-ricci.it>
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

The cpupower-frequency-info(1) man page describes a '--perf' option.
Even though this form is accepted by the program, its proper name is
'--performance'.

cpufreq-info.c:
	{"performance", no_argument,	 NULL,	 'c'},

Signed-off-by: Roberto Ricci <io@r-ricci.it>
---
 tools/power/cpupower/man/cpupower-frequency-info.1 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/cpupower/man/cpupower-frequency-info.1 b/tools/power/cpupower/man/cpupower-frequency-info.1
index e4173417b7c6..7fce2b2e0506 100644
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

