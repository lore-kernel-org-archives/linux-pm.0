Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8114735A952
	for <linux-pm@vger.kernel.org>; Sat, 10 Oct 2026 21:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791667593; cv=none; b=iLGinvGao4CI/pztSRYobp6O4j9B6hWxWQrFOb6qgi8B1/8F+BTP2WCNL7pd6uMfczDSs+2QdVAZbX3ypmtcQQlcQ72OmAabeFVlX9uxf8eAAtQ67h1iWhoYQibaVdHNoEez135oWxadZKMDhheVcYaARqoBZ05PA9UJnqLYQ+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791667593; c=relaxed/simple;
	bh=cd6DBvfY/V0vH3X7czk1rG4Fa13vQUKczFzwYCCmz+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8a3Kysqa4BPssyavSffFH3pQEkbGC3qPojFDW5Wy1XMsj4NgDKWv+iD/EOfKkhyO8KMYXLe26rKilrQcmHQAw628TjfZdGIkW19t6Ggj++FkLUXLpkDIZFy4Gv6knyAR4H1Cbny/J/INRe+vlm6+shsEOB2/zQ5kciCkRpgr+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org; spf=pass smtp.mailfrom=cavan.codon.org.uk; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cavan.codon.org.uk
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-3ab450c0873so734925a91.3
        for <linux-pm@vger.kernel.org>; Sat, 10 Oct 2026 14:26:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791667592; x=1792272392;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xQ+BvwTajbJuDLtdFxXsbhV1xx7cCxJdnpKMHHdw0X0=;
        b=rRK4HQdtpThBU6bk9JQbU94OIUN4YzgGTYLoErxQw3zQ9DP6LpyBij+i6vDUvh9LoY
         Tp2z2SENB0geB6XH0O1NKA1C1qzuhPjCTWLGJoHnSdClTMXdj4DlG+ztqOLRsi7YNoq3
         fqIQh/J2CuLh8IZyjMXwfMd5QtyAjjoFmaIpAE+JgPaPAf0YvGSGyATa9D2QB6ShsYkq
         OQZEmJAMBeJned9+ahCgfhdNvvknflWptpga5blkcjBppY83IatNcSeQINstEn1zZDEC
         R1jcsjvE31GLOu363NryWf0PP6Gh/SoZMuPQ06oMD8dsxBjr1RNu7zgxf3rl4747+t8O
         P9/g==
X-Forwarded-Encrypted: i=1; AKwUvBwcHo+Kdw1Wm9uyudlo9pUt+giFpNmIX623M+7k9T3WHtXMowmzco/pWOzs7jUNSyUsJ30/Uvc9TA==@vger.kernel.org
X-Gm-Message-State: AFq9FYI0BuxW/L/2RLj7ekj9vySFDpbhXZcjihfl4JBUzbizgnYJYV51
	4uI9srUmbM4pA9lkA9YBC+AOEpz4DIFGANWb8LAw7yGLKsW/gbI0LAXyClcbRXz78vmPsqvvF6+
	pJ0oODw6BIOTiZsxwMYYuSN3GIUV3jVpzoYv4VCThk5lmpc5sE7Kb
X-Gm-Gg: AYBFou0IbYlt7F3Rum+zgvjivBbw7IFy7zDHov//8qVpIMX8DUqL2S3T0znIOfxafKT
	SI1xEf5JxUiqoBRYlv7X2j1vY/8nNMvseywo7SqnII6l5TWsQBSN3qKXl0nis7taU5ODb35YHrT
	YbTK1/KSrwmQ38NsRLnsPgayr5iiCeBcLuKcdcd+s8h691MNPL26Gu71UQE03PXuJ0lbVgAbM+K
	UckhkeDIcN5xG0xgbyZvlxq5x+cx7gBraUkGQ0XicDwZ9diHQqoaY93xVnmP6KdCYc+WOi14UXa
	Qif+bDmMyq4PdncqcCopiL3UywhuIc7E8eIt/b1Pnme8JfGZ+9OD3RSmjGaIO8chz9u61rtmAzw
	zuoA=
