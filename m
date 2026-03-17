Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2243EAC7B;
	Tue, 17 Mar 2026 15:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773760505; cv=none; b=pHdNnigpC8A+3dyxX/D2yH/JP/YJPTwTWSstPKWD70ocenqZCvER9t3ZbcZE96sy6C4qu5KEGjTkZFsA/I7l/rBg00Zriq7C1onTjt05GHjA24ZR0rygVj0Xuj+L3fglMgdbgOQ3u5GfQY9ckpxfr2ggtaYAJP7dQCCh544nqUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773760505; c=relaxed/simple;
	bh=45xiiQLLlVrqQcRFySTPrwONjFB09qA8SXMtIiXNbWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iSOLSGF/dWKyrw4r/QoXQ8zIRuJus0Ocd/E0H6Q31RK5aOwed/WcU/w+F8I2xXBlzekzKhcXIq8nXO9pkEXGkgy8zwuMab8tEYBGxNhKRphzAUWmzW87GAE8OMpKKsoFlCzuS6SDhgTeukAaOtb9//Mnm9pnTwlSehhgS9jdM1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=aE6K6iBT; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="aE6K6iBT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=4qqIO5Nq4HZXMqx40ONnhQAaxlGohVZ2byEsaKtpwVE=; b=aE6K6iBT+96RgF/AXkjeTIg7fI
	jlo6J/tjurPYMVRpNDnbGHBIADEYLG82kIiLADARaE4f7JgkQwuswrfvLaqqr7NtHHOCIZvJhIayv
	aWwdrfzo8wD+Qcs6NqgaPI/WOHwK89r1ko1FRqErJsJY9ZSMddQLK9hPC11feftENz+iQK3yPbQoS
	gaZfBJLzT8F7D+u5R84T+2tAFtTvO4XssjWwCxJcWkFoUQAChSJXhW0hcQSy2lVqQKzpuRaZVoVv8
	buG8FU/pxaTAE3L1mMLOx1xGWxBKJuB0jvcMfLSSPsRZB8OljdSHF9stY6s0LPCywIsQ2BZiCtQ6l
	CvCBrOLw==;
From: Heiko Stuebner <heiko@sntech.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.com>
Subject:
 Re: [PATCH] thermal/drivers/rockchip: Shut up eFuse prober defer warning
Date: Tue, 17 Mar 2026 16:14:45 +0100
Message-ID: <3330199.5fSG56mABF@phil>
In-Reply-To:
 <20260317-rockchip-thermal-trim-warning-v1-1-01bc4bda75e9@collabora.com>
References:
 <20260317-rockchip-thermal-trim-warning-v1-1-01bc4bda75e9@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Dienstag, 17. M=C3=A4rz 2026, 15:31:30 Mitteleurop=C3=A4ische Normalzeit=
 schrieb Sebastian Reichel:
> Shut up the following message printed at error level on ArmSom Sige5:
>=20
> rockchip-thermal 2ae70000.tsadc: failed reading trim of sensor 0: -EPROBE=
_DEFER
>=20
> Fixes: ae332ec0009d ("thermal/drivers/rockchip: Support reading trim valu=
es from OTP")
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  drivers/thermal/rockchip_thermal.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchi=
p_thermal.c
> index c49ddf70f86e..2a40339de0d0 100644
> --- a/drivers/thermal/rockchip_thermal.c
> +++ b/drivers/thermal/rockchip_thermal.c
> @@ -1638,8 +1638,7 @@ rockchip_thermal_register_sensor(struct platform_de=
vice *pdev,
>  	if (tsadc->get_trim_code && sensor->of_node) {
>  		error =3D rockchip_get_efuse_value(sensor->of_node, "trim", &trim);
>  		if (error < 0 && error !=3D -ENOENT) {
> -			dev_err(dev, "failed reading trim of sensor %d: %pe\n",
> -				id, ERR_PTR(error));
> +			dev_err_probe(dev, error, "failed reading trim of sensor %d\n", id);
>  			return error;
>  		}
>  		if (trim) {
>=20
> ---
> base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
> change-id: 20260317-rockchip-thermal-trim-warning-cd0072aa2f46
>=20
> Best regards,
>=20




