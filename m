From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: shrinking memory for suspend?
Date: Thu, 03 May 2007 13:33:36 +0200
Message-ID: <1178192016.13233.94.camel@johannes.berg>
References: <1177943076.5102.83.camel@johannes.berg>
	<20070502112929.GD11316@elf.ucw.cz>
	<1178114521.13233.56.camel@johannes.berg>
	<200705031217.30979.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9202799157826909826=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705031217.30979.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org


--===============9202799157826909826==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-JmPsZBYHxtSlpeeIOqlM"


--=-JmPsZBYHxtSlpeeIOqlM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-05-03 at 12:17 +0200, Rafael J. Wysocki wrote:

> I think that on a uniprocessor system it's quite safe, but on SMP it does=
n't
> seem so.  For example, imagine the situation in which one CPU is executin=
g the
> suspend code while another one is running userspace with system calls etc=
.

We can still hot-unplug all the other CPUs though, no?

johannes

--=-JmPsZBYHxtSlpeeIOqlM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGOciQ/ETPhpq3jKURAsRKAJ9qR4K4IqVW/5qjPOi6iWVzQ6Et3gCgj702
8GDlfZcMwhTbDEgIjLtgxqs=
=N+iN
-----END PGP SIGNATURE-----

--=-JmPsZBYHxtSlpeeIOqlM--


--===============9202799157826909826==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9202799157826909826==--
