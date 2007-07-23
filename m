From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: Re: Hibernation considerations
Date: Mon, 23 Jul 2007 13:11:53 +1000
Message-ID: <200707231311.56398.nigel__2587.67214040763$1185160357$gmane$org@nigel.suspend2.net>
References: <Pine.LNX.4.44L0.0707221116060.15224-100000@netrider.rowland.org>
	<200707230842.22121.nigel@nigel.suspend2.net>
	<18083.61595.217126.824924@cargo.ozlabs.ibm.com>
Reply-To: nigel@suspend2.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4871392068588371741=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <18083.61595.217126.824924@cargo.ozlabs.ibm.com>
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
To: Paul Mackerras <paulus@samba.org>
Cc: david@lang.hm, Miklos Szeredi <miklos@szeredi.hu>, nigel@suspend2.net, linux-kernel@vger.kernel.org, miltonm@bga.com, ying.huang@intel.com, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

--===============4871392068588371741==
Content-Type: multipart/signed; boundary="nextPart3061019.5FOuh07jjx";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3061019.5FOuh07jjx
Content-Type: text/plain;
  charset="cp 850"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Monday 23 July 2007 10:04:43 Paul Mackerras wrote:
> Nigel Cunningham writes:
>=20
> > I guess I want to persist because all of these issues aren't utterly
> > unsolvable. It's just that we don't have the infrastructure yet to
> > figure out the solutions to these issues trivially. Take, for example,
>=20
> Ever heard of the halting problem? :)  It's not just a matter of
> infrastructure.  You very quickly get into questions that are
> mathematically undecideable.

Is this the halting problem, though?

> > the locking issue. If we could call some function to say "What process
> > holds this lock?", then task A could know that it's waiting on task B
> > and put that information somewhere. We could then use the information
> > to freeze task B before task A.
>=20
> But how would that help?  If task B holds the lock, then we can't
> freeze it until it's released the lock.  Then the question is, what
> does task B need in order to get to the point where it releases the
> lock?  And so on.  It rapidly gets not just extremely messy, but
> actually impossible to compute in general.

Take a step back for a second.

The problem we're facing now is that we're getting some userspace threads,=
=20
used in processing I/O, that are functioning as exceptions to the "freeze=20
userspace, then freezeable kernel threads" rule. They are only exceptions=20
because of that role in processing I/O - because they're de facto kernel=20
threads. So, if we orient our thinking more in terms of I/O processing and=
=20
less in terms of the userspace/kernelspace distinction, we'll have a=20
solution:

1) Freeze processes that aren't fs related (ie stop them generating I/O).
2) Flush pending I/O.
3) Freeze filesystems in reverse order of dependency, the primary purpose=20
being to stop them generating further I/O on their metadata.

Locks that are being held are only being held because work is being done. I=
f=20
we progressively focus on threads in terms of their create/process work=20
dependencies, we'll see that the problem isn't at all intractable.

Regards,

Nigel
=2D-=20
See http://www.tuxonice.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

--nextPart3061019.5FOuh07jjx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGpBx8N0y+n1M3mo0RAhybAKCZ6JG1LcsYF5DaSS90GYKo5Q8mmwCgneh8
YI3yYVHZsrsq66TLZOMVc/o=
=9J29
-----END PGP SIGNATURE-----

--nextPart3061019.5FOuh07jjx--

--===============4871392068588371741==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4871392068588371741==--
