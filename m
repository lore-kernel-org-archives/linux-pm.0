Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9691A371D0B
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 01:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774316176; cv=none; b=fUY5+NiwAALGgpjN4vkrovgZrnQMiLof9zGaEafKMidVNKRLPLpAKKKhyfcVSc8oFLR9XBJeP6WFUj7Sn2OQbZ+HRGlLo+D6Lkr088YDUdQzDLr0/Oz1xXSzzMpLkAKB2+yrl7lbTHhD7eEMplL2OoiZsWtj1RIkj/n6KUBwjp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774316176; c=relaxed/simple;
	bh=kCH+gWlpiuqLcolyHFKahhmGyOZFdtO3ScEAncHY1NQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jf9SKxLZKQEun+pd/t4xDBh9hmuhcewDqAYpEkMJsOQ0KSL0YSIcH+G3QcQP3xrM2x3U5UuaVzt23rX5Ucyj2U0N5GVBIzQ5van0XPZy6vhjPLGbnhBjJA+da8kF3FIJVOr4+agz17JON+nxS7ysh4+oii6hm29SPDdGZIfvfsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it; spf=pass smtp.mailfrom=r-ricci.it; dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b=XWJjjeEM; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b="XWJjjeEM"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-ricci.it; s=key1;
	t=1774316172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H6WIt5R10n//VBbW+zOKbtChmOiBvgqf7p3GFl0hBZI=;
	b=XWJjjeEMNbfTcO5OGikuHt6+otMyy19nkf7DB7g0nPS59i10aXEbcVexp1JglKjoxckMc9
	QZJdCETVIQyIm2iTPcJ1Tr9Hq9Fo8QFCaBZaDfrTr/Z5dTHGPZ/WQi97DH7cB35bGDQ5TU
	tA2SQPkZpppOCMj/lhW4+5NfbNaU1XF3tO9+8XM1emL7lYU+t1gjm8PS/soq5UASiHrWdd
	i+2O7Vsa4JaxKhCfY/YT0nWtWYs2Zq1zggXT8L6Cq9+wFxcpfpBsdbCZyUA7Eq0ERaxh/7
	LtzLKM3ZvOD/BO9rUEmGuXDvgRlk6PQPXPthA1Vo9NyBXcf4b6WfcwkJRikNUg==
From: Roberto Ricci <io@r-ricci.it>
To: Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Roberto Ricci <io@r-ricci.it>
Subject: [PATCH v4 1/6] cpupower-frequency-set.1: trim trailing whitespace
Date: Tue, 24 Mar 2026 02:35:38 +0100
Message-ID: <20260324013543.4776-2-io@r-ricci.it>
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

Remove useless spaces at the end of some lines in cpupower-frequency-set.1.

Signed-off-by: Roberto Ricci <io@r-ricci.it>
---
 .../cpupower/man/cpupower-frequency-set.1     | 42 +++++++++----------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/tools/power/cpupower/man/cpupower-frequency-set.1 b/tools/power/cpupower/man/cpupower-frequency-set.1
index b50570221a5b..fded317c8c51 100644
--- a/tools/power/cpupower/man/cpupower-frequency-set.1
+++ b/tools/power/cpupower/man/cpupower-frequency-set.1
@@ -1,52 +1,52 @@
 .TH "CPUPOWER\-FREQUENCY\-SET" "1" "0.1" "" "cpupower Manual"
 .SH "NAME"
-.LP 
+.LP
 cpupower\-frequency\-set \- A small tool which allows to modify cpufreq settings.
 .SH "SYNTAX"
-.LP 
+.LP
 cpupower [ \-c cpu ] frequency\-set [\fIoptions\fP]
 .SH "DESCRIPTION"
-.LP 
+.LP
 cpupower frequency\-set allows you to modify cpufreq settings without having to type e.g. "/sys/devices/system/cpu/cpu0/cpufreq/scaling_set_speed" all the time.
 .SH "OPTIONS"
-.LP 
-.TP 
+.LP
+.TP
 \fB\-d\fR \fB\-\-min\fR <FREQ>
 new minimum CPU frequency the governor may select.
-.TP 
+.TP
 \fB\-u\fR \fB\-\-max\fR <FREQ>
 new maximum CPU frequency the governor may select.
-.TP 
+.TP
 \fB\-g\fR \fB\-\-governor\fR <GOV>
 new cpufreq governor.
-.TP 
+.TP
 \fB\-f\fR \fB\-\-freq\fR <FREQ>
 specific frequency to be set. Requires userspace governor to be available and loaded.
-.TP 
+.TP
 \fB\-r\fR \fB\-\-related\fR
 modify all hardware-related CPUs at the same time
-.TP 
+.TP
 .SH "REMARKS"
-.LP 
+.LP
 By default values are applied on all cores. How to modify single core
 configurations is described in the cpupower(1) manpage in the \-\-cpu option section.
-.LP 
+.LP
 The \-f FREQ, \-\-freq FREQ parameter cannot be combined with any other parameter.
-.LP 
+.LP
 FREQuencies can be passed in Hz, kHz (default), MHz, GHz, or THz by postfixing the value with the wanted unit name, without any space (frequency in kHz =^ Hz * 0.001 =^ MHz * 1000 =^ GHz * 1000000).
-.LP 
+.LP
 On Linux kernels up to 2.6.29, the \-r or \-\-related parameter is ignored.
-.SH "FILES" 
+.SH "FILES"
 .nf
-\fI/sys/devices/system/cpu/cpu*/cpufreq/\fP  
-\fI/proc/cpufreq\fP (deprecated) 
+\fI/sys/devices/system/cpu/cpu*/cpufreq/\fP
+\fI/proc/cpufreq\fP (deprecated)
 \fI/proc/sys/cpu/\fP (deprecated)
-.fi 
+.fi
 .SH "AUTHORS"
-.nf 
-Dominik Brodowski <linux@brodo.de> \- author 
+.nf
+Dominik Brodowski <linux@brodo.de> \- author
 Mattia Dongili<malattia@gmail.com> \- first autolibtoolization
 .fi
 .SH "SEE ALSO"
-.LP 
+.LP
 cpupower\-frequency\-info(1), cpupower(1)
-- 
2.53.0

