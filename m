Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1454326E706;
	Tue,  2 Jun 2026 16:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780417053; cv=pass; b=c+xDqOosQtaqr8+NBbrHRMgNCLZ5bAOQd9ScE48cJT0vAklYA0sJvKLQR5kK01Mp6D5Fe8N9HJdMwhmtNwaVpii4oXydlmIqhSKt8ZDo99PaJLkWOo2x3Pk7P2GWzeh8x3mmcb45OW9nTg728R3EhgEdtsOp9pCY2O4u7JFU1I0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780417053; c=relaxed/simple;
	bh=kGL5GoSrxxNYelyQVOL7P+pk8TKiBY5rgX6SEgPGHkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fXL48ysny48aH/3Sou57G1o8e/K1MHqxzHM7P803lHbyK+jlKnOdnZx8ew1+8mdk+yVLBZplPnrmL0RPRTMfhDueI57GN8m4Q5IuDw1zGVfbTuI2sPeNVFjwrgXqVMIbaq5QNjEUyyTfSwWxjdlYE4YUXq2ojbs5Jdf1/s07L5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=Y6Ua1359; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="Y6Ua1359"
ARC-Seal: i=1; a=rsa-sha256; t=1780417045; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KjOZoU/X7ci5/8cLfRMiibLbuZBr5/LdQ2ALqjHaziiLdlnQJu8Y5tNU5XYqpXbFlOyro5kJmSgBChDXIZ+bNpnds8CigMZZf/QtUvTs2aQ/aKIO5hvRhY5Jk/eCCemZeur4ffKZOoOWZUC2ubxbPQmIQUx3esrAg5SQPTuTv+Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1780417045; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=gsqbAdhGzXllXxa+Bt8LLJa7hDfPuUC2XB/tua45DFQ=; 
	b=bQVRTcv5uAxkA3u2s1bSmgnkmX/3/WbjBWYynfO5TtEDBrnQDFgkqfH6li7GrmpU/1YQ+BGlLrco387fSSmVoKeSUozuth8B2tYWU5EBcJ5NJmB1pZo2FrKeqXdKCJFMM/+fvzuy0cnGwUBVXchofSxF5d/wMgOYQo3oJU6rSiY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780417045;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=gsqbAdhGzXllXxa+Bt8LLJa7hDfPuUC2XB/tua45DFQ=;
	b=Y6Ua13596afGMYN5I+lx/ePez3DSLrMN8bXCVmcbcjWC5yyNqlX/A1/eyMjO33+2
	SQwVa5jxVIVBapo+kb6vr73sieR71MvQPO7ioH41P4d9g1HwnWKG/qrES1QEdRT6Fm0
	4Db6BULkql3x+rPPpLD3oZ8l5pavI6LIoSoIR0k4=
Received: by mx.zohomail.com with SMTPS id 1780417043324202.710623861592;
	Tue, 2 Jun 2026 09:17:23 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id D081018094C; Tue, 02 Jun 2026 18:17:16 +0200 (CEST)
Date: Tue, 2 Jun 2026 18:17:16 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Waqar Hameed <waqar.hameed@axis.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, kernel@axis.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] Add driver for TI BQ25630 charger
Message-ID: <ah72aPNg-psfHrHi@venus>
References: <cover.1772201049.git.waqar.hameed@axis.com>
 <pnda4tunkrx.a.out@axis.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oybkq5ntld5gkntk"
Content-Disposition: inline
In-Reply-To: <pnda4tunkrx.a.out@axis.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.1.0.1.4.3/280.384.96
X-ZohoMailClient: External


--oybkq5ntld5gkntk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 0/2] Add driver for TI BQ25630 charger
MIME-Version: 1.0

Hi,

On Wed, May 20, 2026 at 05:49:38PM +0200, Waqar Hameed wrote:
> On Fri, Feb 27, 2026 at 16:35 +0100 Waqar Hameed <waqar.hameed@axis.com> =
wrote:
> > This patch series contains a fully working driver for the basic
> > functionality for the new TI BQ25630 charger (see datasheet [1]).

Driver itself LGTM. I think it would be sensible to merge that while
the extra features are being prepared, but the DT binding must be
fixed first :)

> > However, some functionality has no straightforward implementation. The
> > following features have therefore been left out and hopefully we can
> > have some design discussions to reach a clear resolution for the next
> > patch version (hence the RFC tag):
> >
> >   1. The USB OTG functionality (i.e. power *out* from the device) would
> >      probably need a minor refactorization to use the MFD sub-system to
> >      also register a regulator driver. Looking at the bq257xx driver,
> >      this should be the preferred design?

