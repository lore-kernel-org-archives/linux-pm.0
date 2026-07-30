Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B2B3D8901;
	Thu, 30 Jul 2026 22:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785450286; cv=pass; b=KKkTC9uVbYVOm+eVkcTzGIq1J3LzienLt8I6qhbqI1+HIApWaaJ7Z6QZG9gdoat6wt7a4vPlVfJ3QpFq2nKk7gyxFsTMngQv0NfJaExXpZm3v07s62VMX5LF9i8j03+me5eWAWY8Kz2dHrSjhdEQA7LCOCDKaPoyu6cxnjjyzHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785450286; c=relaxed/simple;
	bh=d0i9HDqmQaVirMU39SBAIJQgl7eqNcVittnSMCAH1Yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMm2qk0Wfi8FkfVq0bF0aIdtEq9z5+H3A/Grll+YUfDhp8i9ubQP5w81vK7IPR6yDtgWndwjcF4JiScA+8ewpZohG6kCnazpqUUQwgas9lEkTviJl590PLSFTxGcYhJ7tMjx0qTLa8GHTAxFeif9liAag6KqAwXX3J/cB6GW3SQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=SgQIyVwH; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="SgQIyVwH"
ARC-Seal: i=1; a=rsa-sha256; t=1785450265; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nCwqrpQA/5KRd/aoEYqtyv5P//KsZyi0QfDgUIPirBnE7rULFe4p/z8fCtwSYYnfNl882nAeMXuGn81z7443i2YARqAtVj3+p/iwagNPmpFfCgnjb7plT5FVxsgHKq4nWGIQw1RqBvOsH6jJtG3mopOst6vi6ylsgEyyfawrRYw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1785450265; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=P2EOieav7Aqn1vOjTwTK3mtj6IAIOaeNk67juagebGM=; 
	b=X9TWJRYqgxEp6be8H9utRmMrJmeiXvpy29IBI8NjPmRRgjUSQpw92+hhPLnzvrC1rx3MvEVDLH3TJNZS35LGfTqK1DckXm9OBoISuht6/jlj8NGomQprOX9gM8JzbstYV107nVrChBkebal+jbJTt2Y3/T7TSN1W/HpXwlJooIw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785450265;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=P2EOieav7Aqn1vOjTwTK3mtj6IAIOaeNk67juagebGM=;
	b=SgQIyVwHk3tFpQsCoVUtW27U7gYycBjqS9l7usPChy5SqAp42CYB1L+TPYStT7FJ
	+Vjkf9vLdUb2p0ZeHKrPGO0b7YvdfLCrbPQzV+Jw075kR9I5km41D5vne7w5FHG2Kcg
	EoMlLQJqv6+9zp+x0/PvRnaqV70wLxzPMzxeRJao=
Received: by mx.zohomail.com with SMTPS id 178545026283429.3908393134966;
	Thu, 30 Jul 2026 15:24:22 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 2B80118029A; Fri, 31 Jul 2026 00:24:18 +0200 (CEST)
Date: Fri, 31 Jul 2026 00:24:18 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Amit Sunil Dhamne <amitsd@google.com>
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
Message-ID: <amvLtvDbJ8g-1rJ3@venus>
References: <20260714-batt-status-v5-0-9de4aa900b69@google.com>
 <20260714-batt-status-v5-2-9de4aa900b69@google.com>
 <amVJ1u67qHENBQ5l@venus>
 <5cdf0238-24f8-402f-a72a-d490f8d9c99a@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qyehq7adb53xg3ab"
Content-Disposition: inline
In-Reply-To: <5cdf0238-24f8-402f-a72a-d490f8d9c99a@google.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/285.439.57
X-ZohoMailClient: External


--qyehq7adb53xg3ab
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 2/2] usb: typec: tcpm: Add support for Battery Status
 response message
MIME-Version: 1.0

Hi,

On Wed, Jul 29, 2026 at 05:56:29PM -0700, Amit Sunil Dhamne wrote:
> [...]
>
> > > +/*
> > > + * As per USB PD Spec Rev 3.18 (Sec. 6.5.13.11), the number of fixed=
 batteries
> > > + * that a port can be queried is restricted to 4.
> > > + */
> > > +#define MAX_NUM_FIXED_BATT				4
> >=20
> > If I understand the spec correctly, the presence of a fixed battery
> > should never change for fixed batteries. I guess the rationale is,
> > that one only has to the battery capabilities once for these kind of
> > batteries. But for the Linux kernel this concept does not exist and
> > all batteries are potentialle hot-swappable. For real hardware with
> > TCPM and hot-swappable battery, this code will now incorrectly
> > expose them as fixed battery and violate the spec. I think this should
> > at least be mentioned in the commit message.
> >=20
>=20
> You are completely right. I was approaching this primarily from the
> smartphone side (Pixel 6), where batteries are effectively fixed and
> inaccessible to the user. Because I don't have a setup with TCPM +
> hot-swappable (in the context of the spec) batteries to test with, I only
> implemented the fixed case.
>
> I mentioned this constraint in the cover letter, but I agree it could
> have been in the commit message as well. Since Greg has already picked
> this series up into his tree, I can't amend the commit message now.
> However, if you think it's necessary, I can send a small incremental
> patch to add a comment in the code clarifying this assumption.
> Otherwise, we can leave it as-is until someone has the hardware to
> properly implement and test the hot-swappable support. Let me know what
> you prefer.

