From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re:
	suspend2 merge (was: Re: CFS and suspend2: hang in atomic copy))
Date: Fri, 04 May 2007 16:56:17 +0200
Message-ID: <1178290577.7408.21.camel@johannes.berg>
References: <Pine.LNX.4.44L0.0705041040540.3417-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6369229693087451249=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0705041040540.3417-100000@iolanthe.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.linux-foundation.org, Pekka Enberg <penberg@cs.helsinki.fi>, Nigel Cunningham <nigel@nigel.suspend2.net>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org


--===============6369229693087451249==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Kgsur4i4pNLURj8Qas96"


--=-Kgsur4i4pNLURj8Qas96
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-05-04 at 10:51 -0400, Alan Stern wrote:

> Exactly because we are waffling on this issue.  If we settled the matter=20
> once and for all (devices must ALWAYS be reinitialized after the snapshot=
=20
> is restored) then we wouldn't have those problems.  (We might have other=20
> problems though...)

=46rom what I've understood so far, ACPI is very unhappy on some machines
if you go to S5 after hiberation. I still don't understand why, if the
ACPI code would properly re-initialise itself (treat ACPI as a device
and apply your "devices must ALWAYS be reinitialized after the snapshot
is restored") then this shouldn't be possible to happen.

And at that point I agree that the issue becomes completely orthogonal.

(btw, it's always possible right now to go to S5 instead of S4 when
doing hibernation simply by changing /sys/power/disk to "shutdown")

johannes

--=-Kgsur4i4pNLURj8Qas96
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGO0mR/ETPhpq3jKURAhlyAKCk3Q6SOGip+jjvq53jqj/6hA8DPQCeM5wZ
P7ExUQA99RsNWRKqKAR+3BE=
=HgrV
-----END PGP SIGNATURE-----

--=-Kgsur4i4pNLURj8Qas96--


--===============6369229693087451249==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6369229693087451249==--
