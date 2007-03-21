From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] introduce /sys/power/disk_powerdown_mode
Date: Wed, 21 Mar 2007 13:25:17 +0100
Message-ID: <1174479917.4230.7.camel@johannes.berg>
References: <1174468981.3769.8.camel@johannes.berg>
	<200703211325.17696.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2066450667=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200703211325.17696.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org


--===============2066450667==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-dnimB/RAyULzDgu02t4f"


--=-dnimB/RAyULzDgu02t4f
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-03-21 at 13:25 +0100, Rafael J. Wysocki wrote:
> On Wednesday, 21 March 2007 10:23, Johannes Berg wrote:
> > This patch introduces /sys/power/disk_powerdown_mode
>=20
> I don't think this name is the right one too, since the platform mode is =
not
> exactly the power down mode (let alone test and testproc).
>=20
> > and deprecates /sys/power/disk. The former has the advantages
> >  * a much more expressive name
>=20
> Well, please choose another name (I'd probably use disk_mode or something
> like that, but 'disk' is well-documented, so why change it?).

I initially just had 'disk_mode' but then I remembered the confusion
about 'firmware' (which I just removed) and changed it. I can change it
again. Another point for changing it from disk was to let both APIs
coexist.

> >  * contains all valid modes as well as the selected one
> >    in a fashion known from the LED subsystem.
>=20
> Pleases review the documentation under Documentation/power and
> Documentation/ABI and update it in accordance with the changes you're mak=
ing.

Good point.

johannes

--=-dnimB/RAyULzDgu02t4f
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGASQt/ETPhpq3jKURAtZlAJ9Ri0gR1EpEpbR8K40+EnxiQN/3CgCgjMu+
6KJ3oWhUTxn+oUacp5sL/b0=
=4baP
-----END PGP SIGNATURE-----

--=-dnimB/RAyULzDgu02t4f--


--===============2066450667==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============2066450667==--
