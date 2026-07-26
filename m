Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBB52772E;
	Sun, 26 Jul 2026 00:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785024100; cv=pass; b=u+TRYbmWZJUU7HfnexzXCwhTrZ0PG0CQrBh/noWX2DGg1SIgjd9Rfu+ubOquqH+Y8sI7EfBDajqrxyewozM6qnk1oUP98DUYfs+/jAc7M9JZDtW1Qb+eS7/WnIHmDCosLdZmumDdX81MrlqzYTOZAHT/bbJttPaNm1t9lN9CQhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785024100; c=relaxed/simple;
	bh=oNFVY4CDk2cf7NSVzzy9rHNhASkP0Sq2Hamjgif4Kkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxi8rtoTTvEDJGXb/uj8V0ROVUL4maQ4UcN4qamJPpliWfZ3zvHjXJdfjUl/3EEte+PBuAXs81XX7a2nxYzbxE9h33FFM9ievb2vw7SzeJvhxPdZ+6xxXuAw1//3yG2VnFAZ7fzCQRVEOQTaeYR0i2d9p8WxJYZQitD3vnIpz2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=VrBibcFn; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="VrBibcFn"
ARC-Seal: i=1; a=rsa-sha256; t=1785024080; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gP6xIXKkIb2CBMzMakz3m+zlzA2Wo15oMdXRKWKhiuu71L5fGarZpdg1RkPdI+6svd472YQ0IvrZrAZ0U5FmhFOnAXdGnaPNgnupQJr34D6WeQVNYZEhUGJX3OeYHc26vycT0oNrbqj7d+bNzK5cPDU1IjBbaXzqxkMMLd9hvok=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1785024080; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=gTR4Fxc7C9VBSL4Vg/8xY18ZJ1z/hE0tDTAhqmt+GUk=; 
	b=Hqdm4vD0G/z12nzAwDLtg/UdQLMKD5LUshgA5JtP0d5TmOUvbwWTiqTsnGQM34D5yHKuFmx0q7icmK3EKwfaav+MMMjcUAFkvmaV07um+uTHdpUijYQPW2O+8K/T58atrU4Xli+whiYQLyiSBl5kIhzPW6QayVnr5+Qr3Kgmay4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785024080;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=gTR4Fxc7C9VBSL4Vg/8xY18ZJ1z/hE0tDTAhqmt+GUk=;
	b=VrBibcFnyDBdEHMP6SC/NZwd/P/AzvJF2kC05ufkhHMNvq92M5TQBxqZ2yRi7SAM
	YdeH0Ky13OaEqYNZOUuuGWcRC+PD9ey9wLvhye4c7MJDTtZExl3uZTjCh/vnzqF8NU/
	bPQSTe0yLr1ldG+6rTF1rpAWICpzVBjWhBUKxLOI=
Received: by mx.zohomail.com with SMTPS id 1785024077557305.1154739495653;
	Sat, 25 Jul 2026 17:01:17 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 4DB1C1802A1; Sun, 26 Jul 2026 02:01:13 +0200 (CEST)
Date: Sun, 26 Jul 2026 02:01:13 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: amitsd@google.com
Cc: Badhri Jagan Sridharan <badhri@google.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Hans de Goede <hansg@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
	Purism Kernel Team <kernel@puri.sm>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, =?utf-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Peter Griffin <peter.griffin@linaro.org>, 
	RD Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>
Subject: Re: [PATCH v5 2/2] usb: typec: tcpm: Add support for Battery Status
 response message
Message-ID: <amVJ1u67qHENBQ5l@venus>
References: <20260714-batt-status-v5-0-9de4aa900b69@google.com>
 <20260714-batt-status-v5-2-9de4aa900b69@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hzx7euwwupsd5hfj"
Content-Disposition: inline
In-Reply-To: <20260714-batt-status-v5-2-9de4aa900b69@google.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/284.966.17
X-ZohoMailClient: External


--hzx7euwwupsd5hfj
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 2/2] usb: typec: tcpm: Add support for Battery Status
 response message
MIME-Version: 1.0

Hi,

