From: Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: Suspend problems in 2.6.31-rc6
Date: Wed, 19 Aug 2009 10:01:56 +0800
Message-ID: <20090819020156.GA22638@zhen-devel.sh.intel.com>
References: <Pine.LNX.4.44L0.0908181149300.2684-100000@iolanthe.rowland.org>
	<200908190122.17015.rjw@sisk.pl>
Reply-To: Zhenyu Wang <zhenyuw@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4303252824238390049=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200908190122.17015.rjw@sisk.pl>
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
Cc: Greg KH <greg@kroah.com>, Zhenyu Wang <zhenyuw@linux.intel.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Dave Airlie <airlied@redhat.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org


--===============4303252824238390049==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2009.08.19 01:22:16 +0200, Rafael J. Wysocki wrote:
> >=20
> > I have narrowed this down.  The problem occurs in agp_intel_resume()
> > in drivers/char/agp/intel-agp.c.  Here's the beginning of the routine:
> >=20
> >=20
> > static int agp_intel_resume(struct pci_dev *pdev)
> > {
> > 	struct agp_bridge_data *bridge =3D pci_get_drvdata(pdev);
> > 	int ret_val;
> >=20
> > 	pci_restore_state(pdev);
> >=20
> > 	/* We should restore our graphics device's config space,
> > 	 * as host bridge (00:00) resumes before graphics device (02:00),
> > 	 * then our access to its pci space can work right.
> > 	 */
> > 	if (intel_private.pcidev)
> > 		pci_restore_state(intel_private.pcidev);
> >=20
> >=20
> > As the comment says, pdev is 0000:00:00.0 and intel_private.pcidev is
> > 0000:00:02.0.  So this is the resume routine for 00:00.0, and it calls
> > pci_restore_state() for 00:02.0 before that device has been resumed.
> >=20
> > Note that there is no corresponding agp_intel_suspend() function.
> >=20
> > Stuff stops appearing on the screen in the middle of the second
> > pci_restore_state() call.  That is, I see messages about "restoring
> > config space at offset..." for each of the two devices, but a
> > debugging message added at the end of pci_restore_state() doesn't
> > appear for the second call.
> >=20
> > (Should these config space changes occur at all, given that I'm
> > testing with "echo devices >pm_test"?)
> >=20
> > It's also worth noting that a debugging message added to the start of
> > pci_restore_state() shows that for both of these calls,
> > pdev->state_saved is false.  It's not clear whether that matters,
> > though, because the suspend and resume routines in the PCI core do so
> > many calls to pci_save_state() and pci_restore_state() on their own.
> >=20
> > Commenting out the second call to pci_restore_state() apparently fixes=
=20
> > the problem.  I have no idea whether it's the right thing to do,=20
> > though.
>=20
> It is.  The PCI core have restored the PCI config already anyway at the e=
arly
> resume stage.
>=20
> I think the first pci_restore_state() could be dropped from there as well.
>=20

Rafael, as I added this restore long time ago, pci core has changed in some=
 way?
We had problem when reconfigure agp GTT space in resume, as we must be sure
gfx device's config space has been restored properly, and as 02:00 gfx devi=
ce
restored later than host bridge 00:00 device, that came to my origin patch =
to
restore it earlier. So do you mean this order issue is gone now?

We also do proper pci save/restore in drm/i915 driver, which is the real pci
driver for our gfx device. I'm not sure if there could any conflict between=
 them...

--=20
Open Source Technology Center, Intel ltd.

$gpg --keyserver wwwkeys.pgp.net --recv-keys 4D781827

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkqLXRQACgkQsQQaM014GCcdRACdFTyPCjy/KrekCdbXSEMsKXn8
sB8An2HqCe/3B0DkjZmTzEBGYSqa7Ejq
=HAD/
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--

--===============4303252824238390049==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4303252824238390049==--
