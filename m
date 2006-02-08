From: Nigel Cunningham <ncunningham@cyclades.com>
Subject: Re: [PATCH] Complain if driver reenables interrupts during drivers_[suspend|resume] & re-disable
Date: Thu, 9 Feb 2006 09:58:57 +1000
Message-ID: <200602090959.02015.ncunningham@cyclades.com>
References: <200602071906.55281.ncunningham@cyclades.com> <200602080040.41495.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2320783.6PeMDbYEdH";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1422676AbWBIACR@vger.kernel.org>
In-Reply-To: <200602080040.41495.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Linux PM <linux-pm@osdl.org>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
List-Id: linux-pm@vger.kernel.org

--nextPart2320783.6PeMDbYEdH
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Dmitry et al.

On Wednesday 08 February 2006 15:40, Dmitry Torokhov wrote:
> On Tuesday 07 February 2006 04:06, Nigel Cunningham wrote:
> > Hi all.
> >=20
> > This patch is designed to help with diagnosing and fixing the cause of
> > problems in suspending/resuming, due to drivers wrongly re-enabling
> > interrupts in their .suspend or .resume methods.=20
> >=20
> > I nearly forgot about it in sending patches in suspend2 that might help
> > where swsusp fails.
> >=20
>=20
> Only sysdevs are guaranteed to be suspebded/resumed with interrupts off,
> other devices are suspended with interrupts on (at least on first pass
> over device list).

Ok. I guess I missed that outcome of that discussion. Sorry for the=20
bogusness :(. Is the sysdev bit useful at all?

Regards,

Nigel

--nextPart2320783.6PeMDbYEdH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD6oXFN0y+n1M3mo0RAuoFAJ94/oBsts/BU8fGeNtMTRJdhBERkwCePsdh
Vw7rlAXmMISOhLQBmn6k/Ck=
=WJdf
-----END PGP SIGNATURE-----

--nextPart2320783.6PeMDbYEdH--
