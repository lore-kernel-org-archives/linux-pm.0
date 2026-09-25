Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010EC2931DE
	for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2026 17:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790357454; cv=none; b=o+Ivi9EoxjwgJIXG07s2TrTjTlstILIfwnzhBy7bK/Sfgx/k7smlHWOG6GIiB0ljWtxgpXFb+ubMMPZPVElXEuJHK6FxZy4ktXRy4EwVMEMjDJEAeEzzwB4dk0fSXBVKRnUZ3hKhczrtKVfNzVeCJ/kT+iVSQxtHGB+XVO7G6ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790357454; c=relaxed/simple;
	bh=tMANEnh28G4gjKICJ4CJmZpedyKfSj78ViMvzrZBw1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kr7aAI2U5FERC82in8msBVcdYZFB5MFEaiRLbCgA10Ikv6xkhSqEAzMdmxSmte+ZH7U5v9MC4ROCy6RfyHWM3mdGkfu5la9vuz6YJPMsv9RGxqm2m4Lhuu5Z8ffgRPfTT2hLiYWuqZnl7Jq7V/DxA0AcW5qci+VNwVL20X70mgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/XUqu53; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/XUqu53"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE9A31F008A1
	for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2026 17:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790357452;
	bh=Epk7UhZ5gcKRlHUrHbKgkjCtg/Lgn+z/n5ZSjQcdqpg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Y/XUqu531F/cGxWNwQZP2KG77Zo/WMA+a2WvMMRbN7BfMI9PrV3w2grWHN7FeDQ3P
	 V6H1WGyGtemPdDpa86l7/FirJmYdVcLZ0afDSQpWpcaagB9mIMo/4IimSgl+irC+Ba
	 7Uwoa8O/oiLOgSfajuan9d0VUnzxBFnHegatmVAc08ehBPOnl/k7CrIF5FSxYGlwcI
	 qbUaMkE0+tJgd54/hu7JN0b8vSKyHceLGyOzCKk/ZGOcik/F3I/rchZ8mJt16+4dqM
	 CRH8mXtTHa/HDfUQiyO8mONN560pa+TrMq2oukgjlnIkhq8Y4dwiri294Ymt7GhEjZ
	 1Q3lnD9Gbf4OQ==
Received: by mail-lr2-f35.google.com with SMTP id 38308e7fff4ca-3a5e548cd7dso8804351fa.3
        for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2026 10:30:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzl8kJ+38uL8m0zPCGJCyXuUXPjDrkW3thwZTkIC49Gt6lsGcyv66mGI2CdJPOGSiroB6y3el/5aQ==@vger.kernel.org
X-Gm-Message-State: AFuF++nexJsslyAR7sAhG4z7jHXMLzIPss10HX8WQtJQkuKBFUAevpU8
	Nd5f+sBZNrlZ7V7ZF1uc6Cmm3+QITeEKy5cK4etFh3mBt/lrdklR2tr5BziUInsDQyv3Etzyy7+
	DkWqAVAsvfispLZNPB038EjJg09a/pUg=
X-Received: by 2002:a05:651c:b1e:b0:3a5:f041:d7c9 with SMTP id
 38308e7fff4ca-3a63c2fbe45mr14867181fa.22.1790357451157; Fri, 25 Sep 2026
 10:30:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260912191156.185448-1-sumeet4linux@gmail.com> <20260912191156.185448-6-sumeet4linux@gmail.com>
In-Reply-To: <20260912191156.185448-6-sumeet4linux@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 25 Sep 2026 19:29:14 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j49-yEYmZXm8-2xWzy9OV7-8dUEwMonzPjbscgGd+6qg@mail.gmail.com>
X-Gm-Features: AclHuK-XXXjTpNVDNNDdptaZZX-F6i5Cfcawa8JfiTGZUJ-XQXiTSEwpAEK52uE
Message-ID: <CAJZ5v0j49-yEYmZXm8-2xWzy9OV7-8dUEwMonzPjbscgGd+6qg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] powercap: intel_rapl: Use %pe to print error
 pointers symbolically
To: Sumeet Pawnikar <sumeet4linux@gmail.com>
Cc: rafael@kernel.org, krzk@kernel.org, amit.kachhap@gmail.com, 
	daniel.lezcano@kernel.org, thara.gopinath@gmail.com, talel@amazon.com, 
	hayashi.kunihiko@socionext.com, mhiramat@kernel.org, mmayer@broadcom.com, 
	viresh.kumar@linaro.org, sumitg@nvidia.com, peter.griffin@linaro.org, 
	myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com, 
	Frank.Li@nxp.com, s.hauer@pengutronix.de, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, sven@kernel.org, j@jannau.net, 
	marcan@marcan.st, casey.connolly@linaro.org, sre@kernel.org, wens@kernel.org, 
	t.schramm@manjaro.org, bcm-kernel-feedback-list@broadcom.com, 
	linux-samsung-soc@vger.kernel.org, kernel@pengutronix.de, imx@lists.linux.dev, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 12, 2026 at 9:13=E2=80=AFPM Sumeet Pawnikar <sumeet4linux@gmail=
.com> wrote:
>
> Replace PTR_ERR() and %ld with %pe and pass the original pointer directly
> to pr_debug(). The %pe format specifier prints a symbolic error name
> (e.g. -ENOMEM) when CONFIG_SYMBOLIC_ERRNAME is enabled, otherwise it fall=
s
> back gracefully and prints the raw integer value. This makes messages mor=
e
> readable without any functional change.
>
> Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
> ---
>  drivers/powercap/intel_rapl_msr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_r=
apl_msr.c
> index a34543e66446..46972ee1ff84 100644
> --- a/drivers/powercap/intel_rapl_msr.c
> +++ b/drivers/powercap/intel_rapl_msr.c
> @@ -582,8 +582,8 @@ static int intel_rapl_msr_init(void)
>         rapl_msr_platdev =3D platform_device_register_data(NULL, "intel_r=
apl_msr", 0, def,
>                                                          sizeof(*def));
>         if (IS_ERR(rapl_msr_platdev))
> -               pr_debug("intel_rapl_msr device register failed, ret:%ld\=
n",
> -                        PTR_ERR(rapl_msr_platdev));
> +               pr_debug("intel_rapl_msr device register failed, ret:%pe\=
n",
> +                        rapl_msr_platdev);
>
>         return 0;
>  }
> --

Applied as 7.4 material, thanks!
