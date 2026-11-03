Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793728250;
	b=ZzP+U/K1ZDhjzySueebRdg1KrkrAmVM7INccOXvTifaTxICfhz8Xsj6euF76hamFGbCR
	 gtxYFaEQel7dq75amM8B+nRGYuEIbvot8+k6/i+aG1h6QmFynSdT4ci2zUoKnrXM98sY9
	 sE/mjaujUGc1WvDkWHx3+3tze28l1MW9uLadPMcT0xjJa49OGgRFzMIbOuAVZJ9EicTtj
	 9OlT/cEFQ0r+Se8PJ2Mi4xSR91nzEmPlwMtAUoWqLRLKb5Ng2smrwbBr+uYs5htrnDJSf
	 NU834Ixd+JT9TeOrTHn50z0Y37aID9e07Ar6tmtY8w4NDDvC4hxugYV13yg6aWxNYFw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793728250;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=d98sL6dlVlb3fgyLP/grb3l4g2YK6zKiWi4X2zK7GoI=;
	b=AbA2aMzB9y+EpDfkxlpmnR4gORy7VMm6HTRea65pDQJnSfcd5WXSNhxXewTKKRLmIQv8
	 b16q8V6bQu+U7NUB7vDKj6l1A98R2Zh9YWU9Cr3O0nwHRcYMRdciokV+xShNeBbY+Ca5T
	 geoCWmOtYkeMhc2ljEukAfEo2veOTGUN7p66oHa1csMdthLAmQf1KlKyD41mu8Do7xUa9
	 tR6aZ/HL6uINfnyq00vlbuDK9+mM3hqzSrNcIRSJmGStOm18YdLSMcfNaDHUXIEkc8qqf
	 7XQIYTlbhQ5dck+cackEHdj69Ig9WumWm42lch0tGIDDUkuUtgXleKYIIh7M/htHC2Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XpQVXOcL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6714606A31B
	for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2026 17:50:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6714606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XpQVXOcL
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a206f0b95bso255e9.0
        for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2026 09:50:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793728248; cv=none;
        d=google.com; s=arc-20260327;
        b=N0D1zweMUS/cg6wGA7c7I0nvbVhUDqKXH4jF37mTkPD/ry+cd7mg3EUxL2EIaZknpX
         xoHHb6qo+u8zLX5xP578lIRrYxxGrVp6PU6/Z6Dxj62wzozK9Rh0hTK1l4CWFIo2hbKZ
         P5ZPqfwVNg1QE3dzKclA8CYAaeymfz/4lQAgxSZ5o5bjZA6VXtU6TrpUEfSkvfctasP/
         SITrl0ccbo1qRCdbjNF6jm4uINLEvnVt6l3HgEyfIjocD5oIszeJ1lMjC4xILBhHG3wv
         cXsotS5BlrELDxK32K+culCP68WUah0rW58Ck2gEZ+1cdyh0fxV/+MnI8rQSziyZ3ra2
         xa6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d98sL6dlVlb3fgyLP/grb3l4g2YK6zKiWi4X2zK7GoI=;
        fh=jSEX+x095BYIT+4kfaw/pA32KU1O+5Le75ldPlBRPIM=;
        b=VGaEPWi+9k6TQF7q0MgHe/awMd11HC0TLCqMBke8VF0WEXYuV61ZCjiEMTLPBQd6tT
         +uJidvew5X4WRq6yVvhJhbpJDfGp3pDKRBjERobGDtb9KJ09RuSeQ0V/GtwlUhwBLvKu
         a4hqxxW9xd3LlHF+E5PsuHOJJGRgNI07CUVwKAyygxhFzckvG5L1GqvG3qw6NJ5Q1uEa
         mWQZvF+J5Pqt0dCKXdpr0Mykdw2ot6fdcAD0PJf2tEfJHuFXI7zB/PWCc3f0mtOvGyTA
         BCiLUKJCDTAJX+pDoNMqHM2SZrsfUqG10dataHjpTubYMDOQTZWxX49fQZBI6/32ReCx
         7X8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793728248; x=1794333048; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d98sL6dlVlb3fgyLP/grb3l4g2YK6zKiWi4X2zK7GoI=;
        b=XpQVXOcL37Aial4LhGuOfR0x/2gg3577Qp0W5IErzF49hcILsqHfnlZIhWxzc9xddE
         freQ3VDpWxIjTlIvrQZIK9rTKyIs3pSgzCwJncK424hO3iu+wTIS1pN0KkXOYRbkjae+
         uN2qvvkEwNB6GadJf4vicUmTKOlvRyNo9wYkBwkqLSuvU7fhmUNusdz6HtlyGzudE1jF
         fWmIkfyi7T+z1fQHIy0ZYx+yRbCYwOFtipOBOSUxORH8VdGxBZ6q53Q0a+uxdkgtaYoo
         ffVw5+5Cf6ToVF2we5Gg9C2GmtEvwv8C2tOv57C247yyrwT6o0EySsQPcTaZrjPqB2fh
         nhGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793728248; x=1794333048;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d98sL6dlVlb3fgyLP/grb3l4g2YK6zKiWi4X2zK7GoI=;
        b=LlzPRZM02PSmktid9qyTm7QQWhiGQ5sksAcljkIcdCd+lCUZwy/JEaxpIdkIpH4v8P
         DPT8yuelX/YAY42+IKUkDEex+96PYkBrBd2+5HzOhwHaSBCAbBuCT21lDwhBOeh+2YzE
         PK7Xuzri1FywUHEUeFxm304aaNyfdlH4OFHNfA+9aSKzNcy5OxmUyIWUELxEXoE8VVUZ
         muvoXMUFiPJHQDTjhN0QN998rq6NM4lL7B3wi4a91eAUvYXFeLpQk0QWCYoONbmaF/mT
         pU/P70zUGF6hN9m16rJewhKT3R7ZXKzSMHnH5q4LHhOGUuuCDGx3u15KPxdUYJOYcWxQ
         s6Lg==
