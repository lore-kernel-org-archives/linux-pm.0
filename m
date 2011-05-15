From: Martin Steigerwald <Martin@lichtvoll.de>
Subject: Re: [RFC][PATCH] PM / Hibernate: Add sysfs knob to
	control size of memory for drivers
Date: Sun, 15 May 2011 10:51:32 +0200
Message-ID: <201105151051.38934.Martin@lichtvoll.de>
References: <201105100059.25372.rjw@sisk.pl> <201105150056.55601.rjw@sisk.pl>
	(sfid-20110515_100223_415195_5F732665)
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3143937588640043949=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201105150056.55601.rjw@sisk.pl>
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
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============3143937588640043949==
Content-Type: multipart/signed;
  boundary="nextPart4128863.aDhnI8StpK";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart4128863.aDhnI8StpK
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am Sonntag, 15. Mai 2011 schrieb Rafael J. Wysocki:
> Hi,

Hi Rafael,

> On Tuesday, May 10, 2011, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> >=20
> > Martin reports that on his system hibernation occasionally fails due
> > to the lack of memory, because the radeon driver apparently allocates
> > too much of it during the device freeze stage.  It turns out that the
> > amount of memory allocated by radeon during hibernation (and
> > presumably during system suspend too) depends on the utilization of
> > the GPU (e.g. hibernating while there are two KDE 4 sessions with
> > compositing enabled causes radeon to allocate more memory than for
> > one KDE 4 session).
> >=20
> > In principle it should be possible to use image_size to make the
> > memory preallocation mechanism free enough memory for the radeon
> > driver, but in practice it is not easy to guess the right value
> > because of the way the preallocation code uses image_size.  For this
> > reason, it seems reasonable to allow users to control the amount of
> > memory reserved for driver allocations made after the preallocation,
> > which currently is constant and amounts to 1 MB.
> >=20
> > Introduce a new sysfs file, /sys/power/reserved_size, whose value
> > will be used as the amount of memory to reserve for the
> > post-preallocation reservations made by device drivers, in bytes.
> > For backwards compatibility, set its default (and initial) value to
> > the currently used number (1 MB).
> >=20
> > References: https://bugzilla.kernel.org/show_bug.cgi?id=3D34102
> > Reported-by: Martin Steigerwald <Martin@Lichtvoll.de>
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
>=20
> OK, there are no comments, so my understanding is that everyone is fine
> with this patch and I can add it to my linux-next branch.

Extensively

Tested-by: Martin Steigerwald <Martin@Lichtvoll.de>

This patch makes a complete difference for me. Instead of not knowing=20
whether my ThinkPad T42 will hibernate with lots of applications open and=20
thus closing applications prior to hibernation preventively now it simply=20
will. *Always*.

I even tested it with two KDE 4 sessions with running desktop search=20
indexing on one. It took ages, cause KDE 4.6 desktop search / nepomuk stuff=
=20
seems to I/O load the machine beyond anything (bugs reported there), but=20
it worked.

16 MiB reserved_size has been enough for one KDE session. With 128 MiB the=
=20
linux kernel hibernated two KDE sessions.

Drivers allocating their memory via suspend/hibernate notifiers according=20
to Rafael should fix the root cause, but until that is done, this will do.=
=20
Adjusting imagesize instead never gave me such a reliable result.

Thanks,
=2D-=20
Martin 'Helios' Steigerwald - http://www.Lichtvoll.de
GPG: 03B0 0D6C 0040 0710 4AFA  B82F 991B EAAC A599 84C7

--nextPart4128863.aDhnI8StpK
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk3PlBUACgkQmRvqrKWZhMcjSwCfQhQldFJoyo04k+PG/Z0AvGF6
mKEAnA//RFQIk7vw5BjAU+p3ejEHAQJE
=GR0Z
-----END PGP SIGNATURE-----

--nextPart4128863.aDhnI8StpK--

--===============3143937588640043949==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3143937588640043949==--
