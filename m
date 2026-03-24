Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BB537A4AB
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 01:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774316191; cv=none; b=GTZAusSlKmFTuvDr++LtK7KA34Ndm4VGFONbICB6qNV1UMdIWygUMsrtCtv3eQS1dxpbcwDeK6x28Ag92yp449L9BAnCiFpoN+MDvAQpRLl08K/AbAGMT0AyBALqKH78BIWT5xfki3eBePcr/sIM7llRWeOxRwafbkYnICcSuCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774316191; c=relaxed/simple;
	bh=J5ORqVEz6qi+oGhAaSzznlsIVkHuhlRydngEq/1lRXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RG/LJCo+vixWXPCFQymA8RFozYXIqhQehCsSnENwVG87TCGg7ckLFg62Yy0jQ9DCgLIFyBq5z6lMeK1h9dX9Tid2SM5Fx8xosed4cdQvs3ACTfInxy8sRR0JUlC+21DZJ4xgljHZK+m5NyVrXLi1LI6tpfnVboqms8ptW0jCdxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it; spf=pass smtp.mailfrom=r-ricci.it; dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b=StuaPErk; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b="StuaPErk"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-ricci.it; s=key1;
	t=1774316188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rqZ4NeFJRpajZkE7Bc+q+gZkqwO0uprgjWoij5NvlcI=;
	b=StuaPErkYMNG0DDGHSR9ssLFACKC2MpmRLYaYNIgU5Gq5Gm3yYz5PnA3AVjgJmvgbcqzrY
	vu4FhIE/lwuaBidhyP2w7vUMGFH/IzDJFOf50gRiZa4iXrZ7UUczsae/L45WxtiSpZMBn6
	1TunTQJV6U3dABE4aC9dJcjT9j78/U9t8iq8DC6+Fu1mpuLeQDud5AwJFmHslmjtXSW4vQ
	nRSrjLWeMtN7hRseBT+pB63XucDT4ORpBUBTvU+YEwJ8KxgXNSHsruyQPOm1JU1VdZm3B2
	lSssVRFxR2sG92v6t5eMb2gRJ9xpvIZHjdp+qWz5uWa97OiSP5k1roVkI2w/cQ==
From: Roberto Ricci <io@r-ricci.it>
To: Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Roberto Ricci <io@r-ricci.it>
Subject: [PATCH v4 6/6] cpupower-info.1: describe the --perf-bias option
Date: Tue, 24 Mar 2026 02:35:43 +0100
Message-ID: <20260324013543.4776-7-io@r-ricci.it>
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

The cpupower-info(1) man page only mentions the short form of the
'--perf-bias' option in the synopsys, but the long form is not documented
and its effect is not explained.

cpupower-info.c:
     {"perf-bias", optional_argument, NULL, 'b'},

Signed-off-by: Roberto Ricci <io@r-ricci.it>
---
 tools/power/cpupower/man/cpupower-info.1 | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/power/cpupower/man/cpupower-info.1 b/tools/power/cpupower/man/cpupower-info.1
index 340bcd0be7de..1f42d8c388a0 100644
--- a/tools/power/cpupower/man/cpupower-info.1
+++ b/tools/power/cpupower/man/cpupower-info.1
@@ -3,7 +3,7 @@
 cpupower\-info \- Shows processor power related kernel or hardware configurations
 .SH SYNOPSIS
 .ft B
-.B cpupower info [ \-b ]
+.B cpupower info [\fIoptions\fP]
 
 .SH DESCRIPTION
 \fBcpupower info \fP shows kernel configurations or processor hardware
@@ -13,6 +13,13 @@ Some options are platform wide, some affect single cores. By default values
 of core zero are displayed only. cpupower --cpu all cpuinfo will show the
 settings of all cores, see cpupower(1) how to choose specific cores.
 
+.SH "OPTIONS"
+.LP
+.TP
+\fB\-b\fR \fB\-\-perf-bias\fR
+Gets the current performance bias value.
+.TP
+
 .SH "SEE ALSO"
 Options are described in detail in:
 
-- 
2.53.0

