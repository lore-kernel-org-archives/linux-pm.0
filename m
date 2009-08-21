From: Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: Suspend problems in 2.6.31-rc6
Date: Fri, 21 Aug 2009 11:13:20 +0800
Message-ID: <20090821031320.GA21420@zhen-devel.sh.intel.com>
References: <200908192322.25261.rjw@sisk.pl>
	<Pine.LNX.4.44L0.0908201115020.2656-100000@iolanthe.rowland.org>
	<20090821012132.GB14002@zhen-devel.sh.intel.com>
Reply-To: Zhenyu Wang <zhenyuw@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8805980641298723535=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090821012132.GB14002@zhen-devel.sh.intel.com>
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
To: Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@sisk.pl>, Greg KH <greg@kroah.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


--===============8805980641298723535==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2009.08.21 09:21:32 +0800, Zhenyu Wang wrote:
> On 2009.08.20 11:17:45 -0400, Alan Stern wrote:
> > On Wed, 19 Aug 2009, Rafael J. Wysocki wrote:
> >=20
> > > Usually, however, restoring the PCI config space twice doesn't hurt, =
although
> > > it evidently does hurt on your system.
> > >=20
> > > Hm, there's a patch that should help here I think.  Can you please te=
st
> > > this one: http://patchwork.kernel.org/patch/40062/ ?
> >=20
> > Testing confirms that Alex's patch (pci: check saved state before
> > restore) fixes the resume problem.  IMO it should be merged before
> > 2.6.31 is released.
> >=20
>=20
> I can't understand why Alex's patch could fix for you, or because you've
> seen 'state_saved' is false in your testing, and Alex's patch just workar=
ound
> state restore for you? I don't understand why 'state_saved' is false in y=
our
> case, as pci layer should do save state for us by default, no?
>=20
> Could you try with this one? And what's your gfx chip? I've tested rc6 on=
 my
> 965GM yesterday, S3/S4 both seem fine...
>=20

oops, here's right one for testing...

diff --git a/drivers/char/agp/intel-agp.c b/drivers/char/agp/intel-agp.c
index 8c9d50d..5ed62c1 100644
--- a/drivers/char/agp/intel-agp.c
+++ b/drivers/char/agp/intel-agp.c
@@ -2303,6 +2303,13 @@ static void __devexit agp_intel_remove(struct pci_de=
v *pdev)
 }
=20
 #ifdef CONFIG_PM
+static int agp_intel_suspend(struct pci_dev *pdev, pm_message_t state)
+{
+	pci_save_state(pdev);
+	pci_set_power_state(pdev, 3);
+	return 0;
+}
+
 static int agp_intel_resume(struct pci_dev *pdev)
 {
 	struct agp_bridge_data *bridge =3D pci_get_drvdata(pdev);
@@ -2410,6 +2417,7 @@ static struct pci_driver agp_intel_pci_driver =3D {
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

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkqOENAACgkQsQQaM014GCeuTQCfeSekciH6BZyjJeTH84LmZVp3
lbAAn27PoR04WjRiLY6ERbvKtFxRlqfo
=IZdR
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--

--===============8805980641298723535==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8805980641298723535==--
