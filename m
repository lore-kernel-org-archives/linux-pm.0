Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793925479;
	b=Q4R59maMe9Qny7NRwXOngIoZ/zgrtnp5dUeAdsk8/P1HUwAknEXzx3reSZI/mUy8v4R8
	 b48UAPKaUl2j8X4wm0odIUiKJ9uOuugLc5GaWlbBldh+vv6eWnFIcDFQzbaGDj/3DiFc7
	 qW2HRc57HBjrhpogeHgTcz8PaOuLJpnCRQyB6XAIC6xM0IYFzfEWmFDAjTsrDUQSub/qf
	 dUBY7g5s0fgGg2D1VJHNjB8mqBlRuQxvG5gf1qLs1urKjK7lfu+wmT3vtilCkvysL59C1
	 cZuex0RgiGaqJhz+0C76zVVg1d3PyYLIr5LGJ5P1hmhtaE8Q6V2xdDli02w1TxdeKMg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793925479;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
	bh=sdoSdWPwCgIPKnV1U3gXURglAJm1i0Icgi+YPF80Ui4=;
	b=KNIfa4cbqyfF7YsNJYdXQsyv+AFYHFMQxyk+tg6B/7mHxKxRQhhZs9Gt2HhRxI3HP8Sz
	 2VUfmN+8Wx+apdJgs1b6e5Zixq4HJvZkFQgUcKiLNlZJmg4lrxCOhgMjWUpGGxX4S6YWr
	 Tw4Zw8b+Df5J4ytEHGLjWOY7Vn6/P8WaXrmwEcdW4bIJCTWnUyLluyepNmCQtGfFvx6fS
	 2b0u5X00VQr7fO7PUrvlNtezB6/f2xzUtg4pAOvbv4Q9w2eN0VbUPheJqyXo8rzJod6nz
	 kihy6RExA2oGQ/mVRn9v8zGGr4hZ2M+zy5mZ81yn/qhYDGPaUthzZPKIqgId/mQWb6g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=WXZsiHrz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.12
Received: from sender6-op-o12.zoho.com (sender6-op-o12.zoho.com [165.173.180.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763D7606A31B;
	Fri,  6 Nov 2026 00:37:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 763D7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=WXZsiHrz
ARC-Seal: i=1; a=rsa-sha256; t=1793925466; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OfYjXpRewqBZ2nokUWf6vGNQf0Y85gbOg36/1SO0Cu8zxdFwVAkXUxkrcZ96wZLzDP3SJwneYmOgINgK5amPpE3MFre6A+yny4FmB1Wm8fxEv8Q1/iFnLYeN4IF9IGzVNNarnubpoZj09qkpr6M0RnqNLRqywXRjsGsRJnSIUms=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793925466; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=sdoSdWPwCgIPKnV1U3gXURglAJm1i0Icgi+YPF80Ui4=; 
	b=O/piH8zXgmhfD9KBe0Tw3FXIiWWOahte5a+IYYeWVT1Et0N5nPocQSdEvMO2LoCJq6N2c0CD4F+vhvu/tXlrf7EzhwSPH//On4YIR6GmZt/VEUSCHK3xMPHakPRoNN0atLh1Y0yCV1TGYyeR7YFB6zpH5ImwAFX/+B+Sm32uztY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: a=rsa-sha256; b=WXZsiHrzTymHXmchiZc3soumXnHZ7CINWHZKZTwkxbfmQP97Y/xNy5x0Lenl3ZecqO4hZlWzlu+tNMYz0Z9RJiRK73IWlsu1rfyJgUvjMAZVZem6dcZqnl/OnlwgsNN/V54V4TH5RT+EW8MVtVgzqheWR9VSQgK1cMf2OlxE0cE=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=sdoSdWPwCgIPKnV1U3gXURglAJm1i0Icgi+YPF80Ui4=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793925465455255.28372820052175;
	Thu, 5 Nov 2026 16:37:45 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 9052B180354; Fri, 06 Nov 2026 01:37:41 +0100 (CET)
Date: Fri, 6 Nov 2026 01:37:41 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Yaohan Li <shunsheng1218@gmail.com>
Cc: hansg@kernel.org, marex@denx.de, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: bq25890: cancel pump work before supply
 removal
Message-ID: <au0gsSfR64U3Bs3S@venus>
References: <179378565123.72475.2497991563887142080@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <179378565123.72475.2497991563887142080@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/293.901.53
X-ZohoMailClient: External

Hi,

On Wed, Nov 04, 2026 at 05:47:31PM +0800, Yaohan Li wrote:
> The existing devm cleanup for pump_express_work runs after the
> managed power supply has been unregistered. A delayed or running pump
> work item can therefore call power_supply_changed() with a freed
> power_supply pointer.
>=20
> Register an additional devm cleanup action after power-supply
> registration, so devres reverse ordering drains the work while the
> supply is still alive. Keep the original late cleanup as a backstop
> for work that might be queued again during supplier teardown.
>=20
> A KASAN test using a simulated I2C device and the real bq25890
> driver reproduced the use-after-free before the change and not under
> the corresponding teardown sequence afterward.
>=20
> Fixes: a7aaa80098d5b7608 ("power: supply: bq25890: Ensure pump_express_wo=
rk is cancelled on remove")
> Assisted-by: ZCode:GLM-4
> Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>
> ---
>  drivers/power/supply/bq25890_charger.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>=20
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/suppl=
y/bq25890_charger.c
> index f7510ada6b734..a3e35e036b97b 100644
> --- a/drivers/power/supply/bq25890_charger.c
> +++ b/drivers/power/supply/bq25890_charger.c
> @@ -1459,6 +1459,23 @@ static void bq25890_non_devm_cleanup(void *data)
>  	}
>  }
> =20
> +static void bq25890_cancel_pump_express(void *data)
> +{
> +	struct bq25890_device *bq =3D data;
> +
> +	/*
> +	 * Cancel the delayed work while the power supply is still alive:
> +	 * bq25890_pump_express_work() calls power_supply_changed() at its
> +	 * end and must not run against an already released supply.
> +	 *
> +	 * bq25890_non_devm_cleanup() stays in place as well: it runs
> +	 * after the devres-managed power supply has been unregistered,
> +	 * catching work queued again from the supplier-change path
> +	 * between this cancel and the unregister.
> +	 */
> +	cancel_delayed_work_sync(&bq->pump_express_work);
> +}
> +
>  static int bq25890_probe(struct i2c_client *client)
>  {
>  	struct device *dev =3D &client->dev;
> @@ -1531,6 +1548,10 @@ static int bq25890_probe(struct i2c_client *client)
>  	if (ret < 0)
>  		return dev_err_probe(dev, ret, "registering power supply\n");
> =20
> +	ret =3D devm_add_action_or_reset(dev, bq25890_cancel_pump_express, bq);
> +	if (ret)
> +		return ret;

Use devm_delayed_work_autocancel() (and drop the INIT_DELAYED_WORK).

-- Sebastian

> +
>  	ret =3D devm_request_threaded_irq(dev, client->irq, NULL,
>  					bq25890_irq_handler_thread,
>  					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> --=20
> 2.34.1
>=20
