Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795176708;
	b=VTVB8MP9j9M5CuZOSO+e2WUk9lctoZBFQYyq+XU0PCuNr2c0dpYSUhPfS5I2+fG5whcS
	 gZcVuHoLRNVlrT+pUOB31IzNNMfMQylRB4WlmpC/gZ2+Uwe/r2ENmIfp8Xh0rJ3teQYOC
	 OHX0ZHlzL0AJWFrqXSwo5UOFBbcL8nzTz5C3nNp0r18iR1oCi7f3hv45boWBhsEKtdvph
	 yRfXl1i2qDCedxtsq3Wb1tpZRSubU116EKQiO7XUio5SrjZLMmDQSnakTHazXXpaiiPvU
	 WW6/VZCyBQyex+o0KCCRm1CPydx49cPHYOVrv4bRkRL7UKwk9ykO6rwqMY+G5w2732g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795176708;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Npj84u5KtbvSHzJsKcBdTvmxE7ZchjU80UhtR/KP1IM=;
	b=1+sOccHQehWunS+b33ljxTCuiWGTyoxTXaGhjIelaNVDrugUIAmUj146PMN4wiKqsUo0
	 +YAqqRUxbSGFhNhuUIbLHQGNaCmY3xHigaiUx+TagmRXwjQEIoJXiYKIkCaM8jeeqlNpK
	 gFlDi1hjpt7KZ7igupYHo6TpD+VOQkFlgnSeo7w50noZxMaWdlESE1TEkakWWoEIoQHNr
	 9yebqfF5VC6VCQASRIraBMotS/uJQ8yUHNivoMQulfPaLmRkz67Hk0J/ufLgJXC9i/SuX
	 LUagwO2rQgqZA8j2ijJgNW+BFUNtGSpQDgq+SdqGdgJ4UXO0rvyJXJBop00LbH7gBTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NfOJBDrU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E39606A325
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 12:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NfOJBDrU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3F71F000CF
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 12:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795176707;
	bh=Npj84u5KtbvSHzJsKcBdTvmxE7ZchjU80UhtR/KP1IM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=NfOJBDrU+8uqBxTCgiWeoBNzzecW/HOJHsMY6JiqTv7/xrxwYu0van0wavFs3f83+
	 IqOb9MJUhcfHFjNsssEE3yrNPKX+AMkJhZ8A6RStW8jCpE95xCy6Mlilw5mIju/IJH
	 +1f+dc9BbuSpPf3t+ZHaBFAEHlw4D4tJTQ34M/aGOpvUUIro09WzcLtERs31stMc1m
	 YXny3l2zEmjl8uA+bFpq7/4IkkBeYG2kZ+kt2hv3yhCRB6aYBwz1O0mtgBjIXxNLb3
	 0zxxbwFZxhHWFqqdKEsC6fAom+navbf7w26+3SrT8A6qKX3SHCGrPWb1sOHhTwdUIM
	 puBJfsfReN7Cw==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3adf9b1f5aeso18596391fa.0
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 04:11:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEeh4AMVHu8Ga8h6/CIMlUylVMKDXe9LSOoSSRNERPTFTn3Ma91TXXJHY2W1Pk5pCPTcMbs1xxH7A==@vger.kernel.org
X-Gm-Message-State: APuU4Z/2AJw30/MX6kfqSWo7Crl+IO3AsC4rKR8KCFQvAT8OIlwxvy0z
	B0ILQDEOAFlN2bpJPT5tcVZfpuaGTDBo/ZxunTiPIzqKWRZGSGb/wqJxcQbP0cPsUkwCuaNcNEM
	pMGyuI8Vl18WFXzrWsHf8GcuffN9czb8=
X-Received: by 2002:a2e:b8c7:0:b0:3a9:829e:1def with SMTP id
 38308e7fff4ca-3ae7b7fc01fmr11147741fa.21.1795176706056; Fri, 20 Nov 2026
 04:11:46 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <1978814.tdWV9SEqCh@rafael.j.wysocki> <3453847.44csPzL39Z@rafael.j.wysocki>
 <c1a2c90f-c667-4bf2-bbc0-2cb3f840ad97@rowland.harvard.edu>
In-Reply-To: <c1a2c90f-c667-4bf2-bbc0-2cb3f840ad97@rowland.harvard.edu>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 20 Nov 2026 13:11:33 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jX8iR5x2eS1uAf_P12Ke_OBq6kx2FRCiVuSRRRDgMzLQ@mail.gmail.com>
X-Gm-Features: Aa3M54qEyXo2NhJpzQ4sNJz2pWKF95GlSunca3HEglNsNnFA3MTXYEZGVJtG7oQ
Message-ID: <CAJZ5v0jX8iR5x2eS1uAf_P12Ke_OBq6kx2FRCiVuSRRRDgMzLQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] PM: runtime: Drop space characters preceding labels
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Brian Norris <briannorris@chromium.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Ulf Hansson <ulf.hansson@oss.qualcomm.com>, 
	Linux Driver Core Development <driver-core@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 3:47=E2=80=AFAM Alan Stern <stern@rowland.harvard.e=
du> wrote:
>
> On Thu, Nov 19, 2026 at 09:17:08PM +0100, Rafael J. Wysocki wrote:
> > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> >
> > Drop space characters preceding labels from the core runtime PM code.
> >
> > No functional impact.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
>
> There actually is a valid reason for keeping the spaces before
> statement labels, although you may not agree with it.  Namely, the space
> prevents "diff -p" from thinking that the label is the start of a new
> function definition.  That's why I put a single space before statement
> labels in the code I write.

But this is not done elsewhere in the kernel and there is already some
inconsistency in that respect in runtime.c.

Since the next patch is adding a new label, I thought it would be
better to make it all consistent first and I chose to follow the
common kernel coding style.
