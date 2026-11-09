Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.204.34.129
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794208442;
	b=09YoNDFAlh3RK6FWuN8MqdI9zqiY95F8Ye6dsQ7ywXhYKuuaGIEUwAV/Frl52fSrwv2Z
	 NMoupNE0Lru7pA+pdx4P9edVhPuEJXXP7kEp7SAwT3xgVlVs+v9j2aAPWWUgwjl1R42jx
	 IpCmKsT6bISTh042Bh5jvT6YPma+/XkEMV4290PWwR1+rsbXJWullTEH8oO1H5wACxFz1
	 /yNXBNOWFl+QEHQD/+qiiFe0tOBLPzIhHKFFRgCy4iM+TffLz1XlHJepWkx3q9keCvq3J
	 vceJ6IDydpP/W0FHxGkAXKsiSyfBSJ+ekivg1wlJWQ9vlgWZMNnTyZjl0bkWC8SZr/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794208442;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:Mime-Version:
	 Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=kJVLZj1Pk3xwWcg8tK9L4RRH3pYszRMc7fN60jkYOvc=;
	b=BCxdYvJSQbQxzaaw+skaNyDR+vYplj+8I2epyv1KAMUJG8trCfAzgtDLT+UUN+f0PDxA
	 gQuM1rVO0jo+LzHEaKlGFiDsELGGBY+DbMS00ipql0mK0m+IexnMG1RPnP3O6s7sgAN6f
	 hrz6qTjqOqSnPxAya5AA8ZP/UKID8wbTBombQeZF2bdnKptwTUhrv3UaxjiveJAMpqq53
	 tNs/LLlozsK7cKyKy/ftKInPDx8Klx52Gq9qS9aSnf7Y5yFqzOcPWTbk3FZvQM/DykUs5
	 eRM/B5cRd9KmKX563xhIdt98a91OanjCR2/YLc2y5wQgc6aGUQ9w2qBGj4cnjLfO1Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux.spacemit.com;
	spf=none smtp.mailfrom=linux.spacemit.com;
	dkim=pass header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=RzuplUmV;
	arc=none smtp.remote-ip=54.204.34.129
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A919606A330;
	Mon,  9 Nov 2026 07:13:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A919606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=RzuplUmV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1794208403;
	bh=kJVLZj1Pk3xwWcg8tK9L4RRH3pYszRMc7fN60jkYOvc=;
	h=Mime-Version:Date:Message-Id:From:To:Subject;
	b=RzuplUmVenoVBR2noYVOzk8sONCpodCMQ/wb13eFDN3vf3VLIFTBSngZ+yzt/KBbU
	 VqMr2aDeQ1j9hVrT2Y8s4gnDUChgjte8U9T+PkOKVGslVRE7pR/G/uZNA0Enjzmo5y
	 hlKlIXYjLz3imXPZkgbytCWZiLsubur8qeqGdoGY=
X-QQ-mid: esmtpgz10t1794208400t3ad1583a
X-QQ-Originating-IP: qo40GlWADYFxTR7NC+gq0T9seFJa2UapBBDpklvpw/U=
Received: from = ( [58.254.68.27])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 09 Nov 2026 15:13:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14165528735187761627
EX-QQ-RecipientCnt: 17
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=e332fbce858a9fc00b10f2e696db37e3970b3372689d66af046121bcb587;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Mon, 09 Nov 2026 07:12:57 +0000
Message-Id: <DMQHSDTR177I.1HWHAF4FWTFQ5@linux.spacemit.com>
From: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
To: "Yixun Lan" <dlan@kernel.org>
Cc: "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Ulf Hansson"
 <ulfh@kernel.org>, "Paul Walmsley" <pjw@kernel.org>, "Palmer Dabbelt"
 <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre
 Ghiti" <alex@ghiti.fr>, "Icenowy Zheng" <uwu@icenowy.me>, "Iker Pedrosa"
 <ikerpedrosam@gmail.com>, <devicetree@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <spacemit@lists.linux.dev>,
 <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Troy Mitchell"
 <troy.mitchell@linux.spacemit.com>
