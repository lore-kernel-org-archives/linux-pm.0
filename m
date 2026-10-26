Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793042626;
	b=AOuCL8/4d8I5pTihCv+3u8SzHnljriK1Xq1qEqXsNtak2z9xJahQSm38PZdXr7kv8oBc
	 yWQvN7q5r8OgjPe++aVitbI/F+1jhAgCtZeCDGR3/ew1ZsJ4lf+2EIx3/eLLlGop1Yzdo
	 /7ooP4OTRD79ovDdeNDFEbd12ZO4QZO/I+8b4Q3qkJv0S9G+Vvyr/fwpFZBZYCjBkpMLT
	 zhc92XQD/pf3a1EsI3gH/QvZuh9U3gmFxQecWHjBkvf1WjRa0ABdoGKQe7MrHIKNBWR66
	 fDrww9S4pGlBWQoVV+LY8X00Xj3X2NMop4XCJFQGxt0dZuNP06Ma585fSUOlTkHg8PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793042626;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=AqmwLYHoY3N3Jn3DcpK5O8ALTetD0GAKAIXiKMQdJkc=;
	b=bQkeFwh+jdhXhOv9d4N+lk/h2ledtn4/ESTpE3YTXitKlkRviF6gj7bSpgMKughAIze6
	 Fw3H2QVM9YrHg3ELFTpnj7ecXk5KXmKluwl+p/dOzHMGWClz9E4ndpuZ5oHKRtUwjxQ6e
	 GRl/LBzrwa8cOVArwSdgzNvQXsQPbRVl6cj9LgwOjQyWhjk76UTv1/1hOieegb/ReUwuL
	 f2sWcp1ofqww6VB0xzk6kKRqKos04da3W6iVh3720lzsZpsCBKMzm0r/RzL3YuZhsRvjq
	 6OM97icnQtrO8okD3NIsyjs6o/PMXwExd595fNSKSof7Tul3qrxtEhgtghN3OBW0Rvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=ihzOWlko;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A82606A31A;
	Mon, 26 Oct 2026 19:23:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61A82606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=ihzOWlko
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=AqmwLYHoY3N3Jn3DcpK5O8ALTetD0GAKAIXiKMQdJkc=; b=ihzOWlkoMuN55i67fxYnH70IAf
	1Dc7JL6ULToy5fPHNtBAS/64psDpQEAe8ggH9ISaZjAgFkHCLKWShulpdK256xKeDdUvQ2u06jj0/
	KspCrAv42gs+pjoMqdUWXXhUsqu0ZlzneX4daVJOJL6bjU4iSflOAZehJ9whPgmfg0+ZaErEFnIYr
	6Q2bee53ETm0trex+Xeq8JwATmWJxRY8uP5NaUfyKk9Jf1Q/4UL5xuLaQBWUY7eHb1XeuT540jDvb
	P5CStcm65dlbdj04Jt3BtadMyua8Uv4fhz1Q7Gj2U6kdnh4x0Yjp1R0NPcW5t19Qfundl9zdXwzfd
	uO5se/3A==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: linux-pm@vger.kernel.org, Chris Morgan <macroalpha82@gmail.com>
Cc: linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 maccraft123mc@gmail.com, zhangqing@rock-chips.com, zyw@rock-chips.com,
 sre@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 lee@kernel.org, Chris Morgan <macromorgan@hotmail.com>,
 Zetarancio <zetarancio@users.noreply.github.com>
Subject:
 Re: [PATCH 4/5] dt-bindings: power: supply: rk817-charger: Add
 rockchip,gate-function-disable
Date: Mon, 26 Oct 2026 20:23:40 +0100
Message-ID: <15875856.JCcGWNJJiE@diego>
In-Reply-To: <20261026174834.1652309-5-macroalpha82@gmail.com>
References:
 <20261026174834.1652309-1-macroalpha82@gmail.com>
 <20261026174834.1652309-5-macroalpha82@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi Chris,

Am Montag, 26. Oktober 2026, 18:48:33 Mitteleurop=C3=A4ische Normalzeit sch=
rieb Chris Morgan:
> From: Chris Morgan <macromorgan@hotmail.com>
>=20
> Add a boolean attribute for the rk817-charger to control whether or not
> the system power is shutdown in battery off mode. The BSP kernel sets
> this value unless a device-tree attribute is present, and this attribute
> is to replicate that behavior.

Devicetree is supposed to describe the hardware, so your description needs
to describe the per-board property this represents.

Just because it's in a vendor-BSP is generally not enough justification :-)=
 .

This is especially true as you wrote in the cover-letter that no known
board actually needs this right now.


Heiko

> Fixes: a592aa3a2a8c ("dt-bindings: mfd: Add Rockchip rk817 battery charge=
r support")
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> Suggested-by: Zetarancio <zetarancio@users.noreply.github.com>
> ---
>  Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml b/=
Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
> index 2cb6d176a84c..4cf987fe763b 100644
> --- a/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
> +++ b/Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml
> @@ -148,6 +148,12 @@ properties:
>            Value in microamps of the sleep filter current for the charger.
>            Value is used by the driver to derive the sleep sample current.
> =20
> +      rockchip,gate-function-disable:
> +        type: boolean
> +        description:
> +          Boolean value to prevent PMIC from turning off system voltage =
when
> +          battery voltage is shut down.
> +
>      required:
>        - monitored-battery
>        - rockchip,resistor-sense-micro-ohms
> @@ -381,6 +387,7 @@ examples:
> =20
>              rk817_charger: charger {
>                  monitored-battery =3D <&battery>;
> +                rockchip,gate-function-disable;
>                  rockchip,resistor-sense-micro-ohms =3D <10000>;
>                  rockchip,sleep-enter-current-microamp =3D <300000>;
>                  rockchip,sleep-filter-current-microamp =3D <100000>;
>=20




