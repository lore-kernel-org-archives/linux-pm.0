Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5656642E8D6;
	Mon, 20 Jul 2026 22:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784584803; cv=none; b=U15OOUYOWXEPj0d7jZirmna3DQI3WcoYmJRWmeUtR04fEsh6sVRB2ue6GysEX9Xz23KsQgv5tf1VnCvwYnv6qT5SSAD5uv2ObYPev/3jJDLof4jtGfo3jeN/J9EA22P4eLKKAX73lfxAJEtMachtAnbABP/AMFAoX4L+bPYh+FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784584803; c=relaxed/simple;
	bh=a/lH/DibqdjYAra5LPRTjJgK4H0NusKAxMUK+sPzdYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrZFAEnfWisUusRVV2nvQuAvDMBlkFpQSnEy/mvEP3OP/JytRwjRe7piDfHhEU17OozZrDlEkgV84HzoQHfrqWFZJfroRK2pwyl7XR6f7AZ046Pu2SxBl5+y8ffIJC6GxT+jUyN0omhf6Mf85mEOUoCWdHVs1IY7cbsXt+w/gos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CtmadWVN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CtmadWVN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEAA41F000E9;
	Mon, 20 Jul 2026 22:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784584802;
	bh=/HFPGnFT5xQPTJel+8S9XjVz+99UaWkvqMJ91wRwak8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CtmadWVNvqP7/U41uGh42YWbf1xyZeS3ezGfVqFEEL/zwIDCH7tTILQfi3ZwkChWS
	 PPNmzRseJf+VoJdsgO2/S503cBfmsu71y2qGPLV1UcAapCigUnfgCWRnxWPSPig2vL
	 KU31LbrN48yZH06yeXfYnxwL9fp/qXqtxJt/zCrlPTITqMPmnDFtk8tnVKqsVVu4/J
	 7t5auaQDt53Qjp7pN7oY/MEzVgr4BBFDaKKXCnuCcN4U+ZD3ONHByOnUaml9nLMJA6
	 dR9vLq+DY3WZrb1dZscgXs91RBujMBR+RF8GdU4l+JQ1d1/EykJjoK87J2LIo0nx3v
	 gwmhQ2Zhw3h9A==
Received: by venus (Postfix, from userid 1000)
	id EA3491809C8; Mon, 20 Jul 2026 23:59:59 +0200 (CEST)
Date: Mon, 20 Jul 2026 23:59:59 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Uday Khare <udaykhare77@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] power: supply: rk817: Fix battery info memory leak
 on error paths
Message-ID: <al6aD588lDLlXkYu@venus>
References: <20260618132151.11227-1-udaykhare77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260618132151.11227-1-udaykhare77@gmail.com>

Hi,

On Thu, Jun 18, 2026 at 06:51:51PM +0530, Uday Khare wrote:
> In rk817_charger_probe(), power_supply_get_battery_info() is called to
> retrieve battery info. However, if the sanity check for required battery
> properties fails, or if rk817_battery_init() returns an error, the
> function returns immediately without calling
> power_supply_put_battery_info() to release the allocated battery info
> structure, causing a memory leak.
>=20
> Fix this by introducing an error label 'err_put_bat_info' that calls
> power_supply_put_battery_info() before returning the error code, and
> jumping to it from both error paths.
>=20
> Fixes: 11cb8da0189b ("power: supply: Add charger driver for Rockchip RK81=
7")
> Signed-off-by: Uday Khare <udaykhare77@gmail.com>
> ---

What is this patch 3/4 and why do you think memory is leaked even
though device managed resources are being used internally?

-- Sebastian

>  drivers/power/supply/rk817_charger.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/power/supply/rk817_charger.c b/drivers/power/supply/=
rk817_charger.c
> index 9436c6bbf51f..a2ca2b46b2f2 100644
> --- a/drivers/power/supply/rk817_charger.c
> +++ b/drivers/power/supply/rk817_charger.c
> @@ -1156,8 +1156,10 @@ static int rk817_charger_probe(struct platform_dev=
ice *pdev)
>  	    (bat_info->constant_charge_voltage_max_uv <=3D 0) ||
>  	    (bat_info->constant_charge_current_max_ua <=3D 0) ||
>  	    (bat_info->charge_term_current_ua <=3D 0)) {
> -		return dev_err_probe(dev, -EINVAL,
> -				     "Required bat info missing or invalid\n");
> +		dev_err_probe(dev, -EINVAL,
> +			      "Required bat info missing or invalid\n");
> +		ret =3D -EINVAL;
> +		goto err_put_bat_info;
>  	}
> =20
>  	charger->bat_charge_full_design_uah =3D bat_info->charge_full_design_ua=
h;
> @@ -1170,7 +1172,7 @@ static int rk817_charger_probe(struct platform_devi=
ce *pdev)
>  	 */
>  	ret =3D rk817_battery_init(charger, bat_info);
>  	if (ret)
> -		return ret;
> +		goto err_put_bat_info;
> =20
>  	power_supply_put_battery_info(charger->bat_ps, bat_info);
> =20
> @@ -1209,6 +1211,10 @@ static int rk817_charger_probe(struct platform_dev=
ice *pdev)
>  	mod_delayed_work(system_percpu_wq, &charger->work, 0);
> =20
>  	return 0;
> +
> +err_put_bat_info:
> +	power_supply_put_battery_info(charger->bat_ps, bat_info);
> +	return ret;
>  }
> =20
>  static int __maybe_unused rk817_suspend(struct device *dev)
> --=20
> 2.54.0
>=20
