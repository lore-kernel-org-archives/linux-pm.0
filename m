From: Benson Leung <bleung@google.com>
Subject: Re: [PATCH v2 1/2] power: supply: add input voltage limit property.
Date: Mon, 3 Dec 2018 11:58:45 -0800
Message-ID: <20181203195845.GA120704@google.com>
References: <20181122101119.29194-1-enric.balletbo@collabora.com>
 <20181123232203.GA3852@amd>
 <c122a1f9-70d7-7129-f139-4a0449c366a5@collabora.com>
 <20181201150934.GA7052@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181201150934.GA7052@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-pm@vger.kernel.org, sre@kernel.org, Sameer Nanda <snanda@chromium.org>, gwendal@chromium.org, linux-kernel@vger.kernel.org, groeck@chromium.org, Adam.Thomson.Opensource@diasemi.com, kernel@collabora.com, bleung@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, bleung@google.com
List-Id: linux-pm@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

On Sat, Dec 01, 2018 at 04:09:34PM +0100, Pavel Machek wrote:
> > I think that handle this via dt / ACPI is not possible for our use case=
=2E It can
> > be a hardware bug or a hardware/user constrain, let me try to explain b=
etter
> > with an example.
> >=20
> > On Pixel C's devices, userspace uses this to set a USB input limit of 5=
V when
> > the screen is on for thermal reasons, but those go away when the screen=
 is
> > off/system is sleeping, so we allow 9V and 12V levels when sleeping.
>=20
> So, on pixel C, what happens if userland ignores the constraint, keeps
> display on and sets charger to 12V?

I was the software tech lead for the Google Pixel C and was involved in this
particular code change in 2015 before the release of the product.

So there's nothing fundamentally broken about the hardware that would cause
the Pixel C to malfunction if we were charging at 9V or 12V instead of 5V
when the screen is on, ie if userspace doesn't change this.

This is part of the Pixel C's thermal management strategy to effectively
limit the input power to 5V 3A when the screen is on. When the screen is on,
the display, the CPU, and the GPU all contribute more heat to the system
than while the screen is off, and we made a tradeoff to throttle the charger
in order to give more of the thermal budget to those other components.

What would happen is that you wouldn't meet Google's skin temperature targe=
ts
on the system if the charger was allowed to run at 9V or 12V with the screen
on.

For folks hacking on Pixel Cs (which is now outside of Google's official su=
pport
window for Android) and customizing their own kernel and userspace
this would be acceptable, but we wanted to expose this feature in the power
supply properties because the feature does exist in the Emedded Controller
firmware of the Pixel C and all of Google's Chromebooks with USB-C made sin=
ce
2015 in case someone running an up to date kernel wanted to limit the charg=
ing
power for thermal or other reasons.

Thanks,
Benson

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlwFivIACgkQHwn1ewov
5lg8+hAAkU3bSc1yCGH1bSwmoNTjpDQHMs/45GRZKQsgfDOKkraVTOm2BM5WriGQ
r5fB85winldp6rdghBT9Epa+zVNYEANaQwcesgoWhgbaqBhpRdyXFLyWLVsGCg/8
2mqfJri7T/uRGLzwFlLVwJwJk/5OrzaNPVPDBTHdfpVirSeYdU34QdiNeDP/TQ8n
TtWE//JApbXb9vB+F+QKlrrU6ImIm0jrukAM6eR+chi8rXPAt2TW1cmlb9JcJxDg
1h9U1uRevKat7zXZ64+LPayQ7R9v64oUMIeKSHapgCXrOqCL0PDlcI4wbVhdK1Cn
h39OEGmhoaub/csJLkUSrn/wjKoLg39edefcZ+sQ5BPosWDrAmvCHh0fZoqKsjfv
Zi3dHFw4qgp/O3vpkvJMcRgpN621FWnNCG7/pRBgr3W+L6HlTXW1s+WADzSkgbzW
4A40LDTWB/4trGv/CKSZgTX93AZhmj7GNdVZyr/XUfKIZWcaNQhMHAPTYttLtFbp
X9jN0YGZvIQ+JaZQyGqEYDxm3rOiidRf40LPrMpoza93npG6FIeGDvAa42XfllHk
AWnmJDxusgJb+oZmKIQMAe9k2jHxafSqzCFjnH57T/6vD1Tn5YYmqJy+b4gAbI83
9IexSFTWAyAbwYg+/pRzcaUnzKCYirLxJSe+585uWEcoilITZ0c=
=Rk1S
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
