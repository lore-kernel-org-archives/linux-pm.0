From: Pavel Machek <pavel@ucw.cz>
Subject: Re: PM / Suspend: Print wall time at suspend entry and exit
Date: Mon, 5 Jun 2017 23:18:35 +0200
Message-ID: <20170605211835.GB9035@amd>
References: <20170605193157.59875-1-salyzyn@android.com>
 <CAJZ5v0iLFw68RxzkgyFF_WhxO-nzr0nWoZjq-uEEU6+UzMB7cQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:36463 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751153AbdFEVSh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Jun 2017 17:18:37 -0400
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iLFw68RxzkgyFF_WhxO-nzr0nWoZjq-uEEU6+UzMB7cQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mark Salyzyn <salyzyn@android.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Todd Poynor <toddpoynor@google.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> On Mon, Jun 5, 2017 at 9:31 PM, Mark Salyzyn <salyzyn@android.com> wrote:
> > Permits power state and battery life diagnosis.
>=20
> Which is possible even without this patch and we have tools for that
> (analyze_suspend.py, anyone?).
>=20
> Honestly, I don't see why this change is necessary or even useful.

I ran dmesg after resume and now I...

[1019729.486249] ACPI : EC: EC stopped
[1019729.486255] PM: Saving platform NVS memory
[1019729.486276] Disabling non-boot CPUs ...
[1019729.490423] smpboot: CPU 1 is now offline
[1019729.531015] smpboot: CPU 2 is now offline
[1019729.577742] Broke affinity for irq 16
[1019729.577747] Broke affinity for irq 17
[1019729.577751] Broke affinity for irq 19
[1019729.577756] Broke affinity for irq 23
[1019729.578771] smpboot: CPU 3 is now offline
[1019729.604987] ACPI: Low-level resume complete
[1019729.605052] ACPI : EC: EC started
[1019729.605054] PM: Restoring platform NVS memory
[1019729.605352] Suspended for 3196.166 seconds
[1019729.605376] Enabling non-boot CPUs ...
[1019729.631246] x86: Booting SMP configuration:
[1019729.631249] smpboot: Booting Node 0 Processor 1 APIC 0x1
[1019729.631496] Initializing CPU#1
[1019729.631514] Disabled fast string operations
[1019729.636643]  cache: parent cpu1 should not be sleeping
[1019729.637286] CPU1 is up

Aha. I missed the "suspended for 3196" message before. So I believe
you are right; there's already enough information in the kernel logs.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlk1yqsACgkQMOfwapXb+vI2TACfYz9Jbmtg9JV0t0qQtaNVoMwt
g8gAnREfJUydi1+OG/RIQG4H8GuGM8Vh
=Twb8
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--
