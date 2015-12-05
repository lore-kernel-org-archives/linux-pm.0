From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] power: qcom_smbb: Add otg regulator for control of vbus
Date: Sat, 5 Dec 2015 17:07:18 +0100
Message-ID: <20151205160717.GA30410@earth>
References: <1445548337-14612-1-git-send-email-tim.bird@sonymobile.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1445548337-14612-1-git-send-email-tim.bird-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tim Bird <tim.bird-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tbird20d-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tim,

On Thu, Oct 22, 2015 at 02:12:17PM -0700, Tim Bird wrote:
> Add a regulator to control the OTG chargepath switch.  The OTG
> switch gets its power from pm8941_5vs1, and that should be expressed
> as an usb_otg_in-supply property in the DT node for the charger driver.
> The regulator name is "otg".  This is used by USB code to control VBUS
> direction.

I could not find a newer version of this patch with the comments
=66rom Mark being fixed. Did I miss anything?

-- Sebastian

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWYwuyAAoJENju1/PIO/qakHIQAIgJfPsKIgeYWdGhp4LWxeNq
MmEaKGkFcjROo4G0YThs7lAj7cl/XMWxwA3V+gZsrFmPwBVBW4yMtNNXPbbmWRBp
fGasCytZvF+LvDRYKFRglEmA6nbeplbj2eZJsFGUUhWjWjC1yNmiAe0HAjZ3hsEV
ef7D/kgcvREL/OFvkwfHvTyBvUX5hKhP4BtUJij7GJ+xA8M9IuGfGPNU8uftafLU
VNP1lIUY0RIUql+rPYCw735vZGJ7jgJ2Ko4K4hYlCroc8Aj6/7KQZcI5Zqskhz90
FA3lFasMYqzAGf00HzDECK0q76A33qZaPGr4CRn4+G4KErw1wDH8b3zpwneRSTRD
JKSmkORMX9Ax4egLqiAHvNt6xsCfq6wgLcgMN/PAz81rOeMTjQNhayEYUMqfAFBd
YOmrSxSDrs74OplIBiiCAavS3aEP3edZiqCW+0wTgU/mir4rKQchhFZ0yLedsKVX
5Gc2UdqD7WWCroFda2Q4QtIZaFUDH/1K/M5Si7Lg4WR9/S1rZy/o1iN53JuPY9yf
c2O5w1JUs/ygXjQDq/gsqOgdYmXOgOdcFB6mCIXE4M5d1HjmkoU/1I0DzdCl6vyx
cPJA6RzwmRSk/GBKDsSk11Voa/mj4sQrCtgcEygjr/ZPs0uy891nFJXc0BlsKbuS
6zBGFhgfuKUnvM9TeJGn
=+AZf
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
