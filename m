From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/2] ab8500_fg: match return type of
  wait_for_completion_timeout
Date: Wed, 25 Feb 2015 22:47:53 +0100
Message-ID: <20150225214752.GL13695@earth>
References: <1423502445-31264-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zH41lVBEV8cLJnCl"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1423502445-31264-1-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Mc Guire <hofrat@osadl.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--zH41lVBEV8cLJnCl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Mon, Feb 09, 2015 at 12:20:45PM -0500, Nicholas Mc Guire wrote:
> return type of wait_for_completion_timeout is unsigned long not int. as
> timeout is used for wait_for_completion_timeout exclusively here its
> type is simply changed to unsigned long.

thanks, applied to battery-2.6.git.

-- Sebastian

--zH41lVBEV8cLJnCl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU7kMIAAoJENju1/PIO/qat2cP/3Q6iYmXD2gh1Q151iPw4iXR
iauN6iQd+dfmUdcPDA2FIPFX5aRsvN6T4YcTICtCMRiLaIOWMaxX8MDmh/EmVWnE
zmOR+AnwozRwl/b/zZJ4K7cTcRe2DMQV/wwC5yDBUuVFA033qsZUoc8LSwrmn15Z
a76910MjCXLlervK4zbE13eV/Qb9cWw8v31o+cyw4PWpD5RNRcOSm/G+WbcH04Ft
ZTA5gt21e/zG36vFTx8LB3aFflO6PIkwXuLjQynikvuaDOxm4yBi0Bvi826lVw9g
3Yvh/w8NxZO1F/wYbIQdSPtjRHxbT8UYsTPrNYfCmhFu7xC+wy2yf9bzcsRcJFCP
5Qe3UXJNSGWZY5O/ZPrlv4ik0N+9rghTQfCy7c64OXsVV8Db8IAnzdppnFbbq4ro
2ePD/j6dU9pZywHGTpU8KfLGIB5KSIj76WLhh+GSjkgxE9x7ZXDN/BszUk+WEuLg
H+YR280OONgmcyt7T6vAMlmsy1vktVN1vuULpdxNlvyWn9Lu4TOT+hR2DF5pmRAO
u+ayo6rV2J6l8q/6QC9eqkvKKNR8R90/kwhPMd6vqzld68oCVekwg4wi3jJxCD3I
rAIosa6CC3kG9m8AsDCObEWDDt/1M297xZppjWAxJByhabOQknJ04oX5nmI1xFM7
f2yM/iniXe4aiqafZ1qn
=e23F
-----END PGP SIGNATURE-----

--zH41lVBEV8cLJnCl--
