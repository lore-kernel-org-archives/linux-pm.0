Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF62630FC33;
	Sat, 25 Jul 2026 00:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784941083; cv=pass; b=lSgmqH42Gwx1uAU6zpxO8LM1eOiV4oqkHrKT+ZHIDNvsoJ8inkSmJ0k2vdAZYVWgLkgQCH24FWF5AsxjDJQahH8QzPCC9iVbJWLEMy0grNHh3JOn+6aVqUsp66XYKEFX9aKk+LlkC3/Mvzki6tGS+LcnQrs6O4zHdUdigAQ5/vI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784941083; c=relaxed/simple;
	bh=3jX2NPn8Ggx5u7oHDBtLI1QXb88eKHpJFAUCqZ1LlVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XCMvP1vTunji4bP527X3VPGnZFXSwFWJX6usGsuf+3ATUFCejh8IrLVDkH6QYnpsFFjH5GlIIRntWL3cmCOKWv8z35+DqeXuZV6G2dmr6telcxS/QBvqsRGrF1PvfQ8IFoxE3b9cO0T9ETT0X5O2mt2UKJ5zpNwjN5GP/xFicrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=bMFLbjWT; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="bMFLbjWT"
ARC-Seal: i=1; a=rsa-sha256; t=1784941076; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Fk/uHJyn1KI1HNQEc448Y5Z/QPTwBNeO8SWNRq/iXpz5/MQOUUA9geWV8mIU3wvZ9jAtsmnR1i3P71msjJ9M9SVvApVbaxk07VLVmOxe+6iug+wbJS/kOje9lbA/irGuU2nN3FvWySNLILV1ZSle8ybpo/go5ZQtkUjiC2CilsA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1784941076; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QoV9MQm2z8Lj660IBnsTrgDLx/F6c63KW1xk1FNy+YU=; 
	b=KnHJpByN7R/2u10h/lcFWjRDWe9P5LbjcQq267PhUdUfRvdccVNktG3eSxVGX4WIwXBAa5x8mbh5+DuZ7XjEwJ/EzYfaQ2aGgba37g991ex0A8eXA5mBXKlz5c7ZLOVD05PY/Tba6RPwyb6OZZ2K8optYfZgceJV3Gj3sGx56qw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784941076;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=QoV9MQm2z8Lj660IBnsTrgDLx/F6c63KW1xk1FNy+YU=;
	b=bMFLbjWTknuQ5w1gKUavpeA1gZ5vgoDHGkXirJYOKDmgpPnlREGoSooJxxcx7hhz
	EBJp1D/pUQLYi/oZvnuAl7CX4cmaNbg+hMYr3kWXWX0do/Tix2p4CUOllHfRnTjvUvC
	aaC+wnm3Vmq0JEqSJfYJ6mKvJ3Fx7UmCk+h2Akqw=
Received: by mx.zohomail.com with SMTPS id 1784941074457494.6111863587579;
	Fri, 24 Jul 2026 17:57:54 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id DC151181F16; Sat, 25 Jul 2026 02:57:51 +0200 (CEST)
Date: Sat, 25 Jul 2026 02:57:51 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Waqar Hameed <waqar.hameed@axis.com>
Cc: kernel@axis.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 2/2] power: supply: Add driver for TI BQ25630 charger
Message-ID: <amQD4oydNkzlOIeC@venus>
References: <cover.1782683551.git.waqar.hameed@axis.com>
 <ca5228dc74705adf96f0af5363ccb65bb965640b.1782683551.git.waqar.hameed@axis.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vp344jh3wzhoodxg"
Content-Disposition: inline
In-Reply-To: <ca5228dc74705adf96f0af5363ccb65bb965640b.1782683551.git.waqar.hameed@axis.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/284.919.37
X-ZohoMailClient: External


--vp344jh3wzhoodxg
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 2/2] power: supply: Add driver for TI BQ25630 charger
MIME-Version: 1.0

Hi,

