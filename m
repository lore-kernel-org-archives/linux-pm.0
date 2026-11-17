Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794896102;
	b=r2tRWvGl6b1Ltp6ycJ37X7aIo2sXEd4BgMESevZJzzR/GqgXXzPO5NzMPOeBT5zW3BM+
	 TDYzxi5k+lQdLWKXUtqSepuCGQ/5aftn1lTArbncLL6gOTK3OFLEO035tjVkana+lix3u
	 lIOM5LRec9qdvgeoHvfYpKpkk3HWb1jHK0BuqyxOKvzM4gYIdxJyfqQpEDb5VzVldjez6
	 qIyo2IL5iqCA3MPcDUX1deihtFfpKG5d9y1OD5ke3udsg0qZiM+1yPpv+WtM9d/uhJHPg
	 cy9shb3qZKzgGiHl42ihWOCKCO7AS9hhG9RMAyCfVGLGRNtGjiRHp/65v44VlOdUWxw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794896102;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=2tlG1uGoZcjaYy1xmlXhRKnsoUqHxLQ1mQdDaLWoWxw=;
	b=GIgwjsk5/hA0PFd1qSAL+jFJyexxuUJm7RMaIYdnMjhQ+O+ARr/dSYp9KjvdHlRdfqcx
	 FhiMKJWU9a4I9OUtqGNB7gxJwKoeYyJ29EIFR3cnD3SXRltpuoocmswSJbhH2o7gxHhEh
	 RZKyhOZzS2nVFXeQVGsNapnzOa6g37n1gc4fjt4N0rTEMic1cl+Rsg+dNRwVQmW8G0/AJ
	 WVm/ffd43IF9ttczoft7KoSVAKcTCQuL/Uvnw8KARuaiDTCe0RHTv0Jr6e/5d/4hMY/Ho
	 dMv9INbcmeWQlj9hNhWcCtbtFN4eKxzUywMiiC5qarONYQwHEYP4VJw3+zyNQuNbcnw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BG4FZG5e;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690A0606A31C
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 06:15:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 690A0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BG4FZG5e
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-170135e43c7so6858334c88.0
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 22:15:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794896100; cv=none;
        d=google.com; s=arc-20260327;
        b=deP5aptAoI+2yTi3c0CYGjBnUHghbZrPXxSDE607FT39CEpXVSOEHt7TiONSC7cCvp
         Tt+IJCf0vT+sx+EYwByOMd8URBbdy9Tl/9eU0gHZBUnjbr/V9Rwr9oRhJz/bWdxMEeZM
         FjDxtsWYTLOT/lkQ/QX0DF6leLMDu5Vre1dU34Dz6A5bTNlGlud6ofCha7ignguw+rC0
         a0kxUvR+WpQj4yTJLXrDm7xKaDNEqq6MUBmHkEP4la3IJ4lQcohuDtvcmnWdRkArOzrb
         y5CYyPjMCvrqmVZTmwI3KbLYohj9CSUN7hjzLwCSlOGs0wXHzaGrq8hEd0cZdLks6y8w
         rsRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2tlG1uGoZcjaYy1xmlXhRKnsoUqHxLQ1mQdDaLWoWxw=;
        fh=ib9tski86amObGMTK85CZrR2cYVDp8BeQMfa5RE863A=;
        b=mpw4CKGZChbm2mXR75dUunWlDcE3hO0FbSWTEY2iNoyA/WC/U9Zyqswjr8H5JlPPLy
         JtE3TB5TTVGrq4kHQ0na4hODcphJPQeftreIx9WxnIstmMgb3Bv2d3quHKVsZ2JEPBHz
         8QNJ2G9Y+UDFkhxlgNzvfTgl3ZOXU/5zJgNMguhClwcuBImJNQygPIQpg6L2erFW4wRF
         Z5oXnNFph0s2PnYg4txVl8szP699ifPk4T0JpIHi9GKwPVGNQr2rXxXDu3SEdp+KlaGX
         dJQf+X8+Jtvg8aNVoFOD9yoF9v9H7DWtMANP09vMK7wtR3sC2ivmbfchLWp03Wz8uvRY
         nC7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794896100; x=1795500900; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2tlG1uGoZcjaYy1xmlXhRKnsoUqHxLQ1mQdDaLWoWxw=;
        b=BG4FZG5ebLAflhDHW2u0yN8dm3eyrZXUYTLHo5JldGheWYi1fIsH2FaizeVmFA9kLI
         +RyhuNCMrzqWS7kJhDGPo4BxJFoKyvf2IYtNVsgl0LkC/dmaN8aKXN2eml8i0ij6E0qs
         BvT6Jk6X4MklIDZaKrqCiwvBjo61puWWfw2hdNfM48pEQ/LxtMvvxqI7j9nGjYxHmsE8
         UrnoDT3FJLhp7ZFdLeDNpw5eLbBmuR/zTY+xxKAAgxqoGkfGsb9IZgXJmtfSEGleFcRE
         ifTsOtpXm4n6cQW6dWpaKzDipKLQwPpnl/vqAnbpR0nin39ANrSZbIj8udtOVpcwRmkk
         KvSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794896100; x=1795500900;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2tlG1uGoZcjaYy1xmlXhRKnsoUqHxLQ1mQdDaLWoWxw=;
        b=RJojFAENwAk4d9mj1zM2O9aOzftzKc5zGQa2Lst0K72dZjjavFaTmCvdkBxgIyLZYG
         V1UKBN2YnuMRNod9+iWpQ4XhDtchhQa/Zfxlc0kX8LVmYQbJ4hh8fDspwdOx0pxpjw6d
         p2OvwE6i2DinnA9J6ndbuEmcxfCytwbTtzz18gGiiUoDgkaxVpR5r72smcXIhqdAUEw0
         y52m/K+Zu09yjyyngSgNeMjg4y3BX86mugB2VsgsksoYZLBZh/fWW3RygBvTlIHhRX6s
         X86Y5BDi6dtFLs262wAMV6T+exS4j4wdVck5FQGJM4+0H5vJHo+9zraVMxRCkJulbWNC
         9ehQ==