X-Forwarded-Encrypted: i=1; AKwUvBwwik3teziVkTz0MooGE32tOal5PfyubICuW5B0SYk85AiFJYJSaETeKFj23RXoYylP1Nr1L29lJg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8E0HZZ+KYSRwk1q0JfErJD0B4T66iF/Hpn1lj1WE8D/tDCDFth
	m69+ZN9SWalK6/egyp52dDEeptB3CEwMZa3SB9cqX78oqiBwHXzh8EsV3lLRLTjf9LuMgrbtawg
	QAgwKN1mJuGw6Lrk9QmzOYBmKJE2SNZE0L6rX7Rsp
X-Gm-Gg: AYBFou1b20iu5LE7PaLxOF5H96ChXhUPn9/b8RSPDsHFTikzDA/1sP5gN7Z7NxzuVCz
	IZzUhVRtKlamVb4WGEQpPSFLUGER4vpZzcVmhaZUXbaKbMipIQPFiOHcYnSQu5ZFj2ZaQjzCWDJ
	AfY3tlv5RamU05Hy1KlNnwTSYAV/TGrIyX5jb8lA1aIfV0XnjKOqLGBht+DXyT+10svcZVYxCkS
	A3j+081Uf/8lv2fMPUgMI1LArJMd3Hg8CeONWOWDBh5zbFqta/MHDxoC/VTJDtUYeIeDTfZuvkj
	P5Tym+ZwouCaK4LhH4dm0l0/blHqZ+ram5kns4M+JDLqqpdDBpPsFILt1vFwWadp38YXZB00F24
	ONjqF2H0wvnc5uXDeZBhkRlcFDTGPfRcBclxycdSSQxFok/QtlGvPuGvxHn5mDa+DA7jxH7DpXT
	a057t7XclyhOKuSdQrrNo6EXqEAJmsUwvyRFs7OTzV
