Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FBA27EFF7
	for <linux-pm@vger.kernel.org>; Thu,  2 Apr 2026 08:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775119161; cv=none; b=m5bL/2NbU/Azkx2w8fR8YiktGm1GQMnlNP0G6Xp8PwOpGUEsx7DDNH800jeCHisIN7Lyf4oePHf97IjgWz5c30R45cqOHkpy54g66KuURQs02YQZQ1KpmDmNWqT/OqKj2b9fgYepmW7JfjtH1GqiqMs66z1nDuDJSlg4VxpeT+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775119161; c=relaxed/simple;
	bh=yjDF3UWajtmEl14vJIGtnLU61WAB9fLljnwfe8PDCxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fBp31FzcrQFsS9dvgX3sxb/qyBAyhgUi1V8RqEzHtGbmMBiJpXG1GzL7UHoMsVnqCO3faSVKwMguMhqmmY4x/JV85SBnSgFowEFUz3T7E7Bemy+Vb+3xzFIN6KYTEEzESUxwKiPnDrcC9X3xq7ZTW78rR4+MNqSn/mk0wKX3Pu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WPzSU2Rn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPzSU2Rn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A11DC2BCB3
	for <linux-pm@vger.kernel.org>; Thu,  2 Apr 2026 08:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775119161;
	bh=yjDF3UWajtmEl14vJIGtnLU61WAB9fLljnwfe8PDCxg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WPzSU2RnEb2/6cfnKznkFiARpckj/8cI7l1iqL4jpiCzl+woeHeBw9MIqihuTTDzc
	 I21gGenSbIdD6VXhVQlkKUHIzVoCnPCY1bGYRWQSKbTd/xP60Q6+6ciiRP4KzEew5H
	 4h1c3/1IpfMZSjD6ZBxf1imPFhwGOqhK7+s1akDpbG0HKJbtaRnoN8k2L+84DfbE1U
	 tha4Hpf6XIwsHwZWj7jaDZ2uhh87f+IHI+oS/l5ulhlK8qz4XFsTy44ZQWIm/Ufugm
	 Jdap3Sx4uSwtA0oFyszl+bwEHhY7t2/wFfNi4IuJj/yxVpJpzUnkkp4j1WB29Sdon1
	 wd3c+PnHBLa+g==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-38c688bdc71so4732401fa.2
        for <linux-pm@vger.kernel.org>; Thu, 02 Apr 2026 01:39:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWrGDLp3Vwy5Rgf9C3Kj/hSDn8+l7Oub7G61R7E/C7wTo1OKpSlxXCyFzefsM0fjmSTLCjzaKDZKA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYpUfJqxX97L3fo6PzswFDImeqUS7s5HXBFXN8D73gws+Zigcb
	K7bogNdF0SegMvegZcE+0JmdRt6ne0LExwspj3MytqzBJO+l+Ei/6fQO+ulNFDkJpGegJdZdwuN
	tKV+eYz30ynoH8ex4iFKkPpIhM1HPW62sVaHtcaoDjA==
X-Received: by 2002:a2e:9dd1:0:b0:383:20cd:52fe with SMTP id
 38308e7fff4ca-38cc3059f8dmr19168421fa.17.1775119160035; Thu, 02 Apr 2026
 01:39:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401091847.305294-1-arnd@kernel.org>
In-Reply-To: <20260401091847.305294-1-arnd@kernel.org>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Thu, 2 Apr 2026 10:39:08 +0200
X-Gmail-Original-Message-ID: <CAMRc=McYdb-R6QpEKn+VoB4KNKLUJzT82BVzBUYdX+HEqhyB1w@mail.gmail.com>
X-Gm-Features: AQROBzCckivygEgdyGkT4GysSuC5OVs7TCr6SL5Y0t1BbBQ1puToVL_cfSMXCck
Message-ID: <CAMRc=McYdb-R6QpEKn+VoB4KNKLUJzT82BVzBUYdX+HEqhyB1w@mail.gmail.com>
Subject: Re: [PATCH] power: sequencing: pcie-m2: enforce PCI and OF dependencies
To: Arnd Bergmann <arnd@kernel.org>, Rob Herring <robh@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 11:19=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The driver fails to build when PCI is disabled:
>
> drivers/power/sequencing/pwrseq-pcie-m2.c: In function 'pwrseq_pcie_m2_re=
gister_notifier':
> drivers/power/sequencing/pwrseq-pcie-m2.c:368:54: error: 'pci_bus_type' u=
ndeclared (first use in this function); did you mean 'pci_pcie_type'?
>   368 |                         ret =3D bus_register_notifier(&pci_bus_ty=
pe, &ctx->nb);
>       |                                                      ^~~~~~~~~~~~
>       |                                                      pci_pcie_typ=
e
>
> Similarly, when CONFIG_OF is disabled:
>
> drivers/power/sequencing/pwrseq-pcie-m2.c: In function 'pwrseq_m2_pcie_cr=
eate_bt_node':
> drivers/power/sequencing/pwrseq-pcie-m2.c:191:9: error: implicit declarat=
ion of function 'of_changeset_init' [-Wimplicit-function-declaration]
>   191 |         of_changeset_init(ctx->ocs);
>       |         ^~~~~~~~~~~~~~~~~
>
> Make both dependencies unconditional to prevent compile-testing
> in either configuration.
>
> Fixes: 3f736aecbdc8 ("power: sequencing: pcie-m2: Create serdev device fo=
r WCN7850 bluetooth")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Hi Arnd,

Mani posted the following series[1]. It seems to me it fixes at least
some of the build issues.

I would really prefer to keep the COMPILE_TEST option here. I'm seeing
that only some of the symbols depending on OF_DYNAMIC are stubbed out.
Rob: is there any reason for that? Would you be willing to Ack a patch
adding stubs for the remainder and me taking it along with the pwrseq
changes?

> ---
>  drivers/power/sequencing/Kconfig | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/power/sequencing/Kconfig b/drivers/power/sequencing/=
Kconfig
> index 1ec142525a4a..77c6d9227251 100644
> --- a/drivers/power/sequencing/Kconfig
> +++ b/drivers/power/sequencing/Kconfig
> @@ -37,8 +37,9 @@ config POWER_SEQUENCING_TH1520_GPU
>
>  config POWER_SEQUENCING_PCIE_M2
>         tristate "PCIe M.2 connector power sequencing driver"
> -       depends on (PCI && OF) || COMPILE_TEST
> -       select OF_DYNAMIC if OF
> +       depends on OF
> +       depends on PCI
> +       select OF_DYNAMIC
>         help
>           Say Y here to enable the power sequencing driver for PCIe M.2
>           connectors. This driver handles the power sequencing for the M.=
2
> --
> 2.39.5
>

Bart

[1] https://lore.kernel.org/all/20260401070735.107162-1-manivannan.sadhasiv=
am@oss.qualcomm.com/
