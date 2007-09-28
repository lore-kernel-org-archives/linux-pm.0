From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: A unresponsive file system can hang all I/O in the
	system on linux-2.6.23-rc6 (dirty_thresh problem?)
Date: Fri, 28 Sep 2007 15:35:42 +0200
Message-ID: <1190986542.13204.10.camel__26181.2172168449$1190993797$gmane$org@twins>
References: <10659.1190986132@lwn.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6126774273950460796=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <10659.1190986132@lwn.net>
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
To: Jonathan Corbet <corbet@lwn.net>
Cc: Chakri n <chakriin5@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, nfs@lists.sourceforge.net, linux-pm <linux-pm@lists.linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--===============6126774273950460796==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-B7gWPg0qNtyVIOP7F/5Z"


--=-B7gWPg0qNtyVIOP7F/5Z
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-09-28 at 07:28 -0600, Jonathan Corbet wrote:
> Andrew wrote:
> > It's unrelated to the actual value of dirty_thresh: if the machine fill=
s up
> > with dirty (or unstable) NFS pages then eventually new writers will blo=
ck
> > until that condition clears.
> >=20
> > 2.4 doesn't have this problem at low levels of dirty data because 2.4
> > VFS/MM doesn't account for NFS pages at all.
>=20
> Is it really NFS-related?  I was trying to back up my 2.6.23-rc8 system
> to an external USB drive the other day when something flaked and the
> drive fell off the bus.  That, too, was sufficient to wedge the entire
> system, even though the only thing which needed the dead drive was one
> rsync process.  It's kind of a bummer to have to hit the reset button
> after the failure of (what should be) a non-critical piece of hardware.
>=20
> Not that I have a fix to propose...:)

the per bdi work in -mm should make the system not drop dead.

Still, would a remove,re-insert of the usb media end up with the same
bdi? That is, would it recognise as the same and resume the transfer.

Anyway, it would be grand (and dangerous) if we could provide for a
button that would just kill off all outstanding pages against a dead
device.

--=-B7gWPg0qNtyVIOP7F/5Z
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG/QMuXA2jU0ANEf4RAvYTAJ4rvKoTju2OD6MnSAG5wpprY/YnlwCeM0x2
8txLQE3YX+G6kU1onUvcGsk=
=TMEF
-----END PGP SIGNATURE-----

--=-B7gWPg0qNtyVIOP7F/5Z--


--===============6126774273950460796==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6126774273950460796==--
