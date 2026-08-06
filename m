Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87A53AB276;
	Thu,  6 Aug 2026 01:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785979793; cv=none; b=BNArUACpy+I3Viq8r4AhrfjtSpaZkEQL19qEgOk40JJwCOrZaWk+/vUw4K+3yy0SYXcu/NncK+4udZ9B5ve3a4UIoQgUr6W7jWVAKGs3h7PhG22GxLw0+v+vpGck2j/Mhre+DG+8rnM+951gT9qQIwckO6cfYSiC0ThWNI7pWX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785979793; c=relaxed/simple;
	bh=S/vyyWHxN0aN7c8ftIPqtyuYeXSHqn36CXUtWmlf7IM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8I38fg7I+1iD9Ykb3QoA6KpDfo/7zHLVLrtrqYFIVXhVhbuQyeH05sApR/+30X3E7rakzi9eGB9X5Qcad9JGAvR2aft6PVcr29TTNb6X9O1LgJB21z0p8Yuwo1RCUiZEtsNhdFQo8Fq7sdvqLpPhL3eEuOFPVa5PuRcj5wWJtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=PodMyj1v; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="PodMyj1v"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 84DD540E014A;
	Thu,  6 Aug 2026 01:29:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id LO0WWIKgXmpV; Thu,  6 Aug 2026 01:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1785979778; bh=g8glapblhe9kAqAMQCy3QhU/vfwtt8CitLSevT1goH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PodMyj1vOGG4pk4uDqI7MREraNd7OoL2a3ugMKbuLF1GnfF1+QM1H7tD1IhOoKTA0
	 J4WQhWA6OsKIUdDTVi9tbX5kriq6Q3a9O52mqh6fltjARbt5m4huQ52+OKnX6VlX4n
	 IXGx2hK5+0z5pUNZ+cNT96kz9uubO2UdpbrvHYZ1UQyRYtqdElF1ILF6JRYPA4q3kC
	 t+Jf0go3BPzTXb1KHbJ8yBh457U5pmYXDyDis/8IFe7FwBlMZ+KUcfwvR5wLzPjNSo
	 JmTCnjNX/b/UGso8LqgH3qeB923O6NSrNZNGIH4oyxnLVEfgE79Yu1PDLxotKm4n/1
	 /pySTYYRXZ2lUI74ZvSyKUIJxAOHYYkPowR0YlVN5EhdLTtBaid4m9+y4ux/DFZIjx
	 jGm9PhZ453SU7g95nzL1V8H1sA86eT961CZ+zh/9lV1LEPgNm6Gj5CyFy3sNW2704U
	 5i+gcwSQtwGmTwYxI9XsF/f1nDypX/x6/hPRuyzyMNxxaHsudG7cXCZe9H4m1LbT9w
	 k9QNGrB/MepkJJpi2dbCdCXfgunqFBYy/M4WCu/ZjyIBe+xmvi464fEXJATlkObrMf
	 +3TQtBCTSh2cJaXpAQl74AP31Z6LMq91tivFWvlLkzA6NINzmqrtAN7WqeERTK2QVF
	 ylRala7P6hDpuOg3Y8EGBcKQ=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E310840E00C3;
	Thu,  6 Aug 2026 01:29:26 +0000 (UTC)
Date: Wed, 5 Aug 2026 18:29:23 -0700
From: Borislav Petkov <bp@alien8.de>
To: Sean Rhodes <sean@starlabs.systems>
Cc: Mario Limonciello <mario.limonciello@amd.com>, x86@kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/pm: Save AMD CPUID leaf 7 across S3
Message-ID: <20260806012923.GEanPjc0w24EdEquDk@fat_crate.local>
References: <4430d02d34617dd2d3cb506202fe44d5e45c053b.1785838418.git.sean@starlabs.systems>
 <20260804184920.GBanI0MCMbnglz7Ncc@fat_crate.local>
 <CABtds-0MUDmxK_Vd_P8CijwzUhQEV4eWNzx1+DbN2wfnY4dbrA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABtds-0MUDmxK_Vd_P8CijwzUhQEV4eWNzx1+DbN2wfnY4dbrA@mail.gmail.com>

On Tue, Aug 04, 2026 at 08:22:36PM +0100, Sean Rhodes wrote:
> If you're saying that because there might be a firmware solution, I am
> all ears, but this issue is present with AMI CRB and coreboot+FSP -
> hit a wall trying to fix it there.

I'm making sure you're using the latest one which might potentially have
a fix...

> Why not?

Because we're not fixing three things with one patch and without a proper
justification for the other two.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
