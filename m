Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795434316;
	b=08wBPBvRrnYL+TFN5ENDpL/+FMZBoNJmsaeKZ8k0DA9akUeu4QfyQzgEsk44NzssqQjK
	 ZKWlOsvYPdu436gHE4wFbcEstiEY7AJq29UiMjCYVlyy1FnY5KKNEixnBx9hYqj5M5Kei
	 NrcKfjHpiBkpyNoAFrGKceTlYFkI4Sl6IjoXyMsk1iDIBHhT14x1KFL1lN8EOrUmNhUf6
	 4506nvhSoEqAe/3S2c5IEvT+fMvTZcER6RYIpgE8IkcnAceKAdFNUVtB/wbhsembmDnLc
	 TDWuIaQzb8dOvwMOGxkB4o3/0nog2xL8YxSJhagNBSxmEiXaSpnS9dv4b72NJYwpyFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795434316;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=O/TZUP+/cDgqPVePhYbaH1kfjdT/O9h7xEGK3jFSArc=;
	b=cJcEzR5vJ/bpiqdkFjPAiLEDGDlTLJ3puwDPHa3rf97+0sA5p+Zw7/eyNtfRtcUKYFq3
	 rLwSWHtDxuXUbNLf2vQ2ewUjTeY+3lyvcnm2RMdfvmtgqOh7cDfy33c2YGLfBSOX2Xyko
	 9um/kvoBtJwMgRYaQrOJz+qR2xJI9eLtzI5Lpz2RikXN/ZUcLKKJTaT2AVdjKKzTK5X6J
	 LvfM0UR+3HEqoOmWOT/8N3JEDljNhV8gzwurmngouWufuQxvkyFILp0zgKAEO4sItR9r6
	 GofSJSKtQX3hoysNuN02T9bLW123fMYbgrBXIn8sig9SlB0hnY6SsEvbfxp7yuhyoXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="M/ov9Ghm";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E26D606A31A;
	Mon, 23 Nov 2026 11:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M/ov9Ghm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F361F000CF;
	Mon, 23 Nov 2026 11:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795434315;
	bh=O/TZUP+/cDgqPVePhYbaH1kfjdT/O9h7xEGK3jFSArc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=M/ov9Ghmefxn9L6wBnE5kr1N83AuM7y28ejF/4o2y1S+n+51U8mODk1l8ZntYty7s
	 yMVF2INlVFW1eEwlL9+pPsSr9yYJDkaPrfXXdakbJW34QZBcUiKJMdbmOL4cYK3EAH
	 wx+ncGycTn3JjvthFloibrAPyry3xrdbnVkxObqS59BXUQiUQzbXsK0hElMsWBq5Mj
	 LxBkZLnTgU9s+fl9RH1taPEHwRHmTbWR6EUxg2oq+Cpr2g2i+HkTT7luDZk/2bb4Op
	 AuRNkfXBmEA93Obu9Jh0na9n0l+cxfW2B0IBB9vNz9/N6mQazTWfigxiTqEXg6Lnnk
	 UA9gqyk2iEoSA==
Date: Mon, 23 Nov 2026 11:45:12 +0000
From: Yixun Lan <dlan@kernel.org>
To: sashiko-reviews@lists.linux.dev, Ulf Hansson <ulfh@kernel.org>
Cc: linux-pm@vger.kernel.org, spacemit@lists.linux.dev,
	devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v5 2/2] pmdomain: spacemit: Add power domain driver
Message-ID: <20261123114512-GKC156439@kernel.org>
References: <20261118-04-k3-pm-support-v5-0-42394acdf3e3@kernel.org>
 <20261118-04-k3-pm-support-v5-2-42394acdf3e3@kernel.org>
 <sashiko-outbox-222182@kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-222182@kernel.org>

Hi All,

