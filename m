Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574663B47D4
	for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 10:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773310884; cv=none; b=J7OOQwy4fweKRgjN1h6hXwq4Hajshj0f/F34FUYJBk6mfk4AVGGAgWgS3V3T61e2p3pD48nQGkvhTJ+y9Kwl5Zk2WbPOrXHdj+MICtm/rFKDx3MZOW7L5OSAA0wLHVuaeOoaz7KlWghfy+FstgKP/cMAZ8ikaCuKKCUuN2We2d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773310884; c=relaxed/simple;
	bh=lLmmJSbUK6nuG3qsXKOyCV63CZJ1OXF4FFrempg0NM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qJhSCldMH+SzKYBzt2LsKrXQZGU1oQIqXZokEoJ9FdDdG4nahUAsYvZGFR9UaIhUKJ5WFZDxeD7CUVSqEQxrUYgUJGgq4nYeLaV8VtvW+ko/aRbSnnz0i182eRE5dtLv/zeMtCkVsjuKlWx0a6Qe3pvc4Hy1sTZo1AcAhODnN9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it; spf=pass smtp.mailfrom=r-ricci.it; dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b=q/OI7cSv; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b="q/OI7cSv"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-ricci.it; s=key1;
	t=1773310880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6e8pNrFlDGhwkWaf4KLIsoEGiaACWnfCT7kPz/obJPE=;
	b=q/OI7cSvpxxaAK4W8I915aiDtIFVsMn/vt+izOlpln5zazWvaGfAnk0S7rZ9umVfPnXMM7
	fYH8m4QrWBIR4JazNvpArE7fjhs/mPULYhokyBm2yp9NZ5VB/EJ+fsQs8ayJD4Mmn5ysnQ
	jmXuEyWunTq+pg2Ml+gqsPbCnSYILNa/cjGDfeE9cRYpR8nWykAsJFMOvvS5bayURducyC
	lUs96pxtkMH53sJ3v9Zzgy7FEgLVg8T5Ry647m69fXwnRd2Q5oPqiqyqLlWpiUpXM5jQtL
	QuJB6/DxxfP8NSlgomE4YctPMTJZjOfeBuiSozMwc0oGznqeZTH3snHuY0PcWQ==
From: Roberto Ricci <io@r-ricci.it>
To: Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Roberto Ricci <io@r-ricci.it>
Subject: [PATCH v3 4/4] cpupower-info.1: describe the --perf-bias option
Date: Thu, 12 Mar 2026 11:20:29 +0100
Message-ID: <20260312102029.14980-4-io@r-ricci.it>
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

The cpupower-info(1) man page only mentions the short form of the
'--perf-bias' option in the synopsys, but the long form is not
documented and its effect is not explained.

Fixes 7fe2f6399a84760a9af8896ac152728250f82adb ("cpupowerutils - cpufrequtils extended with quite some features")

Signed-off-by: Roberto Ricci <io@r-ricci.it>
---
 tools/power/cpupower/man/cpupower-info.1 | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/power/cpupower/man/cpupower-info.1 b/tools/power/cpupower/man/cpupower-info.1
index 340bcd0be7de..a8d5aee4381c 100644
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

