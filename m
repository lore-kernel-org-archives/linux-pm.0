From: Carl Worth <cworth@cworth.org>
Subject: Re: 2.6.35-rc2-git2: Reported regressions from 2.6.34
Date: Tue, 08 Jun 2010 19:38:11 -0700
Message-ID: <87hbldhqwc.fsf__42011.2509899356$1276095863$gmane$org@yoom.home.cworth.org>
References: <Rlf_Qjov7bG.A.a8F.I8rDMB@chimera>
	<alpine.LFD.2.00.1006081814240.4506@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4397086720093346379=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.1006081814240.4506@i5.linux-foundation.org>
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
To: Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Eric Anholt <eric@anholt.net>, Venkatesh Pallipadi <venki@google.com>, Jens
Cc: DRI <dri-devel@lists.sourceforge.net>, Linux SCSI List <linux-scsi@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linux Wireless List <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linux PM List <linux-pm@lists.linux-foundation.org>, Maciej Rutecki <maciej.rutecki@gmail.com>
List-Id: linux-pm@vger.kernel.org

--===============4397086720093346379==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--=-=-=
Content-Transfer-Encoding: quoted-printable

On Tue, 8 Jun 2010 18:53:55 -0700 (PDT), Linus Torvalds <torvalds@linux-fou=
ndation.org> wrote:
> And some of them do seem to be bisected to likely culprits and/or have=20
> patches that are claimed to have fixed them.
>=20
> > Bug-Entry	: http://bugzilla.kernel.org/show_bug.cgi?id=3D16163
> > Subject	: [2.6.35-rc1 Regression] i915: Commit cfecde causes VGA to sta=
y off
> > Submitter	: David John <davidjon@xenontk.org>
> > Date		: 2010-06-02 12:52 (7 days old)
> > Message-ID	: <4C065423.3000202@xenontk.org>
> > References	: http://marc.info/?l=3Dlinux-kernel&m=3D127548313828613&w=
=3D2
>=20
> That has a "reverting the commit fixes it", and a confirmation from Nick=
=20
> Bowler.
>=20
> Eric, Carl: should I just revert that commit? Or do you have a fix?

I'm not aware of any real fix here. That commit isn't supposed to change
much, but it clearly unmasks some broken driver code.

So reverting it for now to hide the broken code from poor users does
seem a good plan to me, (unless Eric has any updates or alternate
suggestions).

=2DCarl

=2D-=20
carl.d.worth@intel.com

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iD8DBQFMDv6T6JDdNq8qSWgRAm2CAJ9p30+Roeli4N7Gv4rKjfxQKvMIOgCeOZfE
GPPsJXno4b3GCgHuFmrqKk8=
=2APO
-----END PGP SIGNATURE-----
--=-=-=--

--===============4397086720093346379==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4397086720093346379==--
