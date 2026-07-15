Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9C342D773;
	Wed, 15 Jul 2026 18:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784138751; cv=none; b=L+uzQsAEisu9j1t9RljpJ20ebOEdAIo0JuOl5ylKtkMGYmZaR+WbcWtr8xUtwGTtFz7pJ215uBPGONvI+yfY/71XjLCtzR7ZOGfOnGZZsY5JcNQ1Qtprbyu/7INRH3Gbha7U4HMEgMy9V0GAi6yeZ2Ga6LFbN4BtpACkwZbhbCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784138751; c=relaxed/simple;
	bh=Bbu0AoXEPypL55FRNzTFD6vY/kta1OLRw8pIciAbveo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iq6uuyVEszkHJJqDnQdqENqLMFNGOihZctWqt9lenxun3Hd3TQ944hD4fxAjgMqcH29nMwNqliJHCp7nCyWeiZ1ygukbR2w5X6ovhEZVJjYoF8iiHFmBER2QTVF6EwotujZ0jsZAaQIk3xUnASjEiF8Sev5ovk6qpLcL9wF/HK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=GQRdj59C; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="GQRdj59C"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6730F40E02C6;
	Wed, 15 Jul 2026 18:05:27 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id mXd8q1GNxtn5; Wed, 15 Jul 2026 18:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1784138717; bh=/qAx7GI9cng+glhdJ+KFN/NEPsPTjrTfJpIfCZMyYao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GQRdj59CpJXfcsNM97BwBY+qYBM99zexm4CC4zhFlslewrKVUgmsmBSCrEGAXYTUI
	 lrWRPa6MJGJXMrbRiQbfc5ADbN4ny2b2ESeKjV0yGAPQWjbavCc8Pkfm2F1vUf2Gp8
	 SE0ECjyOxgWfm5Y1VHxploaNCYFp+7zyT5gWFZi+gd4cXM/kxPunrC7efQJ2LIXTWj
	 dj7enTUS+8/SOhTJOb3mEqp6XjWKJdPij2sxX/b/xvTJ/+OM+yPYLya2tkVt6QgII4
	 ZIUOoW7f7EoC3TVZtmlEa5v19ccZQMYEYpCVRk9O85kDqQAGswVvei1+QOtZGlnxFI
	 z9w/hCK2J8c46ERw27rRZja45MliDxi+fz1qEX2ZRzzCS5c56RqA2PnUH03eh33Vhn
	 dpWBs3BCHuryt+sAsI+MSF59oOsZyecKcoJTbt/eThO8khj8eokdeWUQEGki5lNhd3
	 0LLycpxENvQg0w6yVTidxEliGbUw7jy5DXb8TlqgtPQtRnKksVjDgfhl8KErgfrsXN
	 e6qb7nt4Nkj/izepXEjZAesJ4zfHQQPs+sH2MOiInYnqXqPmS3c/ciNLxBVuHGwG4L
	 nAUmxoyX7moE6ycOEDyXFpVLaeB7iERxZvImvH+E1yn1oOqMsBZRn2GVBCGChJ/Y8s
	 eIe/rrbR5ePr5rr/OWeBZBDU=
Received: from stx.tnic (unknown [38.92.23.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E4C9440E02C4;
	Wed, 15 Jul 2026 18:05:06 +0000 (UTC)
Date: Wed, 15 Jul 2026 11:04:54 -0700
From: Borislav Petkov <bp@alien8.de>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Rong Zhang <i@rong.moe>, Huang Rui <ray.huang@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Andryuk, Jason" <Jason.Andryuk@amd.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq/amd-pstate: Bail out early in virtual machines
 and don't warn
Message-ID: <20260715180454.GAalfLxn3Wyu-fRjoT@fat_crate.local>
References: <20260716-amd-pstate-vm-v1-1-2ac97d3cf6e7@rong.moe>
 <0c55d331-bf98-4e6e-9de5-35803ead3c0a@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0c55d331-bf98-4e6e-9de5-35803ead3c0a@amd.com>

On Wed, Jul 15, 2026 at 12:46:24PM -0500, Mario Limonciello wrote:
> Conceptually this makes sense to me, but I would like some comments from
> others if this is the right way forward.
> 
> Jason, Boris,
> 
> comments please?

We don't care if someone "passes-through a relatively new CPUID" - I am not
sure what that means - but we won't patch the upstream kernel just because it
dumped an error message in the guest.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
