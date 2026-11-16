Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794809005;
	b=QOPRCfSvxAhHqRxj5fYps9Oq4AjM86+/sD1tTshqOIaSk1/aA6/lJdzbq+JlUCpHYOD2
	 dZck/NxHfSdLjfB9sSPDRGnplFPRAn8ZjkIJkQytNn6zb4To1XEz30jDNq8ysOfOxBsza
	 wLj8Dk59TU9s6KGbli4dc85zt96d/ETOPGZnJjt17996ZV6LJfapJucbWNR9rLPJCX6Xk
	 ST5y7Z7ESa2Gn/fQ0uEJIBN8UNA7YOSECHWP8SMtehWiAefi2GDT3xnFX1YowfLucGUqq
	 OtnbRy6eeJEIqoPbMoRdmZRA42qpvTPHV8peJWlb94TcEBAxgnAmHkUz/8m22TGC2MA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794809005;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:
	 X-ZohoMailClient;
	bh=GjrJKJtHS46OJDZX/DmXEog4SSg8yCUr8jL/qe72nY8=;
	b=UAO9Ql4nxZ/KCPgFQFyJFiMfxdzjz4jXmoigEv8EbQ4NoYKyv50qDV0f4rzZeBdk7UW8
	 KXzd5oPMq1ay9ffpyBV8BnyejRvIz/HwcUSlKt+WQrfB5NtfdLXBQUnZGgA/m0/0Hhw/B
	 bf+VHxFLZkSFtbYSiNpwZIERvMq9nSEHLytLRFnkPIvGZMHN3126Wm4x8zLYaJrf4jlqO
	 HxIQ4uhhdferwByX/2R2pDyyV26SkRkRMu3l0kUK8k5LfUN/cuAF7IcYt0kqFaNIYYTYc
	 bcqgJEw+q2lyBvCLm2aoMDgxMoKPVuPLv4oyqdSThtKrRQg6mlUYdRsjCockGPPcxgA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b="kWBnjja/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com [165.173.180.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176BE606A89C;
	Mon, 16 Nov 2026 06:03:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 176BE606A89C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=kWBnjja/
ARC-Seal: i=1; a=rsa-sha256; t=1794808967; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=eO4NunFLfUpjtdqFsInmL6Ig78bKoBisGOClJFqnmNazXN90VGUa48sk5lsIpf4p0ukeqfEn8b9qyekan2mEUDbanjEw64dYjcF/4ocAZrBBrQlYP9CGth3k8l6EmQsKC1Lw9TkNN7mP8Ug49roZYrdHYt1kkbXRafj34pmbqIw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794808967; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=GjrJKJtHS46OJDZX/DmXEog4SSg8yCUr8jL/qe72nY8=; 
	b=AbF5OxZjTE08cKKF8c8SjcA6Vc7ZKhI9uufNdP2df+UtdWDkIxaEhOubKmGUhBPT54PbE3ByMKU3gaIwlZJJwwXhyf2hGxXGFvA2ffuVTUQGa9R07DI6hRUsidkFF8cP9sM8LChTZ4yhORUQ+pxa6yuLCAjU6p4RvjKt1vICbFs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: a=rsa-sha256; b=kWBnjja/3WrebN6d3OTdAS8BWIhdNbHhIM8L+lTCg/Dd/UX+5RJ4udDvkLvKyS3QAUX8FUATz/hWFfrk+MCatFfO1n2CqRUjqEYzUjtCivQRGY8rL6ph+NFHseRfjeOl2RsAFFRje/IWg9AGC32EEaXk1dx0ububurdK6G11Sb8=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=GjrJKJtHS46OJDZX/DmXEog4SSg8yCUr8jL/qe72nY8=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794808965217229.76632615707183;
	Sun, 15 Nov 2026 22:02:45 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 20A3C181BF9; Mon, 16 Nov 2026 01:30:41 +0100 (CET)
Date: Mon, 16 Nov 2026 01:30:41 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Yixun Lan <dlan@kernel.org>, 
	Aurelien Jarno <aurelien@aurel32.net>, 
	"open list:I2C SUBSYSTEM HOST DRIVERS" <linux-i2c@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:SYSTEM RESET/SHUTDOWN DRIVERS" <linux-pm@vger.kernel.org>, 
	"open list:RISC-V SPACEMIT SoC Support" <linux-riscv@lists.infradead.org>, 
	"open list:RISC-V SPACEMIT SoC Support" <spacemit@lists.linux.dev>
Subject: Re: [PATCH v1 2/2] power: reset: spacemit-p1: Use atomic I2C
 transfers for power-off and restart
Message-ID: <avpN-gFOvTBAMY6G@venus>
References: <20261110061429.2036-1-linux.amoon@gmail.com>
 <20261110061429.2036-2-linux.amoon@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u676w3pv57qxlz5x"
Content-Disposition: inline
In-Reply-To: <20261110061429.2036-2-linux.amoon@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/294.637.76
X-ZohoMailClient: External


