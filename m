Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794566898;
	b=DwTCU0/nbHLeqxNbPP0nq949uDIR7xj+8GzvNvKfas9MVYQUw8WjK11wW/kUiPL9OB6b
	 lP1Ritf+5GZWcK1sjBG4OIjDYLWZOLufPjFIQaK/3DTMPtyekEm+P0SPeWF29qrfuR1kQ
	 zo7jS5MYPZ8SP5T1svPbbmtw4IeM8rfMHWMTQd1AzrkaC4w9MUvOHfPsyw8C7CxYp1jwx
	 hX9XRtYyyXtjJnfme1i07qmMTOkbPTaLZdcdmc5MDim8z1nZ53Phswf9t5S/hq7C+67RN
	 nT8trPnt3oc1t4MBfyi6l/LJyeGB0q7I6j+NyIW+8QBNN3GGcTauN41Ct4USs5CfWpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794566898;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=33cVRKk3YgstXddql5txx0xbzf1mHptz6aS9wSjcTFw=;
	b=b4ap0MReJxvaNeJXj5VKYodgosHEjt6HhycA3PpnWDp5vygcuf6LrsjNZl8tdQirwDmW
	 MmPXX1T30Qi/i1d1J0vdN3UoIMwrV+sLS+EvOOk6oNSctR/E/fYFv9R5obT/fubd956e7
	 gnkeIVP4InOIhye7KJj2r8YmeXSMsClj9WxrKca9wwM8e0T+xi5dU3GJcVn5Gqv2cCqzx
	 jI3m+HTdzQ6p2hxVdDtyve2bEh+lGErnuvbmMyvUfCubpAYaj8IquMYk+XMvoru0mVNQe
	 7EiIo1CHOQy/VsjCeG0ebdmTeqKkl0NFqiN063R22hJdFK0FzgF7Ui1eAoXM1g5NOQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S543vWSv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849BA606A31C;
	Fri, 13 Nov 2026 10:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S543vWSv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A254F1F000C4;
	Fri, 13 Nov 2026 10:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794566898;
	bh=33cVRKk3YgstXddql5txx0xbzf1mHptz6aS9wSjcTFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=S543vWSvlhe1976ESvDx0Sh8BK29rzjm9wRA/T4CDpA0WLlHO8848X+WcfQS63iOi
	 Nhz3JLybLhmz93t2GNNQ6NCUV8JbmlWh4gQ7c2QkLyZdVXIjgvZA7pyBnYZw39HMb6
	 ZfHWNZOWsAjUs1G307mf40Rri7lATqBoGvUAWMYq1wG+zsrSHgokWCOhnRXBd1vRBf
	 Rn40AGWVJ0/DQRhVlOJdULOcYE76LwTWqE0pZlm6Upf1nesfauMThvJob+pd2QvqL7
	 +qGxqYsDaYTsXaVgQp7sG2IvhW49f74sc/ngcEyoG4zmS2toEumlD3Diz4g5gF4T5v
	 EIDdH4WTzsWCw==
Date: Fri, 13 Nov 2026 10:48:15 +0000
From: Yixun Lan <dlan@kernel.org>
To: Ulf Hansson <ulfh@kernel.org>, sashiko-reviews@lists.linux.dev
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	spacemit@lists.linux.dev, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 2/2] pmdomain: spacemit: Add power domain driver
Message-ID: <20261113104815-GKB73509@kernel.org>
References: <20261112-04-k3-pm-support-v4-0-de3931aa5153@kernel.org>
 <20261112-04-k3-pm-support-v4-2-de3931aa5153@kernel.org>
 <sashiko-outbox-210694@kernel.org>
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
In-Reply-To: <sashiko-outbox-210694@kernel.org>

Hi Ulf,

I'm seeking help for last review comment from sashiko, see my reply
at end of this mail..


