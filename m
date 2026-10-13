Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4344E73AE;
	Tue, 13 Oct 2026 23:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791934839; cv=none; b=ovYVtd5A7+XWqViqr6I1Hk/SLN6jtTxkf1YzR4qkQlu19RXHup/IRdNask1NbOecMt2BCnvQV9SfPma4facrkXdGXfOLX7X43MAPdLv/+U5OoHsiZpMstkIQw5INJ2GXkAWRZ4sNIhKtOuAxJ6ZmM70/YwC/m6cuEGbLvNU5hm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791934839; c=relaxed/simple;
	bh=9yZ1adNk99ubTSg6ZaGlhNogGt7S1nWzDZrrtvfWTlM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=doSKMuCFKnJcfREpv5SK8aia1urYadINjkuU3387qCYxyaQhMbiftrOIHQwoqb22mqUpisQv/MsyCeE6jz7ugRn8JzH1UVblrGrHFNoEo1GG6xL78lxmme+VfmdcX4X2Z9UV/Tz3UFXHoR7v8iAL1z3mr5UNauS5Ri1pVcr/pF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=It1v0KwG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="It1v0KwG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 400701F000FF;
	Tue, 13 Oct 2026 23:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791934836;
	bh=ZR0K/zBXcFgt220pxwCaLeRkxeEkOllzFCwAM4z537Q=;
	h=Date:From:To:Cc:Subject;
	b=It1v0KwGQvLxNeoU194gizmXxBkJpK/BJi7dPkIvdWIw6x3cRrbw6eweknZ91AYPY
	 I+PtPj8WFCxZj9MSmHRTRQTKov/g07byEQ0EWw32GHjg2cd7yEHZ7wQFKKvufRxTj4
	 rqnwEc+ro4ZbbCThxm10z3iyNqUzSORvz8ExhLH8+8AswNs/k+YeylkL4BqaaaBc5A
	 4LEn0VEAEqPKpcUhFxh2Ef8iJ3gxY2xiSilcWMqAySPqsVtHouKwogp5LpchG3kvvf
	 lSpVCIxjDWyW+IbSvPkVBGCOwV2Gd2ssjdcGw8P3hWK8UVYveUfijjaxmbZ9vTLs5x
	 1/bVu3t7zSuxw==
Received: by venus (Postfix, from userid 1000)
	id B2F25180F5B; Wed, 14 Oct 2026 01:40:34 +0200 (CEST)
Date: Wed, 14 Oct 2026 01:40:34 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 7.3-rc
Message-ID: <as7BWpR9ytU4Ihdd@venus>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ax27xi7dz555qubz"
Content-Disposition: inline


--ax27xi7dz555qubz
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: [GIT PULL] power-supply changes for 7.3-rc
MIME-Version: 1.0

Hi Linus,

The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v7.3-rc

for you to fetch changes up to 5b4bd13e0552926648a46c2c9a12a24dfaee3715:

  power: supply: core: prevent unregistering a power supply while a callback runs (2026-10-04 18:49:02 +0200)

----------------------------------------------------------------
Power Supply Fixes for 7.3 cycle

 * power-supply core
  - prevent unregistering a power supply while a callback runs
 * power-supply drivers
  - generic-adc-battery: Fix temperature IIO channel conversion
  - ds2780: Fix ds2780_get_capacity() returning raw value
  - max17042_battery: Fix vmin assigned instead of vmax in DT parsing
  - Fix maintenance charge table kernel-doc

----------------------------------------------------------------
Alexey Charkov (1):
      power: supply: core: prevent unregistering a power supply while a callback runs

Karl Mehltretter (1):
      power: supply: Fix maintenance charge table kernel-doc

Svyatoslav Ryhel (1):
      power: supply: generic-adc-battery: Fix temperature IIO channel conversion

Xueqin Luo (2):
      power: supply: max17042_battery: Fix vmin assigned instead of vmax in DT parsing
      power: supply: ds2780: Fix ds2780_get_capacity() returning raw value

 drivers/power/supply/ds2780_battery.c      |  2 +-
 drivers/power/supply/generic-adc-battery.c |  9 +++++++--
 drivers/power/supply/max17042_battery.c    |  2 +-
 drivers/power/supply/power_supply_core.c   | 26 +++++++++++++++++++++++++-
 include/linux/power_supply.h               | 16 +++++++++++++---
 5 files changed, 47 insertions(+), 8 deletions(-)

--ax27xi7dz555qubz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmrOwXIACgkQ2O7X88g7
+pqxNg/7BAZNGBmlx5GgQRyIbzTHJDHYsirXPpANRexVlQTFlZpLlI2lgRALuUyM
jWqmYMeK6klQBB7+eipVMeIP9gWgjUpR+Ys2v9nzZNslrx0izm1ofAV8FUfRDj/+
7pOovr0OAoMNcqUk0V28nBAQ+tUX1Pgh280BdscKR3hW+DwFbHgOF+nQXjI/KL2D
JQWik6zEm+zXRk9LvCLeQPhfsyEvYGpTTEVArEGXe7ftxCmKh8sbVsqG4+SinoFm
ep96TdeZxhYSCibgUGSiVld7UjUhk1wWLpOwsGGVt3PwqJE323N5BrBIakuC4Aeb
jI/MhI+jSOFFcGpEwRTTmHWyPA0RFRDiwasUvxcAYtTMsdcci4VEA7JkpSNS9KM8
a9VAGWaPpg/MvvioNgp+jFCMSiXSIHGgZiGaNJ/H/JC3XtClTHig/SP3E/DI76c3
8/tgLOk/gcUR8g+6g/ano9iWuPyj1CRcBdwKoqfPBzmYkUIZaDCBtk/SYdI6RC5q
k5wPDi99Rk+z48+h+8z1+klJCodH1vOI+0PlZET4qMS4hnD/G3VKjek+rMltaFTN
D9/KtiMsE0nXPbpCz6h+CM3NmYyW2e8lKTcrVK8KhmebFycVGZwTaN35j/r5PqDg
9vGXQNGZOR879l9Tg+XDDqW7qib2k8potfXU3cBrU4/EdbDMEsM=
=/r0+
-----END PGP SIGNATURE-----

--ax27xi7dz555qubz--