X-Received: by 2002:a05:600d:848e:10b0:4a1:eb02:37c with SMTP id
 5b1f17b1804b1-4b2c55b2b1fmr867185e9.6.1793728247764; Tue, 03 Nov 2026
 09:50:47 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102234813.1069156-1-wvw@google.com> <aunKa8uBZJTCzVjd@willie-the-truck>
 <auoCjmMnzRE8c1cN@arm.com>
In-Reply-To: <auoCjmMnzRE8c1cN@arm.com>
From: Wei Wang <wvw@google.com>
Date: Tue, 3 Nov 2026 09:50:34 -0800
X-Gm-Features: AclHuK9_lwqQICSBvCDQ12EV2wMp0iVdU4Jo-z-GyS8-J8k5xR21p5bgCHg2xk4
Message-ID: <CAGXk5yq0Abvr3LvJLTaRoBFJSE+45LznsMGge3n3fU6hB3MiGw@mail.gmail.com>
Subject: Re: [PATCH] arm64: suspend: Save and restore TPIDR2_EL0 across CPU suspend
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	wei.vince.wang@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 7:49=E2=80=AFAM Catalin Marinas <catalin.marinas@arm=
.com> wrote:
>
> On Tue, Nov 03, 2026 at 11:50:03AM +0000, Will Deacon wrote:
> > On Mon, Nov 02, 2026 at 11:48:13PM +0000, Wei Wang wrote:
> > > On systems with FEAT_SME, TPIDR2_EL0 is part of userspace thread stat=
e:
> > > the AAPCS64 SME ABI uses it as the ZA lazy-save pointer, and the kern=
el
> > > context-switches it eagerly in tls_thread_switch(). While a task is
> > > running, the live register is the only copy of its value.
>
> [...]
>
> > There's a lot of unnecessary (AI-generated?) detail in here. Please can
> > you trim this down a bit? I don't think we care about the firmware part=
,
> > the stuff about idle or the bionic crash. The bottom line is that we're
> > not saving/restoring a live EL0 register across suspend/resume.
>
> I should get an LLM to trim it down when applying ;).
>

Fair point, I'll send a v2 with a trimmed commit message.

> > > diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> > > index 7afbece885a3..c7b7fa6491c3 100644
> > > --- a/arch/arm64/mm/proc.S
> > > +++ b/arch/arm64/mm/proc.S
> > > @@ -103,6 +103,10 @@ SYM_FUNC_START(cpu_do_suspend)
> > >  alternative_if ARM64_HAS_TCR2
> > >     mrs     x2, REG_TCR2_EL1
> > >     str     x2, [x0, #104]
> > > +alternative_else_nop_endif
> > > +alternative_if ARM64_SME
> > > +   mrs_s   x2, SYS_TPIDR2_EL0
> > > +   str     x2, [x0, #112]
> > >  alternative_else_nop_endif
> > >     ret
> > >  SYM_FUNC_END(cpu_do_suspend)
> > > @@ -142,6 +146,10 @@ alternative_if ARM64_HAS_TCR2
> > >     ldr     x2, [x0, #104]
> > >     msr     REG_TCR2_EL1, x2
> > >  alternative_else_nop_endif
> > > +alternative_if ARM64_SME
> > > +   ldr     x2, [x0, #112]
> > > +   msr_s   SYS_TPIDR2_EL0, x2
> > > +alternative_else_nop_endif
> >
> > nit: We use msr and REG_* for TCR2, so it would be more consistent to d=
o
> > the same for TPIDR2_EL0 if the assembler is happy with it.
>
> TPIDR2 is not defined in arch/arm64/tools/sysreg yet (for some reason,
> only TPIDR_EL1 is). Since this is a cc stable, I think we can leave it
> as is and do a TPIDR* cleanup going forward.
>
> --
> Catalin
