Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E6543D4EE
	for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 17:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778521241; cv=none; b=LS8LPlGENrC89NYq9jLwyq6i83lW/lY8rmxjwOGFXhieQC4p+H2GV4i7ADG1xbwUjI7U7dQ1jrWK3g27G2yd65qPQJ+S/ZWYqd3UMAavB/0g9IoYVoxgpt5CIn0/PdHcaOWGDgptoTLbbb0pFLWpIix7ZlZh+5i+pXcM2Pa90ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778521241; c=relaxed/simple;
	bh=30QatsexPGJGyDcExAsSA1Xk3opFonlwu+IFZaezoKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ft7iB2gQz4Qutl79xyqPpgkAvqtRLLI1aT4BLaBboJ1Gs3EjdA4GoR1DmyQwAl/bvQsauSN87r02BH2EpmYQagzFaqOnIhtmBjLRq+E3dqYAXqsEnB2SyNNYif3e3nKsdnEmXitlY2JlSTZOrfAFatMxWEN7wy4o6qFmuTBA4t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xcg8xA1M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xcg8xA1M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CF06C2BCF6
	for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 17:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778521241;
	bh=30QatsexPGJGyDcExAsSA1Xk3opFonlwu+IFZaezoKA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Xcg8xA1MFyWsUWE9WKNcIIbuKkRHSwIF02htPOe6jgMh4Y2V86o1mNlkMi33pSLXb
	 Z6Lb0z4BxPndsiADZZoeWHcOkHU4CFc/KxFXCf8pAwOiqP1eWJU2l2/N5a0r54ik2O
	 oCPRlePrMrFq5s2/uCavyhH0TT8JLKu/dkQ4qnmhRODBM9FcL/egsy3kMyPbYQEufA
	 IaiWaVMEEcC775RqySDo2VjS5utHBjDhCeO1Qysmf2//7oeWN8RdEZtd3CDYPZygRk
	 em8NbIjSI6tj/b0MJReZkNgp/Jb6qsdSPXEtDxu2+z2Kp+NjOTkAYcMDvkZvYGX+XN
	 pHlr0NdqSlduQ==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a8d1f43432so1636968e87.3
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 10:40:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+e6QLKjDV4OEDUaKaUDc3ylNvxAkomMyH1hlopkOL9Cc8SKoAPOMwBXdnsrNm9k5w6xnANrONXAA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5WmSeuPj+KniviLdTbav3EhHcLo4SUSnY2WItOrTjvETT4UAr
	pEw2D0ODcsS9Gn6KY4bvncTtEjxvSVayFMg0hTdKkEvL4DJZUok0rBm+NDx6oNLkjVugkXXNbda
	b3QrSYd3m++EL5yO2AFJT6Tz8bVK6icI=
X-Received: by 2002:a05:6512:3046:b0:5a4:56:aa88 with SMTP id
 2adb3069b0e04-5a887ce5cb9mr8657666e87.27.1778521239239; Mon, 11 May 2026
 10:40:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511173359.212865-1-kmayur809@gmail.com>
In-Reply-To: <20260511173359.212865-1-kmayur809@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 11 May 2026 19:40:27 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gJnJnP2O=R+Wn35wZM4ax9CqwtB0itXBJtrJvLO5jAJQ@mail.gmail.com>
X-Gm-Features: AVHnY4LOJss1MxMUEgSS4PiqeZLtGknnDBgyASngayhWpG70RaF9N33hmOKJEMA
Message-ID: <CAJZ5v0gJnJnP2O=R+Wn35wZM4ax9CqwtB0itXBJtrJvLO5jAJQ@mail.gmail.com>
Subject: Re: [PATCH] thermal: core: fix permissions and cleanup style
To: Mayur Kumar <kmayur809@gmail.com>
Cc: rafael@kernel.org, daniel.lezcano@kernel.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 7:34=E2=80=AFPM Mayur Kumar <kmayur809@gmail.com> w=
rote:
>
> Convert symbolic permissions to octal 0644 in thermal_core.c.
> Also, re-align function parameters for for_each_thermal_* helpers
> to match kernel coding style.

checkpatch.pl is for new code.

Generally speaking, existing code that works need not be "fixed" to
address checkpatch warnings in it.

I'm not going to make this particular change.

> Note: checkpatch.pl reports an error regarding brace placement
> on lines 707, 725, and 743, but these are false positives caused
> by the complex function pointer arguments in the definitions.
>
> Signed-off-by: Mayur Kumar <kmayur809@gmail.com>
> ---
>  drivers/thermal/thermal_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_cor=
e.c
> index 2f4e2dc46b8..c44bc084064 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -877,7 +877,7 @@ static int thermal_bind_cdev_to_trip(struct thermal_z=
one_device *tz,
>                  "cdev%d_weight", dev->id);
>         sysfs_attr_init(&dev->weight_attr.attr);
>         dev->weight_attr.attr.name =3D dev->weight_attr_name;
> -       dev->weight_attr.attr.mode =3D S_IWUSR | S_IRUGO;
> +       dev->weight_attr.attr.mode =3D 0644;
>         dev->weight_attr.show =3D weight_show;
>         dev->weight_attr.store =3D weight_store;
>         result =3D device_create_file(&tz->device, &dev->weight_attr);
> --
> 2.34.1
>