Subject: Re: [PATCH v3 2/2] pmdomain: spacemit: Add power domain driver
In-Reply-To: <20261108-04-k3-pm-support-v3-2-b9dc0857039b@kernel.org>
References: <20261108-04-k3-pm-support-v3-0-b9dc0857039b@kernel.org>
	<20261108-04-k3-pm-support-v3-2-b9dc0857039b@kernel.org>
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MIODS64eMatOtLYkCYprGJLH8gStOTN7ayneCZEb7cAqjI18Lf7bOP+S
	R4U+GuZxC4R65LKC2xE6bBE7HXg4bZOgeCJFKRInnBN8Q7K4xF3nUtUFh7l0uctRu1ivNnh
	pBU6oDfmtYDNa9Qhw/Ijc/TTAgIDVSBdrtZiPcyOIrJ8a53hf5j5WsHMT/GSFQaK5p6M777
	VMnI3IVLHQc+OM/bqX+MA4V20izD/ZZKAgE5oKnVe/rJDAPuYXH7OWLZ09W4yDo6IHTwV8H
	X+7WEW8Abyxn7AcEXt/9E4LNgpKpliHRZrwB3Nb4Tcb2A07q9yiX0I5qYPV2UgJ/KHw7wHj
	/rxkbECA+TaNPWAGp54XsGcI9XDsU3AFm2siCkPcsmcsN+9pt3HYT7daSf9O9+4I49Z89cV
	BlhNTr8tjo1m5ltBI3s5hUPQdk9P65rC8bHIXUWrIWyrqOJ8AQTpOeJQLgaLJIJv4DISIss
	3I8DuYT8oDFNWr3nSGSBF00rKDucMtovTIbAVEQT7KipGOXMvcYBBfzLO2ij9EL+XYd1BDk
	+L6kAbw3vT+aKV+YnQ+ymOA6+gVuQWcs/Mn1teZutlnTd91SxUbCsmWUJ+OniyNDSCKyM0S
	udNaZO2gGXwgwswcv+1dhz94t0YEbJKV5TVWP6Mg3EPtdqLkPcRMGVouNJNglS2gjTx0IkZ
	VoexwHmdMaf+nxIjBhWiEcc6iqZAoAQ7Vu6Hxs9tHsN3D3ySzv1ZyWqzUJh7tj1P4ETmP4d
	uG0HMnN3ctNAbUAG0lgEft+ZkQu/AY8BOuWnrjdsMEj6nWP8Nx6EJCukr5mefs57368aLvT
	Ha7ldmpfuxI4dFO5k9r6czpeghO1kG1vpbgRpIcyaIZs+0L94mGrwYFZePPoWHzWNHokk6+
	jjWBFNI5F0q+vBOdT5qgXZxdJ9Z/TRCKUIxyuuTeIk5smXXWniTz5ewk07vqJUfGaB7RyjN
	41QZgA6Yv2c2fiVmgAkxfVj6FHQCss2U3EKST7fJApCIu3/2nKNjYp5kYpSLNKrPnoTN4Bc
	YF2NxxMj0xOg/W09EwpeVBq053aFQtBkbyvDPZ1GK9rkCGRB8oyFe2DCbQsf/+ZE+POrtUa
	4fX2XLlZit3
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

--e332fbce858a9fc00b10f2e696db37e3970b3372689d66af046121bcb587
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Yixun,

On Sun, 08 Nov 2026 10:36:02 +0000, Yixun Lan wrote:
> +config SPACEMIT_PM_DOMAINS
> +	tristate "PM Domain driver for SpacemiT SoC"
[...]
> +	  Say y to enable device power management through PM domains.
This is tristate now, so "Say Y or M".

[...]
> +#include <linux/io.h>
> +#include <linux/err.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
> +#include <linux/regmap.h>
> +#include <linux/auxiliary_bus.h>
io.h, err.h and platform_device.h are not used right now.

[...]
> +static int spacemit_pd_power_off(struct generic_pm_domain *domain)
[...]
> +	if (ret) {
> +		dev_err(&domain->dev, "failed to power off domain %s: %d\n",
> +			p->name, pd->pm_index);
> +		return -EBUSY;
> +	}

-EBUSY drops the -ETIMEDOUT returned by regmap_read_poll_timeout();
why not print ret and return it? Same in spacemit_pd_power_on().

[...]
> +static bool spacemit_pm_is_off_state(struct spacemit_pmu *pmu,
> +				     struct spacemit_pm_domain *pd)
[...]
> +	return (reg & bit) ? false : true;
return !(reg & bit);

[...]
> +static void spacemit_pm_domain_cleanup(struct spacemit_pmu *pmu)
> +{
> +	struct spacemit_pm_domain *pd;
> +	int i, ret;
> +
> +	for (i =3D 0; i < pmu->genpd_data.num_domains; i++) {
> +		if (!pmu->domains[i])
> +			continue;
> +
> +		pd =3D to_spacemit_pd(pmu->domains[i]);
> +		ret =3D pm_genpd_remove(pmu->domains[i]);
> +		if (ret)
> +			dev_err(pmu->dev, "failed to remove domain %s: %d - state may be inco=
nsistent\n",
> +				pd->param->name, ret);
> +	}
> +}
[...]
> +static void spacemit_pm_domain_remove(struct auxiliary_device *adev)
> +{
> +	struct spacemit_pmu *pmu =3D auxiliary_get_drvdata(adev);
> +	struct device *dev =3D &adev->dev;
> +
> +	of_genpd_del_provider(dev->of_node);
> +	spacemit_pm_domain_cleanup(pmu);
> +}
pm_genpd_remove() fails with -EBUSY while a consumer is still attached,
but pd is freed by devres anyway. Set suppress_bind_attrs like most
pmdomain drivers?

--=20
Troy Mitchell

--e332fbce858a9fc00b10f2e696db37e3970b3372689d66af046121bcb587
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJcEABYKAD8WIQSL4Ay2cExaPXAQcU2YCe+A+TM0LwUCavFyeSEcdHJveS5taXRj
aGVsbEBsaW51eC5zcGFjZW1pdC5jb20ACgkQmAnvgPkzNC9MtQD/aDe7GEsQxXem
tqumpi4bxtTDHQPVsbj5Wnjdb4MV1uIBAM48sFNsLNa4JF/Fk4zZ+5Dmf0vEjAGt
+OkFbGjc5/oK
=gTan
-----END PGP SIGNATURE-----

--e332fbce858a9fc00b10f2e696db37e3970b3372689d66af046121bcb587--