On 08:22 Thu 12 Nov     , sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [High] pmdomain: spacemit: devres frees active domains when
>   pm_genpd_remove() fails
> - [Low] pmdomain: spacemit: log ret instead of pm_index on power
>   transition error
> --
> 
> commit 1bedd4d63c29dbe88ab766b2b331bdd5d01ee76c
> Author: Yixun Lan <dlan@kernel.org>
> 
> pmdomain: spacemit: Add power domain driver
> 
> This commit adds a generic power domain driver for SpacemiT K1 and K3 SoCs
> as an auxiliary bus driver supporting both software and hardware power
> sequencing modes.
> 
> > diff --git a/drivers/pmdomain/spacemit/spacemit-pm-domains.c b/drivers/pmdomain/spacemit/spacemit-pm-domains.c
> > new file mode 100644
> > index 0000000000000..dd0613c1912a0
> > --- /dev/null
> > +++ b/drivers/pmdomain/spacemit/spacemit-pm-domains.c
> > @@ -0,0 +1,424 @@
> 
> [ ... ]
> 
..
> > +
> > +static int spacemit_pd_power_on(struct generic_pm_domain *domain)
> > +{
> > +	struct spacemit_pm_domain *pd = to_spacemit_pd(domain);
> > +	struct spacemit_pmu *pmu = pd->pmu;
> > +	const struct spacemit_pm_domain_param *p = pd->param;
> > +	unsigned int val;
> > +	int ret = 0;
> > +
> > +	if (!p->use_hw) {
> > +		regmap_set_bits(pmu->regmap, p->reg_pwr_ctrl, BIT(p->bit_sleep1));
> > +		fsleep(20);
> > +
> > +		val = BIT(p->bit_sleep2) | BIT(p->bit_sleep1);
> > +		regmap_set_bits(pmu->regmap, p->reg_pwr_ctrl, val);
> > +		fsleep(20);
> > +
> > +		regmap_set_bits(pmu->regmap, p->reg_pwr_ctrl, BIT(p->bit_isolation));
> > +		fsleep(15);
> > +
> > +		ret = regmap_read_poll_timeout(pmu->regmap,
> > +					       APMU_POWER_STATUS_REG,
> > +					       val,
> > +					       (val & BIT(p->bit_pwr_stat)),
> > +					       5,
> > +					       APMU_POWER_TIMEOUT_US);
> > +	} else {
> > +		val = BIT(p->bit_auto_pwr_on) | BIT(p->bit_hw_mode);
> > +		regmap_set_bits(pmu->regmap, p->reg_pwr_ctrl, val);
> > +		fsleep(300);
> > +
> > +		ret = regmap_read_poll_timeout(pmu->regmap,
> > +					       APMU_POWER_STATUS_REG,
> > +					       val,
> > +					       (val & BIT(p->bit_hw_pwr_stat)),
> > +					       5,
> > +					       APMU_POWER_TIMEOUT_US);
> > +	}
> > +
> > +	if (ret)
> > +		dev_err(&domain->dev, "failed to power on domain %s: %d\n",
> > +			p->name, pd->pm_index);
> > +
> > +	return ret;
> > +}
> 
> [Severity: Low]
> As reported by Troy Mitchell on v3 [1], should these dev_err() calls in
> spacemit_pd_power_off() and spacemit_pd_power_on() pass ret instead of
> pd->pm_index so that the error code is logged rather than the 0-based
> domain index?  With that changed, pd->pm_index can also be dropped.
> 
Ok, I see the point..
I was initially trying to log the id (pm_index) of power domain, but
with p->name, it's not necessary, I will fix it in next version.

I would completely remove member pm_index from struct which not useful..

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
> > +	pd->pm_index        = id;
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
> As reported by Troy Mitchell on v3 [1], can unbinding this driver or
> unloading the module while a consumer device is attached cause a
> use-after-free on pd->genpd?
> 
This is an alter solution.. but just workaround the problem

> Because the auxiliary device shares its parent CCU platform device's
> of_node, fw_devlink links consumer devices to the parent CCU device rather
> than to adev->dev, so consumer devices are not detached when
> spacemit_pm_domain_remove() runs.  pm_genpd_remove() then fails with
> -EBUSY because genpd->device_count > 0, leaving pd->genpd linked in the
> global gpd_list and referenced by consumers' dev->pm_domain pointers right
> before devres frees the devm_kzalloc()-allocated struct
> spacemit_pm_domain.
> 
> [1] https://lore.kernel.org/r/DMQHSDTR177I.1HWHAF4FWTFQ5@linux.spacemit.com
> 

I've attempted to submit a patch to fix this issue, Ulf, can
you give an early comment on this? I'd like to see if it's a
right direction before I go further.. see below
https://lore.kernel.org/all/20261112-01-pm-device-link-v1-1-8932e0862378@kernel.org/

-- 
Yixun Lan (dlan)
