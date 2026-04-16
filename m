Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78B329827E
	for <linux-pm@vger.kernel.org>; Thu, 16 Apr 2026 09:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776332607; cv=pass; b=GhPMQDGaphMVcmg3AqqX3eZVwC+RdMTbUc154AKTvUMSrCGS78ZFVZr0Bazdpbp+0sXEXR3FEc/4oitYP7h1WATcaRLD8tyOQimLjJaFHFkYwm0xBravd2g7ODhak8ARtSCb/60nQnbE/1yPH5YyTeaQZqVQniZ21w1ie3TMxzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776332607; c=relaxed/simple;
	bh=tc1aahXe/kJI3XC8Rg2ouu43ca/7LjUrOAsrC0p5JRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KRE4/qJi2K+OjupkIHi7Jlqn7nnp1rrmLRUMsCDgoU34jZ1vf16RZWX2BOw6J/N/b16CLdVmbPPEVunuVUYSfke0mFolzWz73SZAY/5e4YcbdTfmjXE9C7ebaEdP0QjgiAC7y2eHCmMFUesr1XsyxQb3PPFfB1eyyosaHFS0T4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O75Utn3z; arc=pass smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O75Utn3z"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-38e7bd07656so34673791fa.1
        for <linux-pm@vger.kernel.org>; Thu, 16 Apr 2026 02:43:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776332604; cv=none;
        d=google.com; s=arc-20240605;
        b=LTgXaFsr7BCupnA8RYFNq4XP3VBssagMjEKBeXWt9Y5cOHsl9U2XM1LLdUD9UKuepj
         fL0NiM0ntj7jrWyCXDuQLcFgj+tQ2imsG6IYAM8EWrmMkq3MDtz8hUqJuNFUDeGlFTf/
         Q1h57wDLWn73LhPIDLyYB5iPX8Hi1bqoR0tyfQS70WOkW5VL1lhjHENiu9AzYOnIcBlf
         0M3ozTCuaUl3n1y0nFzBtjEAqbmivkUWCZfF3ZYxLU5RWGN8bNwcXDvVAxY8JJJqNv3S
         Pur8/prrjIKwOZyBkXf2ftmcICZFX9U6ylEXEjai7M4QkqK7YkIXaLeNVWZsUEuBr6sw
         hC9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jwzf4S6QgG2jfgxSyqcETN1wIIzICofgP6SGF67d4ws=;
        fh=RWjRWxKh6iODj7+gLORxw+0IZNUVMfRe0bSf0/zlNmA=;
        b=fl7xBosIpOIPkwug+Ba0UVmY7XHgHQnrzcMevx5FV02yeuUnzOJJLCJsJ3vcVHxdjk
         IN1yTPPxtB1HH3xgmIoO4TsM+mV2Idx61czDhKwSlIpSb4FMHHr2wzSpxzgYHILcm1WB
         lXlGWcNY+sjuGbmh4xkTMG/O44Ekgex/a/MojZcS98/5CBjVe3JLBM2r1T3r2ut6dfMe
         CrUBOQreuufloGdbdVGM+Lv5zWvOCzSsZ06zb575kgkC/UH9T16Koc81qjwCO3Hj6vih
         o/+g06+66sybHcImAuwkfVwD5SzEnI+16RN+S0XwpQTI8HJFmUOypvrquhOa0zyYCTwx
         zx4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776332604; x=1776937404; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jwzf4S6QgG2jfgxSyqcETN1wIIzICofgP6SGF67d4ws=;
        b=O75Utn3zt+U0dSmP5ESVAKiNPMaK9twlXm4qAja/aB7Ts58suVQqYGfCBfwyjezBo0
         sz14UMtO6l+Z44LyXjgUcBQ5cuqmUyVlFghfy0Adld9Gh6L19WFPUEdCkHEsqEZ9vz8z
         Arq31BHTLH/k0WwCUavf9/W8XyyNKl3JcEkfPWSxFzrKezxmx7ocB32zI/rrsUVs3ayN
         6imTw8b4VkFieBjkHbkX6AcajJqYbhHp5ZBN04ohoMwNXHprLgp0kaRFO0LzNlQLT1/j
         C5Wi0FNAdltGHgxyKtbHo4DY7CM3MShELxniWfoSv33u97NutAVZlbArToDFubvO7CaW
         3J6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776332604; x=1776937404;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jwzf4S6QgG2jfgxSyqcETN1wIIzICofgP6SGF67d4ws=;
        b=iQV+I+aEdapany6sL5vRlUOp5/rLGrxodLGBgh1UV9LBtiReRUJQBkJ3NF7xteWv2y
         /gUDSUUV2e7Wa7DrZEubN4BIDNHfkBSHpDrD1r8gVXlgM2vnnshqq9Va34hBxn8a7pyz
         kkSoSUdzNHTe/91OMKVd3lLEa2f2d8kZWDqA/ZviKfBWQD4+O+PlDjwwHKGhpO2KPfix
         jJ8HhnOXswqg0JzrsXFYR5qnyP0R9urftSm+W64pQrNLVeQO2LGWqtqIJy7t/vZKVSEI
         YPIiMecaWURFweeGoGaRtMBC4jjHhhWurOZSO9UKQXkTwJeWz9/sH5gmNkOBXyPJfVBG
         WJ5g==
