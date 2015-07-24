From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v3 4/6] power: da9150: Add DT bindings documentation for
 Fuel-Gauge
Date: Sat, 25 Jul 2015 00:00:53 +0200
Message-ID: <20150724220053.GA24362@earth>
References: <cover.1436284659.git.Adam.Thomson.Opensource@diasemi.com>
 <3f9095a583c26cdb4a6dd7b749d7f6b33c87b8f7.1436284659.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57077 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752539AbbGXWBF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 24 Jul 2015 18:01:05 -0400
Content-Disposition: inline
In-Reply-To: <3f9095a583c26cdb4a6dd7b749d7f6b33c87b8f7.1436284659.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Tue, Jul 07, 2015 at 05:34:21PM +0100, Adam Thomson wrote:
> diff --git a/Documentation/devicetree/bindings/power/da9150-fg.txt b/Documentation/devicetree/bindings/power/da9150-fg.txt
> new file mode 100644
> index 0000000..c3c76eb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/da9150-fg.txt
> @@ -0,0 +1,23 @@
> +Dialog Semiconductor DA9150 Fuel-Gauge Power Supply bindings
> +
> +Required properties:
> +- compatible: "dlg,da9150-fg" for DA9150 Fuel-Gauge Power Supply
                  ^^^^^^^^^^^^^

s/dlg,da9150-fg/dlg,da9150-fuel-gauge/g

> +Optional properties:
> +- dlg,update-interval: Interval time (milliseconds) between battery level checks.
> +- dlg,warn-soc-level: Battery discharge level (%) where warning event raised.
> +      [1 - 100]
> +- dlg,crit-soc-level: Battery discharge level (%) where critical event raised.
> +  This value should be lower than the warning level.
> +      [1 - 100]
> +
> +
> +Example:
> +
> +	da9150-fg {

Make this just "fuel-gauge".

> +		compatible = "dlg,da9150-fg";
                      ^^^^^^^^^^^^^

here too ;)

> +
> +		dlg,update-interval = <10000>;
> +		dlg,warn-soc-level = /bits/ 8 <15>;
> +		dlg,crit-soc-level = /bits/ 8 <5>;
> +	};

-- Sebastian

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVsrWSAAoJENju1/PIO/qaf/AP/A6TIswbIMR+x9zkFyeRYXNt
v772UA+fRwr8aLGnGRnOPZ3KBjcwvtIRsAf8F1V3KXoUSsFetkJoHYq0hVNOVV0k
vb7yyhs2C+LPsnt3bM+r9iCcTCP0VcWcTTrZa97gAvQ2/6PMFF8cu5G3cmXAXkLL
YcsUX5ehITR99Tu0xAlCDqX/abBP3L5YRlu8OuiPzQLKw1Z9T7Iw72901+FyRMAM
nEFk8xis4U+y8SR5JZgie2k0sGHkObVh1dUPWL4YGu4t2NcBoZBAREL0D9cfi03V
E4JZgUAuPT6sSftWLT3mYf9Jo6s0/pyHl/yZ3P/i49BxSu0UdvzBU2YordBAElBD
ORfbcsQSZD5NJY3pR2qg+HMe7F6/u7mKepHhxXmt//dxKRa82w5ZAECtXVLUDD3O
2H+uiBmW/SVQAeyhexgEyrCAh8LpKBWtsI8rTSIuwpwzyjXsWewhmtP1bZ9ca9Uc
Vcgdx/y/kQqQ2L14bqLjPRsp9DTdb9QjJ9c9SLkVuir7eq0YwPaPh8mXyqjWQHfh
Gbwg437ITzXUWh9rCN0+Tb0nQ4O5j6aJaAK1vwSotsuYCIiai1NX46bVTm7qVuLu
VYgl+XJlG4K2izSz0grf3umY8jyFczam/zw7RVPPerl5NSeekU/sb3FZdQTeu8Zx
Q8JnEMK2Kjmyh2zwCqPN
=TNkJ
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
