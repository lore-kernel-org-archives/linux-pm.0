From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: + rework-pm_ops-pm_disk_mode-kill-misuse.patch	added
	to -mm tree
Date: Thu, 22 Mar 2007 16:23:54 +0100
Message-ID: <1174577034.3588.14.camel@johannes.berg>
References: <200703212334.l2LNYDjj007030@shell0.pdx.osdl.net>
	<20070322094825.GA29627@flint.arm.linux.org.uk>
	<20070322015614.dafa1ed7.akpm@linux-foundation.org>
	<20070322100355.GA6834@elf.ucw.cz>
	<1174558128.3944.78.camel@johannes.berg>
	<20070322132622.GD29627@flint.arm.linux.org.uk>
	<20070322133117.GC6050@elf.ucw.cz>
	<acd2a5930703220641p6bd02f5dk433232093a331772@mail.gmail.com>
	<20070322140305.GC7693@elf.ucw.cz>
	<acd2a5930703220727u631236c2vbd755ce67968b39c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0315481506=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <acd2a5930703220727u631236c2vbd755ce67968b39c@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Vitaly Wool <vitalywool@gmail.com>
Cc: Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org


--===============0315481506==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-jEc4Stxj9+2kijMaV3WE"


--=-jEc4Stxj9+2kijMaV3WE
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-03-22 at 17:27 +0300, Vitaly Wool wrote:

> > Then why did you ask it to suspend, and why did its manufacturer
> > enable SOFTWARE_SUSPEND?
>=20
> Well, the suspend for instance might mean suspend to SRAM, turn clocks
> off, put RAM into self-refresh and so on... Sounds familiar?

Reread the help text for config SOFTWARE_SUSPEND?

johannes

--=-jEc4Stxj9+2kijMaV3WE
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGAp+K/ETPhpq3jKURAuQSAJ9wZ0lWYafvccrJbXTq0u3WgyntzwCZAW9c
1E21zt2S+/Re0Pl3qSSduog=
=Ku80
-----END PGP SIGNATURE-----

--=-jEc4Stxj9+2kijMaV3WE--


--===============0315481506==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0315481506==--