X-Forwarded-Encrypted: i=1; AFNElJ8B+g0tEQOY13xvGfecz4bj7dd9I6CIlKhgvD36KvDHUBfUM2bFlxbTKt/W8fBGtlff5CUve3tMig==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0VaFynyROu8vAzL/tsOcZodmCew4A9wY88oQl4Kq2or08hg45
	SxGI9TnRHB33FZ+AiUBXT0hPygI1YWbtllH2WVhF5wHEOO0XcBEiG9nuNlVqcYu+RvwrFOhioRO
	mThjKS8DE4A1o4q5AmPbxvyRUZalJ+RBKwkVDhl4Daw==
X-Gm-Gg: AeBDieuUWInx1rcu8DKY4Z20I544a9hmfdUvLxCisHRC4C+B/Uib1tguV9nNyMYZUMD
	90C7hwf9STy52YvaNih2fCz+s0KIpB1I3o07rII0HpuW5EhU/uliVIw1n+zyjUS9lOag4tUR6kp
	I8LKxwC1t6oD9TKfnsGCzzWH1ypiEMhUSb7oE5WMMcUvaYJQIsBjFmi/HCmWXztxpgPA2Ad+51Y
	p3xsY0GFsLzcjPNzKcIlIrYq4Fg63bt19SzPAVRkO6/R0XAcr5VIm1PUHkwVkZ4a7vsJ8WfBLTE
	ZB9wjTIurYK4Pfg4Vlo=
X-Received: by 2002:ac2:4855:0:b0:5a3:f309:42bc with SMTP id
 2adb3069b0e04-5a3f30942c8mr5012628e87.35.1776332603751; Thu, 16 Apr 2026
 02:43:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410104058.83748-1-ulf.hansson@linaro.org> <CAMuHMdWHnANr4R+AW5-xHrm=D4SJLuKVF5mq3PFkbevcTz5qWw@mail.gmail.com>
In-Reply-To: <CAMuHMdWHnANr4R+AW5-xHrm=D4SJLuKVF5mq3PFkbevcTz5qWw@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 16 Apr 2026 11:42:47 +0200
X-Gm-Features: AQROBzByupCgfYQNSB5KjMp-9WACrVqsXB76aGpaQekAwhIX9pEpFrllJozXBsw
Message-ID: <CAPDyKFpxooSD=k2jtMgMqTDP+ovmqZWoo_VBsKfpce3vRaZfSg@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] driver core / pmdomain: Add support for fined
 grained sync_state
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Saravana Kannan <saravanak@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, 
	Sudeep Holla <sudeep.holla@kernel.org>, Cristian Marussi <cristian.marussi@arm.com>, 
	Kevin Hilman <khilman@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Bjorn Andersson <andersson@kernel.org>, 
	Abel Vesa <abel.vesa@oss.qualcomm.com>, Peng Fan <peng.fan@oss.nxp.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Maulik Shah <maulik.shah@oss.qualcomm.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 Apr 2026 at 11:15, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Ulf,
>
> On Fri, 10 Apr 2026 at 12:41, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > Since the introduction [1] of the common sync_state support for pmdomains
> > (genpd), we have encountered a lot of various interesting problems. In most
> > cases the new behaviour of genpd triggered some weird platform specific bugs.
> >
> > That said, in LPC in Tokyo me and Saravana hosted a session to walk through the
> > remaining limitations that we have found for genpd's sync state support. In
> > particular, we discussed the problems we have for the so-called onecell power
> > domain providers, where a single provider typically provides multiple
> > independent power domains, all with their own set of consumers.
> >
> > Note that, onecell power domain providers are very common. It's being used by
> > many SoCs/platforms/technologies. To name a few:
> > SCMI, Qualcomm, NXP, Mediatek, Renesas, TI, etc.
> >
> > Anyway, in these cases, the generic sync_state mechanism with fw_devlink isn't
> > fine grained enough, as we end up waiting for all consumers for all power
> > domains before the ->sync_callback gets called for the supplier/provider. In
> > other words, we may end up keeping unused power domains powered-on, for no good
> > reasons.
> >
> > The series intends to fix this problem. Please have a look at the commit
> > messages for more details and help review/test!
>
> Thanks for the update!
>
> At first glance, the only real change compared to v1 seems to be
> the removal of printing
>
>     pr_info("%s:%s con=%s\n", __func__, dev_name(dev),
>             dev_name(consumer));
>
> Right?

Correct! I forgot to include a version history, sorry.

Besides the removed print, I have just added your tags and updated the
commit message in patch9.

FYI, my plan is to queue this as soon as v7.1-rc1 is available.

Kind regards
Uffe
