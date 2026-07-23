Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CB247140D
	for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 13:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784813946; cv=none; b=SKgd4bi8KGBSVOjqkpOLeIQDchkHSK3bsjIt5f95x1uCNB/0MQC2Qm0Z1/eIyK1nVjxEN2PFhndG2aQGt5PYUf5d0uxqBSd+lixlTvjhnz4kFCAOi3J5eIj1AQZ1cstSbNmPC28MwEjuayzZwSZi8glSDQNk4S4SuuP6l8vc2uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784813946; c=relaxed/simple;
	bh=OQTuO4DN/hFEJtYQR4kVIIZZu9dB7ui6IGjs3jsNKks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ASp9snYFbPeywq00wTnE1Youy+SjcJIpyuTbbVpVP60X0hKJCjhh8ia5m1etpM+p/73yR/gOUKNE4A6ShSPsAqGaA7XKN3nXPY7OX9uUYUrj6ldAxBC9zU6JI1OaAF9kh/9dT4j8AnM0EJS1/UzFzaogZIG28nrQmZR3ZrEPA2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A9E11F00A3A
	for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 13:38:56 +0000 (UTC)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-39c74722e27so5159501fa.0
        for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 06:38:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpkzN51glafxCv6peFdRMbQ9r2eYO5mPf4mDFyiOwGDGtmGvr2fCdKQ6jEYCVzPKXU5Qbx73KGoBA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzC0BwAVKMhtt/Q+VajbSNuoRou+Foeb9y3ji+8ztcD0XJFl8wE
	b3xne/iFORJfbs3TLTVrL3vhTv48fW7Owb5JnO9L/GJyLTWkOCIQaX59s6MWCsuJDFtwZGoO15T
	AtoXDrpj+QXeO2MEL3AnOmXcFNRTeq5s=
X-Received: by 2002:a2e:a594:0:b0:38e:8357:c5ae with SMTP id
 38308e7fff4ca-39f09812c3emr4867161fa.9.1784813934830; Thu, 23 Jul 2026
 06:38:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260719085100.145555-1-sumeet4linux@gmail.com>
In-Reply-To: <20260719085100.145555-1-sumeet4linux@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 23 Jul 2026 15:38:41 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hb-FAZXvP3T-6+rv5bFuhCjhJgvDh-sZDTa1KUfjvdPQ@mail.gmail.com>
X-Gm-Features: AUfX_mwYgZA0ldiuTIs-y2i-cjp9f-mmmfduYz3h1Et-gk1xnOCyP4ajBxZsTvo
Message-ID: <CAJZ5v0hb-FAZXvP3T-6+rv5bFuhCjhJgvDh-sZDTa1KUfjvdPQ@mail.gmail.com>
Subject: Re: [PATCH v2] powercap: intel_rapl_tpmi: Handle PMU registration
 failure during probe
To: Sumeet Pawnikar <sumeet4linux@gmail.com>
Cc: rafael@kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 19, 2026 at 10:51=E2=80=AFAM Sumeet Pawnikar <sumeet4linux@gmai=
l.com> wrote:
>
> intel_rapl_tpmi_probe() invokes rapl_package_add_pmu() but ignores
> its return value, so a PMU registration failure would leave the driver
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
> index 7f41491d9cd1..078a85158ce4 100644
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
e%d, %ld\n",
> +                       info->package_id, ret);

Please fix the format string as per the Sashiko comment at:

https://sashiko.dev/#/patchset/20260719085100.145555-1-sumeet4linux%40gmail=
.com

>         auxiliary_set_drvdata(auxdev, trp);
>
> --

Thanks!
