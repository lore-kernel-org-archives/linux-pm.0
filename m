Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E51429825;
	Tue, 22 Sep 2026 05:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790053869; cv=none; b=NymhPBtTY17gFPFCTlmTL+NktK+7I4aG/3I1Euu0q+B6HEFoA86Tko86M+fkBVBiiXX2ZqCfHaVaCV3veg2ufk6YMnEBpZWbq2YQBf8KgRWAzH7mhLem9q2PUp4Mx2YOMKjtghh6uQGpnUYNDxyJvA+605TMhGsQCaW8jdNvM8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790053869; c=relaxed/simple;
	bh=+rOLlOcSnTuhGolRvrYiCHv46Rgbvvy135eqpmo7aKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UVMEzJdADZEfv+0zd6fNLv8wrAiJIjHwzu8qEZePepJl8XkoeSoWG4f4YokB3uOqxxY0Hy3wA82jAJLyn0u1xN4XS38a2EBdzsHQhmNycNAysEYOQprWnzUh6oUWTdW0bqx720vRdlwuAEwMw1qT1VnbiGgkg5s6pnkqrf4bNkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=agc4q3v+; arc=none smtp.client-ip=188.68.63.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="agc4q3v+"
Received: from mors-relay-2502.netcup.net (localhost [127.0.0.1])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4hpp8M14Sbz6Nb7;
	Tue, 22 Sep 2026 07:10:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1790053843;
	bh=+rOLlOcSnTuhGolRvrYiCHv46Rgbvvy135eqpmo7aKM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=agc4q3v+peuu8FcSl7YvGQT+gGnGjdR2Iwq5IGGaf3fq46pRICiA1kkUmX/F8LBMQ
	 tiyUEzOeXiAa3phinZE9rjLUgFNr8P/aeol4P4IfMwYEdiKlqDUp+DWJK6alZTKWBV
	 XlT+n6pYPx3X6OVX0NHMzBb8WArje/497mMKP2WeaqgGkgA7pCsbNHYb6Y1dXJwULS
	 PUj8aI/iea0jzUc+sGylCYSr+UJ9+xa4HUdzSqUnMX8+L2dN4FYAY1Daw+7Z3zY+6z
	 cKLmHJYfcQKs884cMSa0vG5BNYJmQoXQqzbBvRoanRnNHxQ0023dIVajY5VNca3M4e
	 ctgpSAqPt9RuA==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4hpp8M0Kkkz4ybD;
	Tue, 22 Sep 2026 07:10:43 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4hpp8L0xWZz8sbH;
	Tue, 22 Sep 2026 07:10:42 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 1DB055FC2E;
	Tue, 22 Sep 2026 07:10:41 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <1d25a149-8f00-4d3f-8b5e-56943a9bfa02@leemhuis.info>
Date: Tue, 22 Sep 2026 07:10:39 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PM: hibernate: Freeze kernel threads after image
 preallocation
To: Florian Schmaus <flo@geekplace.eu>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Len Brown <lenb@kernel.org>, Matthew Leach <matthew.leach@collabora.com>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 David Lomas <david.s.lomas@gmail.com>, Hic Haec Hoc <h.haechoc@gmail.com>
References: <20260920-fix-hibernation-v1-1-f9940c2d7d7f@geekplace.eu>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <20260920-fix-hibernation-v1-1-f9940c2d7d7f@geekplace.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: 
 <179005384163.4132640.15499112207501133857@mxe9fb.netcup.net>
X-NC-CID: Uhis3gRudamMTVFkNuULSZleteeot9H2AYWWqpJyf2lwR0kA8xc=

On 9/20/26 16:35, Florian Schmaus wrote:
> Commit 783c81098445 ("PM: hibernate: call preallocate_image() after freeze
> prepare") moved hibernate_preallocate_memory() after dpm_prepare() so
> that device drivers have the opportunity to release pinned/unswappable
> memory during their ->prepare() callback before memory is preallocated
> for the snapshot image.
> 
> However, that commit also placed hibernate_preallocate_memory() after
> freeze_kernel_threads(). While it was assumed during review that swap
> I/O submitted via submit_bio() is synchronous and would not depend on
> frozen kernel threads, this does not hold in practice. Calling
> hibernate_preallocate_memory() with kernel threads frozen leads to
> intermittent deadlocks during hibernation.
> [...]
> Fixes: 783c81098445 ("PM: hibernate: call preallocate_image() after freeze prepare")
> Signed-off-by: Florian Schmaus <flo@geekplace.eu>

TWIMC, there are two reports about hibernate problems that identified
the mentioned commit as culprit (in one case while a stable backport was
prepared that was dropped meanwhile). One of the reporters mentioned
that the quoted patch fixed things in 7.2.y (see the last of the
following links):

https://lore.kernel.org/all/CALjEBWT9wyBYtWPgtg8Xd_FxRU_XnatzQMcwMB9_P2Fdj83+cQ@mail.gmail.com/#t
https://lore.kernel.org/all/CALjEBWQo0-Sdimo+aRNKUQvgDGw=jBFCcfwCXaqVdtoPrHLAQA@mail.gmail.com/
https://lore.kernel.org/all/CAKp=m=DkRA3FQdJC+1AKDtn1X8ZuO0HRF5H7PJVf15uQyBuEbg@mail.gmail.com/


Adding a stable tag would likely a nice touch.

Ciao, Thorsten
