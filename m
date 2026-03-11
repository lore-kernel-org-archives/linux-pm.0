Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCDB313E00
	for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 19:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773256841; cv=none; b=mOdUddtsWdnx1IXHNrl5XvUxJr/whlFb/+vsuUOZC8MRjO3oAK/6xRuv0ZDlmLGgcgB46h6Cc33V0ajNv/Nbfk0oohhgOvyEwNTSvyGmI0GLtp6YmK36iDnPpKiQatdxHjce3JZh6UI0/9TIRHpK7a23AHY4/tKwQEPBVYwLJcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773256841; c=relaxed/simple;
	bh=yghs5fvKxsGg7fw3o/fIRIea3nWaKBtpLs2eu1Sr3tI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bban1Kre1p3X3HM1FmWsM40zMw1IDeDwd5WtE47klsYXWyJSiy1EMxF8zBcMBlk3lRozaJiFLJqWoMUblT4+4Wgc80AmQvxNMLmjg4/tn4sZNOXfbbfPlmLg1ayc69jaVFbmJ13oFHUKvUMEdufha2C+JhiTn8QBw6eFnXEvTwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it; spf=pass smtp.mailfrom=r-ricci.it; dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b=ZPrnH3Hq; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b="ZPrnH3Hq"
Date: Wed, 11 Mar 2026 20:20:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-ricci.it; s=key1;
	t=1773256838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=AUz7pfsAB75yDDXSi4tTMhvUm30e76VZdaXQkVJ/8W4=;
	b=ZPrnH3HqhCw4DuRs0A5oT7RPvrv4n2byYJy5EJHd+wMHOyY26xW8I6TPpD29WhecsW3Otr
	NR7fQVRFi9qGisfGfb+BXK5VLQU1ZmbG+CNfkRT547knuMFODXdX/Cq2gzERto576nCw/S
	2IVVVCJuYyUWCbVoNY36TAsB3/Hb5KjNuxRyjPo+W7nFtkOTgpbiKp6g64MVpwxFkvmi0t
	pY61Btg1CBjUxsAh/xJz6EW20jqj5G6j3v8PJbnYdRMRaSggJxpUBVY2nxIVvUf4e5auuN
	H5hRmA74FBB3e5YZgUJgRjaRCyRQDIlr71yqLyPdHZTQZKzgrpD0EPL+6DQQbQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roberto Ricci <io@r-ricci.it>
To: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] cpupower-frequency-info.1: document --boost and --epp
 options
Message-ID: <abHAhAg-6gaK0Qn7@desktop0a>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Signed-off-by: Roberto Ricci <io@r-ricci.it>
---
 tools/power/cpupower/man/cpupower-frequency-info.1 | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/power/cpupower/man/cpupower-frequency-info.1 b/tools/power/cpupower/man/cpupower-frequency-info.1
index 1173d4f31e69..1dc7536e13ab 100644
--- a/tools/power/cpupower/man/cpupower-frequency-info.1
+++ b/tools/power/cpupower/man/cpupower-frequency-info.1
@@ -32,6 +32,12 @@ Gets the currently used cpufreq policy.
 \fB\-g\fR \fB\-\-governors\fR
 Determines available cpufreq governors.
 .TP  
+\fB\-b\fR \fB\-\-boost\fR
+Gets the current boost state support.
+.TP  
+\fB\-z\fR \fB\-\-epp\fR
+Gets the current EPP (energy performance preference).
+.TP  
 \fB\-r\fR \fB\-\-related\-cpus\fR
 Determines which CPUs run at the same hardware frequency.
 .TP  
-- 
2.53.0