On 23:32 Wed 18 Nov     , sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [High] pmdomain: spacemit: devres frees active domains when
>   pm_genpd_remove() fails
> - [Medium] pmdomain: spacemit: unpowered always-on domain in
>   spacemit_pm_add_one_domain()
> --
> 
> commit 3dbb7292ceae5fc8cd5471f6a58e884045deb2ec
> Author: Yixun Lan <dlan@kernel.org>
> 
> pmdomain: spacemit: Add power domain driver
> 
> This commit adds a generic PM domain driver on the auxiliary bus for
> SpacemiT K1 and K3 SoCs, supporting software and hardware power-on/off
> sequences.
> 
> > diff --git a/drivers/pmdomain/spacemit/spacemit-pm-domains.c b/drivers/pmdomain/spacemit/spacemit-pm-domains.c
> > new file mode 100644
> > index 0000000000000..9d77d3f4c182b
> > --- /dev/null
> > +++ b/drivers/pmdomain/spacemit/spacemit-pm-domains.c
> > @@ -0,0 +1,422 @@
> 
> [ ... ]
> 
> > +static int spacemit_pm_add_one_domain(struct spacemit_pmu *pmu, int id,
> > +				      const struct spacemit_pm_domain_param *param)
> > +{
> > +	struct spacemit_pm_domain *pd;
> > +	int ret;
> > +
> > +	pd = devm_kzalloc(pmu->dev, sizeof(*pd), GFP_KERNEL);
> > +	if (!pd)
> > +		return -ENOMEM;
> > +
> > +	pd->param           = param;
> > +	pd->pmu             = pmu;
> > +	pd->genpd.name      = param->name;
> > +	pd->genpd.flags     = param->flags;
> > +	pd->genpd.power_off = spacemit_pd_power_off;
> > +	pd->genpd.power_on  = spacemit_pd_power_on;
> > +
> > +	ret = pm_genpd_init(&pd->genpd, NULL, spacemit_pm_is_off_state(pmu, pd));
> > +	if (ret)
> > +		return ret;
> > +
> > +	pmu->domains[id] = &pd->genpd;
> > +
> > +	return 0;
> > +}
> 
> [Severity: Medium]
> Can pm_genpd_init() fail with -EINVAL for a GENPD_FLAG_ALWAYS_ON domain
> such as K3_PMDOMAIN_AUDIO if it is powered off at boot?
> 

I've checked in U-Boot which before booting Linux,
=> md.l 0xd42828f0 1
d42828f0: 00000008
which shows bit[3]=1, audio power domain already in 'on' state..

So, K3 SoC should have no problem on this.

> pm_genpd_init() requires always-on domains to already be powered on
> (is_off == false) and rejects them with -EINVAL otherwise, aborting
> spacemit_pm_domain_probe().  Also, because genpd never powers an
> always-on domain off or on after initialization, the power control
> parameters defined on K3_PMDOMAIN_AUDIO are unused unless
> spacemit_pm_add_one_domain() powers the domain on before calling
> pm_genpd_init() (note that spacemit_pd_power_on() logs with &domain->dev,
> which is not initialized until pm_genpd_init(), so pmu->dev would need to
> be used for logging).
> 
> > +
> > +static void spacemit_pm_domain_cleanup(struct spacemit_pmu *pmu)
> > +{
> > +	struct spacemit_pm_domain *pd;
> > +	int i, ret;
> > +
> > +	for (i = 0; i < pmu->genpd_data.num_domains; i++) {
> > +		if (!pmu->domains[i])
> > +			continue;
> > +
> > +		pd = to_spacemit_pd(pmu->domains[i]);
> > +		ret = pm_genpd_remove(pmu->domains[i]);
> > +		if (ret)
> > +			dev_err(pmu->dev, "failed to remove domain %s: %d - state may be inconsistent\n",
> > +				pd->param->name, ret);
> > +	}
> > +}
> 
> [ ... ]
> 
> > +static void spacemit_pm_domain_remove(struct auxiliary_device *adev)
> > +{
> > +	struct spacemit_pmu *pmu = auxiliary_get_drvdata(adev);
> > +	struct device *dev = &adev->dev;
> > +
> > +	of_genpd_del_provider(dev->of_node);
> > +	spacemit_pm_domain_cleanup(pmu);
> > +}
> 
> [Severity: High]
> As reported by Troy Mitchell on v3 [1], can unbinding the driver or
> unloading the module while a consumer device is attached cause a
> use-after-free on pd->genpd?
> 
I don't want to combine into this series, see cover letter or the link below
https://lore.kernel.org/r/20261112-01-pm-device-link-v1-1-8932e0862378@kernel.org

I'm trying to address in a separate patch

> Because adev->dev shares the parent CCU device's of_node, fw_devlink
> links consumers to the parent CCU platform device rather than adev->dev,
> so unbinding spacemit_pm_domain_driver does not detach consumer devices
> first.  When genpd->device_count > 0, pm_genpd_remove() fails with -EBUSY
> and leaves pd->genpd linked in the global gpd_list and referenced by
> consumers' dev->pm_domain pointers right before devres frees the
> devm_kzalloc()-allocated struct spacemit_pm_domain.
> 
> [1] https://lore.kernel.org/r/DMQHSDTR177I.1HWHAF4FWTFQ5@linux.spacemit.com
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261118-04-k3-pm-support-v5-0-42394acdf3e3@kernel.org?part=2

-- 
Yixun Lan (dlan)
