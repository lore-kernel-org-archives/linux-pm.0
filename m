From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: Re: Hibernation considerations
Date: Sun, 22 Jul 2007 08:16:02 +1000
Message-ID: <200707220816.03838.nigel@nigel.suspend2.net>
References: <Pine.LNX.4.64.0707171319140.2467@asgard.lang.hm>
	<200707212243.35602.nigel@nigel.suspend2.net>
	<87lkd9ohtn.fsf@jbms.ath.cx>
Reply-To: nigel@suspend2.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1070297643266740212=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87lkd9ohtn.fsf@jbms.ath.cx>
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
To: Jeremy Maitin-Shepard <jbms@cmu.edu>
Cc: david@lang.hm, Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, miltonm@bga.com, ying.huang@intel.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

--===============1070297643266740212==
Content-Type: multipart/signed; boundary="nextPart1976347.8yxf0I4N35";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1976347.8yxf0I4N35
Content-Type: text/plain;
  charset="cp 850"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Sunday 22 July 2007 02:13:56 Jeremy Maitin-Shepard wrote:
> It seems that you could still potentially get a failure to freeze if one
> FUSE process depends on another, and the one that is frozen second just
> happens to be waiting on the one that is frozen first when it is frozen.
> I admit that this situation is unlikely, and perhaps acceptable.
>=20
> A larger concern is that it seems that freezing FUSE processes at all
> _will_ generate deadlocks if a non-synchronous or memory-map-supporting
> filesystem is loopback mounted from a FUSE filesystem.  In that case, if
> you attempt to sync or free memory once FUSE is frozen, you are sure to
> get a deadlock.

Ok. So then (in response to Alan too), how about keeping a tree of mounts,=
=20
akin to the device tree, and working from the deepest nodes up? (In=20
conjunction with what I already suggested)?

Regards,

Nigel
=2D-=20
See http://www.tuxonice.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

--nextPart1976347.8yxf0I4N35
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGooWjN0y+n1M3mo0RAiFrAKDoNHX3OYIQ5oa5oMuyorrITCWFngCgndeJ
kW4J4yTjFIdPr+slSiMtIwo=
=CQ/Y
-----END PGP SIGNATURE-----

--nextPart1976347.8yxf0I4N35--

--===============1070297643266740212==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1070297643266740212==--
