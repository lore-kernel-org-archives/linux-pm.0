Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8831D63F0;
	Fri, 12 Jun 2026 19:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781294191; cv=none; b=EzeG7t+S7jVxxnBngqGvUuEffj4tehALGPuVXE47gqVpoUbnmSQcoBMKMcQdmIxPqbLAZpNg7fN8j8RrKuYxV+ORbqZFV/VtVzEwx5kfIr9QgxS9YJYSpwEyiHLraQLG3MrFbs1bUFMewUk5H6VMo+cYPXzLyI9c5oOg/8/cCQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781294191; c=relaxed/simple;
	bh=atpCt5iq+n5E6TxrkJFopl9tTt8b7HM+kTlUKoIhd7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLosRkfKr4TqtNKnWJHKbtDzjedz2mJuMGucHobz/BE96d00k5D0i4+ifw2xMSloSHWtNos22jP2lqmh0LVBGkRzyUq8zAnJxP4xXEI710eCCt06tsVFYRibdzLR16WThlRNKXkjxRU94i1tmr1Bk4zVq8RzFNAR2edz+QzPt5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=sZgQhVu5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kjt1XIlc; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="sZgQhVu5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kjt1XIlc"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id A6969EC01EF;
	Fri, 12 Jun 2026 15:56:29 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 12 Jun 2026 15:56:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781294189; x=1781380589; bh=/VBnOtclHq
	Qu8WUbzo4nkQz4Q8rlxK7VwsYBiEgNET4=; b=sZgQhVu5HGcn53/mvBAl2slZlz
	HZqh8b4vUmoyAcucTZwqV0O/jgPDWmGEaRmuocdKU9JYtZkzrUhOtxW3OoGd/Mmb
	zAOqOWva6nLZnvu9AGaYXGzzPvcyhZSexCtrDATzptFfpV+NdHwW8V1ToLmb98kP
	V5Y85ynzUoOqaWFzIJwfQtAdetzFy2a81KuSN9ujSsvVDeJpIddddo57m0xAkjAB
	gNyWq55Uffb+pyyKCsV+BBdrQ47f+wVwNoGTKSByoEtFaTvj3EqLkp9yc/rNKCKA
	Ttu9ePKEp+sJ3L70SUq3erwCEC/36YWoVAMf7sbZ6nkq/Zfuio/5m7f4IDwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781294189; x=1781380589; bh=/VBnOtclHqQu8WUbzo4nkQz4Q8rlxK7VwsY
	BiEgNET4=; b=Kjt1XIlc8EN7VdAua8vEKfUr5g2wXF4RxDnNac5cWj72LhyA9KM
	0cpVdtUO69OFM2+4jpm37zsTKp4/WbSgaVubZgiw3MEE5pZyiqtm1JYnvHODwlV8
	xFlbeJlokhZsU9AIZ+VKBh+q2EzT+4FMapCwc6bSw2WSGnwCvRbbqSQDUDmNMtLZ
	EQN5hkGVeYI/xAfJnIskbKpsPMBv+/pBVdDUIf9kcfjuqBpV+cfbwEztrtrROqJA
	We5RWkDzFM0UxvwtS74MTb8bMzl1zg8ct6E9oz3vBKfe2WckvRu25AOt/9biXdaD
	cO5EcL8ODv6Or2/PMYlM8t2riBMCuJFENwg==
X-ME-Sender: <xms:bWQsaoge0RMrcFAWJXg8Z84yw2Csw01ngQir0QgI1hvvusz5mk_9Ig>
    <xme:bWQsajkQjJkiLXqumeBGVhd7m2PEFGeXcQK8-1ewUZ6nIo8HUZl4tLQ7-t0ek5KOq
    W9ECBIqXfGOQRETBaJ25N9jYeqKOV8SnsuU5hpHkOohxlxevLvnxnk>
