Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52023090D7;
	Sat, 25 Jul 2026 02:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784947217; cv=pass; b=EeRMOTZm2/QxCH4/WRyaRAcvq6/Huoqzp4aVbNLHBihuTjZG66BErmMH+Od5W/YhvGHi9s1VGQUf9vIdEqNY0YUkwEOU1z7G1DbwShdnbziFW0XRaPkg2HCQ1r6MU/OK2pGVGtCNiygfO97glp2KoUARVwS74W/U+Oh02aP81Ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784947217; c=relaxed/simple;
	bh=EBuUb00s3/5Qe+t92Dn2L9BPl8kdUBUNL8M+AkHOyW0=;
	h=Date:From:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=se2MBrhkstBYpeV972Q/n3QgeVzEQZjWo5HISjMilipC4xcsR7z7ay794SONSr9vZzdH59mLqtQG7IYm/EIYU5m2CZbTYmSkG0jJFrX10UUmFa7qUG8j7GTxutBuGqnMThXld7VkTDm7Hv6nbQ1ch3CmZ0njv+/7XMPGTkIl3Xk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=fngl8UYm; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="fngl8UYm"
ARC-Seal: i=1; a=rsa-sha256; t=1784947212; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GjbWC07I+o7Aq2ph/nIIFP41KxlDOmIjEFkpDLgGWZSSBbWfp4hQZDS8I2edqNy70AlPtFGn6cJlCHDk3qdXx9E4WE1LEotSYj4G4/b+N3iARAFrEac8C0sczjqcP3V+S4W+NwrALy4/BqqGR1N/RY7ZyUmxeHw8epumdUzF3sA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1784947212; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:Message-Id:Reply-To:To; 
	bh=1E2XTXDpQtjlzW1VOQI0W43iH8CavnEQDTPwlGOvurY=; 
	b=RyNyPHHl3CRCwvKfvLqL+rcXfR8w1iLki4o+gJV650xHcJIKAf5RnShs3hGX2vbgExMXuqcAVNbkUAOMOsRTGpwtb+HLR1/Xs2qlG+gI13zLkkmcZ+8yPKWHOH9eJSLog2GgJgLooYnZIpDMufkcEO/jkzrhoFRvdO471GzPZXs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784947212;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To:To;
	bh=1E2XTXDpQtjlzW1VOQI0W43iH8CavnEQDTPwlGOvurY=;
	b=fngl8UYmoVqHZi75pVkZhk9COM+4wl5nYjVrgDeByoMmoryDsALUrN91LRzCKqvb
	Ev1f+iAMkIpnj2s5gqnmOGtYXdR0/saLOpIqIzSxuxdz99rK7ywMF/vcqK0KfWHHnV0
	XovuYC/pipS+eaM19QJSBxodZgI6ETCDrra72Xj0=
Received: by mx.zohomail.com with SMTPS id 1784947211626271.6279091495768;
	Fri, 24 Jul 2026 19:40:11 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 65984181F16; Sat, 25 Jul 2026 04:40:09 +0200 (CEST)
Date: Sat, 25 Jul 2026 04:40:09 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] power: supply: leds: add a not-charging trigger
Message-ID: <amQWViWt8ovRisp0@venus>
References: <20260625-std-power-supply-triggers-v1-0-d80db570d329@beckhoff.com>
 <20260625-std-power-supply-triggers-v1-2-d80db570d329@beckhoff.com>
 <al6dJek_lLPGARdU@venus>
 <b31e36e3c6b36e1b65880d91b53f6f3f9611a102.camel@dirkwinkel.cc>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hgyayp5vuh366c4u"
Content-Disposition: inline
In-Reply-To: <b31e36e3c6b36e1b65880d91b53f6f3f9611a102.camel@dirkwinkel.cc>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/284.942.77
X-ZohoMailClient: External


--hgyayp5vuh366c4u
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] power: supply: leds: add a not-charging trigger
MIME-Version: 1.0

Hi,

