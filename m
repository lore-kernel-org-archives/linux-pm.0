From: Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: Suspend problems in 2.6.31-rc6
Date: Fri, 21 Aug 2009 09:21:32 +0800
Message-ID: <20090821012132.GB14002@zhen-devel.sh.intel.com>
References: <200908192322.25261.rjw@sisk.pl>
	<Pine.LNX.4.44L0.0908201115020.2656-100000@iolanthe.rowland.org>
Reply-To: Zhenyu Wang <zhenyuw@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7852381986212455075=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0908201115020.2656-100000@iolanthe.rowland.org>
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


--===============7852381986212455075==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zx4FCpZtqtKETZ7O"
Content-Disposition: inline


--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2009.08.20 11:17:45 -0400, Alan Stern wrote:
> On Wed, 19 Aug 2009, Rafael J. Wysocki wrote:
>=20
> > Usually, however, restoring the PCI config space twice doesn't hurt, al=
though
> > it evidently does hurt on your system.
> >=20
> > Hm, there's a patch that should help here I think.  Can you please test
> > this one: http://patchwork.kernel.org/patch/40062/ ?
>=20
> Testing confirms that Alex's patch (pci: check saved state before
> restore) fixes the resume problem.  IMO it should be merged before
> 2.6.31 is released.
>=20

I can't understand why Alex's patch could fix for you, or because you've
seen 'state_saved' is false in your testing, and Alex's patch just workarou=
nd
state restore for you? I don't understand why 'state_saved' is false in your
case, as pci layer should do save state for us by default, no?

Could you try with this one? And what's your gfx chip? I've tested rc6 on my
965GM yesterday, S3/S4 both seem fine...

diff --git a/drivers/char/agp/intel-agp.c b/drivers/char/agp/intel-agp.c
index 8c9d50d..1f3a299 100644
--- a/drivers/char/agp/intel-agp.c
+++ b/drivers/char/agp/intel-agp.c
@@ -2303,6 +2303,12 @@ static void __devexit agp_intel_remove(struct pci_de=
v *pdev)
 }
=20
 #ifdef CONFIG_PM
+static int agp_intel_suspend(struct pci_dev *pdev)
+{
+	pci_save_state(dev);
+	pci_set_power_state(dev, 3);
+}
+
 static int agp_intel_resume(struct pci_dev *pdev)
 {
 	struct agp_bridge_data *bridge =3D pci_get_drvdata(pdev);
@@ -2410,6 +2416,7 @@ static struct pci_driver agp_intel_pci_driver =3D {
 	.remove		=3D __devexit_p(agp_intel_remove),
 #ifdef CONFIG_PM
 	.resume		=3D agp_intel_resume,
+	.suspend	=3D agp_intel_suspend,
 #endif
 };
=20
diff --git a/drivers/gpu/drm/i915/i915_drv.c b/drivers/gpu/drm/i915/i915_dr=
v.c
index fc4b68a..f54880f 100644
--- a/drivers/gpu/drm/i915/i915_drv.c
+++ b/drivers/gpu/drm/i915/i915_drv.c
@@ -95,7 +95,11 @@ static int i915_resume(struct drm_device *dev)
 	int ret =3D 0;
=20
 	pci_set_power_state(dev->pdev, PCI_D0);
-	pci_restore_state(dev->pdev);
+	/* XXX as pci layer should have already early restore state
+	   for us, or intel_agp driver has taken care of reconfigure,
+	   we don't need to restore again here, which might corrupt
+	   reconfigured state...*/
+	/* pci_restore_state(dev->pdev); */
 	if (pci_enable_device(dev->pdev))
 		return -1;
 	pci_set_master(dev->pdev);

--=20
Open Source Technology Center, Intel ltd.

$gpg --keyserver wwwkeys.pgp.net --recv-keys 4D781827

--zx4FCpZtqtKETZ7O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkqN9pwACgkQsQQaM014GCeRMQCffhts2jhLYfNC4soEwaNBcquk
UcgAoIJoYD9CxfFFCS0Mrzgio4n4Zqs5
=M6qb
-----END PGP SIGNATURE-----

--zx4FCpZtqtKETZ7O--

--===============7852381986212455075==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7852381986212455075==--
