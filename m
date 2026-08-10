Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CD4442B34
	for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 19:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786390986; cv=pass; b=eMuIfQlz1OPEiBAIBDlaTJNVb6+zEPCg6+jTWi9zsD9mb/QIS3kKVhLzTkZanZ4Wg5Ukb22G9LgD3I6G0jr9X4rNEcwVbXv05ctHzMlRrUVO9TT23XHhDcs5EL9bcjIMtU3sm6GOwbJkZcNV4l8qNnpzPz1tM2GRqhwc3D5HuTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786390986; c=relaxed/simple;
	bh=sSfTl/Btn2V10b+yQ0O+ip8v3QAAuBldP5gKNtUYnog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZiUePCpBbxLHqkfHf4kuLan5ldb9FsLwOTJwn/VKV9CZhe3FDVYaWckKBvcmT+FDM2Uz2lG8yi5Q+AX+88MN0r98ktNDjlrg9CPr5aJvpGuFHUlclhoyNJb08B5oyESjq9ds+q/wBEq/plPBQYQ6qU7rvd/oqGtJ5nIZ6rEokv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b=ZVBolws8; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="ZVBolws8"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-664b05d408bso1921960d50.1
        for <linux-pm@vger.kernel.org>; Mon, 10 Aug 2026 12:43:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786390983; cv=none;
        d=google.com; s=arc-20260327;
        b=pTX7hgoZ907Jev3OIBky1bE/+AE9HyE3YJS6XXnur0yGO/IVF7O0KoVdB18+XvElPM
         t+zTFl4MuZMDHT93lIKw9hd2GIokhUoQSPUkrFmt5mdxTveikDTuYvvlKpCZdyqdll6X
         oBIdpEvtSZE1Pya13bSotBOA0ZF2s8ixNOJoEVduvVxNDvW9uW04UEic6SZS1iuXauWu
         VonH5hCIDBT0bc5qgo257zs6GIOpWCWY/cwFHAaJr1aQBTjeUz24ZOA5+fe/p73Puh2G
         ZdtDdHkCX3m+LKg17ozWKodHlFuUffYS3sgSqwGptcWY6QgyRUdNwHynQV6uBUzGzEg0
         EauQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=EjY4g3T95g6mKD1MBixHXdc5wVPM/K5AAfu326hoiTU=;
        fh=Ergp7Yx7CGZftq96XgojbcaiTxcMmur5dhTNrDtBUhg=;
        b=qxSrpDU+gp1FvFlJWpqRJy01EZ3E0tfJz79/79v8rwJFzXvUL7HE5q1TJZl/z3rULL
         3yJIm2Qa3zeFbLB8ZExT3JcwdN1SDrI34EnNXILYX81LNpWyztZHm7Zh9h8BxzJ25TcV
         KCgD7exXmUOs9MKihS8EkJEEpABOXWZRgitvVGlVZDKcBliTPcC39n/IXWAPpj9lI3yH
         nQFSuHAjt/9nqEoboCyjigU1i7Vgr4jlt1Lo56ZNsYs0To8KtkZD8kwDi31tPhPdU0xV
         vQaXWB+S/MBFQrvuto5MIrebKpTdo3zb87lY+DBusPtPwDhID9/IOd+Y0pF3gIzt9jut
         EMZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1786390983; x=1786995783; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EjY4g3T95g6mKD1MBixHXdc5wVPM/K5AAfu326hoiTU=;
        b=ZVBolws8HymJq/a9EC5vw8PVShpucmZFddxLUOYZ4c+BSfeTaKA2lWth9Hai6bfsvu
         T4vwdueKHe1w72P8zOmHSE1yDp6AkRxktE32fydqzcmGGraMBIM0/KU4abN3dSZ5w4aU
         ZDM6S1EMZjzii2DpNYMeQvb0W6Q+NW8zPiInuTBOi3bxfKE95yVvKpUdEMOWudm4t8C3
         YRReAIe9fcoKZCH/laQl+BKB5Y4QhJi/DVcBB88Vx6mxThndezeCAIXyW+3xkosxa1Bb
         m7IQzAhsbf1oxiIRjPmwbBcngbnaO49+zBgmgxfxcHqBAA3XRx4KYeomSivz2yM+Ohzc
         fHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786390983; x=1786995783;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EjY4g3T95g6mKD1MBixHXdc5wVPM/K5AAfu326hoiTU=;
        b=D8/gENxL/yRBbOoO/pzV4zL8Mviy2FoLiDha78VlbEaPWS/M2+uY4WaYMLJjhhcubo
         5VBLW2IJM+nD2dAdlE6i6hqKS3dhZf3bdl/mBkkxDB33hIYrRb9F8cW/MMPfygtfEuDW
         aX3w7rBnPVWpbjzel3IZWB5+jmrwLNdsSCEso9u83MfQPIWD24JijignsfyLz3emzXUk
         seK1vtx1J0UkvzGWEyQ6k2OODkv3etd1brQ07lsHFojbt8ifSjgUsGnl9tHz3lX7TUb6
         JjhYd76vP4pOccQZEGLqMak/pKBzO3kKzoUWYjuJ+E3YPskoCLqW+tS1vKnGWTtE+mnL
         gGdw==