On Tue, Jul 21, 2026 at 08:56:47AM +0200, Steffen Dirkwinkel wrote:
> On Tue, 2026-07-21 at 00:23 +0200, Sebastian Reichel wrote:
> > On Thu, Jun 25, 2026 at 07:07:35PM +0200, Steffen Dirkwinkel wrote:
> > > From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
> > >=20
> > > We intend to use this with a gpio-charger ups device that reports
> > > charging or not-charging based on a gpio to set a "power failure" led.
> > >=20
> > > Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
> > > ---
> > >  drivers/power/supply/power_supply_leds.c | 7 +++++++
> > >  include/linux/power_supply.h             | 1 +
> > >  2 files changed, 8 insertions(+)
> >=20
> > POWER_SUPPLY_STATUS_NOT_CHARGING means, that a battery is neither
> > charged **nor discharged**. I think the NOT_CHARGING status has a
> > bad name, but it's ABI and cannot be changed easily. But I certainly
> > don't want it to spread further. Let's find a better name for this
> > trigger. Maybe idle?
>=20
> Hm, I guess I was also mislead by the name, as it's somewhat correct for =
my
> usecase, our gpio connected ups is indicating "not-charging" via a gpio a=
nd I'm
> using it as a gpio-charger charge-status-gpio.
>=20
> I guess it would be more correct if I could map the gpio-charger charge s=
tatus
> to switch between charging and discharging instead of indicating not-char=
ging.
> If you agree I'd add that as an option via device tree binding there and =
add a
> discharging trigger instead of the not charging one to the led triggers:
>=20
>   charge-status-discharging:
>       type: boolean
>       description:
>         Interpret a deasserted charge-status-gpio as "discharging" instea=
d of
> 	"not charging".

For a normal charger your gpio would be the ONLINE state effectively
(i.e. "gpios" in the binding). For most devices that's basically the
only thing a charger reports.

Looking at UPS support in the mainline kernel, it does not look like
anyone used it so far (not just with gpio-charger; I cannot finy *any*
user for POWER_SUPPLY_TYPE_UPS). I do see some issues with some of
the power-supply framework's properties as a UPS is basically a
combination of a charger and a battery. I wonder if it's better to
simply expose them separately to avoid these problems.

Can you share a bit more details about your platform? Would it be
possible to expose your UPS like this?

ups_charger: charger {
    compatible =3D "gpio-charger";
    charger-type =3D "mains";
    gpios =3D <your_status_gpio>;
};

ups_battery: battery {
    compatible =3D "gpio-battery";
    power-supplies =3D <&ups_charger>;

    /*
     * does not yet exist, any GPIOs are optional. In the simple
     * case it creates a TYPE_BATTERY device, which sets its own
     * status based on the ONLINE state of the charger it is being
     * supplied from. Potentially could have a gpio to notify
     * critical battery status.
     */
};

Greetings,

-- Sebastian

--hgyayp5vuh366c4u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmpkIgEACgkQ2O7X88g7
+po2zw//YJK0dY2pNa4rOGLaZzlc2ovAWnnMzAQ0WOd81vAw4OJvhAW3Vk1K3VAV
kED6MIN0Z3YVLsxMEQh8W5O6rZmmeMtLZkIcpo+RyELfVahqhDQ9kX3drcY2sGvj
UeVAEDqy/P4O8gsZqv+kyAhOS3z9ENX/fN8m2RPOSF2PetjFYudahUO2Qb7Ud1Qa
u3ETUxBXPDUWcACQl8oziVTiS8qQAA3JuC8ptup7+NaI5gGsTnLB4RULm0QpPXEs
opsYugwxMy9+HTV/Z8lD3bq6ZXarmrJ9fhpdfmWPC7tDvuR/3aZTrMHfRllqz5Nu
N3U98flvxplGAoeTNAuLEahgXljRw3ar6nTCO/tUDZ7rcHbYJNORl2Au9TaGxB5N
9WPI1pqy9LD42lZ7XspNgcd1vo7oEowakznGY+yuAK1hGJeF8j6ATa0ZxAadquew
2O+T7c8OVYxinsu5GdlZ1xnmVmRx+nSa3eao0WetG8qx8clOhWyXOwbjn32Lh5vM
O8jEyz84ZJs91ajo00UKpCt07SxYFhV3BEBeFxeouGY8m1om/f1VJ0hcqez1VRuo
CATSaY9XsDl4hjIoQpWqdbHPrLU0X7fq1NuvYtut+QD7CLQ5OmUH2CFc3yg18237
irA6H3cHCLCktj7JcDZ6hHbmLYidZCKYebsK/4hRbBxDkGL26rw=
=L8F/
-----END PGP SIGNATURE-----

--hgyayp5vuh366c4u--
