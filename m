Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1BA3921CD;
	Sun,  4 Oct 2026 13:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791121623; cv=none; b=HSFTG8nWQ9PquwwsBqORVVZB7py4vADBIYRi/hItpGoyQC/JUwtyMB3o+hzEBldbdZRv++5dN1nxKcFsP9xhN94Vrk2n1/teg2SNsyXpQ6wXok+8+BsjJp7OSMbEToPcmLGoRbDqlUL390U27nfMPnxrNyhW0aeOchh9985U1O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791121623; c=relaxed/simple;
	bh=goAz44AdPNm4n6S6aHSSoTQPQGJYpi0Gy8CR9FEka08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDXZ9rybZNIqH+LYAJCUcpea07qF/kkoOuhlZAGPAr2bDPPBGIUcwBRA2qS0IVYq/ZZKQNg3AAUtx3oCNao2EXjDe30a3Z/Nk1o9CS5CsXljb9t6Tx+mNxoB3vlHP5Hv4PayecgGyOXJyXjQ8+RL7XDqwbbXtgrIMEamRqMt0uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ga1cjuC4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ga1cjuC4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF5861F000FF;
	Sun,  4 Oct 2026 13:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791121622;
	bh=wjQUJehNv7x6Ld+SZmB+IotKGd3LDi+sKb1y5LRwM1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ga1cjuC4+1ZZi/OrlQCwWxWKpt+32ez03wp++NxitjZ9yXOJcEnE8ZPnXPzI5eQLv
	 2b8xtO6ihMDSElUJjnZ76hjZMXKqs1qUQPGX7bvGfJBPIeQnYqYJ0W58/Y8TOvhkSU
	 CsnYHhi6NTJ65XZnM7cyJt5g6dmPWGeJZpnn/+ZOi9PklExuwd2lGCLBRjsKLyJcLp
	 f8wlyN/fkbfRPC5DrIdvmkLNGG/3IkUvrfvqm7hxSMkD/I5qZMqCmK8x69bVNfEJp/
	 1IWl9Q/BQJ1K6ZyX/JAmb382vCCqqvI6tjdh5CtTyiXg91JjHOnQ/APZK2RLxh4EEA
	 W0Ho3gfGjmbsQ==
Date: Sun, 4 Oct 2026 13:47:00 +0000
From: Yixun Lan <dlan@kernel.org>
To: Iker Pedrosa <ikerpedrosam@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/3] pmdomain: spacemit: Add power domain driver
Message-ID: <20261004134700-GKA83703@kernel.org>
References: <20260918-04-k3-pm-support-v1-0-0acd2b36b96f@kernel.org>
 <20260918-04-k3-pm-support-v1-2-0acd2b36b96f@kernel.org>
 <CABdCQ=OUTASG8JDBqnJAPJ5aTDUC-BQzCVcw0r=cxrb8CPUO2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABdCQ=OUTASG8JDBqnJAPJ5aTDUC-BQzCVcw0r=cxrb8CPUO2A@mail.gmail.com>

Hi Iker Pedrosa,

On 20:54 Fri 02 Oct     , Iker Pedrosa wrote:
> El vie, 18 sept 2026 a las 7:49, Yixun Lan (<dlan@kernel.org>) escribió:
> > [...]
> > diff --git a/drivers/pmdomain/spacemit/pm_domains.c b/drivers/pmdomain/spacemit/pm_domains.c
> > new file mode 100644
> > index 000000000000..d563e4e4e232
> > --- /dev/null
> > +++ b/drivers/pmdomain/spacemit/pm_domains.c
> > [...]
> > +static struct spacemit_pmu *gpmu;
> 
> Would it make sense to embed the 'struct spacemit_pmu' pointer directly into
> 'struct spacemit_pm_domain'? Other generic Power Domain drivers (Rockchip,
> QCOM, Renesas) use this pattern to keep domain callbacks self-contained and
> ready for multi-instance SoCs
> 
> > [...]
> > +static int spacemit_pd_power_on(struct generic_pm_domain *domain)
> > +{
> > [...]
> > + regmap_read(gpmu->regmap, APMU_POWER_STATUS_REG, &val);
> 
> Please check the return value of regmap_read()
> 
It's not necessary, or it's not really useful to check return value here,
regmap_read() shouldn't fail here, it generally access the io memory

> > [...]
> > + if (ret < 0) {
> > + dev_err(&domain->dev, "power-off domain: %d, error\n", spd->pm_index);
> 
> Typo: should this say "power-on domain" since this is inside
> spacemit_pd_power_on()?
> 
will drop this logic, I just followed vendor driver which try to force power
off donmain before doing the power on operation if it's already in 'on' state..

while found it's not really necessary to do this during actual testing

> > [...]
> > +static bool spacemit_pm_get_state(struct spacemit_pmu *pmu,
> > +  struct spacemit_pm_domain *pd)
> > +{
> > + const struct spacemit_pm_domain_param *p = pd->param;
> > + u32 reg, bit;
> > +
> > + regmap_read(pmu->regmap, APMU_POWER_STATUS_REG, &reg);
> 
> Please check the return value here as well
> 
I don't think the check is useful, in rare case it should fail

> > + bit = p->use_hw ? BIT(pd->param->bit_hw_pwr_stat) :
> > +  BIT(pd->param->bit_pwr_stat);
> 
> Since 'p' is initialized to 'pd->param' above, you can use 'p->bit_hw_pwr_stat'
> and 'p->bit_pwr_stat' directly here
Yes, will do

-- 
Yixun Lan (dlan)