X-Forwarded-Encrypted: i=1; AHgh+RqY8Y6+gFEIyMn1QOuIf++9hlNjHTSUY6418OKdJ3qqyFMFpYOtHEJZexXssF8Asimv8cViVUAWJA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzuzEC76kVsrWRBJ8pfT4VeB+dj+FYWt5nzkF6FhHNTQrIVOJBY
	eY0hQc5N1VCYA877l9YWAirpsX9sbVYFSOU4X4p4t8hyyu9aEhJ5/TSe/EmhD333dx+juaIsa5C
	Udq6VLR+nG2rDKP6R/i4iehlfyO7Z75yOcbC7KoZU
X-Gm-Gg: AR+sD10KH+tflNTW5OfAxXKqi5xWgd0GTmVDEH8z/y2ArAImmSIFDmTDNOgfP4Y7SE+
	XmDAidtVucs17wH7QbWvhhE9WtbC60pHfdEB2pcmZ8uT2ErqIUv7xRdX9kx1X3RRk4epgIJkGBd
	s0o9stWY7bbJrkMcc2/b3wlqVtCZ0rkYd6ASkH29pko96cQk81x1EE1YUXs5xUfV+0NmZNlPM0h
	c4xOdPTY48pEktYvDN80wMVfq5aGlA+vW0oJ5OcblJF2OdpVnI1J95S0M/COlATWYp7mQ4RI59n
	YuXMdugLzaHxObelFD6C0jz2HDK5iSwaD2bca6m3rOU23kfxkZhQOAKf2alcMU1ClqDhjqhTduY
	=
X-Received: by 2002:a05:690e:d84:b0:668:2439:c5f8 with SMTP id
 956f58d0204a3-66b193cb346mr328299d50.12.1786390982630; Mon, 10 Aug 2026
 12:43:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4430d02d34617dd2d3cb506202fe44d5e45c053b.1785838418.git.sean@starlabs.systems>
 <20260804184920.GBanI0MCMbnglz7Ncc@fat_crate.local> <CABtds-0MUDmxK_Vd_P8CijwzUhQEV4eWNzx1+DbN2wfnY4dbrA@mail.gmail.com>
 <20260806012923.GEanPjc0w24EdEquDk@fat_crate.local> <131d39d6-c2a9-4d80-99e9-526d347bf608@amd.com>
In-Reply-To: <131d39d6-c2a9-4d80-99e9-526d347bf608@amd.com>
From: Sean Rhodes <sean@starlabs.systems>
Date: Mon, 10 Aug 2026 20:42:51 +0100
X-Gm-Features: AUfX_myzko68P5cjgRn0jWZDGqZNNBv0osckw3ROSluup1iI9UrlkNPgrntOcow
Message-ID: <CABtds-1wb1zt4cP9jrUhivRZKEqG6Geq5XtK4j3R4hr-6nMkfw@mail.gmail.com>
Subject: Re: [PATCH] x86/pm: Save AMD CPUID leaf 7 across S3
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, x86@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Aug 2026 at 19:31, Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
>
>
> On 8/5/26 20:29, Borislav Petkov wrote:
> > On Tue, Aug 04, 2026 at 08:22:36PM +0100, Sean Rhodes wrote:
> >> If you're saying that because there might be a firmware solution, I am
> >> all ears, but this issue is present with AMI CRB and coreboot+FSP -
> >> hit a wall trying to fix it there.
> >
>
> Does this only happen in coreboot + FSP?  Or it also happens in latest UEFI?

Also UEFI

>
> Does it only happen in S3 or also S0i3?
> How about S4?

Only S3

>
> > I'm making sure you're using the latest one which might potentially have
> > a fix...
> >
> >> Why not?
> >
> > Because we're not fixing three things with one patch and without a proper
> > justification for the other two.
> >
>
> I would expect the restore of this register to be the platform
> firmware's responsibility.
>
> I don't know right now if this a BIOS bug, an suspend/resume bug, or how
> wide of an impact it is.
>
> Your fix might make sense for "this single platform", but we don't have
> any evidence it's needed for any other one just yet.
>
> We shouldn't make changes because there "might" be a problem.  We need
> affirmation from testing or an assertion from the BIOS team.

Ack
