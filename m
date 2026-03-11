Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95D03A75BE
	for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 23:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773272596; cv=none; b=o3Cu5DTxxtdpo0SanF7qyqzJVOoRsunJioM6OGAEvUByDmnrQ1uTEa24rnjX1dI0hIkPQ5FlyZkK8Ec8VYzbACFRo22CU7K/GXe6EICTKr21d/G0E6FaxayB4wJO39r9nzfKzlf32uBvrBc0QuT4RIg5HxgNlITMEYaaBrbF73c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773272596; c=relaxed/simple;
	bh=o8m1v3JNpN8dDO+7+GDWpX84aC6h0KhybiodB8RZuM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EkqHnaCgq+ky8D+hq8rRDV5l5Cx1YVkVUgJ3DcpyrNOuRewsg2jwHVDsL1CuQEQ9D2rabUk6/URpeusZQ1KhRV4lzaKREjn2jf2FIFgnNVOyuxoyw80Y2na5knsR4hTPhlm91A3yrBrmkfN4faqpCky3hMgR7v3lUFRp2+kHEN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it; spf=pass smtp.mailfrom=r-ricci.it; dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b=KK+DGQgC; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b="KK+DGQgC"
Date: Thu, 12 Mar 2026 00:42:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-ricci.it; s=key1;
	t=1773272590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PDwtBjDbAIfUf2ENbKaakzJbnlw7BsD5UoLNp5aAZWw=;
	b=KK+DGQgCAZQNbBJeoMWaKwlaltwOsjb+sDjAFETlZ62cmRF4npvOeAOHUlvnaTuzT4u4sL
	TI7O8gbK3Nqbi50JROeUEaQLnBbkjLmwJLXpFm7pXbV5+P59XdTfp7+OUi6rsrHNRFkm7G
	TjHvzMUFhBKp38tTY8K0/FF5NUyDRVrKYVrTgHKMhTVNaLblbnujqeszrktPHDndBFpgYA
	hN/Iu/2sfNXGDnB/PgstNQAOc9pZGhRrUe3/Y1qQIWTn1Z3Nrwce/XeCjOijnI1Hsje06s
	MvEW/hTndRWqwZ5Ej3ieyqo+Si6hnaZ5cbwypvNzfJTEJ914EfXwzn5tETOEPQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roberto Ricci <io@r-ricci.it>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Thomas Renninger <trenn@suse.com>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] cpupower-info.1: describe the --perf-bias option
Message-ID: <abH9_Jk-ckkJvsGb@desktop0a>
References: <abHAkgiPg8VDpDoV@desktop0a>
 <b86a7991-3919-4efd-b366-5a8652c0b8a3@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b86a7991-3919-4efd-b366-5a8652c0b8a3@linuxfoundation.org>
X-Migadu-Flow: FLOW_OUT

The cpupower-info(1) man page only mentions the short form of the
'--perf-bias' option in the synopsys, but the long form is not
documented and its effect is not explained.

Fixes 7fe2f6399a84760a9af8896ac152728250f82adb ("cpupowerutils - cpufrequtils extended with quite some features")

Signed-off-by: Roberto Ricci <io@r-ricci.it>
---
v1 -> v2: improved changelog
v1: https://lore.kernel.org/all/abHAkgiPg8VDpDoV@desktop0a/

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

