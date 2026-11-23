Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795436946;
	b=4rmpCP2DgyCZn1c2Muj0sfxiWmA0+AbNYKRegVcvMb/qvBUBprE1dD/qrMNwb2lHBFVv
	 gNjaqYjat6aZG4Vdx2MRNxvQFF7OCGGpFN1zXPpKi/5mnyrG+zKvH6ElrYk9P/C8VYEN/
	 tzvYgKEsqxKoJS6BGhkxqRARb9tJhnlvCM7uFxrVFUbQojC+nwKonac7VBg8w1vbhTaHB
	 g6yz8kj8hPyKLFwbRastqbcvf+p9BZ6rrhRJU/4+HBxdplduZGfBdao6+zyE3IglPCtgr
	 sTttpVoZuDtxZXZwdCmyV7TBPHmerGNjCW+qsLAlYydBca18tyE8pG2WEs7TbOoXFFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795436946;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=iqxEC0EPQ5zrbuiYk9Q/uqJgIY+W1YcdjzVH1pEwG2Q=;
	b=gmeL7ApmUGJ8oBGKkbPaL7aOqV67lbZQeG6mrkuLtJ+vwplGSIlBBYC4ROS0r8TJAHTU
	 khbrea8SvzbHt8LhYrsXV1QTRgLFHIgVuhcTY62bL2MuUeWxE5cfBfMW41fZHlY2zgvt/
	 /YEK6jzcUFjuvJzpNTkS89snBwr1OI6B/g7QUfqIGWfbyu/fDBwZeeZzJXsSJjx1TbYbr
	 5QpZhK4Xt81gFtEHRHCtDJrAyOcW/LN19JveRvKLesM6FTcO5MKz3gz5bg/+pw5TORDaD
	 tKtfYbbreSC9JmX8kLiwf/aJNtweNu9asn03ItQcmFXA/s78EP2F46OKobFDxTPtk0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F0okqa7r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A671F606A333;
	Mon, 23 Nov 2026 12:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F0okqa7r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22021F00A00;
	Mon, 23 Nov 2026 12:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795436946;
	bh=iqxEC0EPQ5zrbuiYk9Q/uqJgIY+W1YcdjzVH1pEwG2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F0okqa7rSwEwR0I8NI0WC5EYyOL1DiREEFmDrzoXAU5k6UbZJJ3Wy+7qeH68ymTuB
	 jGrDvdlxC5bmQOWVhnTupCSnZGBbEOUjSQmj7YeyQKGfqht93pR5psjrXsSw23i0PN
	 F6TUtgr2h3gLCXCXjt3onSZe21AarqoG9cR/vcANuBi4exBCVN28nMHKjfiDmAx8Xj
	 3m2Xa8frTMVjHHiaobZHEconVpa+UAPcC3mYP7rBhRWCmfpiMFRICDYF+i6e+WgQRC
	 SCQh++JCbWP4TQzPLXgOCB4YSRZ2O7zugU49wQ/4I90+m7jm4vO6ENXEEgJO8DWOnP
	 FYfLX1VOF6Bag==
Date: Mon, 23 Nov 2026 13:29:03 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Adil =?utf-8?Q?H=C3=BCsrev?= Tepe <tadilhusrev@gmail.com>
Cc: sre@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: power: supply: add
 samsung,s2mu106-fuelgauge
Message-ID: <20261123-hot-stallion-of-fascination-eaa83c@quoll>
References: <20261117104328.1176951-1-tadilhusrev@gmail.com>
 <20261117104328.1176951-2-tadilhusrev@gmail.com>
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
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20261117104328.1176951-2-tadilhusrev@gmail.com>

On Tue, Nov 17, 2026 at 01:43:27PM +0300, Adil H=C3=BCsrev Tepe wrote:
> Add a binding for the Samsung S2MU106 PMIC's fuel gauge, as a
> standalone I2C device (own address, 0x3b) rather than a fallback
> compatible on samsung,s2mu005-fuel-gauge.
>=20
> A previous version of this series
> (https://lore.kernel.org/all/20261116074000.355176-1-tadilhusrev@gmail.co=
m/)
> extended the S2MU005 fuel-gauge binding and driver instead, with
> samsung,s2mu106-fuel-gauge falling back to samsung,s2mu005-fuel-gauge.
> Sashiko AI's review of that series pointed out that the fallback let a
> board bind through the plain samsung,s2mu005-fuel-gauge compatible

Why is this relevant to commit msg? Whatever was decided in previous
review, stays in previous review. If you had bugs, would you be
describing each bug?

> with no guard at all, which runs s2mu005_fg_get_voltage_avg()/
> get_current_avg() against MONOUT registers the S2MU106 doesn't have,
> and can misreport charging status from the resulting garbage reads.

Explain simply differences between devices.

>=20
> Rather than add a flag to close that specific hole, this binding
> avoids the fallback-compatible construction entirely: the S2MU106
> fuel gauge only shares the S2MU005's STATUS/RVBAT/RCURCC/RSOC register
> layout and scaling, not its device-tree node shape, so it gets its own
> compatible and its own driver
> ("power: supply: s2mu106-fuelgauge: add standalone driver").
> samsung,s2mu005-fuel-gauge is left untouched.

This is completely redundant paragraph. Are you pasting here LLM stuff?
LLM has no place in commit msg. Usage of LLM means you do not understand
what you did.

>=20
> Signed-off-by: Adil H=C3=BCsrev Tepe <tadilhusrev@gmail.com>
> ---
>  .../supply/samsung,s2mu106-fuelgauge.yaml     | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/samsun=
g,s2mu106-fuelgauge.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/samsung,s2mu1=
06-fuelgauge.yaml b/Documentation/devicetree/bindings/power/supply/samsung,=
s2mu106-fuelgauge.yaml
> new file mode 100644
> index 000000000..3dd91412e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/samsung,s2mu106-fuel=
gauge.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/supply/samsung,s2mu106-fuelgaug=
e.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung S2MU106 Fuel Gauge
> +
> +maintainers:
> +  - Adil H=C3=BCsrev Tepe <tadilhusrev@gmail.com>
> +
> +description:
> +  Fuel-gauge sub-function of the Samsung S2MU106 PMIC, on its own I2C ad=
dress
> +  (separate from the 0x3d charger/MUIC/FLED block). As on the Galaxy XCo=
ver5.
> +
> +allOf:
> +  - $ref: power-supply.yaml#
> +
> +properties:
> +  compatible:
> +    const: samsung,s2mu106-fuelgauge
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  monitored-battery: true

Exactly the same as s2mu005. I do not understand why do you need a new
binding file and no one suggested that.

Best regards,
Krzysztof

