From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: Re: Hibernation considerations
Date: Sun, 22 Jul 2007 08:21:04 +1000
Message-ID: <200707220821.05725.nigel__19940.2534323328$1185056506$gmane$org@nigel.suspend2.net>
References: <Pine.LNX.4.64.0707171319140.2467@asgard.lang.hm>
	<87lkd9ohtn.fsf@jbms.ath.cx>
	<E1ICJRG-0000OG-00@dorka.pomaz.szeredi.hu>
Reply-To: nigel@suspend2.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5447241746103174273=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <E1ICJRG-0000OG-00@dorka.pomaz.szeredi.hu>
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

--===============5447241746103174273==
Content-Type: multipart/signed; boundary="nextPart1243396.LYrJ3f5hE8";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1243396.LYrJ3f5hE8
Content-Type: text/plain;
  charset="cp 850"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Sunday 22 July 2007 04:12:22 Miklos Szeredi wrote:
> > It seems that you could still potentially get a failure to freeze if one
> > FUSE process depends on another, and the one that is frozen second just
> > happens to be waiting on the one that is frozen first when it is frozen.
> > I admit that this situation is unlikely, and perhaps acceptable.
>=20
> It isn't all that unlikely.  There's sshfs for example, that depends
> on a separate ssh process for transport.
>=20
> Oh, there are also userspace network transports, like tun/tap,
> nfqueue, etc.  They could block any network filesystem (not just fuse)
> if frozen first, making the freezer fail.
>=20
> Hmm, wonder why this isn't affecting people with VPNs?  Probably
> network mounts over VPN are rare, and ever rarer to have fs activity
> on them during suspend.
>=20
> Anyway, I think it's long overdue to stop thinking about how to "fix"
> fuse, and concentrate on fixing the underlying problem instead ;)

That's what I'm seeking to do :)

> > A larger concern is that it seems that freezing FUSE processes at all
> > _will_ generate deadlocks if a non-synchronous or memory-map-supporting
> > filesystem is loopback mounted from a FUSE filesystem.  In that case, if
> > you attempt to sync or free memory once FUSE is frozen, you are sure to
> > get a deadlock.
>=20
> Well, it would deadlock, if
>=20
>  a) memory reclaim was synchronous, or
>  b) large part of the memory was used for dirty file data

These are problems in normal operation, aren't they?
=20
> I can't remember if (a) was ever true.  And now the dirty ratio is 10%
> by default, so if we go OOM because that 10% can't be reclaimed, there
> is a more serious problem.
>=20
> Swap over loop over fuse would be problematic, but that won't work for
> some time yet ;)

Hopefully people will wake up to the problems with Fuse and get rid of it=20
before then :|. Of course I don't really expect that to happen.

Nigel
=2D-=20
See http://www.tuxonice.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

--nextPart1243396.LYrJ3f5hE8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGoobRN0y+n1M3mo0RAkbpAKDsZxJGatakwWR4v4LBsD7g5SaVLgCdEUGw
jUnKdIz/RnbJk5F2SIMf53M=
=IwHG
-----END PGP SIGNATURE-----

--nextPart1243396.LYrJ3f5hE8--

--===============5447241746103174273==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5447241746103174273==--
