From: Andrey Rahmatullin <wrar@wrar.name>
Subject: Re: ehci_hcd related S3 lockup on ASUS laptops, again
Date: Thu, 12 Apr 2012 21:37:50 +0600
Message-ID: <20120412153750.GA12852@belkar.wrar.name>
References: <1334193773.23924.316.camel@gandalf.stny.rr.com>
	<Pine.LNX.4.44L0.1204121017460.1496-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9154039236006845345=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1204121017460.1496-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: jrnieder@gmail.com, Greg KH <greg@kroah.com>, linux-pm@lists.linux-foundation.org, USB list <linux-usb@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>
List-Id: linux-pm@vger.kernel.org


--===============9154039236006845345==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 12, 2012 at 10:28:31AM -0400, Alan Stern wrote:
> > > > > I replaced the hcd_pci_suspend_noirq call with retval=3D0 and sus=
pend/resume
> > > > > was successful.
> > > > =20
> > > > This indicates that your computer doesn't like to suspend while the
> > > > EHCI controllers are in D3hot.  I have no idea why not.
> > > >=20
> > > > If you want a really thorough test, try changing=20
> > > > drivers/pci/pci-driver.c:pci_pm_suspend_noirq.  In the "if (!pm)"=
=20
> > > > clause, add a call to
> > > >=20
> > > > 	pci_prepare_to_sleep(pci_dev);
> > > >=20
> > > > just after the pci_save_state line.  Then try suspending with the=
=20
> > > > script enabled (ehci-hcd unbound from the controllers).  If this fa=
ils=20
> > > > then we'll know it is the source of the trouble.
> > > Looks like it works even with this line added.
> > >=20
> >=20
> > I reverted the retval change (that worked) and added this line. Put the
> > script back and did a suspend. The suspend and resume worked without
> > issue.
>=20
> Hmmm.  This is a situation where the wakeup setting might matter.  Did=20
> the /sys/bus/pci/devices/0000:00:1[ad].0/power/wakeup files both=20
> contain "enabled" when you ran the test?
Yes.

> Here's a diagnostic patch that will give us a little more information. =
=20
> Keep the previous change (so that pci_prepare_to_sleep gets called=20
> whether ehci-hcd is bound or not) and let's see what it says.  Try=20
> doing it both with and without ehci-hcd bound.  Running this with "echo=
=20
> devices >/sys/power/pm_test" ought to be good enough.
I don't see that line with ehci_hcd both bound and unbound and both in
'devices' test and in a real S3.

> Index: usb-3.4/drivers/pci/pci.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- usb-3.4.orig/drivers/pci/pci.c
> +++ usb-3.4/drivers/pci/pci.c
> @@ -1720,6 +1720,9 @@ int pci_prepare_to_sleep(struct pci_dev
> =20
>  	error =3D pci_set_power_state(dev, target_state);
> =20
> +	dev_info(&dev->dev, "target %d wakeup %d error %d\n",
> +			target_state, device_may_wakeup(&dev->dev), error);
> +
>  	if (error)
>  		pci_enable_wake(dev, target_state, false);
> =20
>=20
>=20

--=20
WBR, wRAR

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPhvbOAAoJEDNi9wMaSZLhrKMP/0Nq/dM5bX4f6xfDrUJl13J+
S1QsXR7BWoQt+b4WN4Nf8fEB3gunwOguRx1Z+f8GEp5S2R1HFy08tcW5vOMjYrqn
gtdbgvoZSMU4vu8cuZ7GM+oeORxsCDjFkQWCYwv6kTBITR7vEWa16mF6ppXNhReZ
f6sNyooETrpDOwxeBN3YHY02qAiYzE1PCRyw0s5VGPkkYH3Py3uaM7FXGN1m6IUY
QcAeJUCt36ROzhwS/ZsgL+0lRU2x7pmn9RfrfduHBghcBCriMCHS6jB41Cas4xZn
zkDd3ckDf9poMmIVMXff9IokGWbOkEyRXCRs6KDRIW69uYJmXYHxzuJrnKgkTjdq
9sC8pSPDZpXUnmuNNQEKKKSS4UUaVyDV3ilXJuUc8gOEval/Cc/LvmzryYFZ8x1w
jQg7RLRaYPu2aSU5dolc0yx4TdO7HNraswGnbpyRvD4U+VQoT8rMc65xV/muxcTb
vas+iXwfsHFn7zHZTnDKV5VjYJe1OI5DXW5A2x2iqlZ2WHcVw8Pq0e3OtUuwpnJC
cBfM4is5+BsTzuirhg8liA7J9pH3kvqtG5YIgft+TdaCBj7G9Uv0EseWH/SqK2KP
5b5psonMFknVaEfA5aVVKnZr2Q8XYKCpLSINhTcSCF8bVyt7G8xjNSQneT+jRynF
hEqTNVz++k8C2IcB9W5i
=0mMa
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--

--===============9154039236006845345==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9154039236006845345==--
