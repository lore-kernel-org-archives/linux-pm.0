From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] power_supply: rt9455_charger: Check if CONFIG_USB_PHY is
 enabled
Date: Wed, 3 Jun 2015 15:20:55 +0200
Message-ID: <20150603132054.GA18181@earth>
References: <1433321223-19442-1-git-send-email-anda-maria.nicolae@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1433321223-19442-1-git-send-email-anda-maria.nicolae-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Anda-Maria Nicolae <anda-maria.nicolae-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Anda-Maria,

On Wed, Jun 03, 2015 at 11:47:03AM +0300, Anda-Maria Nicolae wrote:
> If CONFIG_USB_PHY is not enabled, struct notifier_block is not defined and
> compilation fails. Therefore, the functions that process USB event
> notifications are defined only if CONFIG_USB_PHY is enabled.
> There is no need to define these functions if CONFIG_USB_PHY is not
> enabled, since no USB notifications are received in this case.
> Also, since rt9455_set_boost_voltage_before_boost_mode() function is
> called only if USB_EVENT_ID notification is received, this function should
> also be defined only if CONFIG_USB_PHY is enabled.

Thanks, queued for 4.2.

-- Sebastian

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVbv80AAoJENju1/PIO/qaF+UP/0JR+CtIfOxjyg6GathzQZhr
l6DHkNgPwjsokSqVSEx33BpXe9745+NMSc1aNEN9dIedK/MQMovKSCP/xGHucGwc
TpeFq4VjWG4kSrbCAulJHT4cD6ZiVg9ZlU5zbOv0iCgIYFhw+jJ6X/SU5vb/nVrp
b6KHjLcohTYqg1oVhSIAMYxuZT1mReZoYoIS0fBHAJg0ZP1gDCIOGba9O57TwOeK
yg5SMmzB8B4nCmszkjfdyzcz8/8v2nuNbrPPd6ebmP/LyavNj2s59dNOxBe3BgOZ
ofHtIjf84FmPYFjn9J2nWZr4t+bLrCy8wbdLkitUM9VZxzW90lB03uY+o43wDWc6
BndBnWTAHEQLeZOQFa3PmAiUUbN7bao81xjKr8SuXtJh5lF/ILVpJCu2jxwGQahY
Ne2c21TFiGGvsmdtyd9/C7a9u1Sg+sp/5UWKNWMN6wj5nPK/gmA4JTCsfmVdO5pd
t6hFxyiO1mlE82acdCdp+Uikbofipz3ctceE3ZBRyl1o1vUDa1Q9YnnXZeMPriC5
RsCfQgvfybwJKksnqIy3Ds02tsZL7VsC0L4RDXF2qYNiSjojcJqG4NpxC9Xa3EUc
QcRKvEcUVCdUUYSeu5rhVA1Z9ERUhwUPN07AX9MxAo5rgE48rHxZq5EQJ1+6Ozg5
rhjSf2+ixr/A4XAGuVIm
=KecI
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
