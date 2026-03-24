Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CB432BF44
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 22:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774392058; cv=none; b=ENkKEUodmdVkaMxyNf7PE04NpRSpyYDVBTmKoyIWxMDqjrFvhi56qLd0qRf50oIDqkixhkAE7qJufSktU/Jv5afWVbXrYbto7IInWAE1VA9jyIpP7cjsgUQVwQKHbQ1jiVmviiaTQkzd/a1Qj/S3fhQDJ2Yo/kd0R24fO/iwbKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774392058; c=relaxed/simple;
	bh=J5ORqVEz6qi+oGhAaSzznlsIVkHuhlRydngEq/1lRXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KEDFvl3J6pBcUdLco5yDTQoHFparswU6sAzIcyBwbhLVf56CKpGACjvxrNSHYcs5r6ZJn+vARN7SRAQ+dyGFd4lv1uOYVP67QrWz4H4QVr4cBCKkU/GqVeVPYbTDVbD2/RaYCM7HEiHkNztOj4K2mUU3eveT8ni7lxrITxfmhH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it; spf=pass smtp.mailfrom=r-ricci.it; dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b=wosDFaDU; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b="wosDFaDU"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-ricci.it; s=key1;
	t=1774392055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rqZ4NeFJRpajZkE7Bc+q+gZkqwO0uprgjWoij5NvlcI=;
	b=wosDFaDU1aXcM1t8BV+d3O+V2SMFae3EIWv/GOoISb0R/WquMp9i2+1PKtds2mek5sVj3J
	gzPiZ5hh2A1JiD+vUIWVj1UGDkvAEZuVb21kqISqane2hdZvRKRSmOuNR18Fq1UMDRplEM
	Xws0Q6d6cpJYxiedhZV3wjCOu/mvTb9jMD2U3hNUPI+F8oOxCFrIE/VCoM0kBfA1VbrSIy
	bMRGQSVj+Nhwmq9sq9UoX9OIP/HzT3fu8mrSfLdpEWtgWLVw2Ca7i+sVe+BmutmbVqYvTQ
	c9wgkb04AIrDTlOBkGUGpK79j2VNcRpQA2T1fV6ifjST0li2LLk12Ht7gf/MHA==
From: Roberto Ricci <io@r-ricci.it>
To: Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Roberto Ricci <io@r-ricci.it>
Subject: [PATCH v5 4/4] cpupower-info.1: describe the --perf-bias option
Date: Tue, 24 Mar 2026 23:39:04 +0100
Message-ID: <20260324223921.14317-5-io@r-ricci.it>
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

