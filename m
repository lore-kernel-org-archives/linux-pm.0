From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] pm_ops: add irq enable/disable hooks
Date: Fri, 06 Apr 2007 23:59:27 +0200
Message-ID: <1175896767.8459.6.camel@johannes.berg>
References: <1175810054.3489.34.camel@johannes.berg>
	<200704060217.50560.rjw@sisk.pl>
	<1175849322.3489.64.camel@johannes.berg>
	<200704061141.31677.rjw@sisk.pl>
	<1175852652.3489.67.camel@johannes.berg>
	<20070406191903.GD2583@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1017407030=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070406191903.GD2583@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org


--===============1017407030==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-4jg4AmeOPVs1iIz94Abz"


--=-4jg4AmeOPVs1iIz94Abz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-04-06 at 21:19 +0200, Pavel Machek wrote:

> And why do _you_ need it? Unfortunately I do not know what the
> decrementer is...?

The decrementer is a sort of timer that counts down and once it
overflows raises an exception in the CPU. Like a timer interrupt, but
not coming from anything external. We need to be able to make sure we
don't get a decrementer exception at some spots.

Also, we need to call some platform function things at that point to
prepare the system for suspend, and it needs to be done with interrupts
enabled but after all devices are suspended.

johannes

--=-4jg4AmeOPVs1iIz94Abz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGFsK//ETPhpq3jKURAmQRAKCQfIp1B5oIUA49yyuphSmccp4y6gCfeCOV
f3hjkQzQykecNGxem+sExA0=
=Qbfl
-----END PGP SIGNATURE-----

--=-4jg4AmeOPVs1iIz94Abz--


--===============1017407030==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1017407030==--
