Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18CE30F531;
	Sat, 25 Jul 2026 01:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784943716; cv=pass; b=le6njyzWbRplIyxN1txZsCIIlmHQb2CZd3sdua3V/4OesVx+kUoeP2fbsevzAFizhGRLHzYK3Nlvo2I7ye9d7bbtaO8RSLGDZLiXYXmNe/aeODxRUPaQyU/RyINn4m6bi3m02KdOW683JLoSwyTEwyVRApeQYFGeR92b0MgoOTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784943716; c=relaxed/simple;
	bh=NZyVFpIRyK2rNwaMXjWMJlx5PJeZGjemTrC+PWB+WmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ebqCrIqESpAtA9iy2HZ0/SLKFxGrDhVGPKyFTwdWLT/QX2xqZBmfHGgqsKSLF5gvFFeeXN3VmaU5LWhLg5TiAUKgbxIkMH40S32fF9XjLdrKl4MwSO6P4UwAeUa4n0HDxETThHpqYGaS3Q3g54uX30med5X3oeIpvpAOyU+BOIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=kDM2xX65; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="kDM2xX65"
ARC-Seal: i=1; a=rsa-sha256; t=1784943702; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lMrrV9vou/udhD54x/d1OJXy38OqQLeUw1vHRFqX4cThDHyh74iHVoUmq334x+yzGnbSZM09NpPBTw8vu2cjZM5n5ErUyzyZcquLu3tXxXOBZGd0Gqy2fD7mznQuXKPKPAYc0KD1dZDlQWKg+qXTkgjDwBOTjHbt8vqcPqDxJ6c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1784943702; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=sH6CqLJTGi8ISCigCTRSI5cDrts97yVGtVPSig9GIGk=; 
	b=RTr4lha7eCMULJZyHNUR1LxWTw3vTGrP9Tq+dPcM3pPnEPvcdklDS2ClvqWxdMkvIoZPYrvthf0nHK0IvzZmRK/goUCh48d1mksled/CCBOpDOF0n62Qb0JLYUdmWvmuq+jPA/CQvCL2DJ9Z7BEr07gylXmk+jTSinPzvIVabHo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784943702;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=sH6CqLJTGi8ISCigCTRSI5cDrts97yVGtVPSig9GIGk=;
	b=kDM2xX65FhVl5v1HHE7bUlOtCmlEFWjYuLu/2bXo+Coekl4Bu/IlPfXXuypWeRUH
	iCvxNU7vfE83f5WNFPe7zEA38ZIVOKZfhUpZiaY3XhczGFt0DW3Uj1DBrcWitzMiX0f
	+N+aYGzfqS4oy0WtbFsLuQi8plWza7pEtJuyhpi0=
Received: by mx.zohomail.com with SMTPS id 1784943699375320.3677950223381;
	Fri, 24 Jul 2026 18:41:39 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 9CED8181F16; Sat, 25 Jul 2026 03:41:35 +0200 (CEST)
Date: Sat, 25 Jul 2026 03:41:35 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Bruce Robertson <brucer42@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Igor Korotin <igor.korotin@linux.dev>, Gary Guo <gary@garyguo.net>, 
	Tamir Duberstein <tamird@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun@kernel.org>
Subject: Re: [RFC PATCH 0/3] rust: power_supply class abstraction and SMB347
 charger driver
Message-ID: <amQPYhBkj9rIdSZ_@venus>
References: <20260708214738.25008-1-brucer42@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t4jkyeocqyd2wit6"
Content-Disposition: inline
In-Reply-To: <20260708214738.25008-1-brucer42@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/284.919.37
X-ZohoMailClient: External


--t4jkyeocqyd2wit6
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 0/3] rust: power_supply class abstraction and SMB347
 charger driver
MIME-Version: 1.0

Hi,

On Wed, Jul 08, 2026 at 09:47:35PM +0000, Bruce Robertson wrote:
> This series adds a Rust abstraction for the power supply class -- which
> does not currently exist in mainline or rust-next -- together with the
> SMBus helpers needed to drive an I2C charger from Rust,

Having Rust bindings for new drivers sounds good to me.

> and a Rust port of the Summit SMB347 battery charger as the first
> consumer.

Any reason for Summit SMB347 specifically? I would prefer not to
have two drivers for the same hardware. Looks like this is used
by just three relatively old devices:

rg -l '"summit,smb347"' arch
arch/arm/boot/dts/ti/omap/omap4-samsung-espresso10.dts
arch/arm/boot/dts/nvidia/tegra30-asus-nexus7-grouper-common.dtsi
arch/arm/boot/dts/samsung/exynos4412-p4note.dtsi

All are ARM32 based, so Rust is at least available by all users.
So I suppose replacing this C driver would be an option, OTOH I
don't want to motivate people to rewrite things either :)

