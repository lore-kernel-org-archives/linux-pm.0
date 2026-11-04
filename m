Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793789658;
	b=PwR4xFrteePbFcgQ2X9TP9q5u7tEeurwmH6oRVh8tr5iIQmwnVEFZ+m4EmLTdI/sNIld
	 ZJjXooOIvamXtUfJSuqIKiVnilig+IVm6s6qEc35atQuGAmPnpVJGmc9ON4SZGJJ37D7Q
	 9wrajRmtVO23+ugRp0TnGyfqwvHVt8fE9wx3uZKg2mijiz8IcMYhJS2KKuThZTUIiXKiX
	 +2hTSz5pkusP/C68i5lDkxkpfGUVHDo3rVOqcRtTOHwraL0RpyU9J4lxmWGsERFaJqJd3
	 2sYcJPW5ntaPHnGnTW0iXyo2Qh2T5c9haauSfE4ojCe9OVv3+hcrTIiRWCm62xJynrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793789658;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=advfz8qU7dnMlSXaKuDgnefU48uHbLndv3sHhQbWPMw=;
	b=w4wS4iZPbxUe0z76vtRiXfkOtruBmwD6I66ZDZ5ddUzMoi02mKZZhR+5DRELqElx8iUr
	 Kjn2wfifBtMvOE7Yh26Ob3c9OFKn2sihqc9mBFfZNhRW5ADi9ANHbpde8OZF74yhR177i
	 c1z6O2aVHGfctQeNFzFa1qjqK5diKcf/OhWwpje4626gm3f67lvZuT2FwOsV/9NOaRk3W
	 P4CfUDrrfw7KhSS7wD2NTyjyMRQPu4OmagHPO4tH5yArVTRuwmUrt8B7ZpzHQY2NNr/fx
	 ubgoFiAD3rerj14NTorycfHfb1jLdNmvf2t1O27BusptjYGt3NMY07afk9+cF84HH2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=zdYbA7OO;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68033606A326;
	Wed,  4 Nov 2026 10:54:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68033606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=zdYbA7OO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=advfz8qU7dnMlSXaKuDgnefU48uHbLndv3sHhQbWPMw=; b=zdYbA7OObWwvo7rs7AE3iCVGzj
	BDWigqB1/746eJLXXkDf5qazrTOAWtpR6IXVUy5F4lAy5LRoWZzSvOuDDxhuxlWORs7Qh69SwEZHc
	/9XupRpbA4WLdDHRfdMCjKF3Z6gu12ueLkcIdQmUVPxsP9aWKjSFXTyd9KVC5arkHdNzBjEbyymlN
	BWkvNbJCMZ/yMIKfdw/XZIRe7TItZc9UJTFoBH0IcZQYPT5jLnIgAPXCbtTEVaKoSrJRTb8+SKCSY
	LbXBS/G7gGrWxExn6fTQEFPtVasKqtTGmql2SVnWJq0h+v6qQkSjC7PI+cWefytkCnlECJnArTLKw
	e6i1O+cQ==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: tomeu@tomeuvizoso.net, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 ulfh@kernel.org, p.zabel@pengutronix.de, ogabbay@kernel.org,
 zhangqing@rock-chips.com, Jiaxing Hu <gahing@gahingwoo.com>
Cc: royalnet026@gmail.com, abel.vesa@oss.qualcomm.com,
 sebastian.reichel@collabora.com, sidong.yang@furiosa.ai,
 u.kleine-koenig@baylibre.com, chaoyi.chen@rock-chips.com,
 diederik@cknow-tech.com, alchark@flipper.net, leonard@lausen.nl,
 jeff.hugo@oss.qualcomm.com, rfoss@kernel.org,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jiaxing Hu <gahing@gahingwoo.com>, chaoyi.chen@rock-chips.com
Subject:
 Re: [PATCH v15 14/15] arm64: dts: rockchip: add NPU (RKNN) nodes to rk3576
Date: Wed, 04 Nov 2026 11:53:47 +0100
Message-ID: <2915499.MsWZr2WtbB@diego>
In-Reply-To: <20261101082307.151957-15-gahing@gahingwoo.com>
References:
 <20261101082307.151957-1-gahing@gahingwoo.com>
 <20261101082307.151957-15-gahing@gahingwoo.com>
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

Am Sonntag, 1. November 2026, 09:23:06 Mitteleurop=C3=A4ische Normalzeit sc=
hrieb Jiaxing Hu:
> Add the two RKNN cores and their IOMMUs, disabled, and label PD_NPU so a
> board can give it the NPU rail. Each core lists both core domains, its own
> first, as tested.
>=20
> Assign CLK_RKNN_DSU0 594 MHz. Nothing in mainline sets its rate or the NPU
> rail, and at the 786 MHz it comes up at, on the 750 mV a ROCK 4D boots
> with, two cores running together write wrong words, 11 to 25 in each pass
> of 5400 rows. 594 MHz is clean, and Rockchip's OPP table asks only 725 mV
> of its 500 and 600 MHz steps.
>=20
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3576.dtsi | 74 +++++++++++++++++++++++-
>  1 file changed, 73 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/d=
ts/rockchip/rk3576.dtsi
> index ea9229b6e6f5..80943d748bfa 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
> @@ -1057,7 +1057,7 @@ power: power-controller {
>  				#address-cells =3D <1>;
>  				#size-cells =3D <0>;
> =20
> -				power-domain@RK3576_PD_NPU {
> +				pd_npu: power-domain@RK3576_PD_NPU {
>  					reg =3D <RK3576_PD_NPU>;
>  					#power-domain-cells =3D <1>;
>  					#address-cells =3D <1>;
> @@ -1284,6 +1284,78 @@ power-domain@RK3576_PD_VO1 {
>  			};
>  		};
> =20
> +		rknn_core_0: npu@27700000 {
> +			compatible =3D "rockchip,rk3576-rknn-core";
> +			reg =3D <0x0 0x27700000 0x0 0x1000>,
> +			      <0x0 0x27701000 0x0 0x1000>,
> +			      <0x0 0x27703000 0x0 0x1000>;
> +			reg-names =3D "pc", "cna", "core";
> +			interrupts =3D <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&cru ACLK_RKNN0>, <&cru HCLK_RKNN_ROOT>,
> +				 <&cru CLK_RKNN_DSU0>, <&cru PCLK_NPUTOP_ROOT>,
> +				 <&cru ACLK_RKNN_CBUF>, <&cru HCLK_RKNN_CBUF>;
> +			clock-names =3D "aclk", "hclk", "npu", "pclk",
> +				      "aclk_cbuf", "hclk_cbuf";
> +			assigned-clocks =3D <&cru CLK_RKNN_DSU0>;
> +			assigned-clock-rates =3D <594000000>;
> +			resets =3D <&cru SRST_A_RKNN0>;
> +			reset-names =3D "srst_a";
> +			power-domains =3D <&power RK3576_PD_NPU0>, <&power RK3576_PD_NPU1>;

Why do you need both power-domains here?
The naming does suggest each belongs to one core - similar to the rk3588?

If each core really needs both domains, please state this explicitly.

Rockchip sadly does not provide RKNN documentation the first
two parts of the TRM.


Heiko



