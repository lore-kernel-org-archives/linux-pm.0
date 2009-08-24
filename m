From: Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: Suspend problems in 2.6.31-rc6
Date: Mon, 24 Aug 2009 09:30:48 +0800
Message-ID: <20090824013048.GB4624@zhen-devel.sh.intel.com>
References: <20090821031320.GA21420@zhen-devel.sh.intel.com>
	<Pine.LNX.4.44L0.0908211022210.2912-100000@iolanthe.rowland.org>
Reply-To: Zhenyu Wang <zhenyuw@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8818703339928089711=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0908211022210.2912-100000@iolanthe.rowland.org>
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


--===============8818703339928089711==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NDin8bjvE/0mNLFQ"
Content-Disposition: inline


--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2009.08.21 10:32:22 -0400, Alan Stern wrote:
> > > Could you try with this one? And what's your gfx chip?
>=20
> 00:02.0 VGA compatible controller: Intel Corporation 82845G/GL[Brookdale-=
G]/GE Chipset Integrated Graphics Device (rev 03)
>=20
> I don't think this will help.  The state _is_ getting saved, so saving
> it again won't make any difference.  The problem occurs because the
> state is restored at the wrong time.

oh, that's old chip, it looks later chip doesn't have this problem.

>=20
> > diff --git a/drivers/gpu/drm/i915/i915_drv.c b/drivers/gpu/drm/i915/i91=
5_drv.c
> > index fc4b68a..f54880f 100644
> > --- a/drivers/gpu/drm/i915/i915_drv.c
> > +++ b/drivers/gpu/drm/i915/i915_drv.c
> > @@ -95,7 +95,11 @@ static int i915_resume(struct drm_device *dev)
> >  	int ret =3D 0;
> > =20
> >  	pci_set_power_state(dev->pdev, PCI_D0);
> > -	pci_restore_state(dev->pdev);
> > +	/* XXX as pci layer should have already early restore state
> > +	   for us, or intel_agp driver has taken care of reconfigure,
> > +	   we don't need to restore again here, which might corrupt
> > +	   reconfigured state...*/
> > +	/* pci_restore_state(dev->pdev); */
> >  	if (pci_enable_device(dev->pdev))
> >  		return -1;
> >  	pci_set_master(dev->pdev);
>=20
> And I don't think this will help since I don't have a 915 controller.
>=20

This's only for other possible graphics problem involved in suspend/resume,
and drm/i915 should also work for your 845G. ;)

--=20
Open Source Technology Center, Intel ltd.

$gpg --keyserver wwwkeys.pgp.net --recv-keys 4D781827

--NDin8bjvE/0mNLFQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkqR7UgACgkQsQQaM014GCcffQCeOt3It4HCNXzhZUAY18/I4fe/
S4EAn3lS0blEoS3QhyfgxWU0vBOgymg4
=M29+
-----END PGP SIGNATURE-----

--NDin8bjvE/0mNLFQ--

--===============8818703339928089711==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8818703339928089711==--
