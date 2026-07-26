Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34C013FEE;
	Sun, 26 Jul 2026 00:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785024303; cv=pass; b=cBke5bAHJ9HZNzVNO2EOEv4s24L+yQxaHed0sb87UkmUuIYaTur98mGSCuBB52+mzOMoWI8Skvj/EQmHW5Ee6Bw4kk43WFI9K4kA46ZZd79bwwfBMZox9QX9zDYuAdPM9DoVISOGInp6XN7xzBI201FnOfn2hYcvbXVEpPVFPRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785024303; c=relaxed/simple;
	bh=zdwmwSjlv5HSJMCjXoAa8XOTBONbWO6Dxow9THKZBYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kmbd9r9wpHFEbe3qxCfnbYBdP4l5FhsTUlkQ23u+n188+89tXv0Dgw/aTW8NqxgqAsXN7RnU1EmDYAes2Cw3FrjbdJ2Pya4WjbhCV3jelA7NviGKjvoxaInoNyEPMfR3TV53nwDqY9TWd0M0YDZj8K1jvDhJwNIgfY5EJ7exonc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=Jkj0JhS1; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="Jkj0JhS1"
ARC-Seal: i=1; a=rsa-sha256; t=1785024283; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=O4C27WDzyRE6JF3uSatgl1SCTUoywkMJLxKBRFkf3aUb1IdNkWHxbFexsHqhj/iTUnrqA+O6clRt8CJYGEpWZx5ZKUTtd/Ea6IMOCBJACkeP1wyvr/6E8Ia465LTKMGJObhv6X9FScXUIjsOi9qLP70bAQ8Dr91EOKf1tqFDFvw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1785024283; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=GXBUHeWmx05A7NG2QHLd/WXxw6+eRlY+JwG0eU+0yMA=; 
	b=OdnOWQF1Cxx4uSOEdAhcadVmsQEZGpJBBzgl0d8Y2iu3JJyunFPQMx0XwKhfqXOhLct1aoMDyqxjfZ9OgeSlB4ganwNsKVbsE3/61lSvv5nUMs/qZn2B9HPEqZQE3g5c1gGhT1AOoyOiyLcXV3J0iPcm8xk7GJH2M5ykGAOAask=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785024283;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=GXBUHeWmx05A7NG2QHLd/WXxw6+eRlY+JwG0eU+0yMA=;
	b=Jkj0JhS1RdaUdEuKsuubBQ4AaN+7UMfMZJzkgk5LHagcV41+QHcsp0P99nGuODaI
	6yykw/Kmxr8oAYkqd88sgzgth70vim0rrJx9VscXDcrbsRCR7NU61Qmy9TkhyZM/0P7
	i7pd9DF8NeT8YiA+kLbGaQ1mMdBbsC9gh3570zY4=
Received: by mx.zohomail.com with SMTPS id 1785024280358794.0851362361248;
	Sat, 25 Jul 2026 17:04:40 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 0D0361802A1; Sun, 26 Jul 2026 02:04:36 +0200 (CEST)
Date: Sun, 26 Jul 2026 02:04:35 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Badhri Jagan Sridharan <badhri@google.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Hans de Goede <hansg@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
	Purism Kernel Team <kernel@puri.sm>, Amit Sunil Dhamne <amitsd@google.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, =?utf-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Peter Griffin <peter.griffin@linaro.org>, 
	RD Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>, 
	Hans de Goede <johannes.goede@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v5 0/2] Add support for Battery Status AMS
Message-ID: <amVOuVIW7WFCckfN@venus>
References: <20260714-batt-status-v5-0-9de4aa900b69@google.com>
 <178502408322.829727.13725435987030791049.b4-ty@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bk3fbf2cmj33nl56"
Content-Disposition: inline
In-Reply-To: <178502408322.829727.13725435987030791049.b4-ty@collabora.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/284.966.17
X-ZohoMailClient: External


--bk3fbf2cmj33nl56
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: (subset) [PATCH v5 0/2] Add support for Battery Status AMS
MIME-Version: 1.0

Hi,

On Sun, Jul 26, 2026 at 02:01:23AM +0200, Sebastian Reichel wrote:
>=20
> On Tue, 14 Jul 2026 21:10:51 +0000, Amit Sunil Dhamne wrote:
> > PD 3.1 v1.8 Spec necessitates a response to Get_Battery_Status request
> > from the port partner (see "6.13.2 Applicability of Data Message").
> > This patchset adds support to get all the battery type power supplies
> > and query them to report the telemetry required to build a Battery
> > Status Message. Right now, this submission assumes all the battery type
> > power supplies that exist in the system are fixed (meaning cannot be hot
> > swapped).
> >=20
> > [...]
>=20
> Applied, thanks!
>=20
> [1/2] power: supply: Add helpers to get and put arrays of power supply ha=
ndles
>       commit: 0962125d9001077e91bc90656245f009e3c6c129

Here is a signed immutable branch/tag for the USB subsystem to
handle patch 2 (I also left some review feedback for that one):

The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:

  Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.gi=
t tags/ib-psy-array-helpers-for-v7.3-signed

for you to fetch changes up to 0962125d9001077e91bc90656245f009e3c6c129:

  power: supply: Add helpers to get and put arrays of power supply handles =
(2026-07-26 01:31:43 +0200)

----------------------------------------------------------------
Immutable branch for battery array helpers for power-supply and USB

----------------------------------------------------------------
Amit Sunil Dhamne (1):
      power: supply: Add helpers to get and put arrays of power supply hand=
les

 drivers/power/supply/power_supply_core.c | 153 +++++++++++++++++++++++++++=
++++
 include/linux/power_supply.h             |  15 +++
 2 files changed, 168 insertions(+)

-- Sebastian

--bk3fbf2cmj33nl56
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmplTxMACgkQ2O7X88g7
+pp4jA//eH9yHH+lFgxlN69qbhh8SunlrsCUxR0Z2Eob4EDAye2KknJhJHpW2O7c
ZVEeiaesxJoztTl2hGztveEu0eFyIpF5oIlX270I77R11RBBG0BGa9kXXpgD0npU
peTSHjSJ0GUGFdlOMbMVNy/wMwI/4shjEcydKq0RPVyDJ4WeM8rrB0Pj+VCfX3iX
egCn9R9XuFMUxCjR5yFrRJ0gCnO0IujglIonjng4S8oPR0l2HNC3cssMlvdiHM2p
NwPQNweTZeOU4nGlEjO28iSVIRZRvjC77LDaHCIR8WDLn9+WyuBYj+khugZvbaFp
vh5Mce86LwdVcUl5wLqewlrAKGXHiZBRcxyQGiGnGvpHDIGHyMwv8c6DGFR70fI9
58ljpXMpw3Mk6adkUeub21poDxu+nCYMeaooXQH8GCOrZubQsVPSJV8YE+VHxaJg
kwxBJm4JE08ahqRn98WguzFAycIFCX154zYJ2l08jEzIjCAIXhacGwxAFMtQJxqL
tBuNBQskpepUmfGsPcA4Uv+6mxDySmgjPkTpB27MHYLv1gW07ycpGpL6gHzhaJc8
f6fWsQO0e2xRx3c+yp7qqXAbP+kq75TA+Sh18MyIQB+bISIaf5rQd7WY7taWjswT
xdiMpohL6nTULhaqzdw1FHVYQK0d8BAckzfxBSpiZIICIHP3/K0=
=3P8d
-----END PGP SIGNATURE-----

--bk3fbf2cmj33nl56--
