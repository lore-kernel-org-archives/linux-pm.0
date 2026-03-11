Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA113A75BE
	for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 23:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773272510; cv=none; b=OL59mDANeR1DpvFD5P/LWagjTvXDGpAAJqIJKxa0/JIYSzG22eni1HaVu4HYYOMuHMPdA051spKoFTXipRlJIb0YYae3D61XuEYkleAXRPnrtQUlxfQje8wzuuYHFrURTMKg8IMQRSAJBzCIsmtoGvtE6lyLyRVQr8mKPgmarp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773272510; c=relaxed/simple;
	bh=PORP953ErOsCms4ACaLyrWjw6kNE0lrPnCqdbcm9Ib4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tVsFhFFyNbhKCI0bGmGvtMgcNanPTyLwe18rpdTJ6b30oOiGRsQS+3d/xUtbY+tMEkXhZRl09xDUoAhJ1uLK3J3WAn+GZ2a7tJsgDQKhM1xt+hLNrISCTzeI2aL524CYIM7pnF/F7QFNXXdO2LwnbHHQFuvEYZwtjbcLgJcbdJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it; spf=pass smtp.mailfrom=r-ricci.it; dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b=Fs5td7CF; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b="Fs5td7CF"
Date: Thu, 12 Mar 2026 00:41:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-ricci.it; s=key1;
	t=1773272506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HKKkmH6HUdyQQUxCaIhsyFiGvcYxMQprKELK+/yJQvM=;
	b=Fs5td7CF2m9vtS0r0cG8RU9GO7+/5WR3oznDKSbo8srgo9G55+RhnZ6T8EUBz7pM1Dcxks
	looxFkcS2IwP1u8q1zvfnwOwxqyK0ii3ju19aeGtri4NAd4fcgGOEWYdnn64XNt7uG9mhT
	Ka84QuXrvxb9a7z5T2B8sM0AuWVR+0/meJDeO7dJWVNhV5bfxFI9FvD70ZswepUx1ma5nd
	Upd2qtba7KYHzRmN5YPK7rLAJn44hHRQvDXJIszut0O/+5yneidUPxSsO/3hX+PyY3/YWd
	p1fpFypyPsoNkkgrGkdiDx4pOqQIDYbeFJZGnoPNk1AVaHQHV3t0kqksTNZlww==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roberto Ricci <io@r-ricci.it>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Thomas Renninger <trenn@suse.com>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] cpupower-frequency-info.1: document --boost and
 --epp
Message-ID: <abH9rMVuy8wmzgkG@desktop0a>
References: <abHAhAg-6gaK0Qn7@desktop0a>
 <c3fd1b01-0184-43ef-9739-f523650cb6fb@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3fd1b01-0184-43ef-9739-f523650cb6fb@linuxfoundation.org>
X-Migadu-Flow: FLOW_OUT

`cpupower frequency-info` supports the '--boost' option since the
program was first added with commit
7fe2f6399a84 ("cpupowerutils - cpufrequtils extended with quite some features")
but the man page lacks it.

'--epp' has been added with commit
5f567afc283f ("cpupower: Add support for showing energy performance preference")
but it has never been added to the man page.

cpufreq-info.c:
	{"boost",	 no_argument,		 NULL,	 'b'},
	...
	{"epp",		 no_argument,		 NULL,	 'z'},

Fixes 7fe2f6399a84760a9af8896ac152728250f82adb ("cpupowerutils - cpufrequtils extended with quite some features")
Fixes 5f567afc283fc9e7c6a34d013c4fc6c5e8d6afae ("cpupower: Add support for showing energy performance preference")

Signed-off-by: Roberto Ricci <io@r-ricci.it>
---
v1 -> v2: improved changelog
v1: https://lore.kernel.org/all/abHAhAg-6gaK0Qn7@desktop0a/

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