On Mon, Jun 29, 2026 at 12:01:19AM +0200, Waqar Hameed wrote:
> TI BQ25630 is a battery charger that is I2C controlled. Despite its
> model name, it is rather different from the other devices in the BQ256xx
> family; it has a completely different register layout and some other
> additional functionality (see the datasheet for more details [1]).
>=20
> The most "annoying" thing is that it has two different register lengths:
> 8-bit and 16-bit. Moreover, the 16-bit registers are further partitioned
> into either being little- or big-endian... Luckily, `regmap` has support
> for multiple `regmap_config`s (by setting unique names). Therefore, use
> three different `regmap_config`s for the corresponding registers. ADC
> functionality has been left out, due to it not having any real-world
> use-cases.
>=20
> The `enum power_supply_property` values are straightforward to map. Some
> properties are clamped (e.g. voltage/current ranges). Common
> `bq25630_read/write_limit()` functions for this are therefore suitable.
>=20
> Interrupts are sent whenever a state change is detected. Save the state
> status registers in `bq25630_data` and `memcmp()` this in order to
> decide if `power_supply_changed()` should be called or not. The actual
> state values are in (and fetched from) the other
> `power_supply_property`-mapped registers.
>=20
> [1] https://www.ti.com/lit/gpn/bq25630
>=20
> Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
> ---
>  drivers/power/supply/Kconfig           |    7 +
>  drivers/power/supply/Makefile          |    1 +
>  drivers/power/supply/bq25630_charger.c | 1073 ++++++++++++++++++++++++
>  3 files changed, 1081 insertions(+)
>  create mode 100644 drivers/power/supply/bq25630_charger.c
>=20

[...]

> +static const struct power_supply_desc bq25630_charger_psy_desc =3D {
> +	.name =3D BQ25630_DRV_NAME,
> +	.type =3D POWER_SUPPLY_TYPE_USB_TYPE_C,

Just POWER_SUPPLY_TYPE_USB, other USB details should be done via
USB_TYPES (as you do already). I just cannot remove those types
because they are used by some old drivers and exposed to userspace
and thus ABI. I guesss I should add a _DEPRECATED to the in-kernel
name.

I will fix that up while applying.

Greetings,

-- Sebastian

--vp344jh3wzhoodxg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmpkCgsACgkQ2O7X88g7
+pq/sxAAow06EJ79auZhgPrPXjc8zh8OUDAtxvtmLoUU61nmDGxpEDHzLlh83wZ6
F117WY91PRrP9GsvmlshAxIXPn1v7ePyAhDaFxtb3KGkhYuOXvDcEcVHMo+NfA5p
Hc5US/5H+FvQXts2ZU7KuKuJlo1h0AvMbikVLDTNq7OroewMXO0DdcKRYnnycLZ1
zrjWpfFkCpxBUWKiKlnKQmlrOYkl+T0/JpbURQpr3BoClYr+qKiy5ssqv/91onMg
8TdOy0igj+sNqwUGfEcDtwS8w4zmyZaPWcGuZ57WZRFgWoCINvktMEGRYYk0k8ZO
SeXcpeeSStiXgmahNFic4zJkbQ4tWNxhVjfOKGY60MfXFP9Poim7ECXee49CFh8O
bqfVjg4fyMsqji2EhUqGTDl1cmXZ6fRAMz1XZJk4jl6dAgXR7E5xb26xV7YSCH78
GgotqE1BQJ7Q55YoBlid5nlofD1P2ZTCJFbsCLXtHBhyexXEYB75HyiinCiy5bnI
FvHcGDpC1znuAWC5hsX9B0XzWg/tX0db7Wo13kGjDrp1DaYsiWAMnmMSPzh5bJ3n
Wniqz0SQ6K7sJBgqtKxN7smnh5ukPGIRUyBQqyeIIlYTbicsyaTPtz3x4xwiPepl
awvU8kO25EbP0hSum+q00oAhzJsDDkUjWZZcy/n2Dg5fDyWVhaU=
=lp4S
-----END PGP SIGNATURE-----

--vp344jh3wzhoodxg--