> Motivation
> ----------
> Rust drivers for power supply hardware are currently blocked: there is
> no safe Rust interface to the power supply class, and the I2cClient
> abstraction exposes no register I/O. This series provides a minimal,
> self-contained path from binding an I2C charger to reporting charging
> state through sysfs, entirely in safe Rust, with the unsafe FFI confined
> to the two abstraction layers.
>=20
> The series is structured abstraction-first:
>=20
>   1/3  Safe SMBus read/write/update_bits over i2c::I2cClient.
>   2/3  A power_supply Driver trait, a generic get_property trampoline,
>        and an RAII Registration that owns the descriptor lifetime.
>   3/3  A Rust SMB347 charger driver consuming both: it binds over I2C
>        and reports STATUS, ONLINE and CHARGE_TYPE.

A new driver supporting CHARGE_TYPE should also support
CHARGE_TYPES.

> Testing
> -------
> Built and exercised against an emulated SMB347 using i2c-stub: seeding
> the chip's status registers and reading back the corresponding sysfs
> attributes (status, online, charge_type) confirms the full C->Rust->C
> path. No physical hardware or interrupt path has been tested.

If the idea is to just have a user for the Rust binding and
something to test/play around: Maybe convert test_power instead? It
would also decouple the power-supply Rust bindings from I2C/SMBus.
The disadvantage is, that this driver is a special-case, since it
has no parent device :)

Greetings,

-- Sebastian

> Open questions / known limitations (hence RFC)
> ----------------------------------------------
>   - get_property recovers the driver's private data via the parent
>     device's drvdata. The current code relies on the observed ordering
>     (callbacks only fire after probe() has set drvdata); the contract
>     should be made explicit.
>   - smbus_update_bits() is not atomic against concurrent callers; a lock
>     will be required before a charger IRQ handler is added (not yet
>     implemented).
>   - Only get_property and a handful of properties are wired up;
>     set_property, property_is_writeable and the IRQ-driven
>     power_supply_changed() notification are future work.
>=20
> Feedback on the abstraction's shape -- especially the descriptor
> lifetime and the drvdata recovery -- would be very welcome.
>=20
> checkpatch emits one MAINTAINERS warning on patch 3/3 (new driver file);
> it is a false positive -- the driver is covered by the existing POWER
> SUPPLY CLASS "F: drivers/power/supply/" glob and needs no new entry.
> Patch 2/3 adds the one file outside any existing glob
> (rust/kernel/power_supply.rs) and updates MAINTAINERS accordingly.
>=20
> Based on rust-next (v7.2-rc1).
>=20
> Bruce Robertson (3):
>   rust: i2c: add SMBus byte transfer helpers
>   rust: power_supply: add power supply class abstraction
>   power: supply: add Rust SMB347 charger driver
>=20
>  MAINTAINERS                                 |   1 +
>  drivers/power/supply/Kconfig                |  14 ++
>  drivers/power/supply/Makefile               |   1 +
>  drivers/power/supply/smb347-charger_rust.rs | 180 ++++++++++++++++++++
>  rust/bindings/bindings_helper.h             |   1 +
>  rust/kernel/i2c.rs                          |  42 +++++
>  rust/kernel/lib.rs                          |   1 +
>  rust/kernel/power_supply.rs                 | 133 +++++++++++++++
>  8 files changed, 373 insertions(+)
>  create mode 100644 drivers/power/supply/smb347-charger_rust.rs
>  create mode 100644 rust/kernel/power_supply.rs
>=20
> --=20
> 2.43.0
>=20

--t4jkyeocqyd2wit6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmpkFEsACgkQ2O7X88g7
+pqG5A/+OXDSMBBeBQeHtPnntBd8Wx6nflqqmyNWgjtgNzc1Hmk+yQzj2BFnvkwq
UwzB7KOiUxVJbNzOuV19yRqVeSFmxYHGXEUzNsQNFHBpvSPopOj/IN/sd3uw6eEw
w8a356v9gJdEP/cMd2pKOKQmRzDDDwNbMSOYaAxhMLaBa8kSepf37L2nWx8RnxoK
7Usvij75cQN4RIsGzg5QsjwujoSNuBdk0naHkGUsdVjq0eTPLiYMeIck6nQ69VtU
NUsUy96WDAgiZJU+iir1rh/IVRJQS+nNO/Kd41ANyMhP47e3idOVJ24PJivjFnWw
wq8wKSGxOT9rhkrLDddgJwFKKeZYp5AH2NmvquSCS3xF3k1uSow2uPmBYpP9nx4K
Aay0TjibqIJWt58swQegj2OpogWn72VTs7l3HQUp6ARy06FOv/LXxFMPKWDnH22u
vL4MrUC+Brbt5751q6hOfna9399fv+C8KO6WblFlBXs5hfumLNjbWilNCy/BH+6v
7QOcT1WvOuwbNAsMnECGSsf/Tlv4EVh/6XBYl9eN8PrlIM/r6lnXGVZUgwtwbz0w
3MsLJwdBiqHKPYZsHr1NN5Uy5+GUhkHORT3Rc+3YbxyR0PRrnanu3dTvSY6pHsLQ
mhW9p1sgguehZBDH6411FwsEkO+dMSCV8v1Q0AyPI2Q4RDCnaqQ=
=V0FH
-----END PGP SIGNATURE-----

--t4jkyeocqyd2wit6--
