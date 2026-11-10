Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794308221;
	b=KvmsWCZoLGxDgPM/XtyoQmpYEV8fZ+48KCSB0PzY6O/e6Wj5Gww5PRRNBrfWCVtUoT7Y
	 AnkPC4Gg1fTuZbNw4ZzRFC9/zRzjhzRNhd1Z7Z4FwQL42gw5bg8ogzq4PZVJqS+vQUP6x
	 9HViHZ0TQv5psiShsFZrBQW5oQB3/94pc8ZtOTg0hhQpBzn6FXTmNu2DTevdqQzY+ViRw
	 utXrcYDrc/Z1AVBGSsWnmcj1VkmXTqjMgEiQTqNWHDxhDneggruCPVBpyZxsTnQqiDvs5
	 F4ZC4tQBECYzxPCj5wqYbUL9OPo+gw2vvDmvUyqaOed8giiS1+fZ7uRN/ShPi6MO17w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794308221;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=yYiBagOWcslaP5fFjDzsUoDb/X8ymLQTjZmMzDj0cQI=;
	b=uD24ureKFbFTTH7dnXpmZvAWj3jbp4Vgb/9M5yqgFpFe+xQa6VYlPVWrK0znkgbnEFcu
	 CwH4VJKSAznl4tOw0l51lmvOAW2dJq2fDYAIPSiPjFYBU88avkwKG1odFeLPf86Hsc80a
	 LRKyBiCo9zjSao6l2S3C51LJ9pd16gnC8bUq64hiE1sEvHnkRwrRDPVfb/5PzrzHARozT
	 E2Y/t4Rjz0MKbizbTmJNudoBF4BgfqwxEavIhA7fWhb7PrFP8NV5zVb04/qn0/OOCTWsr
	 Bkt6KKW2BmkoelKp1aUVYf7NHT/9OcYkj+1QCNi99nBh1mQPGPtyxzRrj9lDOQBJoxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PlEvOM2Y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280D9606A321;
	Tue, 10 Nov 2026 10:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PlEvOM2Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82ED41F008A2;
	Tue, 10 Nov 2026 10:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794308220;
	bh=yYiBagOWcslaP5fFjDzsUoDb/X8ymLQTjZmMzDj0cQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PlEvOM2YRIZR+c3pFtg6FLYfZSD1LfYFaVgyGJ5nHhH/FmgpYnP+G+XWJnWlpsOvh
	 aqYmcsjfoMohZAdVcOPGFh8Eh05u3fW+9cEIVNSV5dzqcc13iNevdsjP9Nfir86BYN
	 2EYbj0xF3PbCK0noup/owF88hhPFTnEa7opHOTlzIg1YXSlDlWKD2fEfaKoZssnz9R
	 Y/EIzp6M5CspnCMsl34DxT3LdhBZekEKRmKcUggCh6CP+s8tgltiiBUv63DLZgejXn
	 f7RGmMpfMR2VdOJqk0+jgMRdVBHXFWUTZaSgbcxleaXfvzFIL2mhz2a5m6hD5bQCkr
	 6rgexRC1hN18g==
Date: Tue, 10 Nov 2026 10:56:58 +0000
From: Yixun Lan <dlan@kernel.org>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Icenowy Zheng <uwu@icenowy.me>,
	Iker Pedrosa <ikerpedrosam@gmail.com>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] pmdomain: spacemit: Add power domain driver
Message-ID: <20261110105658-GKA2005@kernel.org>
References: <20261108-04-k3-pm-support-v3-0-b9dc0857039b@kernel.org>
 <20261108-04-k3-pm-support-v3-2-b9dc0857039b@kernel.org>
 <DMQHSDTR177I.1HWHAF4FWTFQ5@linux.spacemit.com>
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
In-Reply-To: <DMQHSDTR177I.1HWHAF4FWTFQ5@linux.spacemit.com>

Hi Troy,

On 07:12 Mon 09 Nov     , Troy Mitchell wrote:
> Hi Yixun,
> 
> On Sun, 08 Nov 2026 10:36:02 +0000, Yixun Lan wrote:
> > +config SPACEMIT_PM_DOMAINS
> > +	tristate "PM Domain driver for SpacemiT SoC"
> [...]
> > +	  Say y to enable device power management through PM domains.
> This is tristate now, so "Say Y or M".
> 
Ok, will update

> [...]
> > +#include <linux/io.h>
> > +#include <linux/err.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_domain.h>
> > +#include <linux/regmap.h>
> > +#include <linux/auxiliary_bus.h>
> io.h, err.h and platform_device.h are not used right now.
> 
Ok, will drop them

> [...]
> > +static int spacemit_pd_power_off(struct generic_pm_domain *domain)
> [...]
> > +	if (ret) {
> > +		dev_err(&domain->dev, "failed to power off domain %s: %d\n",
> > +			p->name, pd->pm_index);
> > +		return -EBUSY;
> > +	}
> 
> -EBUSY drops the -ETIMEDOUT returned by regmap_read_poll_timeout();
> why not print ret and return it? Same in spacemit_pd_power_on().
> 
Yes, I think it's ok to propogate the err

> [...]
> > +static bool spacemit_pm_is_off_state(struct spacemit_pmu *pmu,
> > +				     struct spacemit_pm_domain *pd)
> [...]
> > +	return (reg & bit) ? false : true;
> return !(reg & bit);
> 
Actually, there isn't much difference, your version is slightly short

> [...]
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
> [...]
> > +static void spacemit_pm_domain_remove(struct auxiliary_device *adev)
> > +{
> > +	struct spacemit_pmu *pmu = auxiliary_get_drvdata(adev);
> > +	struct device *dev = &adev->dev;
> > +
> > +	of_genpd_del_provider(dev->of_node);
> > +	spacemit_pm_domain_cleanup(pmu);
> > +}
> pm_genpd_remove() fails with -EBUSY while a consumer is still attached,
> but pd is freed by devres anyway. Set suppress_bind_attrs like most
> pmdomain drivers?
> 

No, I won't add suppress_bind_attrs

As I'm also aware of this problem, but intend to address it in a different
way, and should send a patch in another separate thread..

In my opinion, Adding "suppress_bind_attrs = true" will only mitigate
the problem, in the case of this driver, it will still trigger a problem
while unloading the driver with rmmod command if built as kernel module,
consumer side won't get notification with the event. Ideally the device link
machanism should solve this, currently I'm working on a patch for this..

-- 
Yixun Lan (dlan)
