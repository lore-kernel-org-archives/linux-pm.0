Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2043D411A
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 13:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779802491; cv=none; b=rhQO8TBB7O0PlIb2wlVhGK1BP/eO9AOynT2QdW5VXySNPXnyPu8kJzw5tZubldoAlN+RWe5rQbP2kqhMszWl87ngUvY0QdEpCADzloc216a3fuYM++WESdXibvuw6LUCzh4jwiHLAHk55sCnv9FWgiKgte83n6FB9X3P62H/wBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779802491; c=relaxed/simple;
	bh=P2ehno1YErmvizuB79N7xr+7qrKGR3WNRhBZOc62bQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X7nGDAMgqAJpbsqeh9tMVuKeAWYOaWcIyHUay+Ivu06cJoBwG+c69DnHAz8rmJ8V3fVYUrNgMbkM6etgWeKRT0hoP+9EqqJWqZVWdv2xYUdi5x1AZvj1S9QmldiGni9gs8MLwhHpkRn3BDJ+QucwH3frMUcVQuA3ud2JTdrdOm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vx5CZkmx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vx5CZkmx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 199071F00A3C
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 13:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779802489;
	bh=h0M+ucjsCvDEyWupY9AZdbx6j10Egj2FR2XnU87Mm7E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Vx5CZkmx5Alpq1ITiAW8JRkNccqLhWyjP8d6fJsr0kHvYWUYJiL+brc/uZRVybki4
	 T4w7dqYQ7GwHSkKFOP/b0jiIfo9j7xZ49L09T9KfvX/Oi16wfFUlUwSqQInk6IAdOj
	 /V1kqYELXE8ox8Iz2VuwfdlC375QdGlenoEj5viH/Q473lC9uByCGvj1oRIlHqvHaq
	 Ne6dCAEnd9qNnOZINEiCHveji2p3H1+/YmDtoTNFBKrFa00/GRRan7n2h8BZJIv/4b
	 k6vA4p38dPYJk5z9o+lsCvMn9Jt7j19zbqrpp3Suw0/RanzN6J5EkUD/rh8HO77qED
	 fl4Jdo8hk1sag==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a742b8b72eso11905273e87.1
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 06:34:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9ufh6X941GPjqgBvGE9/Qn5cro7ZqQH9q6PcBCaS39sBF2oLp/zoJiy2OIrGy2gOCmnAz00SZtrw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzP8I0DvSEdlB+coEHQmxFj13Szv9Yd1lOxDYEahOMenKiT0Yec
	ma+nBRcn0UO1PwqLNTRn48Yt9U3509GY5n8LUQBVnTTNcWRGH5pcaKFAaNfspJ7MITrJWJ6+AJb
	XVMIO6Od+Uu9zJAgREB8bwybHw+BOAHY=
X-Received: by 2002:a05:6512:2113:b0:5a8:b92f:5471 with SMTP id
 2adb3069b0e04-5aa3238e249mr4615195e87.23.1779802487448; Tue, 26 May 2026
 06:34:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515184250.228062-1-sumeet4linux@gmail.com>
In-Reply-To: <20260515184250.228062-1-sumeet4linux@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 26 May 2026 15:34:35 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iWMWa9SfiXgk6ripi0Gke9r97+uK5B-=UpXvpqubSRSQ@mail.gmail.com>
X-Gm-Features: AVHnY4JhycEgku20-1iUUTt-m6UOnOuqOjVZRDADYrBcLbr9wH35GFMxj2V8Crs
Message-ID: <CAJZ5v0iWMWa9SfiXgk6ripi0Gke9r97+uK5B-=UpXvpqubSRSQ@mail.gmail.com>
Subject: Re: [PATCH] powercap: intel_rapl_tpmi: Handle PMU registration
 failure during probe
To: Sumeet Pawnikar <sumeet4linux@gmail.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 8:43=E2=80=AFPM Sumeet Pawnikar <sumeet4linux@gmail=
.com> wrote:
>
> intel_rapl_tpmi_probe() invokes rapl_package_add_pmu() but it ignores
> the return value, so a PMU registration failure may leave the driver
> reporting probe success despite the PMU being absent, with no log
> trace. Worse case scenario, the previously-added RAPL package would
> not be torn down.
>
> Add check for the return value, log the failure, undo the package
> addition with rapl_remove_package() and fail the probe.
>
> Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
> ---
>  drivers/powercap/intel_rapl_tpmi.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/powercap/intel_rapl_tpmi.c b/drivers/powercap/intel_=
rapl_tpmi.c
> index 7f41491d9cd1..8bc95310b542 100644
> --- a/drivers/powercap/intel_rapl_tpmi.c
> +++ b/drivers/powercap/intel_rapl_tpmi.c
> @@ -414,7 +414,14 @@ static int intel_rapl_tpmi_probe(struct auxiliary_de=
vice *auxdev,
>                 goto err;
>         }
>
> -       rapl_package_add_pmu(trp->rp);
> +       ret =3D rapl_package_add_pmu(trp->rp);
> +       if (ret) {
> +               dev_err(&auxdev->dev, "Failed to add RAPL PMU for Package=
%d, %d\n",
> +                       info->package_id, ret);
> +               rapl_remove_package(trp->rp);
> +               trp->rp =3D NULL;
> +               goto err;
> +       }
>
>         auxiliary_set_drvdata(auxdev, trp);
>

Please see the sashiko.dev feedback on this:

https://sashiko.dev/#/patchset/20260515184250.228062-1-sumeet4linux%40gmail=
.com

and either address it or explain to me why it doesn't need to be addressed.

Thanks!