X-ME-Received: <xmr:bWQsajvz3yBUNkfPg8ep4516mRTCxr9Wxy3JBHMKfoUHEZQxj2QtunDCC7zhAIVYC8pGJLrRcKt157onMGa0CRvDeTct2tS7ygU>
X-ME-Proxy-Cause: dmFkZTEYSH4UO5YuL41xdLEJP/iBMLlNcYTfRr55mxPjS8nSyhazv8Tf8YZsVZlUvD8yuM
    lUgjHR4KfHn0kRMmgOHaOe5Oh7pC64waq8rH0ekOImoTive8zdtlxl0vJdaaH9HEEFzB26
    SPTW7gyhcQV59/VG/1prinomI6KGuIu8jf48OEgR2LZWcGcqzQXPu7+vkNpuT1qZZSYm5D
    9msR8K8YtYpVJ0xTcoGPDVEswDZF4/zwX/hmbH3yuMhglaKWkf0wo8Qs7zSkl3rrKKIH2M
    5vnpj/HWcohpJMXUPgX6q0nXnE9lJisi6ySeo+yGI3/qAwioKmf6fl48CVOiw3UyZy9tE9
    lCTXG0sdPpuLgDHC6GmEacqHXFkLrmEsjNl0NJ1GkSsogQ1btfyvx2s/nqT7j27DkH1ReW
    uFTmpeUHZzIuZ7CvFmbBTOuWS+sXrKWVgKxzfnqYX+dD2upRlQBH7/8e8lXTNdQ7GClZWs
    7b2w8/cPk2oAjMcLqIWyoDmFro1fj4pETq35Q+DU7NWcufrr4nv//m6gw9UgcmypDixf/j
    FS6I/2upmvpPLN74pKO6eRBVcpzJfLNB9OjpNbkkz6KgfcyZKSXSE0vUr0wnxa0hWSSCcP
    EjhGR2qcQrrt2G5AdLfWh0Np9+vVArLoKO8tFXgzfopQUenvipaR5JqfMIyA
X-ME-Proxy: <xmx:bWQsapZH0qVIiYR6He5AA81UNUzz32TL9lXAcdDQU87Si7SjL6hygA>
    <xmx:bWQsarBuoRq5y3jcbEc0FtBbswirJ3FAI1QR7HWN9nK1YjiTvjfqhw>
    <xmx:bWQsah_3DxyI1lfgRXgepma81wSo81ajTdABBuOE7c5MYR6cDSD-cw>
    <xmx:bWQsanQObcYWAWmy6yInHg44Gq4J7KV_qr4Okok0wG7WvRmWkARhtA>
    <xmx:bWQsakGsNxg_5LybkbHGxNzFKX2Bz26Tlm0cVfgnYfj8iBF2IMejT1tO>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 15:56:28 -0400 (EDT)
Date: Fri, 12 Jun 2026 21:56:27 +0200
From: Janne Grunau <j@jannau.net>
To: Sasha Finkelstein <k@chaosmail.tech>
Cc: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>,
	Sebastian Reichel <sre@kernel.org>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] power: supply: macsmc: Support macOS 27 SMC firmware
Message-ID: <20260612195627.GB7993@robin.jannau.net>
References: <20260612-gate-power-v2-1-de76cb9bb7ef@chaosmail.tech>
 <20260612193353.GA7993@robin.jannau.net>
 <18396D14-17AF-4B43-AD6D-A88D2E7C44D3@chaosmail.tech>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <18396D14-17AF-4B43-AD6D-A88D2E7C44D3@chaosmail.tech>

On Fri, Jun 12, 2026 at 09:42:12PM +0200, Sasha Finkelstein wrote:
> 
> > On Jun 12, 2026, at 21:33, Janne Grunau <j@jannau.net> wrote:
> > 
> > I think the following is slightly easier to read
> > 
> > {
> > if (power->bcf0_1byte) {
> > u8 tval = 0;
> > int ret = apple_smc_read_u8(power->smc, SMC_KEY(BCF0), &tval);
> > *val = tval;
> > return ret;
> > }
> > 
> > return apple_smc_read_u32(power->smc, SMC_KEY(BCF0), val);
> > }
> 
> I personally prefer using early returns as much as possible, as it makes
> it easier for me to read in linear order and due to line length reasons.
> But no strong opinion either way.

I don't disagree in general but in this case the code inside the 4 lines
inside the if are not much more complex than the early return. It
limits the scope of the local variables and avois a not on the
condition.
I can live with either version and the strength of my opinion will be
depleted by writing this reply.

Janne