If the regulator is the only part making this a MFD, just create it
in the charger driver itself. There are a few examples, just grep
for 'struct regulator_ops' in drivers/power/supply.

> >   2. Other drivers add a custom `sysfs` attributes for BATFET control.
> >      See for example rt9471 and bq24190. Is this the preferred approach?
> >      Should we add a new power `sysfs` class ABI for this? (There is a
> >      TODO left in the code for this.)
> >     =20
> >      I reckon it is quite common to have BATFET control for chargers,
> >      i.e. being able to set them in "ship mode", "stand-by mode",
> >      "shutdown mode" or "idle mode" (example values taken from the
> >      `BATFET_CTRL` register field from datasheet [1])?

Yes. I usually ask to use custom properties until there are a few
users to avoid cluttering the general ABI. I think BATFET is a good
candidate. Please add a new property for that one.

> >   3. This device has liquid detection and corrosion mitigation. I
> >      couldn't find any existing device driver with this kind of
> >      functionality. The datasheet [1] even mentions "patent pending",
> >      although it refers to the USB type-C Specification 2.3... :)

This is something I also expect to see in more devices; I know a
couple of Android devices offer this. But indeed nothing has been
submitted so far.

> >      When liquid is detected in the charging port, an interrupt is
> >      fired. Likewise, an interrupt can be fired when the port is dry
> >      enough (according to some configured threshold value). My initial
> >      thought was that maybe we can add "liquid detected" to the `health`
> >      `sysfs` ABI?

Sounds good to me.

> >      However, the question still remains though how one
> >      should enable/disable and set threshold values for this (new power
> >      class `sysfs` ABI or a custom one only for this driver)?
> >
> > [1] https://www.ti.com/lit/gpn/bq25630

I had a quick look at the datasheet. I think a new standard property
would be sensible:

LIQUID_DETECTION_CONTROL with possible values
    off =3D Not liquid detection is being performed
    auto =3D Periodic liquid detection checks are being done
    once =3D Writing this will perform a single check (and return to off)

For the other controls I'm not sure how generalized they are. E.g.
for TLQD and ILQD it offers 4 steps, but not explicit current
(seconds and amps). OTOH for the voltage explicit values are listed.
Maybe just leave them to the default until somebody actually need
this configurable?

> Friendly ping incoming!

Sorry for being slow with reviews, I was quite busy and out of
office in the whole May. I suggest that the 3 things are being
send on top of the updaed base driver :)

Greetings,

-- Sebastian

--oybkq5ntld5gkntk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmofAggACgkQ2O7X88g7
+pqhyg/+NRhgP5w48z5MfRA5UnpQ4swNmWs0oiwK8CiZQkQJ5OZd82pGm/8ICYSo
Qxx/EfNochHhZv+R02xUDvabU7Ua77GXYXAXDsdlGzWjuFxFJmx9VA9gDLmHXl8o
BtiauwMhx4M7s6u1rAgbAJeMAOteUAWcM2HQ/t+Crjst0g7kxPMImuks+LijRQ9e
Q/lInQ8+zMMWK1+OIOuYTJTqTpuXIrBWIVgV0h7TlQXFUh6+fHKox1fRIAHqzOwI
y6mAAREtHi8B/w+kvmub/9KU8xiMTGueLcbLWOztZFCmroVIJFa+OCtgC+iqBxa6
+4avc3TT3HwD6cflMGVUhNDWDRw17yXdPP/pz7A6BYTQdvE0krz7JKtkQ+tuwHFK
LRAaq/nqFJlpIrgfG/7M9jAGMzXTPUZwV3EyktVo8DCOQAzN/+d1guxxgZtrjqqn
ON2WqVgh+XrDmVIpKzmb+Rih1nROIkhka5CZsNdIW4HzDsX6/58q4V/edLKxi49y
mnljdhmmv24/+UEHseNW4uj0NOjOxqD9PJUErJmPrjXW18HcYGKlmZKFD4yQt9Xq
wl1sTv2G5eyT+zY/fDVMqDU3y4XqiBqzzJaYfhSHJlx1EqFghuqcl8ehXiU3oJOm
bC/RMoEXG6mocJSK8iD0n8VFwddPCfEVzELbMvF8dnuTUC/Ffkc=
=ql5j
-----END PGP SIGNATURE-----

--oybkq5ntld5gkntk--
