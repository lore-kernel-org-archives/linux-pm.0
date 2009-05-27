From: Martin Steigerwald <ms@teamix.de>
Subject: Re: [TuxOnIce-devel] [RFC] TuxOnIce
Date: Wed, 27 May 2009 16:38:44 +0200
Message-ID: <200905271638.50097.ms__37620.506124995$1243525048$gmane$org@teamix.de>
References: <1241620755-22133-1-git-send-email-nigel@tuxonice.net>
	<200905260058.54482.rjw@sisk.pl>
	<200905260113.46440.oliver@neukum.org>
	(sfid-20090526_021237_792985_629AEF36)
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4932886927508638109=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200905260113.46440.oliver@neukum.org>
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
To: tuxonice-devel@lists.tuxonice.net
Cc: linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

--===============4932886927508638109==
Content-Type: multipart/signed;
  boundary="nextPart4710087.X9GrhZ40pD";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart4710087.X9GrhZ40pD
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Dienstag, 26. Mai 2009 schrieb Oliver Neukum:
> Am Dienstag, 26. Mai 2009 00:58:53 schrieb Rafael J. Wysocki:
> > On Tuesday 26 May 2009, Oliver Neukum wrote:
> > > No, I am afraid it is not. The average user has no clue. Even if that
> > > is not the problem, the user never knows for sure he has encountered
> > > the worst case.
> >
> > OK there, but surely it's better to have a sysfs attribute than a fixed
> > value?
>
> Why? The driver knows best. Tunables are generally the worst solution.

I agree, but what about the not so ideal real-world? What about closed sour=
ce=20
drivers? Who is going to educate closed source driver writers to inform the=
=20
kernel about their memory requirements early enough? And how long will this=
=20
take?

I think at least as an interim measure it makes sense to have a sysfs value=
=2E=20
Or discourage closed-source drivers even more.

I prefer open-source gfx drivers and don't need extra pages allowance, but=
=20
that might not hold true for everyone.

=2D-=20
Martin Steigerwald - team(ix) GmbH - http://www.teamix.de
gpg: 19E3 8D42 896F D004 08AC A0CA 1E10 C593 0399 AE90

--nextPart4710087.X9GrhZ40pD
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkodUHUACgkQHhDFkwOZrpDmlgCfV1MuUTij216v9Sf7c6Fw4HwB
2oQAn02qnn09In43E/RCtqQcYFvF1FhV
=gzej
-----END PGP SIGNATURE-----

--nextPart4710087.X9GrhZ40pD--

--===============4932886927508638109==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4932886927508638109==--
