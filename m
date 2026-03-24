Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A612134C815
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 22:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774392054; cv=none; b=EYyWWovRTmT+pVx4ZtreOsEZuqurHl9tkZ07YBUMxSeVmk/wRQM0bwEwFvNf9rJuBXMsKDOsWR+tYtCM9Kxt7VA2BtvSuqWRgvwifxgA5IjUUK9LQHAkAWqFI68iCk7tu8choPWyT/7/pwhnxe1VoJtVIRMU15bp64ZX6l60i+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774392054; c=relaxed/simple;
	bh=a2mqwOFJ2nF2nsLyaAKHrVZJrRNEwH5GrtyyVfV8EEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aGrx9Ko/P+m6OiGuIGOLhrZasy8W4G7ydua2C+bwpvf7TVgWq2FjIQ+yMjH0MukQf4eWUVmHcngYAwJGAMOOxyCUfWZky41CDOWXrwz9zrjdXrMG/qmtLxFWqhp4IsDdUoQBuSKT/kBTdOBkq/GPjQ9q1yHf5qENewwrZeWUDjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it; spf=pass smtp.mailfrom=r-ricci.it; dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b=X3/0EGel; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b="X3/0EGel"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-ricci.it; s=key1;
	t=1774392051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BrBIR+Ywcksbmd2rSJersbN+vcoXft4ANLyGK0uIq9Q=;
	b=X3/0EGel7iJ3PU9JXFdJK88VVKAlEtqxo6uFtc8BBU+tzSlHHmNoXf54nMAmEk48j88wtR
	zuKnyHK5Rjk0YKwGjUATTRA7TJA865g4bcRf3jllR4wEQZSPeKKuTwI9fKAhbKRodyYTla
	XRPkGa5rs+oin82ZZhbJtaTIJUCcJLmVcR5x/LsiCfTgsOOWCY5jcgjkDZRZc2mtSRucu0
	5TfwjT8+tt8X3qjm0tR+8LbpIri7YPe8yLv0+NWL3BzRYWEJcOwtK1mlG90idnbhLVXc7T
	pDtHDlb5MA+gGV/6SgSD4mUC/PywZ9KafboWDO3SfXfRF8IEMo+Kz/sAScpJYw==
From: Roberto Ricci <io@r-ricci.it>
To: Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Roberto Ricci <io@r-ricci.it>
Subject: [PATCH v5 2/4] cpupower-frequency-info.1: use the proper name of the --perf option
Date: Tue, 24 Mar 2026 23:39:02 +0100
Message-ID: <20260324223921.14317-3-io@r-ricci.it>
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
index 47fdd7218748..1173d4f31e69 100644
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