X-Forwarded-Encrypted: i=1; AL+hErEiM53g2Qt+J8UP0J3wunIbWaUwHGa6KOIkxA0yRZj03VpFyhCnFLubX0puAaoT/LhQuQIXMErLrg==@vger.kernel.org
X-Gm-Message-State: APuU4Z++ad6x4+OwBc1m5UN5VGveutXXVrD4c6mg4GfUYxmeH6Z7o1G8
	fW5pvz2u+vASpWRN4D9uxgqgJ9z9Orwv3hUKZi75W6jIOp3HwnOH8qhC4CzdPYVPa6OFkXgbmAq
	r5n1duuzqcA+zHWlhED6KwNtIuxQ0gzQ=
X-Gm-Gg: AYBFou2dqZ2YW3wILpAovz7KcdAsMcbkn7KrQ2HVaKgMfEWQlTQlehkIITXoG/xscps
	CBBcVSpE535ySNljfCiJsgHfrVV1exUlr4TdA/FXLBL8qxJ42lzp0kUfrAf/wWBIaA2Nud1mVLs
	QInTeQczzhuK2qhjSlHQ35JZt2om3y5pMsVpvQEG2Ht4Jufj/wnaq9QUrrzpygIrO1wYMTDGe2y
	smEcf9WZcYLJo8A6OIroap2iYvbnOQAyN4d/1ffbSLQxoYz9E2uxvROwvLFsEFkJuyR5exRiWiy
	g33S1GQw/AI8A5DLEBrzOlj4zoOGcem6pYpXxeTa6CIMu4DX6a0yUrC8oyCfSmS7LLzuZ6zWqZ6
	8AskDXqg9m5a2gEBAo/abZARadWDQLHXPwmeR/ls=
X-Received: by 2002:a05:701a:cccc:20b0:1b5:32d7:7d73 with SMTP id
 a92af1059eb24-1b532d780bbmr3902889c88.30.1794896100415; Mon, 16 Nov 2026
 22:15:00 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022-psci-fix-v3-0-9ce2133c5659@gmail.com>
 <20261022-psci-fix-v3-1-9ce2133c5659@gmail.com> <CAPx+jO-rMeg8BvemcMUcC10enjt0dkqWvsK+uRwc75rWpLXhMg@mail.gmail.com>
