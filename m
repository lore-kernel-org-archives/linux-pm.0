Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F019336891
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 22:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774392051; cv=none; b=gn9vHAeT2iop7CR3QaXtq3WVzgz1gRJPdtvjLIP2KHMJLV+ZkJziiVWpbuNDh3sLT3ODjoUweqyK5UZM90gyj7N9BbbgYf0jy3w81XtW4Y0fu7pUm5x9O1UaVlvZ6ZlnHEHserpjs86jI/EYHkcEhE1xQjN8Cb1HPMCtZE7cu54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774392051; c=relaxed/simple;
	bh=Y5BcBGtNUQLVYQs3QRDux4aVEbLP0dNAyrhRkmk5nfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZbZYDC2yc5vrWFOM8BeYJj/CSc2RZp52bkdK0eCVKH6MBqccgOjFjaxrdWv8wv+PObpCDKRWEQlSeWG2AL9/lwIcFjCWdlfdPwYUJurs/Jgy/0trVJbD2ARBK+gyR8EWbX86n3/sGHQO3imOZr1z9xZPDXgJxe5LPKMbDNV0m9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it; spf=pass smtp.mailfrom=r-ricci.it; dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b=hZ1K+n94; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b="hZ1K+n94"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-ricci.it; s=key1;
	t=1774392047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v+yK+9OINSKQwlx/h5ZhN8aAxMviN5G+FIJiHwexRSI=;
	b=hZ1K+n94AZGmvprr0sVQ6IlfaOacJjbYtcx9FzX1GM+0ZxbjVonDCk/mJyBCYCbq2LRZ81
	QGEo64C+SK3z3EDMZaRcuCC3l15lWhWTqwl56ReYHWUKlBQ6dd7Z9E3auHf3C9nbuskx2n
	Cr2vN+Lux4qO0Wl+0LFTxgknogYvF4iCdAVsqhw0MBaM1E5Z5hsexzv9+m7IofOeHr57In
	TfVh+gNNQBqFv2xcPB/nDcscvhVGBYu8f6yX+nMlpJ4oE3/VM9G+vuPdPe51DzXNSK39Jn
	5JULchJRihd6ssQ4o6HZj05WSaap6t166LAp2xKOddPqBOlZqyL526OlzHia1A==
From: Roberto Ricci <io@r-ricci.it>
To: Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Roberto Ricci <io@r-ricci.it>
Subject: [PATCH v5 1/4] cpupower-idle-info.1: fix short option names
Date: Tue, 24 Mar 2026 23:39:01 +0100
Message-ID: <20260324223921.14317-2-io@r-ricci.it>
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

The cpupower-idle-info(1) man page describes '-f' as the short form of the
'--silent' option and '-e' as the short form of the '--proc' option.
But they are not correct:

$ cpupower idle-info -f
idle-info: invalid option -- 'f'
invalid or unknown argument
$ cpupower idle-info -e
idle-info: invalid option -- 'e'
invalid or unknown argument

The short form of '--silent' is actually '-s' and the short form of
'--proc' is actually '-o':

cpuidle-info.c:
	{"silent", no_argument, NULL, 's'},
	{"proc", no_argument, NULL, 'o'},

Signed-off-by: Roberto Ricci <io@r-ricci.it>
---
 tools/power/cpupower/man/cpupower-idle-info.1 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/power/cpupower/man/cpupower-idle-info.1 b/tools/power/cpupower/man/cpupower-idle-info.1
index 20b6345c53ad..b2f92aba5f5b 100644
--- a/tools/power/cpupower/man/cpupower-idle-info.1
+++ b/tools/power/cpupower/man/cpupower-idle-info.1
@@ -11,10 +11,10 @@ A tool which prints out per cpu idle information helpful to developers and inter
 .SH "OPTIONS"
 .LP
 .TP
-\fB\-f\fR \fB\-\-silent\fR
+\fB\-s\fR \fB\-\-silent\fR
 Only print a summary of all available C-states in the system.
 .TP
-\fB\-e\fR \fB\-\-proc\fR
+\fB\-o\fR \fB\-\-proc\fR
 deprecated.
 Prints out idle information in old /proc/acpi/processor/*/power format. This
 interface has been removed from the kernel for quite some time, do not let
-- 
2.53.0

