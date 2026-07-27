Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76CA19DF62
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 14:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785162632; cv=none; b=HlVRyYpikUMkFxdIIJoP6YpBngmQNQnnhqfll3Saq+jReIIkKsK4pA+BHRbn1+Jo9ouBOQiVH9Zq2tCWYcM7dDGEz5iHOqVrEJQI/ZCzOTMEXC/tQ5K5K9H8DvhCAqCQo/qUYKa9fn0yBXP84GFty9Z1yv3fAaXOAIEjyN7SciI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785162632; c=relaxed/simple;
	bh=Tt0oQNJSjoI49maDYnclb3miLTDfBBIehZosh1R1mGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ADZiCFxoWDs4dXQeDlEg42aTF0uchFARAq0xiJHb5UScb+xv9ER5LDrTIpbFoI/NBH/LEfM2KQ1lh83tymWR1+KmmkoqhdzLOGn9KV2WGJ3bg4yRq4VtqNPye+L8y+cKDY5gq/kt9QevXt+JXaHYhk/LzQvHrbxZ6AFiZLaY+Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+9yRJXx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+9yRJXx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E664C1F00A3E
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 14:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785162627;
	bh=8hJ+TMhcAx6rGXBJm2K6Kp6oGOMldVVuUivL4Q4i98o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=g+9yRJXxm0l/eDBvr2nloQZMf8v3tNtKOL5LiqLkYlur/DVYYB2CodMdHKHrTy+BE
	 zRFxUEA1aI54sJNH67rsVZ9iRM4jdut1VAznXAvp93QfNAU3AwhJNygq1wGLmZgJmH
	 SzckfAKH90D65gTFxk8PnNV5FNVySB5QWq2UbweJYJqHYI4QfAT5ZKoLblzUB9HyaW
	 XizuMnkXRKmnrpq4LfK3UknFvxR7DCydL8BQM0v2vgv7GMPZjIHtXb+OoeQ3rhR7S0
	 MeCGx3RSPiDITQNK3b3uzOPbPyOsQ8P+ad+zXNuJqvJZmlMEniVQInXf1ITeczo/NB
	 Pty06m9mtx+8Q==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39c953950dfso24638131fa.1
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 07:30:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpLt7RsamZ1HttMpOOkEJ1DmDMph+d99UN9YQ9SzCYvEsJ81oAv1q0CXMLXv/XKbAKndOHTrJ3D/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxdwWf/lmA2ZVDApCDAl4xJ9I/viD2SxgfGAPkYO108iamUUkto
	IJhPXqpoikqRqbHb/hEWQOIvUTjbCpfUA/ntzYPHOwmMgDigRxmguDI+AuiSZjNRty3YokzrEkY
	TFFsgiJIKnCQUCEVL3zGaVc2zhn9qv24=
X-Received: by 2002:a2e:a988:0:b0:39b:b01:ab84 with SMTP id
 38308e7fff4ca-39f4a6b12eamr1586341fa.3.1785162626387; Mon, 27 Jul 2026
 07:30:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723172321.5960-1-sumeet4linux@gmail.com>
In-Reply-To: <20260723172321.5960-1-sumeet4linux@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 27 Jul 2026 16:30:14 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gV5dz7RCu0XmH70Bv6bABH+Swii88CJK++oEdmDoSohg@mail.gmail.com>
X-Gm-Features: AUfX_mxMpTxRRJcczYnrLt8QIPGG8ZDlEutSiJ8hoQoMpU9KB76lakFjnaahFTA
Message-ID: <CAJZ5v0gV5dz7RCu0XmH70Bv6bABH+Swii88CJK++oEdmDoSohg@mail.gmail.com>
Subject: Re: [PATCH v3] powercap: intel_rapl_tpmi: Handle PMU registration
 failure during probe
To: Sumeet Pawnikar <sumeet4linux@gmail.com>
Cc: rafael@kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 7:23=E2=80=AFPM Sumeet Pawnikar <sumeet4linux@gmail=
.com> wrote:
>
> intel_rapl_tpmi_probe() invokes rapl_package_add_pmu() but ignores its
> return value, so a PMU registration failure would leave the driver
> reporting probe success despite the PMU being absent, with no log
> trace.
>
> Since PMU registration is an optional auxiliary feature for perf energy
> counters, its failure should not break the primary powercap functionality=
.
> Check the return value and log a warning to ensure graceful degradation.
>
> Fixes: 963a9ad3c589 ("powercap: intel_rapl_tpmi: Enable PMU support")
> Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
> ---
> v2->v3:
>   * Fix the format string as per the Sashiko comment:
>     https://sashiko.dev/#/patchset/20260719085100.145555-1-sumeet4linux%4=
0gmail.com)
>
> v1->v2:
>   * Since PMU registration is an optional auxiliary feature here,
>     treat it's failure as a non fatal error and log a warning
>     and continue, similar to other RAPL drivers like intel_rapl_msr,
>     to ensure graceful degradation (Based on Sashiko feedback:
>     https://sashiko.dev/#/patchset/20260515184250.228062-1-sumeet4linux%4=
0gmail.com)
>   * Add Fixes tag in changelog.
> ---
>  drivers/powercap/intel_rapl_tpmi.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/powercap/intel_rapl_tpmi.c b/drivers/powercap/intel_=
rapl_tpmi.c
> index 7f41491d9cd1..a870199a9272 100644
> --- a/drivers/powercap/intel_rapl_tpmi.c
> +++ b/drivers/powercap/intel_rapl_tpmi.c
> @@ -414,7 +414,10 @@ static int intel_rapl_tpmi_probe(struct auxiliary_de=
vice *auxdev,
>                 goto err;
>         }
>
> -       rapl_package_add_pmu(trp->rp);
> +       ret =3D rapl_package_add_pmu(trp->rp);
> +       if (ret)
> +               dev_warn(&auxdev->dev, "Failed to add RAPL PMU for Packag=
e%d, %d\n",
> +                       info->package_id, ret);
>
>         auxiliary_set_drvdata(auxdev, trp);
>
> --

Applied as 7.3 material, but I've changed the log level of the new
message to "info".

Thanks!