In-Reply-To: <CAPx+jO-rMeg8BvemcMUcC10enjt0dkqWvsK+uRwc75rWpLXhMg@mail.gmail.com>
From: Reza Kurniawan <imkyufie@gmail.com>
Date: Tue, 17 Nov 2026 13:14:49 +0700
X-Gm-Features: AclHuK-92z3C_GXFHu7R-8mmf-2cWRgFAIJrCVXLvNtI2-ZT_Yern3kmnNXQGro
Message-ID: <CAAq9HC4doEs2v=aW0-tR+ARD8a1OGes8xDi2BV=T7m40YFBmww@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: arm: psci: Add skip-suspend-mode-switch
 property
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Sudeep Holla <sudeep.holla@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Christian Loehle <christian.loehle@arm.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
	Val Packett <val@packett.cool>, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Alejandro Tafalla <atafalla@dnyon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 8:10=E2=80=AFPM Ulf Hansson
<ulf.hansson@oss.qualcomm.com> wrote:
>
> + Sudeep
>
> On Thu, Oct 22, 2026 at 11:41=E2=80=AFAM Reza Kurniawan <imkyufie@gmail.c=
om> wrote:
> >
> > From: Alejandro Tafalla <atafalla@dnyon.com>
> >
> > On some SoCs (e.g. Qualcomm MSM8917 and MSM8937), PSCI_FEATURES reports
> > that OS-initiated mode is supported, but every PSCI_SET_SUSPEND_MODE
> > call is rejected with NOT_SUPPORTED.
> >
> > PSCI provides no call to read back the current suspend mode, so the OS
> > cannot tell which mode the firmware is operating in or why the switch
> > is rejected.
> >
> > Add an optional flag that tells the OS not to issue
> > PSCI_SET_SUSPEND_MODE on such firmware.
>
> I think it would be nice to further clarify what's going on in the
> PSCI FW. If I understand correctly, the only supported mode is the
> PSCI OS-initiated mode, hence it's always running in this mode, right?

That is correct.

>
> This is clearly a violation of the PSCI spec - and I guess updating
> the FW isn't possible at this late state, or is it?

Just as Val stated, it's not possible sadly.

>
> >
> > Signed-off-by: Alejandro Tafalla <atafalla@dnyon.com>
> > [Reza Kurniawan: split out the patch, rewrote the property description,
> >  renamed the property]
> > Co-developed-by: Reza Kurniawan <imkyufie@gmail.com>
> > Signed-off-by: Reza Kurniawan <imkyufie@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/arm/psci.yaml | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/psci.yaml b/Document=
ation/devicetree/bindings/arm/psci.yaml
> > index 0d04389c81..2eee38d155 100644
> > --- a/Documentation/devicetree/bindings/arm/psci.yaml
> > +++ b/Documentation/devicetree/bindings/arm/psci.yaml
> > @@ -98,6 +98,19 @@ properties:
> >        [1] Kernel documentation - ARM idle states bindings
> >          Documentation/devicetree/bindings/cpu/idle-states.yaml
> >
> > +  skip-suspend-mode-switch:
>
> Maybe a more descriptive name can be found?
>
> osi-mode-only or broken-suspend-mode-osi-only?

I initially settled with a similar name before (with 'osi-only'
phrasing). I ultimately went with 'skip-suspend-mode-switch' because
the root cause was only due to the mode switch not functioning
properly. This property doesn't do anything regarding the mode the
firmware is stuck at as it's only fixing the failed call. Normally,
the driver sets the PSCI to the preferred mode at driver probe (OSI if
supported, PC otherwise). This property simply skips that part and
assumes the FW is already in the preferred mode. It could
theoretically work for firmware stuck at either OSI or PC mode, as long
as the platform shows the same symptom, It is mode-agnostic essentially.
That being said, I'm not completely against the 'osi-only' phrasing.

What do you think of the above rationale? I'm open to suggestions.

I admit that the word "skip" here isn't really helpful since it counts
as an implementation detail. "broken" should better describe that it's
a quirk.

Best regards,
Reza
