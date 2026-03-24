Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1792F23B612
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 22:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774389852; cv=none; b=CDf4AEqBKVyC4VgpuFMD9eGy1AQrzCZtbarqFVHjv/4Ru+OmZkgEwrJnX59rpm72PhFY9WdOJDOhAsGT0DB+cBKN3QqpTFm5FvZ0QbtNSXwpBdMWvcCvMUDikNt92jkzalC2Z4LFVh4dhZ8RVPzXmPMxYU1voBsgopV7cH6LI0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774389852; c=relaxed/simple;
	bh=n1pR0LBakIDl0ye/9DaZl1o93v74ScpxgmLi6y7A7LU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nIlCZk5fuCHF74ELBJeEZsaw9AnMAmzpmNghaFY0sAf/HHYUkZXY/38vjhgepmK1bcmHXHJ7JtqBkDnvCVmGdK0coopKuvPcrgF23z8Nl8eZn+etAqi9Xf4rkC8I0uPDOqFluGgjeN3fLVq5iNmQLeBTWA7E177z+TGuPLSuc5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it; spf=pass smtp.mailfrom=r-ricci.it; dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b=CvtSrPC2; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r-ricci.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=r-ricci.it header.i=@r-ricci.it header.b="CvtSrPC2"
Date: Tue, 24 Mar 2026 23:04:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-ricci.it; s=key1;
	t=1774389846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5pQUWLfuaLXqFdgeKC0IoiIlL7YCLHrJwlXiT0xeGYY=;
	b=CvtSrPC2m70Hnc/zQkJsALhS4oM0KZpAz2xthz2Wgc+KOxd8N07ggz3B+3w574WDmhGP2h
	kCLxexut0eXyTG923SqByLVvEL82uOwjlFqHVOzssUlR37SB+dfAEXY2v3+c83BVWTgHtC
	Cdk9IJZoB9ZCZ5xAPI28tmqKcFcxUWKexi1oWVdk3y7DCaALehRqL2CIjVIAydPl7Fh2Jq
	uPcrBTihItupMdtxtP8BFmWYbuG0upbLgxlnkrUBhxEmjyVMpv8WSby2MqMl9o9/8BXUF4
	1itobBxd42vv/RtSMGbMaXTWz7pCOK32b0mJL0rUxI3z36nKbzvFDLCg/27Aag==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roberto Ricci <io@r-ricci.it>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Thomas Renninger <trenn@suse.com>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/6] cpupower-frequency-info.1: trim trailing
 whitespace
Message-ID: <acMKUXmN7BFDjfGu@desktop0a>
References: <20260324013543.4776-1-io@r-ricci.it>
 <20260324013543.4776-4-io@r-ricci.it>
 <f229ee71-4297-4fb8-995c-16e86be6e953@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f229ee71-4297-4fb8-995c-16e86be6e953@linuxfoundation.org>
X-Migadu-Flow: FLOW_OUT

On 2026-03-24 14:00 -0600, Shuah Khan wrote:
> On 3/23/26 19:35, Roberto Ricci wrote:
> > Remove useless spaces at the end of some lines in
> > cpupower-frequency-info.1.
> 
> Why are the spaces useless and what happens if you don't
> remove them?

They seem to be both useless and harmless. With or without trailing
spaces, the output is identical (tested with both mandoc and groff).
Since I added the new options by copy-pasting the existing ones and
changing the text, my patch added lines with trailing whitespace and
checkpatch.pl complained about this. Removing these spaces from just the
new lines fixes the error, but I decided to remove them from all the
lines in the file for consistency.
