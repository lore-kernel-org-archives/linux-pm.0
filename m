From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: Re: Hibernation considerations
Date: Sat, 21 Jul 2007 22:43:33 +1000
Message-ID: <200707212243.35602.nigel__34492.8061975681$1185021862$gmane$org@nigel.suspend2.net>
References: <Pine.LNX.4.64.0707171319140.2467@asgard.lang.hm>
	<200707202302.07116.rjw@sisk.pl>
	<E1ICDNw-0008HC-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8277683733832928989=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <E1ICDNw-0008HC-00@dorka.pomaz.szeredi.hu>
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
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: david@lang.hm, linux-kernel@vger.kernel.org, miltonm@bga.com, ying.huang@intel.com, linux-pm@lists.linux-foundation.org, jbms@cmu.edu
List-Id: linux-pm@vger.kernel.org

--===============8277683733832928989==
Content-Type: multipart/signed; boundary="nextPart15622834.9J3sI0TMqq";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart15622834.9J3sI0TMqq
Content-Type: text/plain;
  charset="cp 850"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Saturday 21 July 2007 21:44:32 Miklos Szeredi wrote:
> > The problem with FUSE is related to the fact that the freezer can't
> > freeze uninterruptible tasks and we said that perhaps we might avoid
> > it if FUSE was made freezing-aware.  Still, no one has gone in this
> > direction and I don't know of any plans to do that.
>=20
> I thought we have fully explored this direction.  Lots of emails, and
> an IRC session with Pavel.  Conclusion:

What am I missing in the following suggested solution?

1) In the freezer code, we implement a new TIF_LATEFREEZE process flag, whi=
ch,=20
when set, causes a  userspace process to be frozen with kernel threads=20
instead of with userspace ones. When freezing, we freezing !TIF_LATEFREEZE,=
=20
sync and then freeze TIF_LATEFREEZE and freezable kernel threads.

2) In the fuse code, the PID of the process that will do the work gets pass=
ed=20
to the fuse kernel code when the mount is done. The kernel code sets the=20
TIF_LATEFREEZE flag, and resets it on umount.

Sorry, but this is a hit-and-run email - I'm off to bed now.

Regards,

Nigel

--nextPart15622834.9J3sI0TMqq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGof93N0y+n1M3mo0RAtjIAKC72IcfI+29n7sCdQKpsiXhWk7lawCg8f9I
js3PkNzEYGPN456Kc60+f34=
=/GN/
-----END PGP SIGNATURE-----

--nextPart15622834.9J3sI0TMqq--

--===============8277683733832928989==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8277683733832928989==--
