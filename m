From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v4 1/5] gadget: Introduce the notifier functions
Date: Thu, 1 Oct 2015 12:29:32 -0500
Message-ID: <20151001172932.GG4469@saruman.tx.rr.com>
References: <cover.1443057229.git.baolin.wang@linaro.org>
 <e58e4f26028c37877d02907831cf4ae411eaf984.1443057231.git.baolin.wang@linaro.org>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="svZFHVx8/dhPCe52"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50168 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751336AbbJARaV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 1 Oct 2015 13:30:21 -0400
Content-Disposition: inline
In-Reply-To: <e58e4f26028c37877d02907831cf4ae411eaf984.1443057231.git.baolin.wang@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: balbi@ti.com, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, gregkh@linuxfoundation.org, peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, sojka@merica.cz, yoshihiro.shimoda.uh@renesas.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, sameo@linux.intel.com, lee.jones@linaro.org, ckeepax@opensource.wolfsonmicro.com, broonie@kernel.org, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, device-mainlining@lists.linuxfoundation.org

--svZFHVx8/dhPCe52
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2015 at 10:39:23AM -0700, Baolin Wang wrote:
> The usb charger framework is based on usb gadget. The usb charger
> need to be notified the state changing of usb gadget to confirm the
> usb charger state.
>=20
> Thus this patch adds a notifier mechanism for usb gadget to report a
> event to usb charger when the usb gadget state is changed.
>=20
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  drivers/usb/gadget/udc/udc-core.c | 32 ++++++++++++++++++++++++++++++++
>  include/linux/usb/gadget.h        | 18 ++++++++++++++++++
>  2 files changed, 50 insertions(+)
>=20
> diff --git a/drivers/usb/gadget/udc/udc-core.c b/drivers/usb/gadget/udc/u=
dc-core.c
> index f660afb..4238fc3 100644
> --- a/drivers/usb/gadget/udc/udc-core.c
> +++ b/drivers/usb/gadget/udc/udc-core.c
> @@ -129,6 +129,32 @@ void usb_gadget_giveback_request(struct usb_ep *ep,
>  }
>  EXPORT_SYMBOL_GPL(usb_gadget_giveback_request);
> =20
> +int usb_gadget_register_notify(struct usb_gadget *gadget,
> +			       struct notifier_block *nb)
> +{
> +	int ret;
> +
> +	mutex_lock(&gadget->lock);
> +	ret =3D raw_notifier_chain_register(&gadget->nh, nb);
> +	mutex_unlock(&gadget->lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(usb_gadget_register_notify);
> +
> +int usb_gadget_unregister_notify(struct usb_gadget *gadget,
> +				 struct notifier_block *nb)
> +{
> +	int ret;
> +
> +	mutex_lock(&gadget->lock);
> +	ret =3D raw_notifier_chain_unregister(&gadget->nh, nb);

Greg, this is the kind of thing I wanted to avoid adding more of.

I was wondering if you would accept subsystems using kdbus for
this sort of notification. I'm okay waiting for kdbus for another
couple merge windows (if we have to) before that's merged, but
if we take this raw notifier approach now, we will end up having
to support it forever.

Also, because soon enough we will have to support USB Power Delivery
with Type C connector, this is bound to change in the coming months.

Frankly, I wanted all of this to be decided in userland with the
kernel just providing notification and basic safety checks (we don't
want to allow a bogus userspace daemon frying anybody's devices).

How would you feel about that ?

--=20
balbi

--svZFHVx8/dhPCe52
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWDW18AAoJEIaOsuA1yqREWg8QAKJtPxCRgtkw+LHi+DDcBVV4
Z8o1OtHq0wJAknKMoKg9T90XxbwJi8A6/XRYK4whZypwi2zZ3rdD5T0mtfw9H8tc
jP2qd2Wd7AnXuzsmUEOljuUeHfrkFaaJE/nEGdZ4CZjeAJC2nAuGsuB83NrA8b2x
tqplEK7+coolcFCvjokFsFqQdvscnCQcsMaUzuTiiHAxSt5W060xdUSKdp7QAaI/
qkQizt4IWfy9j4DgiMGFWQ7WB/IWXdpLfyOCM9nhH9lPIl5RPPp5mv3pzcWBKij0
w/0cXlO3XM/wzKG+AVVkdPreTrENf35h3j7SJegKrvLRqRhM2OURmwOcFmfjU0Aw
pieJsbekLAV3fpKT0BRipS0SVQuXbSlBouxPk4DIS4DK6iresPUyPha6hj2z6zMd
ktPWZTOl2iQIiRZOj+oBUkr/SBdNA5IDE1Ab1/tPYfRjwFCmZ6c2qk4pJSiHNIgk
wDd8p4N0VwbV8fyS+ngYGL7ZBwPU7YlT4K7uSs46AHWHVw6GN555xOjouLK04gTh
WZO+FuolmeCBzTo6MbK18mw78DQRi09W3y1/kY7B6OxBrCxNNDnNzbDOfFW1dZfu
j6dKmgKWsnO7VdsLiw/8P9MtqZpzlsaWxYpZ/w9oE4S3U0kMUVxu1ggGXwna68O7
jYgBbZrJYp17BJr8rPgV
=6hV/
-----END PGP SIGNATURE-----

--svZFHVx8/dhPCe52--
