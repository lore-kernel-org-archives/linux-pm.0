Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EAE4AC16B;
	Mon, 21 Sep 2026 21:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790027568; cv=none; b=ZNiysLU7e9eOOFbV1lqME+5V7RuMUeV6kmhDOEXros9lTTITjnClh3k71KuJPp43n923OZNvIX3mNiG4G+cI6HofoBgZloXSkzzNFK4MVGvSdUNfghjibklGWcDTi9buTZve/RUSy8+EZxau2UvPvKtq/lCC75qfX0npEcaGi7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790027568; c=relaxed/simple;
	bh=wxd70BIFeKSbrHBYOztIxDPaWIutTGD5h3nEV8wgIFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TxBdWZX0EA91Lu2pBtuXmBfx+C8ouanxf053Xej9GpVog5qW1cP6RBn1jzSA1becBLGW0k4FRbjzkxgZcc+t2li9256ztS6zUBzNQ8y3ZbgvQaPww1SEfTYsKzZ9LGEDSpvnKav6pYiqi86ZisGIJ5MXmgtwwQG8gMTipBJy+RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=kOKh+tO1; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="kOKh+tO1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=eoWfYjj7geBEgtBjXdF5/WIH4GJNtcxQHnt+xjX8Kvw=; b=kOKh+tO180j0JZFNK/WRL9wKCn
	OsrbwpICbLRHcW+J3f/ISUueH6+dPWCMG8lkIeWPJM2/kT9gRaTTvaYlUEdJbSW5yPbvIsFIKotX8
	4vlKwGkEN29oWCVA0oEA26cAn0CM4u+ile4EdpHQ0Nsja0IwHNvfxvjJJODjLLWCYIutNkJR9U7kL
	cxkRTYOklkTtzeASjPrsO/Svnu01pm00kH3Z/Q43Y3FC3unz6hZsQA0fYFDOGPJv09UXidcW4UenI
	O8hJh/gXD8lBrT+PEvLGlcnSWizPbOnDYLpT0uQHRBKW2XlD7zPwXxcBlpyPKkzYgDWaH5v9FEcLN
	c/2G0pNA==;
From: Heiko Stuebner <heiko@sntech.de>
To: tomeu@tomeuvizoso.net, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 ulfh@kernel.org, p.zabel@pengutronix.de, ogabbay@kernel.org,
 zhangqing@rock-chips.com, Jiaxing Hu <gahing@gahingwoo.com>
Cc: royalnet026@gmail.com, abel.vesa@oss.qualcomm.com,
 sebastian.reichel@collabora.com, sidong.yang@furiosa.ai,
 u.kleine-koenig@baylibre.com, chaoyi.chen@rock-chips.com,
 diederik@cknow-tech.com, alchark@flipper.net,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jiaxing Hu <gahing@gahingwoo.com>, Conor Dooley <conor.dooley@microchip.com>
Subject:
 Re: [PATCH v13 07/14] dt-bindings: power: rockchip: allow resets in a power
 domain node
Date: Mon, 21 Sep 2026 23:52:31 +0200
Message-ID: <2492931.NG923GbCHz@phil>
In-Reply-To: <20260915104328.45901-8-gahing@gahingwoo.com>
References:
 <20260915104328.45901-1-gahing@gahingwoo.com>
 <20260915104328.45901-8-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Dienstag, 15. September 2026, 12:43:21 Mitteleurop=C3=A4ische Sommerzeit=
 schrieb Jiaxing Hu:
> Some domains do not come up in a usable state on their own and need their
> resets cycled once power is on. The RK3576 NPU domains are one
> case: without it the first access after power-on takes an async SError.
>=20
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  .../bindings/power/rockchip,power-controller.yaml         | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/power/rockchip,power-contr=
oller.yaml b/Documentation/devicetree/bindings/power/rockchip,power-control=
ler.yaml
> index b41db576f..83741f048 100644
> --- a/Documentation/devicetree/bindings/power/rockchip,power-controller.y=
aml
> +++ b/Documentation/devicetree/bindings/power/rockchip,power-controller.y=
aml
> @@ -136,6 +136,13 @@ $defs:
>            A number of phandles to clocks that need to be enabled
>            while power domain switches state.
> =20
> +      resets:
> +        maxItems: 1
> +        description:
> +          A phandle to a reset that needs to be cycled once the power do=
main has
> +          been switched on, for domains whose logic does not come up in =
a usable
> +          state by itself.
> +
>        domain-supply:
>          description: domain regulator supply.
> =20
> @@ -216,6 +223,7 @@ examples:
>                      reg =3D <RK3399_PD_IEP>;
>                      clocks =3D <&cru ACLK_IEP>,
>                               <&cru HCLK_IEP>;
> +                    resets =3D <&cru SRST_A_IEP>;
>                      pm_qos =3D <&qos_iep>;
>                      #power-domain-cells =3D <0>;
>                  };
>=20




