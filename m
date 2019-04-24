From: Pavel Machek <pavel@ucw.cz>
Subject: Re: next-20190408..0418: Suspend/resume problems on Thinkpad X60
Date: Wed, 24 Apr 2019 12:17:11 +0200
Message-ID: <20190424101711.GB32457@amd>
References: <20190408173928.GB13260@amd>
 <20190412102812.GA24977@amd>
 <20190423102239.GA15531@amd>
 <fed0549d-a789-294c-d899-304911106113@acm.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="98e8jtXdkpgskNou"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <fed0549d-a789-294c-d899-304911106113@acm.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bart Van Assche <bvanassche@acm.org>
Cc: kernel list <linux-kernel@vger.kernel.org>, rjw@rjwysocki.net, linux-pm@vger.kernel.org, sfr@canb.auug.org.au, linux-next@vger.kernel.org, hdegoede@redhat.com, axboe@kernel.dk, linux-ide@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--98e8jtXdkpgskNou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2019-04-23 07:09:42, Bart Van Assche wrote:
> On 4/23/19 3:22 AM, Pavel Machek wrote:
> >>> It boots ok (unlike mainline -- I'm debugging that), and I can suspend
> >>> and resume... but then cursor in X is moving and I can talk to
> >>> applications cached in memory, but any access to disk hangs.
> >>
> >> Mainline problem was identified.
> >>
> >> But resume is still broken. I took advantage of fact that I can still
> >> do cached commands, and got complete dmesg. I'm attaching it.
> >=20
> > Still broken in 0418. Ideas would be welcome at this point.
>=20
> Have you already tried the debugging steps explained in
> Documentation/power to obtain more information about the nature of the
> suspend/resume problem?

That won't help, as system resumes ok, then disk hangs.

Does it work for you?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--98e8jtXdkpgskNou
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzAN6cACgkQMOfwapXb+vJezgCgoWVWmfeF9ahvqokqnECrFOcX
h9UAmwaJqzgcLU/tD0reSxmWbm8ChQPv
=RDqQ
-----END PGP SIGNATURE-----

--98e8jtXdkpgskNou--
