From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v12 2/4] gadget: Support for the usb charger framework
Date: Tue, 21 Jun 2016 13:27:50 +0300
Message-ID: <87bn2uomzd.fsf@linux.intel.com>
References: <cover.1466497505.git.baolin.wang@linaro.org> <f7bae2566824a5e1da14c1a19dee6af5f250262f.1466497506.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f7bae2566824a5e1da14c1a19dee6af5f250262f.1466497506.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: robh@kernel.org, jun.li@nxp.com, m.szyprowski@samsung.com, ruslan.bilovol@gmail.com, peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, lee.jones@linaro.org, broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, baolin.wang@linaro.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Baolin Wang <baolin.wang@linaro.org> writes:
> For supporting the usb charger, it adds the usb_charger_init() and
> usb_charger_exit() functions for usb charger initialization and exit.
>
> It will report to the usb charger when the gadget state is changed,
> then the usb charger can do the power things.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> Reviewed-by: Li Jun <jun.li@nxp.com>
> Tested-by: Li Jun <jun.li@nxp.com>

Before anything, I must say that I really liked this patch. It's
minimaly invasive to udc core and does all the necessary changes. If it
wasn't for the extra charger class, this would've been perfect.

Can't you just tie a charger to a UDC and avoid the charger class
completely?

>  static inline int usb_gadget_vbus_draw(struct usb_gadget *gadget, unsign=
ed mA)
>  {
> +	if (gadget->charger)

I guess you could do this check inside
usb_gadget_set_cur_limit_by_type() itself.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXaRamAAoJEIaOsuA1yqRExuIP/j2IikJOFNIX7M+ixwED8poJ
1ukutmtQAi012IIMk/GHNKttXC7IxsE7zD+WveLjBPh0oLv1BvtXoOs1ryzQdH3C
66eSJ4k0z9bnm6g7nKX6KqZa44ukodJHDRTnhMGcmscyBLqQGxQXM6HS1NOt60T4
Ggr96g2eL6oU+OJYM/e08jpd79lusO/AXzjPZs/fmVWiPFgujFJXgHNpo7+46fTJ
HyiCn0s0O+yrLWp8ceinlT+5Sbchk+uGfM+wK2ORwvBdfR+WSqUeA+zn5oj/8D6H
mZzM1TfT6jvis+rGrrpnNL4+NtwYNPKMTbZsqNRjg0d+h78xzPUPki7wV1KKk+yS
PZZb10RqMMLyAbnr5kKW0JMIP5pW1Bl33V2/rf2EEJbuEO+/EXUVHalqdV5DZu+1
JE7qXR3CYrGEIcCIH6oeytrArPVX7n7gCl4+FOIDdnlGTGLJ+bwG7bB+XPvMpLGU
gEAzFtSG5tyau+lvpqGWeiE8okJwYAcxWLGRVvHWS5wcsfVKwFQocA6crlmZZ/Ih
BIx6WGZRpb9hElg8V7fbThFeYghXm9hd3R4B+k5brWjeynmE5XmJ7IdReU6+AfS5
qt1CTI+/GUDP9mTopcbf5sfGjCl4nd2yg5+KcHMLC/BUFiYwSYUq3RjC4YOyJgcW
NrtLOeGQCZeyy/G6M6Q/
=dgJQ
-----END PGP SIGNATURE-----
--=-=-=--
