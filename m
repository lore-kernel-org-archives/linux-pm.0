Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E3C2D1F40
	for <linux-pm@vger.kernel.org>; Sat, 10 Oct 2026 21:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791667124; cv=none; b=Os+LgdpQgUUhmei12IAu/y1q7EX/VuWwbpTNIpSph4BWodaX43+jyAR+3RH568v0UEoorYBbHm8js+fOiZCN4ryp6QnnAqy5vnPcgAUqdAWQu91fyDok77lXC6CSoUfhcTct3RH+tv9LSPX4Nm5OD5cDRqewsl3BolZFo2w0sT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791667124; c=relaxed/simple;
	bh=tcL6A5SoUYWty+VXbzXNe06G0pu698TmKup8qJ97Wco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vky+b96gkMHcmdOZHT0ZM0RHiTZEzqDNSEyNLdb+jFQgObV+aVXzoWQhqJHjnIvZkwHhcOWQ3+o5iq1gQPGSJq6G9OG1uz7OVMMKayTEgyIfs7RsLzF4EEysCzoxO0OCsWDOWHgf7EfXPmlnpiUiD6NyY97VOisoSwo1I+QpNvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org; spf=pass smtp.mailfrom=cavan.codon.org.uk; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cavan.codon.org.uk
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-917ad52d7b6so10993926d6.2
        for <linux-pm@vger.kernel.org>; Sat, 10 Oct 2026 14:18:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791667121; x=1792271921;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WXTNApq6aSI569pIUAzzE6jSpAQWrYRivHcZV0gC9AQ=;
        b=UWSNJoSkqwGI1sg5nKnnHxF3Df7FtelCA2BYV6xNPync/6rzbllWzXygywwLtfjD8f
         W5SiA0sSQPrcsXRIzPlVOHDpqCk9qXoIcWFGenHjGBSjAUFbJdQK7kVKt6uh0lJrlejz
         BEVKYCuQu8EOnivL11vIkkZnGWSxgFRiNm1DspMRdsXn4yDyUIdTY1Zof/+eSxWaw2HP
         G7H0e2BL+PUQCb2v5T2JgoeAMaIVul0uJFRdO5KaO/BH+1ntkwK8+hAV4gNnZIkXWcNt
         dihk5KF8VaQaVDRN2mfqIAcNEFn5NhUyyAKvSQC0RHdeF7Ah/Wur1BU4XVksf/SrGQ6i
         nd7w==
X-Forwarded-Encrypted: i=1; AKwUvBygBnWR7W7PlQugNYx8e2vK18Dhi+odhwyL4QSc5bih/4b97zVlBvtdZ/8bHLE2cJef6xErGdgSKw==@vger.kernel.org
X-Gm-Message-State: AFq9FYKafvxpV0Bjk4UViVb8w7lvGPJ/ZK+85p7+WnWfRmWIEwFWO6qh
	8JdB0PES9zSk3A9jRnJ0rmd8Nj1xTNORz+RAvy1OoI+YLLIM/00dLPGh2t9oItwZlg2Oc8zxI7z
	tPraVP4BlUiwBVKJU4MHVygLDetPwH2NUN8No
X-Gm-Gg: AYBFou2B96lQXFGxtU+lILsJUDPmR7ACkiW/A4wsuthoRzGH8/f5AE5FVeoRIqlNDqZ
	GLk+pjZRMTA4SJdanj9gnhgYIJEVOLrs4iPUMdMNr3V1l/p1pVABRZRyzTOoQ95Y1wmft1h3DlE
	dHGuYsyaiGX2x9XejfGWUAB0+l/mGMuPda0ychPEBKId5gvlVFRY+NRcXtsmJlk7hnnNWyvB4Xv
	ecBv86lCTO8yCydbXmrEZlJF+boT/h3IYX783VpnHQlSHXj+E+sYko1Z701/MocLLs3iEj+6t1n
	ZDtzS6eh7Yg4OjrrbfjBuzzuBY30Fq4yFbP4Ie6E5kA1dHt1oZig2MR2pM8A0vh30E7EF5G82xx
	8ARP5cIduM82hgDA8edIzuz4x4cpCt0KXWieVZlw4
X-Received: by 2002:a05:620a:2b49:b0:93e:83a9:d59f with SMTP id af79cd13be357-93ebd23f1ddmr876491385a.57.1791667121467;
        Sat, 10 Oct 2026 14:18:41 -0700 (PDT)
Received: from cavan.codon.org.uk (207-53-253-74.PUBLIC.monkeybrains.net. [207.53.253.74])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-93eb986adf7sm109798385a.9.2026.10.10.14.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 14:18:41 -0700 (PDT)
X-Relaying-Domain: codon.org.uk
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
	id 273C51287ADC; Sat, 10 Oct 2026 14:18:40 -0700 (PDT)
Date: Sat, 10 Oct 2026 14:18:40 -0700
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Matthew Garrett <matthewg@nvidia.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, rafael@kernel.org,
	linux-pm@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH 13/17] tpm: Add verification of kernel signing key
 provenance
Message-ID: <asqrsIij3KjUWQev@srcf.ucam.org>
References: <20261008132532.1155166-1-matthewg@nvidia.com>
 <20261008132532.1155166-14-matthewg@nvidia.com>
 <0e47c22afbce2f94673bcc77d640cd9da410c2f2.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e47c22afbce2f94673bcc77d640cd9da410c2f2.camel@HansenPartnership.com>

On Sat, Oct 10, 2026 at 11:34:10AM +0200, James Bottomley wrote:

> I get that PCR 5 measures boot configuration and isn't supposed to
> change from boot to boot, but what about across things like firmware
> upgrades ... do you have any idea how brittle it actually is?

It is likely somewhat brittle, but: firmware updates may also change the 
memory map, at which point we'll bail out of resume and lose user data 
anyway. I think the appropriate guidance is for userland to unstage any 
pending updates before allowing hibernation.

> If it is brittle, one way out of this might be only to care about the
> last log entries, so make sure the log hashes to PCR5 then find your
> EFI_ACTION and the exit boot services mark in the right order rather
> than caring about exact value match.

So include the old event log as part of the hibernation image? We 
wouldn't be able to trust the event type because that's not part of the 
measured payload, but altering that should fail safe so that shouldn't 
be an issue. My gut feeling is that this makes things more complicated, 
but all of this is opaque to userland so if it turns out to be a problem 
we could revisit it?
