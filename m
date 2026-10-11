Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFBE4349A5
	for <linux-pm@vger.kernel.org>; Sun, 11 Oct 2026 10:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791714215; cv=none; b=WKOINP+6WOO3CfCRB2Cg2y4ajI5ZCFR1t23JgYq7HXFjqvK8yEgk2a1SxIPyfaSeqjEN1zZ9T/biOcJPU/E3Pp1dtOK3TUkU9V59YpssOTbGacDDzUeSdbvPUGJ8CcDh9pTM/9avRaPveRLMmBnj9S8i/Juiv7N7mjPEbgTDhnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791714215; c=relaxed/simple;
	bh=vpW8/KkGJ7bWQM1agx07Nvt0sF65rPu6xz06pQZazSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjMLrZi35Cvu+Uu+o96NtY90XEMx70lZhsYvkADwME09G9KGFvmHwpPzBXk25qWSK+2gznE79gTUTUK7AuPS0keQz+ZfDq+x7G5Ubp3Wm6jr0HuieRBFZCT9lK3H38CpPQcyCucH4VK7nHgZ618b0nZkR7E+AMbOYSneVjZV7TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org; spf=pass smtp.mailfrom=cavan.codon.org.uk; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cavan.codon.org.uk
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-3ab33730821so509446a91.3
        for <linux-pm@vger.kernel.org>; Sun, 11 Oct 2026 03:23:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791714213; x=1792319013;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GCrU7gKGl9q2lr9szhaNlgI07chMKDnbiy6n8axucp8=;
        b=wAxuQP97vee/UXAHJjN9y3hEGrn8VxnluuASTOLfZddK2krdVHfMiLGjLdGtIe1ldO
         LA9IRo0FGyImMN6HMb0z+FrKiTSQvpGWxbyEBSndXdAMEbMmW13Eo7fS17vBJDtdNESl
         Sr5tJG5UYzVY3L0SOGCT5I52u20l4/GZWMhJtJ4BWHoTb7m+M/3nc5FeI3uZhgkSMEe7
         uHvIZBtHeHZj6OYFN1eqyiqeKPG72z3ByG9Sk/qLg0JaaRb+8cvHgx1PmMzE/zNDOSC9
         RKp0OyXbF32IAaloco20+2zcl8gGF4EhC7T7+zg7/czuNV17iuGFtqWdIn1AKlsH75j8
         nWBg==
X-Forwarded-Encrypted: i=1; AKwUvBy/A6MZYY24LafQuCxAaP+hq12PuAnRreksc/h947KezvfwCxbsF9S5ikrdSzD9ByMFWRNgEixesA==@vger.kernel.org
X-Gm-Message-State: AFq9FYL3syx2iAN5ujC4XmXV5cXBIntHz3U5VCd1aKrJdCKgMHQVAXml
	0bAaX+O7HOPFocSJdtLPsf9X4bWWoGB4ygdAH/eKa+xZWX3ATZE5Xajzl7/OxydzYEKi5vQQfIM
	jo6ppTsJN2WWlCJ8Y3lCKIo6GvBZ3Mf/1s2Qk1lon4TyAeZ0u6yGB
X-Gm-Gg: AYBFou16u5GrcAaYmiO8lkUi6UrmVawc9o01WQ956fqsqxi4oVFnMeNx1SlDknZtB8k
	apSIkvXEccJpsqd0CUWUECh8dFWiF/pMy1R/+JlxSLQEVaAIZ0Je2egPw0/0nrxIYY49kpKeT5C
	PgjbaIe53/7VqmoKI9x451sqes3bFKTbmDKNOMuYK5BUXGfj91UqsD4QpAk0YurWBm+yei4Xt+r
	DLyrGHecqUzSSjaGe7PmzX0oPogd8pgnJKjsojZP3gH4wMf0BJzQwzrc3AFLwG8NYkhRSoc/ApR
	AK4J3OtsquBXGdJPI8Ut21tDMr2nQ+1Iw2Ab1Ikh7hxIt2zKOTlUKHgkCXWot4BAL6ne+wZfn21
	iUxc=
X-Received: by 2002:a17:90b:2d86:b0:3ab:3437:554f with SMTP id 98e67ed59e1d1-3ab3a746d73mr5664315a91.29.1791714213229;
        Sun, 11 Oct 2026 03:23:33 -0700 (PDT)
Received: from cavan.codon.org.uk ([2607:f598:b99a:160:8a88:88ff:fe88:8788])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ab36d3f9c8sm4193873a91.0.2026.10.11.03.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 03:23:33 -0700 (PDT)
X-Relaying-Domain: codon.org.uk
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
	id 6F3CB18A4492; Sun, 11 Oct 2026 03:23:32 -0700 (PDT)
Date: Sun, 11 Oct 2026 03:23:32 -0700
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Matthew Garrett <matthewg@nvidia.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, rafael@kernel.org,
	linux-pm@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH 01/17] tpm: Define a kernel-owned TPM NV index that can't
 be modified by userland
Message-ID: <astjpI65VOyU8xvI@srcf.ucam.org>
References: <20261008132532.1155166-1-matthewg@nvidia.com>
 <20261008132532.1155166-2-matthewg@nvidia.com>
 <435907614242e82ecde1767a967a3110fca6fb37.camel@HansenPartnership.com>
 <asqthz69ohnMVCye@srcf.ucam.org>
 <059384e86fd256618498b9a7214b6421d38fdf1f.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <059384e86fd256618498b9a7214b6421d38fdf1f.camel@HansenPartnership.com>

On Sun, Oct 11, 2026 at 08:04:27AM +0200, James Bottomley wrote:
> On Sat, 2026-10-10 at 14:26 -0700, Matthew Garrett wrote:
> > Does your log replay correctly for PCR 5? It's *extremely* common for
> > the extension to happen without logging, since logging needs to be
> > done  into the late events table and almost nobody got that right
> > until a few years ago (hence 
> > https://github.com/google/go-attestation/blob/master/attest/eventlog_workarounds.go#L70
> > )
> 
> It seems to.  This is what tpm2-eventlog returns (edited only to show
> PCR 5):

Hmm. Well, that's irritating. Which year's XPS is this?
