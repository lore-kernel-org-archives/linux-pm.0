Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5438372EEA
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 01:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774316186; cv=none; b=X2weCxoo/rYvn8BHpZUScf2qcLkr+UfTcgFNmV+LRGCtaLR9G30ICXZL76HSpHUp+EMEPK5ZpRwnbzX20QydQiNDMLq2/gr0MQNqMwuXeTQtdu4gEsvvj1gsVoSr+2JRofT/5HUXNGDzHnx/9HAllIqyeboRGGgZDGLEPRE3PVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774316186; c=relaxed/simple;
	bh=CCsJSzdjoIzvSysH/lVvJDxs9dn6ULCxrrgKN1aeb8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lcSuQgj97nLfgsVrkHKWA4/pEaMgoOHZccTSuuVuz1zwo5bj6jys7cAdVE0weDcxnEky/0e7L+bwSl9qOF/a0OZDuvmb7kCqjpEiK9ziQk3L7Q+Yt6bEjPA6TH7sNNVHGYbgNct0ie/TYy7b6Uu5IuePwQvdZ9Bw91ZkvHFNa6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it; spf=pass smtp.mailfrom=r-ricci.it; dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b=HRoEPFKe; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b="HRoEPFKe"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-ricci.it; s=key1;
	t=1774316182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pv50I02xcEaHi9CnK9QZv6zTKNMyBH8zXsZ3w3vHXiU=;
	b=HRoEPFKeHvXzLPLQl1f6chwe0wwA5rW4nOHj+Mn1bqsNEZiUI7EmU2cpH4bcAXPr421l74
	gy9qajzW43kgysFQjKY5asgZ0DSyTM9EwgXc6JjodurmDOweQx81/0vavkFylbtov8zqJr
	ec+vYTXAYHBBWG7At23u1e6b8w3D+QjJe4SOkBtI69iWhNMGx2yYf50rEWJhn/8uc4YaD0
	b7f5uYtBYFhRVVhBdm5XoemI16ylrIXkfMpjJJkbqohrcX+y5juEhJb3bTx4+jooTJ1RLQ
	2bpv5hAlzt4h8EDW/2HUjFD8qp6roA51TSoauad4hrw7n7BUHsFoRBiKioB4UQ==
From: Roberto Ricci <io@r-ricci.it>
To: Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Roberto Ricci <io@r-ricci.it>
Subject: [PATCH v4 3/6] cpupower-frequency-info.1: trim trailing whitespace
Date: Tue, 24 Mar 2026 02:35:40 +0100
Message-ID: <20260324013543.4776-4-io@r-ricci.it>
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

Remove useless spaces at the end of some lines in
cpupower-frequency-info.1.

Signed-off-by: Roberto Ricci <io@r-ricci.it>
---
 .../cpupower/man/cpupower-frequency-info.1    | 56 +++++++++----------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/tools/power/cpupower/man/cpupower-frequency-info.1 b/tools/power/cpupower/man/cpupower-frequency-info.1
index 47fdd7218748..e4173417b7c6 100644
--- a/tools/power/cpupower/man/cpupower-frequency-info.1
+++ b/tools/power/cpupower/man/cpupower-frequency-info.1
@@ -1,80 +1,80 @@
 .TH "CPUPOWER\-FREQUENCY\-INFO" "1" "0.1" "" "cpupower Manual"
 .SH "NAME"
-.LP 
+.LP
 cpupower\-frequency\-info \- Utility to retrieve cpufreq kernel information
 .SH "SYNTAX"
-.LP 
+.LP
 cpupower [ \-c cpulist ] frequency\-info [\fIoptions\fP]
 .SH "DESCRIPTION"
-.LP 
+.LP
 A small tool which prints out cpufreq information helpful to developers and interested users.
 .SH "OPTIONS"
-.LP 
-.TP  
+.LP
+.TP
 \fB\-e\fR \fB\-\-debug\fR
 Prints out debug information.
-.TP  
+.TP
 \fB\-f\fR \fB\-\-freq\fR
 Get frequency the CPU currently runs at, according to the cpufreq core.
-.TP  
+.TP
 \fB\-w\fR \fB\-\-hwfreq\fR
 Get frequency the CPU currently runs at, by reading it from hardware (only available to root).
-.TP  
+.TP
 \fB\-l\fR \fB\-\-hwlimits\fR
 Determine the minimum and maximum CPU frequency allowed.
-.TP  
+.TP
 \fB\-d\fR \fB\-\-driver\fR
 Determines the used cpufreq kernel driver.
-.TP  
+.TP
 \fB\-p\fR \fB\-\-policy\fR
 Gets the currently used cpufreq policy.
-.TP  
+.TP
 \fB\-g\fR \fB\-\-governors\fR
 Determines available cpufreq governors.
-.TP  
+.TP
 \fB\-r\fR \fB\-\-related\-cpus\fR
 Determines which CPUs run at the same hardware frequency.
-.TP  
+.TP
 \fB\-a\fR \fB\-\-affected\-cpus\fR
 Determines which CPUs need to have their frequency coordinated by software.
-.TP  
+.TP
 \fB\-s\fR \fB\-\-stats\fR
 Shows cpufreq statistics if available.
-.TP  
+.TP
 \fB\-y\fR \fB\-\-latency\fR
 Determines the maximum latency on CPU frequency changes.
-.TP  
+.TP
 \fB\-o\fR \fB\-\-proc\fR
 Prints out information like provided by the /proc/cpufreq interface in 2.4. and early 2.6. kernels.
-.TP  
+.TP
 \fB\-m\fR \fB\-\-human\fR
 human\-readable output for the \-f, \-w, \-s and \-y parameters.
-.TP  
+.TP
 \fB\-n\fR \fB\-\-no-rounding\fR
 Output frequencies and latencies without rounding off values.
-.TP  
+.TP
 \fB\-c\fR \fB\-\-perf\fR
 Get performances and frequencies capabilities of CPPC, by reading it from hardware (only available on the hardware with CPPC).
 .TP
 .SH "REMARKS"
-.LP 
+.LP
 By default only values of core zero are displayed. How to display settings of
 other cores is described in the cpupower(1) manpage in the \-\-cpu option section.
-.LP 
+.LP
 You can't specify more than one of the output specific options \-o \-e \-a \-g \-p \-d \-l \-w \-f \-y.
-.LP 
+.LP
 You also can't specify the \-o option combined with the \-c option.
 .SH "FILES"
-.nf 
-\fI/sys/devices/system/cpu/cpu*/cpufreq/\fP  
-\fI/proc/cpufreq\fP (deprecated) 
+.nf
+\fI/sys/devices/system/cpu/cpu*/cpufreq/\fP
+\fI/proc/cpufreq\fP (deprecated)
 \fI/proc/sys/cpu/\fP (deprecated)
-.fi 
+.fi
 .SH "AUTHORS"
 .nf
-Dominik Brodowski <linux@brodo.de> \- author 
+Dominik Brodowski <linux@brodo.de> \- author
 Mattia Dongili<malattia@gmail.com> \- first autolibtoolization
 .fi
 .SH "SEE ALSO"
-.LP 
+.LP
 cpupower\-frequency\-set(1), cpupower(1)
-- 
2.53.0

