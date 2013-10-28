From: Mark Brown <broonie@kernel.org>
Subject: Re: Any news on Runtime Interpreted Power Sequences
Date: Mon, 28 Oct 2013 16:53:44 -0700
Message-ID: <20131028235344.GB16686@sirena.org.uk>
References: <20131025112224.6e5265e6@notabene.brown>
 <526A0E71.100@nvidia.com>
 <20131025183345.2b963e13@notabene.brown>
 <526E3605.9080002@nvidia.com>
 <20131028221004.3294c1ea@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:36579 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753546Ab3J1XyU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 28 Oct 2013 19:54:20 -0400
Content-Disposition: inline
In-Reply-To: <20131028221004.3294c1ea@notabene.brown>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Alex Courbot <acourbot@nvidia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thierry Reding <thierry.reding@avionic-design.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 28, 2013 at 10:10:04PM +1100, NeilBrown wrote:

> I agree that this power-up sequence should be a property of the device.
> However until the device has been powered up, Linux doesn't know about it.
> Neither a board file or a devicetree can (as far as I can tell), tell the
> MMC port that a particular card is attached.  Rather the host probes the card
> to see what it is.
> So there isn't any way for the device driver to get control at the
> appropriate time to effect the proper sequencing.

If it is a genuinely pluggable MMC slot then I'd expect the sequence to
be implementing whatever is required for standard MMC enumeration to
work.  If the device is a soldered down one with extra control (as is
quite common) then there shouldn't be a problem describing it?

--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSbvj/AAoJELSic+t+oim9IS8P/3WjzQfhO5hssgCAj8rHvX6a
VMA4o4CgegM3cBpxxbje77w+R4FlEdQ77eUvghBov5mRVAplJ6y8CRnG54Kt0Gvq
Z+LH4h4VbbvO60jtNonPnSKOIk50MDvGS/qRKWKzK0BV3mMiioq8XW8i9ida/XCc
SbWRJJqpovlGUVhG+9K2r+kBfcIEqy86nvzVp8BL5dX24ePr8knZfxaiTjh+9hwX
9Fh+COVTWpwZADwnjBxYiDVvNk7H8hqVrdDZOpFIT/kGDO6HRHI60a06S6h0sHK/
QHI0cZ7yvNCOOscc6q6rE8GMANUlU5ge7r+Xp9TpylRmkrsG63dEU/GyFOt25yR2
M6FBhah79rxh8wYyE4EVzxmh3vbK5YVuuXcf0PzkU+7ibPfN59Oki0aN1Spj56Vi
EKbJR4ohmIxpmaZ6fAsYk5WQV1M77tdFMSrscOirls+Lkx7YiwgLpx62P6TNZpeg
bWzBXgdud0s/DT7OGNl3/nmgM+yZaCyObkai1dEhs03US90Ob78ed50jmcfXEEFe
MVu7wA6pdsePWK5+bqKCUlN0KDUxViFyYzESTBSGazQBiwUDKLe6yQ3M/Upl0Arp
0nsECibK9vW5v3dnU7AFKsTpd+ociagCMvDt1UkYzoze33P0r/nQb0dkfXR7emfL
EdyuW8gSqmZK5he9A0WZ
=nOdO
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--
