Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795490857;
	b=pIo0Z9Z6dZZ+L8s7UzaRIVd3ZwUd2AsKmH4nka02ngAt4FZLnzam0QjE6sDKauWyISua
	 YNfT1EAEhL1AxIeIMaBEN9aAMBN+KVSfZBCQ63x0193DufOApp9ffRBjdDXyt0dOzhZSh
	 oWimSc24u/gBm6QhZVTZ0kDVMgKgnyUSAjy6gVyIzyCi6RENeLLjtJeralpsqilQELh4P
	 8fTSbJ1T1WQqhWfe7UmtB3rVFbRFfXjfuATBUR6E3VhHDOHY2MFXIWq+WwFH/ds7stf12
	 odtzKQP3kUxumhwRmALxDjrdOhwnQM2b5W1O0w7fShI1mrSec2G7UIONak901nDIfvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795490857;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vA/JkDlzEuqb+fY1HM/C6RlpWoROSycPr2A7ltH0xJA=;
	b=IMSQOcOsEeQYv9TO+mGlR/aYrjdDVWvQpBdAZaWOSsfaLYU1jpXy+Wam+cceQnt2FFd9
	 HsvRIjgRFrQW+oArMp7AKBA5fxa4WC2zeHlA+PggDTVdyPwZcWJZXYVpoENsojuo6Zm3H
	 Y/3QtsS4Smorb7UUYj9ZJRmhCttaTo5HYK6ncJ5jk6e6Apzb5xKEmACi/8KbVOxV5w2+6
	 sIJ4lKyZNfCZYZLpybu2lJbJi2BKUHn2Nq2I5sJ6PprVE5r4+/6f5z0e5R7R+OJvFEOl4
	 YbxQtd3suMvylcDdgG0nHiPyWfEVhxCo7/mufQkhD4BrJb1lJ+W0NJ93TnqNnHLAILQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Fb035xzO;
	arc=none smtp.remote-ip=115.124.30.130
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51206606A32A;
	Tue, 24 Nov 2026 03:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51206606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Fb035xzO
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795490848; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=vA/JkDlzEuqb+fY1HM/C6RlpWoROSycPr2A7ltH0xJA=;
	b=Fb035xzOk5JE/KZaoJsWuGPPzm18+SJWdakWtyAiVoVOsFLExHucrGsrA8ktMoNIyRqK88n3eVD8WINnzYFqo1YxospUAG4NpzFgEfq32lWk7x3a77G/Zs8W+mX/1PI2YddaNzMK1NkLJdDxSkgrWfZDP35G8uG/EWtL266EwP8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=qinyuntan@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0XFN2idj_1795490847;
Received: from banye.tbsite.net(mailfrom:qinyuntan@linux.alibaba.com fp:SMTPD_---0XFN2idj_1795490847 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 24 Nov 2026 11:27:27 +0800
From: Qinyun Tan <qinyuntan@linux.alibaba.com>
To: lenb@kernel.org
Cc: michael.hebenstreit@intel.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xlpang@linux.alibaba.com,
	Qinyun Tan <qinyuntan@linux.alibaba.com>
Subject: [PATCH 3/3] tools/power turbostat: Fix --cpu summary description
Date: Tue, 24 Nov 2026 11:27:23 +0800
Message-ID: <20261124032723.157254-4-qinyuntan@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261124032723.157254-1-qinyuntan@linux.alibaba.com>
References: <20261124032723.157254-1-qinyuntan@linux.alibaba.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The man page states that --cpu only filters output and that the summary
always includes all CPUs. Numeric CPU selections also restrict counter
collection and the summary, while core and package only filter displayed
rows.

Correct the option and row descriptions to match this behavior.

Fixes: 0fe375290137 ("tools/power/turbostat: Obey allowed CPUs for system summary")
Signed-off-by: Qinyun Tan <qinyuntan@linux.alibaba.com>
---
 tools/power/x86/turbostat/turbostat.8 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
index c905198d0501..c2b86d20db95 100644
--- a/tools/power/x86/turbostat/turbostat.8
+++ b/tools/power/x86/turbostat/turbostat.8
@@ -92,7 +92,7 @@ name as necessary to disambiguate it from others is necessary.  Note that option
 		'%x' hex identifier of the PMT MMIO region.
 .fi
 .PP
-\fB--cpu cpu-set\fP limit output to system summary plus the specified cpu-set.  If cpu-set is the string "core", then the system summary plus the first CPU in each core are printed -- eg. subsequent HT siblings are not printed.  Or if cpu-set is the string "package", then the system summary plus the first CPU in each package is printed.  Otherwise, the system summary plus the specified set of CPUs are printed.  The cpu-set is ordered from low to high, comma delimited with ".." and "-" permitted to denote a range. eg. 1,2,8,14..17,21-44  Multiple invocations of --cpu are OR'd together.
+\fB--cpu cpu-set\fP select CPUs to monitor or limit the rows displayed.  If cpu-set is the string "core", then the system summary plus the first CPU in each core are printed -- eg. subsequent HT siblings are not printed.  Or if cpu-set is the string "package", then the system summary plus the first CPU in each package is printed.  Otherwise, counter collection, output and the system summary are restricted to the specified set of CPUs.  The cpu-set is ordered from low to high, comma delimited with ".." and "-" permitted to denote a range. eg. 1,2,8,14..17,21-44  Multiple invocations of --cpu are OR'd together.
 .PP
 \fB--hide column\fP do not show the specified built-in columns.  May be invoked multiple times, or with a comma-separated list of column names.
 .PP
@@ -138,7 +138,7 @@ The \fBcommand\fP parameter forks \fBcommand\fP, and upon its exit,
 displays the statistics gathered since it was forked.
 .PP
 .SH ROW DESCRIPTIONS
-The system configuration dump (if --quiet is not used) is followed by statistics.  The first row of the statistics labels the content of each column (below).  The second row of statistics is the system summary line.  The system summary line has a '-' in the columns for the Package, Core, and CPU.  The contents of the system summary line depends on the type of column.  Columns that count items (eg. IRQ) show the sum across all CPUs in the system.  Columns that show a percentage show the average across all CPUs in the system.  Columns that dump raw MSR values simply show 0 in the summary.  After the system summary row, each row describes a specific Package/Core/CPU.  Note that if the --cpu parameter is used to limit which specific CPUs are displayed, turbostat will still collect statistics for all CPUs in the system and will still show the system summary for all CPUs in the system.
+The system configuration dump (if --quiet is not used) is followed by statistics.  The first row of the statistics labels the content of each column (below).  The second row of statistics is the system summary line.  The system summary line has a '-' in the columns for the Package, Core, and CPU.  The contents of the system summary line depends on the type of column.  Columns that count items (eg. IRQ) show the sum across the monitored CPUs.  Columns that show a percentage show the average across the monitored CPUs.  Columns that dump raw MSR values simply show 0 in the summary.  After the system summary row, each row describes a specific Package/Core/CPU.  The system summary covers the CPUs being monitored; see --cpu for CPU selection.
 .SH COLUMN DESCRIPTIONS
 .PP
 \fBusec\fP For each CPU, the number of microseconds elapsed during counter collection, including thread migration -- if any.  This counter is disabled by default, and is enabled with "--enable usec", or --debug.  On the summary row, usec refers to the total elapsed time to snapshot the procfs/sysfs and collect the counters on all cpus.
-- 
2.55.0

