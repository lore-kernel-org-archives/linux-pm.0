From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v6 3/7] power: act8945a_charger: Add status change update
 support
Date: Fri, 19 Aug 2016 17:50:32 +0200
Message-ID: <20160819155032.3efkx7cizhh5viv4@earth>
References: <1471569215-6046-1-git-send-email-wenyou.yang@atmel.com>
 <1471569215-6046-4-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fesxptbswe53rbwb"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754607AbcHSPui (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Aug 2016 11:50:38 -0400
Content-Disposition: inline
In-Reply-To: <1471569215-6046-4-git-send-email-wenyou.yang@atmel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wenyou Yang <wenyou.yang@atmel.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Brown <broonie@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-pm@vger.kernel.org


--fesxptbswe53rbwb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Fri, Aug 19, 2016 at 09:13:31AM +0800, Wenyou Yang wrote:
>  - Fix the 'dev' argument of devm_request_irq() to pdev->dev.parent.

This is not a fix.

> +	ret = devm_request_irq(pdev->dev.parent, irq, act8945a_status_changed,
> +			       IRQF_TRIGGER_FALLING, "act8945a_interrupt",
> +			       charger);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to request nIRQ pin IRQ\n");
> +		return ret;
> +	}

This will result in the irq not being free'd during device remove,
but when the parent device is removed.

-- Sebastian

--fesxptbswe53rbwb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXtyrIAAoJENju1/PIO/qalFMQAKAFH+2fFw0/QlOKhaFFZvrS
uFmv05lGGHoMlsxVGmySNUc9OHQ4WWtEdYNRPkXOclaIHa5uGSLW6ULhQc9xNSaS
HaJitrglvrrWdoHjatCezVHlSY5XqYi/Hn5PWD68pvizuYIf1Vy4zaa9zWCpbq7Q
NRgcpOa6D5kIcy/BsQ/wlpQL+7PiemYMnkI9j4CnVVeWY9So8G/DxBd/anHx9nMr
OBAdZD9XpudBYb4nqK9QXxVJqnH84nvXoO+uobObKvWb1O25IhIzA7euSL0u6dMC
93Tca9fuEia/xVpWDbxu4swZ0d4tXwcufbLUOB79d4J5EHKVsOBHPVnVdQypc1c1
FUx9ylIIZba27TM/0ysNLZmxC8oMdZD7GVzDNQJ+8NScBVVZDgQ6Julrp6rEY6x9
J2c4CGiDqUwHsct+YiffkZdiGMSFZwnjH3C6sXSMvL/QL2Fk5gZD80NtfYt75CQR
ORUcDc+ewfWQzlmXezZ1OjAWVA7iwXwYBBfmxwDqOiLxALRAtzGaOlvduWTYgnaI
DvXN0CPrpGC+MrSOlXsCxOj5AifhzRWosFu/4bBbdTVS1aLFDnBCW8rBkCVDl9I4
p/kKQiMoC36LMvRPvxf6vYdV86OrH+ZxTW55yfMBukAKukCGpQK0/tD3b+1nbRKl
AHuO8+Uy00MbvJhkb4tM
=m0gC
-----END PGP SIGNATURE-----

--fesxptbswe53rbwb--