--u676w3pv57qxlz5x
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 2/2] power: reset: spacemit-p1: Use atomic I2C
 transfers for power-off and restart
MIME-Version: 1.0

Hi,

On Tue, Nov 10, 2026 at 11:44:27AM +0530, Anand Moon wrote:
> The SpacemiT P1 power-off and restart handlers use regmap_set_bits()
> to access the PMIC. However, these handlers run in an atomic notifier
> context (specifically within an rcu_read_lock() critical section), while
> the I2C-backed regmap uses a sleepable mutex.
>=20
> This triggers a "WARNING: suspicious RCU usage" warning due to an illegal
> context switch in the RCU read-side critical section during shutdown on t=
he
> Banana Pi BPI-F3:
>=20
> [  563.803475] WARNING: suspicious RCU usage
> [  563.807813] 7.3.1-ARCH-RISC-V #1 Not tainted
> [  563.816614] ./include/linux/rcupdate.h:387 Illegal context switch in R=
CU read-side critical section!
> ...
> [  563.841445] locks held by shutdown/1: 2, last CPU#0:
> [  563.846694]  #0: ffffffff8404fb20 (system_transition_mutex){+.+.}-{4:4=
}, at: __do_sys_reboot+0x230/0x29e
> [  563.856806]  #1: ffffffff84167860 (rcu_read_lock){....}-{1:3}, at: ato=
mic_notifier_call_chain+0x4a/0x1c2
>=20
> Replace the regmap operations with atomic I2C transfers to avoid sleeping
> in an atomic context. Preserve unrelated register bits through
> read-modify-write operations and check for atomic I2C support before
> registering the handlers.
>=20
> Obtain the I2C client from the parent device and verify that the adapter
> supports atomic transfers before registering the handlers.
>=20
> Tested on the Banana Pi BPI-F3 (SpacemiT K1).
>=20
> Assisted-by: LLM
> Cc: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Fixes: 28124cc0fb8c ("driver: reset: spacemit-p1: add driver for poweroff=
/reboot")
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---

regmap runs i2c_transfer itself and thus also uses the atomic I2C
transfers. The problem here is regmap itself. But instead of moving
away from regmap, the atomic use case should be supported properly
in regmap.

Greetings,

-- Sebastian

>  drivers/power/reset/spacemit-p1-reboot.c | 86 ++++++++++++++++++++----
>  1 file changed, 74 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/power/reset/spacemit-p1-reboot.c b/drivers/power/res=
et/spacemit-p1-reboot.c
> index c0454b547718..8fcb3eadddf3 100644
> --- a/drivers/power/reset/spacemit-p1-reboot.c
> +++ b/drivers/power/reset/spacemit-p1-reboot.c
> @@ -4,8 +4,9 @@
>   */
> =20
>  #include <linux/bits.h>
> +#include <linux/errno.h>
> +#include <linux/i2c.h>
>  #include <linux/platform_device.h>
> -#include <linux/regmap.h>
>  #include <linux/reboot.h>
> =20
>  /* Power Control Register 2 */
> @@ -13,13 +14,68 @@
>  #define PWR_CTRL2_SHUTDOWN	BIT(2)	/* Shutdown request */
>  #define PWR_CTRL2_RST		BIT(1)	/* Reset request */
> =20
> +static int spacemit_p1_read_atomic(struct i2c_client *client,
> +				   u8 reg, u8 *val)
> +{
> +	struct i2c_msg msgs[] =3D {
> +		{
> +			.addr =3D client->addr,
> +			.flags =3D client->flags & I2C_M_TEN,
> +			.len =3D 1,
> +			.buf =3D &reg,
> +		},
> +		{
> +			.addr =3D client->addr,
> +			.flags =3D (client->flags & I2C_M_TEN) | I2C_M_RD,
> +			.len =3D 1,
> +			.buf =3D val,
> +		},
> +	};
> +	int ret;
> +
> +	ret =3D i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
> +
> +	return ret =3D=3D ARRAY_SIZE(msgs) ? 0 : ret < 0 ? ret : -EIO;
> +}
> +
> +static int spacemit_p1_write_atomic(struct i2c_client *client,
> +				    u8 reg, u8 val)
> +{
> +	u8 buf[] =3D { reg, val };
> +	struct i2c_msg msg =3D {
> +		.addr =3D client->addr,
> +		.flags =3D client->flags & I2C_M_TEN,
> +		.len =3D sizeof(buf),
> +		.buf =3D buf,
> +	};
> +	int ret;
> +
> +	ret =3D i2c_transfer(client->adapter, &msg, 1);
> +
> +	return ret =3D=3D 1 ? 0 : ret < 0 ? ret : -EIO;
> +}
> +
> +static int spacemit_p1_update_bits_atomic(struct i2c_client *client,
> +					  u8 reg, u8 mask)
> +{
> +	u8 val;
> +	int ret;
> +
> +	ret =3D spacemit_p1_read_atomic(client, reg, &val);
> +	if (ret)
> +		return ret;
> +
> +	return spacemit_p1_write_atomic(client, reg, val | mask);
> +}
> +
>  static int spacemit_p1_pwroff_handler(struct sys_off_data *data)
>  {
> -	struct regmap *regmap =3D data->cb_data;
> +	struct i2c_client *client =3D data->cb_data;
>  	int ret;
> =20
>  	/* Put the PMIC into shutdown state */
> -	ret =3D regmap_set_bits(regmap, PWR_CTRL2, PWR_CTRL2_SHUTDOWN);
> +	ret =3D spacemit_p1_update_bits_atomic(client, PWR_CTRL2,
> +					     PWR_CTRL2_SHUTDOWN);
>  	if (ret) {
>  		dev_err(data->dev, "shutdown failed: %d\n", ret);
>  		return notifier_from_errno(ret);
> @@ -30,11 +86,12 @@ static int spacemit_p1_pwroff_handler(struct sys_off_=
data *data)
> =20
>  static int spacemit_p1_restart_handler(struct sys_off_data *data)
>  {
> -	struct regmap *regmap =3D data->cb_data;
> +	struct i2c_client *client =3D data->cb_data;
>  	int ret;
> =20
>  	/* Put the PMIC into reset state */
> -	ret =3D regmap_set_bits(regmap, PWR_CTRL2, PWR_CTRL2_RST);
> +	ret =3D spacemit_p1_update_bits_atomic(client, PWR_CTRL2,
> +					     PWR_CTRL2_RST);
>  	if (ret) {
>  		dev_err(data->dev, "restart failed: %d\n", ret);
>  		return notifier_from_errno(ret);
> @@ -46,21 +103,26 @@ static int spacemit_p1_restart_handler(struct sys_of=
f_data *data)
>  static int spacemit_p1_reboot_probe(struct platform_device *pdev)
>  {
>  	struct device *dev =3D &pdev->dev;
> -	struct regmap *regmap;
> +	struct i2c_client *client;
>  	int ret;
> =20
> -	regmap =3D dev_get_regmap(dev->parent, NULL);
> -	if (!regmap)
> -		return -ENODEV;
> +	client =3D i2c_verify_client(dev->parent);
> +	if (!client)
> +		return dev_err_probe(dev, -ENODEV,
> +				     "Failed to find parent I2C client\n");
> +
> +	if (!client->adapter->algo->xfer_atomic)
> +		return dev_err_probe(dev, -EOPNOTSUPP,
> +				     "Atomic I2C transfers not supported\n");
> =20
> -	ret =3D devm_register_power_off_handler(dev, &spacemit_p1_pwroff_handle=
r,
> -					      regmap);
> +	ret =3D devm_register_power_off_handler(dev, spacemit_p1_pwroff_handler,
> +					      client);
>  	if (ret)
>  		return dev_err_probe(dev, ret,
>  				     "Failed to register power off handler\n");
> =20
>  	ret =3D devm_register_restart_handler(dev, spacemit_p1_restart_handler,
> -					    regmap);
> +					    client);
>  	if (ret)
>  		return dev_err_probe(dev, ret,
>  				     "Failed to register restart handler\n");
> --=20
> 2.56.0
>=20

--u676w3pv57qxlz5x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmr6Tq0ACgkQ2O7X88g7
+ponXw//Sp9xpt0dtgwqvDwLyNDq4zBRATYky3jp5RiOzLRMnXPL3xnDkjdgJVYL
MAFqKnMs4DrZJLtMjVpWPifQ8/oF2WmxwSzWusMeptDo6237HwLwJIpce3AP2XIG
S4sIK7A3lSTbOqgM/BOMyBtJi0afcgMqT4ElzXZfnfSiT7KyE+rO3KOHHLtxBXGC
6XTXk6ol53Kv8QA5GTIfj+Gu7EWwUsMxuApFWvo6lINcFObKy7uWeqIpvUuVbViD
9IPiaFRsQQtjYr9iax7LxbUcRjOz9BcsHaHsJdwWleoCl8wngMicZaNZPlNZa1rS
lS6bakRDSGfxAbL0UPfWq7D9OTrALgbpprw3AYOkzWeXuvqK4BClbil7cilolz2W
E4AG8A+etvkHLXIJJyEMfN4Zp2ogpL5lnfYKWbHVWbLQtyUtIMS8kqugI/qbWH/G
K31uLkvXuQTk1t6SBLDKk9jyw6w6393l/SQhLTD4kReXgEEmUsG7guLRVuO7ki8C
aBLM5eisYIGDEOjr7b1wAMoOnciy1ZLhUoLc1+aOHhOcHhmGwSvp14LUqg9QozXK
zhgNvwndRH75DdkEU9Okr2MIDtaqTe4HVygijoNmuvPnqrqbXZi0oI2GpSa5lPPn
qQR+mA8tx9mKQ95ruAX3WhHannpOiGI9IQh+Hjenc+1F5h5SFNE=
=5b6q
-----END PGP SIGNATURE-----

--u676w3pv57qxlz5x--
