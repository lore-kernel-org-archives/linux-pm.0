From: Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: Suspend problems in 2.6.31-rc6
Date: Thu, 20 Aug 2009 09:05:28 +0800
Message-ID: <20090820010528.GA9596@zhen-devel.sh.intel.com>
References: <20090819020156.GA22638@zhen-devel.sh.intel.com>
	<Pine.LNX.4.44L0.0908191040050.3001-100000@iolanthe.rowland.org>
Reply-To: Zhenyu Wang <zhenyuw@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5494542548496381390=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0908191040050.3001-100000@iolanthe.rowland.org>
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
Cc: Greg KH <greg@kroah.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Dave Airlie <airlied@redhat.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org


--===============5494542548496381390==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2009.08.19 10:42:07 -0400, Alan Stern wrote:
> On Wed, 19 Aug 2009, Zhenyu Wang wrote:
>=20
> > Rafael, as I added this restore long time ago, pci core has changed in =
some way?
> > We had problem when reconfigure agp GTT space in resume, as we must be =
sure
> > gfx device's config space has been restored properly, and as 02:00 gfx =
device
> > restored later than host bridge 00:00 device, that came to my origin pa=
tch to
> > restore it earlier.
>=20
> Why did you do it that way?  I mean, why not restore the gfx device's=20
> config space in its own resume routine instead of in the host bridge's=20
> resume routine?
>=20

That's the order issue I have mentioned. intel_agp is the pci driver for
host bridge (dev 00:00), and drm/i915 is the pci driver for gfx device
(dev 00:02). Host bridge will always resume earlier than gfx device, but
for intel_agp we need to access gfx device when reconfigure GTT in resume,
we can't wait until restore happen in i915 driver.

So there might be a conflict here, as i915 driver also do pci_restore_state=
()
after we did reconfigure in intel_agp driver, some configs may be corrupted=
=20
then. Although I haven't seen it in real testing.=20

--=20
Open Source Technology Center, Intel ltd.

$gpg --keyserver wwwkeys.pgp.net --recv-keys 4D781827

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkqMoVgACgkQsQQaM014GCe3rACfd5v2civlM3+J1Ne3fHc3LLl2
2ncAn08/3uK0kXv5kiy04QH9215SIX8h
=ZtSr
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--

--===============5494542548496381390==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5494542548496381390==--