X-Received: by 2002:a17:90a:e7ca:b0:3a4:f75d:d194 with SMTP id 98e67ed59e1d1-3ab3a8ce801mr5220265a91.36.1791667591856;
        Sat, 10 Oct 2026 14:26:31 -0700 (PDT)
Received: from cavan.codon.org.uk ([2607:f598:b99a:160:8a88:88ff:fe88:8788])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ab39631932sm1330977a91.2.2026.10.10.14.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 14:26:31 -0700 (PDT)
X-Relaying-Domain: codon.org.uk
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
	id 1A99E1287AF5; Sat, 10 Oct 2026 14:26:31 -0700 (PDT)
Date: Sat, 10 Oct 2026 14:26:31 -0700
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Matthew Garrett <matthewg@nvidia.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, rafael@kernel.org,
	linux-pm@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH 01/17] tpm: Define a kernel-owned TPM NV index that can't
 be modified by userland
Message-ID: <asqthz69ohnMVCye@srcf.ucam.org>
References: <20261008132532.1155166-1-matthewg@nvidia.com>
 <20261008132532.1155166-2-matthewg@nvidia.com>
 <435907614242e82ecde1767a967a3110fca6fb37.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <435907614242e82ecde1767a967a3110fca6fb37.camel@HansenPartnership.com>

On Sat, Oct 10, 2026 at 11:22:34AM +0200, James Bottomley wrote:

> The reason I never really proposed such a scheme is the rollback
> problem (old version of OS or non-Linux OS can create the NV index from
> user space bypassing the kernel only block) which you try to solve with
> PCR5.  Do you have any data for how widespread measuring
> exitbootservices is?  I know edk2 does it, but I just looked on my
> XPS13 and I only have two PCR5 events: a separator and the GPT table,
> so it's definitely in violation, but if Dells don't do this then it's
> indicative that many other manufacturers might not as well.

Does your log replay correctly for PCR 5? It's *extremely* common for 
the extension to happen without logging, since logging needs to be done 
into the late events table and almost nobody got that right until a few 
years ago (hence 
https://github.com/google/go-attestation/blob/master/attest/eventlog_workarounds.go#L70)

> If we do have a problem with lack of manufacturer compliance, one other
> way I've got on my todo list is fake trusted launch: now that
> Trenchboot is heading upstream, we have the real trusted launch, but
> that's usually too fiddly for most people, so I was thinking if we
> could get enough of the TXT launch to happen to open the localities
> (without bothering too much about anything else) that might be easier
> and give us the ability to run the Kernel in locality 2.

Remember that many consumer devices don't implement TXT, it's only the 
enterprise SKUs that tend to. But that would be funny - it's the same 
sort of shape as an awful hack that's used on some of the Qualcomm 
laptops to get access to EL2. Localities are very clearly the Right Way 
to deal with this and ugh if we'd been having this conversation 20 years 
ago instead.
 
> > Reserve NV index 0x014c4853 for use by the kernel, and filter
> > commands submitted through /dev/tpm* and /dev/tpmrm* so that
> > userspace cannot undefine or modify it. Blocking definition is more
> > awkward so let's allow that for now, not being able to modify
> > ithttps://www.bbc.co.uk/sounds/play/p0pfxh72
> > means there's nothing interesting they can do there. The filter
> > simply validates which handle the relevant set of commands is
> > referring to and returns -EPERM if it's the kernel one.
> 
> As you say there are several other use cases, including mine above and
> NV PCRs, that can only be extended by the kernel, so I think this
> should be a range from the get go.

I've got a single index from the UAPI people's range right now, if we 
want more the easiest thing would probably be to ask TCG for our own 
carve out. I don't think the process would be difficult.