You tested only the fixed variant, but your implementation is in the
generic TCPM and does not check if it runs on a Pixel 6. If you
touch generic code you need to think generic :)

Generally I would expect it is "safer" to expose batteries as
hot-swappable when they are fixed than the other way around.
FWIW the kernel's power-supply framework has no concept of fixed
batteries.

> > > [...]
> > > +	batt =3D port->fixed_batt[batt_id];
> > > +	ret =3D power_supply_get_property(batt, POWER_SUPPLY_PROP_PRESENT, =
&val);
> > > +	if (ret)
> > > +		tcpm_log(port,
> > > +			 "Failed to fetch power_supply_prop_present ret %d",
> > > +			 ret);
> > > +	else
> > > +		batt_present =3D val.intval > 0;
> > > +
> > > +	ret =3D power_supply_get_property(batt, POWER_SUPPLY_PROP_CHARGE_NO=
W,
> > > +					&val);
> > > +	if (!ret) {
> > > +		charge_now =3D val.intval;
> > > +		ret =3D power_supply_get_property(batt,
> > > +						POWER_SUPPLY_PROP_VOLTAGE_AVG,
> > > +						&val);
> > > +		if (!ret) {
> > > +			energy_now =3D div_u64((u64)charge_now * val.intval,
> > > +					     1000000);
> > > +
> > > +			/*
> > > +			 * Battery Present Charge is reported in
> > > +			 * increments of 0.1WH.
> > > +			 */
> > > +			present_charge =3D (u16)UW_TO_W(energy_now * 10);
> > > +		}
> > > +	}
> > > [...]
> >=20
> > What about fuel gauges, which expose POWER_SUPPLY_PROP_ENERGY_NOW
> > instead of POWER_SUPPLY_PROP_CHARGE_NOW?
>=20
> Good point. Our fuel gauge uses charge_* properties, so charge_now was
> sufficient for our immediate use case, but it makes sense to support
> energy_now natively for other users.
>=20
> Since the original patch is already merged, I could write an incremental
> follow-up patch that checks POWER_SUPPLY_PROP_ENERGY_NOW first, and if
> it's not supported, falls back to calculating it via CHARGE_NOW *
> VOLTAGE_AVG. Please let me know if this works?

That sounds sensible to me.

Greetings,

-- Sebastian

--qyehq7adb53xg3ab
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmprzw4ACgkQ2O7X88g7
+poz0A/+Oyytl2CQTkU1NiGQryK8B3TvHsp7xGl/6ytERDUEqsth+Bak3dA/qO0t
sHahi8j5TAfnysANfqtMAy3QPNPyYdQTzt3qaUr1LGIZjkQU2Jwc66Fj0VjGJxh3
QGQejTigD2dBJzYvQp4ifvGYXuTba+KhaIyXCdjpzNYQ3K9MRb75e3+cRTElMdsC
YH066o2Dwdm7cDprzm5QKN6Pnv1tORLUenT8x7L67ZrHxQELcZJj/b3b5YbK/bIX
0Fns9AplRLL5Y2s85tl98LhAYSWGrNO8OCr+bY7EAWVzAG2XcOdAg/nADza8ks9E
9qwONB4+b8xDxrRcywhm/Y218NW3jkzv6A3H4tqgsIHA+dTMdD4APuxoro/yhIea
SdxzJsSoGpncgq4vuNubrTFAegMafwWx1ecwIDKAcFmw3TfsukQPPCZot/hQ/rjL
fT3NaVysteP8uqLVTaKXZWTSs58d+GVsPoti3Siiy1wB3l+vtKKsZ/NYlIk6++rU
Zxj/WhTWTmn12XPTiop6M+umqTuBx/6Jhd+MSE7p4AnkCoBiBmMMUDH99WLP5fjV
KlVoxjW38mOnsoAHGKWLNUHWEkuZV+L4bgyJZC5z7nJ9ItUDuE4T2lYlgGkFt8gz
YA8Z/EVmOECCn+fdijlqdua4yjRLTAvdRBFTC5QDzA1iOQPlZwA=
=d4NC
-----END PGP SIGNATURE-----

--qyehq7adb53xg3ab--
