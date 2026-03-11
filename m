Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D803A75BF;
	Wed, 11 Mar 2026 23:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773272379; cv=none; b=dxHcbhw/kYbXe8wbcG5pY3yAnEOd8K2pnuL/gSgsEUzitZsIvLDOnwXTZJPYbFCJbEkokU6e353PdbdY9khEqdO5qdkYlmRB/sD2F/xwKt7dDN0hVaWiAEAUY95ldd5weoolSGni6LuhnPPQmR5/SGqgwL7zOXim8/TotUJHyCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773272379; c=relaxed/simple;
	bh=iOn0ddLw+38UCMnSJ83CcGQxyIyCE999orXzNHXZQcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TuSSRPobZaXwhi7/EM93CnN+DA3b7ZujtQrO0X+yYVSMbM6JgSSJV172tib/YHgDx35pajn04ZzDAtsCLIksuNM6OH5YLfxii97OVtK7s5fKq3K76smr554sR7aThtxk0JHX9pGhiUSd46d9GdbLk1VcRszLkjVgGyCskgsocd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it; spf=pass smtp.mailfrom=r-ricci.it; dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b=sEB6K7M6; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b="sEB6K7M6"
Date: Thu, 12 Mar 2026 00:39:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-ricci.it; s=key1;
	t=1773272375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BwP2mV5YpE7AmxXs1Ye7gaHLCttZIuyqLwbmB4bdbG4=;
	b=sEB6K7M6jqXTBlUVgGeRJcEWBvOACRO5v4pI7T5ZNcJpXkjNra4IYDPMoGf1sFeGmGTXjb
	k49MZfOiNf1USpvOQXQ5+5BDBoY54ryGGUA7Mip8lbP2hu9VDg3cwVObxDbELyLnAAW3MI
	tscxMkFnDLsGiCvZ8vHBJ6hs3BeRNIewmXfUuDaL3+piVIPjKf/ZCdVtpevof1hCEtoZor
	SogpmoywylraAb5e1nzipHQPI3H/xD5qlKMbC4ZctkaxoEGAt92nbM77dD8JdPF1bAzmSm
	5AYnv4kmmkhhvuGyuR4SGPEyFHx1Q3R4qmWdHRzdNZjHe5a950nsP+mdTboBaw==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roberto Ricci <io@r-ricci.it>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Thomas Renninger <trenn@suse.com>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] cpupower-frequency-info.1: use proper name of
 --perf option
Message-ID: <abH9KsKbvyi-iceb@desktop0a>
References: <abHAdH-ggaxUugCy@desktop0a>
 <d7def94c-bead-4544-9208-97e6f0d07483@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7def94c-bead-4544-9208-97e6f0d07483@linuxfoundation.org>
X-Migadu-Flow: FLOW_OUT

The cpupower-frequency-info(1) man page describes a '--perf' option.
Even though this form is accepted by the program, its proper name is
'--performance'.

cpufreq-info.c:
	{"performance", no_argument,	 NULL,	 'c'},

Fixes 8382dce5e4835c045f33b8958a5f559d212cdd11 ("cpupower: Add "perf" option to print AMD P-State information")

Signed-off-by: Roberto Ricci <io@r-ricci.it>
---
v1 -> v2: improved changelog
v1: https://lore.kernel.org/all/abHAdH-ggaxUugCy@desktop0a/

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

