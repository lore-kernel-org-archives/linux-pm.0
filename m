From: Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: Suspend problems in 2.6.31-rc6
Date: Mon, 24 Aug 2009 10:34:23 +0800
Message-ID: <20090824023423.GC4624@zhen-devel.sh.intel.com>
References: <Pine.LNX.4.44L0.0908211022210.2912-100000@iolanthe.rowland.org>
	<200908211901.06616.rjw@sisk.pl>
Reply-To: Zhenyu Wang <zhenyuw@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9040625864590127693=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200908211901.06616.rjw@sisk.pl>
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
Cc: Greg KH <greg@kroah.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Alek Du <alek.du@intel.com>, Dave Airlie <airlied@redhat.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org


--===============9040625864590127693==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Fig2xvG2VGoz8o/s"
Content-Disposition: inline


--Fig2xvG2VGoz8o/s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2009.08.21 19:01:06 +0200, Rafael J. Wysocki wrote:
> Yes.  Moreover, it doesn't need to be restored at that point, because it =
has
> already been restored earlier by the PCI bus type code.

true.

>=20
> So, Zhenyu, it is completely unnecessary to call pci_restore_state() from
> a driver's ->resume() routine, because the PCI bus type driver has
> already called it in its ->resume_noirq().  And please note that
> pci_pm_default_resume_noirq() clears state_saved, which is why the Alek's
> patch helps.
>=20
> Without the Alek's patch on the Alan's system the config registers of both
> PCI devices are restored twice, first by the PCI bus type at the "noirq" =
stage
> and next by the driver.  The Alek's patch turns the second restorations i=
nto
> NOPs, which is fine, because they are unnecessary in general and they bre=
ak
> things on the Alan's system.
>=20

yeah, Alex's patch is ok in general, and Alan's problem seems specific on 8=
45G.
So the origin restore order issue for us seems gone with pci layer early re=
sume,
we could remove the restore in intel_agp and drm/i915, although Alex's patc=
h makes
them noop.

How about this one? Alan, could you help to test this with drm/i915 module =
loaded?

thanks.

=46rom 7ab123a67e3ab3f31051d95e74362ae711e0657e Mon Sep 17 00:00:00 2001
=46rom: Zhenyu Wang <zhenyuw@linux.intel.com>
Date: Mon, 24 Aug 2009 10:29:07 +0800
Subject: [PATCH] agp/intel: remove restore in resume

As earlier pci driver resume has already restored space for
host bridge and graphics device, don't need to restore it
again which might cause problem on some chips, e.g 845G tested
by Alan.

Signed-off-by: Zhenyu Wang <zhenyuw@linux.intel.com>
---
 drivers/char/agp/intel-agp.c    |    9 ---------
 drivers/gpu/drm/i915/i915_drv.c |    1 -
 2 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/drivers/char/agp/intel-agp.c b/drivers/char/agp/intel-agp.c
index 8c9d50d..ed43ab2 100644
--- a/drivers/char/agp/intel-agp.c
+++ b/drivers/char/agp/intel-agp.c
@@ -2308,15 +2308,6 @@ static int agp_intel_resume(struct pci_dev *pdev)
 	struct agp_bridge_data *bridge =3D pci_get_drvdata(pdev);
 	int ret_val;
=20
-	pci_restore_state(pdev);
-
-	/* We should restore our graphics device's config space,
-	 * as host bridge (00:00) resumes before graphics device (02:00),
-	 * then our access to its pci space can work right.
-	 */
-	if (intel_private.pcidev)
-		pci_restore_state(intel_private.pcidev);
-
 	if (bridge->driver =3D=3D &intel_generic_driver)
 		intel_configure();
 	else if (bridge->driver =3D=3D &intel_850_driver)
diff --git a/drivers/gpu/drm/i915/i915_drv.c b/drivers/gpu/drm/i915/i915_dr=
v.c
index fc4b68a..645f298 100644
--- a/drivers/gpu/drm/i915/i915_drv.c
+++ b/drivers/gpu/drm/i915/i915_drv.c
@@ -95,7 +95,6 @@ static int i915_resume(struct drm_device *dev)
 	int ret =3D 0;
=20
 	pci_set_power_state(dev->pdev, PCI_D0);
-	pci_restore_state(dev->pdev);
 	if (pci_enable_device(dev->pdev))
 		return -1;
 	pci_set_master(dev->pdev);
--=20
1.5.4

--=20
Open Source Technology Center, Intel ltd.

$gpg --keyserver wwwkeys.pgp.net --recv-keys 4D781827

--Fig2xvG2VGoz8o/s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkqR/C8ACgkQsQQaM014GCdG5wCdF00k2a3By08IDrukgmhshJW6
EoMAnigW/YMbuIwDpAMZ0rt9Xtm/+Uz9
=4TK/
-----END PGP SIGNATURE-----

--Fig2xvG2VGoz8o/s--

--===============9040625864590127693==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9040625864590127693==--
