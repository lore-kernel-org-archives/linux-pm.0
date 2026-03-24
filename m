Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950B13750AB
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 01:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774316183; cv=none; b=f9Xj4Q62SFkiX08FkLWwToK4oHZuE0dbdrfmbledAy9OCIvy/uFaP3DhYpUDflB+Ss3I6K7c81bv4dxSBYklnbZbj0KuuSx6QGNYFx8Hab4l6UoF7bX3N/1O5Ay26XrU1NIstW9YhHCb94GtQsxT/6m3VJ808e/b1XgQ2SZLS8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774316183; c=relaxed/simple;
	bh=Y5BcBGtNUQLVYQs3QRDux4aVEbLP0dNAyrhRkmk5nfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ejFXsV6yHfnoK0FX6XoVpflZwB557o++j35syE3bjPK3cR6AaRTVnoDHPQfzVa4FOHAK+c1MoLgPI7LV6AH1tWv5zo/Ok0eizrJQDK4GQed3JG798cTXavzAInfWTVsz5by+k+KJWvCkQmT2g5NBkasLPBY80UYTJBOoiqMJ1QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it; spf=pass smtp.mailfrom=r-ricci.it; dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b=X49awb2O; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b="X49awb2O"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-ricci.it; s=key1;
	t=1774316178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v+yK+9OINSKQwlx/h5ZhN8aAxMviN5G+FIJiHwexRSI=;
	b=X49awb2OTv2O35HrkvB/Xse0dQjIGyZ8iLosjXZbP6raIgwS00tB57EbY0IaMMJL3Bw0un
	scroOpf/tjafdZ9lek3hFxTuzjqVG8kj9GfjDuadSIsP6OzFW7kHPZPKwctsE+OaKIp5yb
	zkTwEtaYH66BL0fGz82z+pL8Ot35HYA5PgpeoyS71Q7cHNIfpIqPeMjWqiTS52YcSf5XkC
	CO2WGA44LHSO8UPk9G0k+V1IbjdphWYFvxphJqLowUM8iBO8L9jR+nAbrVwtJ+cnGZjR4q
	doinZDwZecI3edmEPH60DPNMfLkFZfPJjmNpkRUaYN5tIGU919nmELtVwNvROQ==
From: Roberto Ricci <io@r-ricci.it>
To: Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Roberto Ricci <io@r-ricci.it>
Subject: [PATCH v4 2/6] cpupower-idle-info.1: fix short option names
Date: Tue, 24 Mar 2026 02:35:39 +0100
Message-ID: <20260324013543.4776-3-io@r-ricci.it>
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

