Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107163793CB;
	Tue, 11 Aug 2026 18:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786473682; cv=none; b=anEJu9I6zqPMaat4sNWuo/ljuY2F1yCVLtI2PtYfQDmSRiQZMKHdVrJsGqE6OJ8AlNmIrKu+QxUQNaBkMoFjasPpa6yscHWpOeCR3FlYcKpGfVIUyX/BoPDAEsN+4ulNZYuTbxI7Gwmhmso+YubNj+yb3ZwR7lQujJEveq0vFYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786473682; c=relaxed/simple;
	bh=Kv/f1xRUZL2bJpy0m72H7S7xuk4Mdic9fN5C/PCBpHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DVk2A+LZqbC5yA8FA5d5053YMMvun/oEI44hSUf239/Nfis5aR+O2e4PH17cralc/oZDOrpezZePJjWERKrIy0O9on4RRPz3fakF9qYw59lPDOc8ojbkIuzlrKV5qkQmE6gyRVko1qfqbk6ogs81TQaXbCWcPYdhMF9NUZyLZxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=CmIjmomm; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="CmIjmomm"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 100C640E019C;
	Tue, 11 Aug 2026 18:41:10 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id OZIfE6nLOAUP; Tue, 11 Aug 2026 18:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1786473659; bh=wPTllTP5QNIVK72ZOaCjpchNDr3c5E2LVVR069Q0vBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CmIjmomm7rMzDqIhVe+Qx9aVdeVndHCCzG3Rthh805mDt0/r4d4AVWFDFZ7IV1SBX
	 Dn/MytSzTJAaNv73GLNfzjPcHn++8mroykoCJFtPEcIomrVaeNOycRmAZ0VSyVVNdc
	 U0WMNKsj6sPvLPVOaKVDBNLm9YnhKlWutJ8voCsMFRgpnkSibg9aqzS7psOF5JEm0w
	 zadNi2XFzDnYn42xDdDicMt14yYnG9XvC/AHxFG/tqkwIgIJ7kD7IWRKZHEwy1nSFo
	 yFt3wcd1eLM+NQ8ID2VYRCPqYptdsGQ7Yr+U1luxbQ+X2lYTHK6XKQqSVPX42TgGbN
	 NhJDp6KWYwPwkz3p5vs9zj+XaSCL7KrYkcMmiuTFRzotokazl5wLe54xc6RH07zBUo
	 L375Dr36HFj9Lry24cOrdwsDgZiByXTrY2RqxTuDDKkm+RYn+O00XzdwDtvOR9/edM
	 RsoIMHInfSHidtdhjrAP1xgTTlh1rCUhHPhMlOqhwXSuHGQM/UgdWcenUVxTS23rKT
	 Ae0JHWHmUU/c/K9wlT55oiaPjVtTsiv6CeuYARg7/tDY8kOn6OS+0OXQ5fN/IuUB9g
	 3UnOCtZyo+YqnwOS5B0268pT2hIFlDXbznRTuaDWFZoKfHLO9ynIzxgK+kVbQj2Ebp
	 lDgGYpOHX2oh75QKVLfgAsi0=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3439640E00E6;
	Tue, 11 Aug 2026 18:40:48 +0000 (UTC)
Date: Tue, 11 Aug 2026 11:40:44 -0700
From: Borislav Petkov <bp@alien8.de>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Sean Rhodes <sean@starlabs.systems>, x86@kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/pm: Save AMD CPUID leaf 7 across S3
Message-ID: <20260811184044.GAantsrA_ApoUksCiu@fat_crate.local>
References: <4430d02d34617dd2d3cb506202fe44d5e45c053b.1785838418.git.sean@starlabs.systems>
 <20260804184920.GBanI0MCMbnglz7Ncc@fat_crate.local>
 <CABtds-0MUDmxK_Vd_P8CijwzUhQEV4eWNzx1+DbN2wfnY4dbrA@mail.gmail.com>
 <20260806012923.GEanPjc0w24EdEquDk@fat_crate.local>
 <131d39d6-c2a9-4d80-99e9-526d347bf608@amd.com>
 <CABtds-1wb1zt4cP9jrUhivRZKEqG6Geq5XtK4j3R4hr-6nMkfw@mail.gmail.com>
 <f4ec6830-6d7e-47a0-8839-f7e50c8bcce9@amd.com>
 <20260810213309.GDanpDlS1IcRhHKyWK@fat_crate.local>
 <95a0c1fc-4556-4f82-b488-90c5377737c0@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <95a0c1fc-4556-4f82-b488-90c5377737c0@amd.com>

On Tue, Aug 11, 2026 at 01:25:27PM -0500, Mario Limonciello wrote:
> Well the fact that they could also reproduce it on the CRB with UEFI and the
> latest firmware tells me it's most likely any system with this SoC and using
> S3 for suspend is affected.

So S3 is the problem...

> I guess the same thing might be doable in coreboot ASL handlers for S3, but
> I don't know how well that would go over with coreboot folks.
> 
> They might say "It should be fixed in FSP" or "It's the kernel's problem".

Definitely not the kernel's problem. The kernel gets to fix all the shit all
the others broke.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