On Tue, Jul 14, 2026 at 09:10:53PM +0000, Amit Sunil Dhamne via B4 Relay wr=
ote:
> From: Amit Sunil Dhamne <amitsd@google.com>
>=20
> Add support for responding to a Get_Battery_Status request with a
> Battery_Status message. The port partner shall request the status of a
> port's battery by providing an index in the Get_Battery_Status AMS. In
> case of failure to identify the battery, the port shall reply with an
> appropriate message indicating so.
>=20
> Support for Battery_Status message is required for sinks that contain
> battery as specified in USB PD Rev3.1 v1.8
> ("Applicability of Data Messages" section).
>=20
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>
> Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 138 ++++++++++++++++++++++++++++++++++++=
++++--
>  include/linux/usb/pd.h        |  29 +++++++++
>  2 files changed, 163 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 7ef746a90a17..cd33ee131ebd 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -12,6 +12,7 @@
>  #include <linux/jiffies.h>
>  #include <linux/kernel.h>
>  #include <linux/kthread.h>
> +#include <linux/math64.h>
>  #include <linux/minmax.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> @@ -232,7 +233,8 @@ enum pd_msg_request {
>  	PD_MSG_DATA_SINK_CAP,
>  	PD_MSG_DATA_SOURCE_CAP,
>  	PD_MSG_DATA_REV,
> -	PD_MSG_EXT_SINK_CAP_EXT
> +	PD_MSG_EXT_SINK_CAP_EXT,
> +	PD_MSG_DATA_BATT_STATUS
>  };
> =20
>  enum adev_actions {
> @@ -387,7 +389,15 @@ struct pd_timings {
>  };
> =20
>  /* Convert microwatt to watt */
> -#define UW_TO_W(pow)					((pow) / 1000000)
> +#define UW_TO_W(pow)				(div_u64((pow), 1000000))
> +
> +/*
> + * As per USB PD Spec Rev 3.18 (Sec. 6.5.13.11), the number of fixed bat=
teries
> + * that a port can be queried is restricted to 4.
> + */
> +#define MAX_NUM_FIXED_BATT				4

If I understand the spec correctly, the presence of a fixed battery
should never change for fixed batteries. I guess the rationale is,
that one only has to the battery capabilities once for these kind of
batteries. But for the Linux kernel this concept does not exist and
all batteries are potentialle hot-swappable. For real hardware with
TCPM and hot-swappable battery, this code will now incorrectly
expose them as fixed battery and violate the spec. I think this should
at least be mentioned in the commit message.

> [...]
> +	batt =3D port->fixed_batt[batt_id];
> +	ret =3D power_supply_get_property(batt, POWER_SUPPLY_PROP_PRESENT, &val=
);
> +	if (ret)
> +		tcpm_log(port,
> +			 "Failed to fetch power_supply_prop_present ret %d",
> +			 ret);
> +	else
> +		batt_present =3D val.intval > 0;
> +
> +	ret =3D power_supply_get_property(batt, POWER_SUPPLY_PROP_CHARGE_NOW,
> +					&val);
> +	if (!ret) {
> +		charge_now =3D val.intval;
> +		ret =3D power_supply_get_property(batt,
> +						POWER_SUPPLY_PROP_VOLTAGE_AVG,
> +						&val);
> +		if (!ret) {
> +			energy_now =3D div_u64((u64)charge_now * val.intval,
> +					     1000000);
> +
> +			/*
> +			 * Battery Present Charge is reported in
> +			 * increments of 0.1WH.
> +			 */
> +			present_charge =3D (u16)UW_TO_W(energy_now * 10);
> +		}
> +	}
> [...]

What about fuel gauges, which expose POWER_SUPPLY_PROP_ENERGY_NOW
instead of POWER_SUPPLY_PROP_CHARGE_NOW?

P.S.: Sorry for slow review.

Greetings,

-- Sebastian


--hzx7euwwupsd5hfj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmplTj4ACgkQ2O7X88g7
+prIfRAAh33TdgbuXUdlV4quXvm5E+k3lALrL6M3chuUD6OMu1z+oJmGrbU6dDGe
hDudLtDJ1I6UtkzZgOTKXy/k2BKjfXtQsfPZGYFYTPLGfn9kEr1CSdhFQElPAP3M
U76J0thiaxxp0aEV994oQE+mXortKl+9hTlu9umuXl/56B4FafZ1/AsOsEt5vi23
BFkexzACq5LXaJ7bNGC8ZAho4OC5HbxwpockJ1ap1qb9kvF2azC+TnJfoiY27Ior
MKpKTerpVUhKT1SJyaeqcpX+CCj3SU8WKPYDxcOvlSYUMDYe5UJhHC4Y1ztqEi4S
c4pZYTXpK4QOGZL0bVn8a/UMANWTbfF/m9ffzm5miS8VnfmGNBK5rdNDorGJfdEO
SP8WIc6DVZ7jdJpfrslZdZogwvApGgcNqSkfIzrDK6oIcQrk2EvI2dt4wH4LXRtM
CqgUNZINImA0eCRZyqrJS7nbExtjdWYl3EbgkCXdf8iJ7AGcpvtblfKP3n/QXGAX
Xe3tPN49cZwxHWmx0LS9/7NKVaRP4gUWE6TbwrSVNCO6hcDsxBXB7wZ0LN2Hkoy+
b+x0aVVN39nOUSwIm0Exeq0xo+60WcB3qBO3M/rlEpmp4GgVBSGV/hNXH3W5wwov
tZEAkut8fJE2L6h/VEvD6bfGjM00ldh9Wl/8kvimm+OB22j/omQ=
=JF6I
-----END PGP SIGNATURE-----

--hzx7euwwupsd5hfj--
