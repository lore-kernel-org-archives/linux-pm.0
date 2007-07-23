From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: Re: Hibernation considerations
Date: Tue, 24 Jul 2007 07:55:00 +1000
Message-ID: <200707240755.01820.nigel__13522.9829386391$1185227753$gmane$org@nigel.suspend2.net>
References: <Pine.LNX.4.44L0.0707231120380.3545-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3180324534714766052=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0707231120380.3545-100000@iolanthe.rowland.org>
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
Cc: david@lang.hm, Miklos Szeredi <miklos@szeredi.hu>, nigel@suspend2.net, linux-kernel@vger.kernel.org, miltonm@bga.com, ying.huang@intel.com, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

--===============3180324534714766052==
Content-Type: multipart/signed; boundary="nextPart1483447.JhtF0ov2Er";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1483447.JhtF0ov2Er
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Tuesday 24 July 2007 01:23:15 Alan Stern wrote:
> On Mon, 23 Jul 2007, Nigel Cunningham wrote:
>=20
> > Take a step back for a second.
> >=20
> > The problem we're facing now is that we're getting some userspace threa=
ds,=20
> > used in processing I/O, that are functioning as exceptions to the "free=
ze=20
> > userspace, then freezeable kernel threads" rule. They are only exceptio=
ns=20
> > because of that role in processing I/O - because they're de facto kerne=
l=20
> > threads. So, if we orient our thinking more in terms of I/O processing =
and=20
> > less in terms of the userspace/kernelspace distinction, we'll have a=20
> > solution:
> >=20
> > 1) Freeze processes that aren't fs related (ie stop them generating I/O=
).
>=20
> The problem here is that with things like FUSE, _every_ process is=20
> potentially fs related.  Nothing prevents a FUSE thread from doing IPC=20
> with any other thread.

Yes, but the fuse thread is going to know what other thread it's doing IPC=
=20
with, so it can get that thread flagged too.

> > 2) Flush pending I/O.
> > 3) Freeze filesystems in reverse order of dependency, the primary purpo=
se=20
> > being to stop them generating further I/O on their metadata.
> >=20
> > Locks that are being held are only being held because work is being don=
e.=20
If=20
> > we progressively focus on threads in terms of their create/process work=
=20
> > dependencies, we'll see that the problem isn't at all intractable.
>=20
> As has been mentioned before, keeping track of all that dependency=20
> information would be very fragile and time-consuming.

I disagree. It's at least going to be less fragile and time-consuming then=
=20
maintaining new/extra code for kexec.

Nigel


--nextPart1483447.JhtF0ov2Er
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGpSO1N0y+n1M3mo0RAk3RAKDAb98mqiRLbzd3FCufl+9NxNO6zACgjv4u
mmH/Mz3esbPmL1FSGHVFvvw=
=Kgxx
-----END PGP SIGNATURE-----

--nextPart1483447.JhtF0ov2Er--

--===============3180324534714766052==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3180324534714766052==--
