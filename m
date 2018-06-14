From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC PATCH 12/12] PM / hibernate: update the resume offset on
 SNAPSHOT_SET_SWAP_AREA
Date: Thu, 14 Jun 2018 21:45:15 +0200
Message-ID: <20180614194515.GE17808@amd>
References: <20180612205619.28156-1-anchalag@amazon.com>
 <20180612205619.28156-13-anchalag@amazon.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5Mfx4RzfBqgnTE/w"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180612205619.28156-13-anchalag@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anchal Agarwal <anchalag@amazon.com>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, roger.pau@citrix.com, netdev@vger.kernel.org, jgross@suse.com, xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, kamatam@amazon.com, fllinden@amazon.com, vallish@amazon.com, guruanb@amazon.com, eduval@amazon.com, rjw@rjwysocki.net, len.brown@intel.com, linux-pm@vger.kernel.org, cyberax@amazon.com
List-Id: linux-pm@vger.kernel.org


--5Mfx4RzfBqgnTE/w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Aleksei Besogonov <cyberax@amazon.com>
>=20
> The SNAPSHOT_SET_SWAP_AREA is supposed to be used to set the hibernation
> offset on a running kernel to enable hibernating to a swap file.
> However, it doesn't actually update the swsusp_resume_block variable. As
> a result, the hibernation fails at the last step (after all the data is
> written out) in the validation of the swap signature in
> mark_swapfiles().
>=20
> Before this patch, the command line processing was the only place where
> swsusp_resume_block was set.

Are you saying that suspend-to-file was broken, even on
non-virtualized systems?

If so, we may this to go in first...
								Pavel
							=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--5Mfx4RzfBqgnTE/w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsixcsACgkQMOfwapXb+vLC3wCfX4tTCT4FWhC5Eamk0GflW7HU
XwQAoJSlWbWAf4T9Kkoe+rMuMl+uDnkz
=yswn
-----END PGP SIGNATURE-----

--5Mfx4RzfBqgnTE/w--
