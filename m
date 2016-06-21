From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v12 1/4] gadget: Introduce the usb charger framework
Date: Tue, 21 Jun 2016 13:25:12 +0300
Message-ID: <87eg7qon3r.fsf@linux.intel.com>
References: <cover.1466497505.git.baolin.wang@linaro.org> <831e03e8935b4c62e1e6bf94c93e0a08a73d89b2.1466497505.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <831e03e8935b4c62e1e6bf94c93e0a08a73d89b2.1466497505.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: robh@kernel.org, jun.li@nxp.com, m.szyprowski@samsung.com, ruslan.bilovol@gmail.com, peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, lee.jones@linaro.org, broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, baolin.wang@linaro.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Baolin Wang <baolin.wang@linaro.org> writes:
> This patch introduces the usb charger driver based on usb gadget that
> makes an enhancement to a power driver. It works well in practice but
> that requires a system with suitable hardware.
>
> The basic conception of the usb charger is that, when one usb charger
> is added or removed by reporting from the usb gadget state change or
> the extcon device state change, the usb charger will report to power
> user to set the current limitation.
>
> The usb charger will register notifiees on the usb gadget or the extcon
> device to get notified the usb charger state. It also supplies the
> notification mechanism to userspace When the usb charger state is changed.
>
> Power user will register a notifiee on the usb charger to get notified
> by status changes from the usb charger. It will report to power user
> to set the current limitation when detecting the usb charger is added
> or removed from extcon device state or usb gadget state.
>
> This patch doesn't yet integrate with the gadget code, so some functions
> which rely on the 'gadget' are not completed, that will be implemented
> in the following patches.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> Reviewed-by: Li Jun <jun.li@nxp.com>
> Tested-by: Li Jun <jun.li@nxp.com>
> ---
>  drivers/usb/gadget/Kconfig       |    7 +
>  drivers/usb/gadget/udc/Makefile  |    1 +
>  drivers/usb/gadget/udc/charger.c |  770 ++++++++++++++++++++++++++++++++=
++++++
>  include/linux/usb/charger.h      |  191 ++++++++++
>  include/uapi/linux/usb/charger.h |   31 ++
>  5 files changed, 1000 insertions(+)
>  create mode 100644 drivers/usb/gadget/udc/charger.c
>  create mode 100644 include/linux/usb/charger.h
>  create mode 100644 include/uapi/linux/usb/charger.h
>
> diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
> index 2057add..89f4e9b 100644
> --- a/drivers/usb/gadget/Kconfig
> +++ b/drivers/usb/gadget/Kconfig
> @@ -134,6 +134,13 @@ config U_SERIAL_CONSOLE
>  	help
>  	   It supports the serial gadget can be used as a console.
>=20=20
> +config USB_CHARGER
> +	bool "USB charger support"

you didn't build test all possibilities, did you?

I have a feeling this won't link if USB_GADGET=3Dm. Can you test that?

> diff --git a/drivers/usb/gadget/udc/charger.c b/drivers/usb/gadget/udc/ch=
arger.c
[...]
> +struct class *usb_charger_class;

We already have a UDC class, do we really, really need another class
here?

> +subsys_initcall(usb_charger_class_init);

this should always work as module_init(). Please make sure that's the
case.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXaRYJAAoJEIaOsuA1yqREg7YP/jvqts69sdsMx/vGlcpAvkpU
MGQGlsnuCTPU+MUlBC0g5H2O7fEr9bxf4VN0jXJqRgwlqq2OjBs/Kbvl65mCohHg
s6GggLH0qhk5YWAXIxZfKTurKL6eLZ8IclgAlUA253i5bt15vFOvM94a40J8zFRC
+CU3AM9uGsI85ern6BSgSoZTtQ3T6A4eM3szv/4rX5FhlRJirMRrFbHrvZnwoQPx
BWFs0E13QDLl+i6jUnGverQ6Lw7bU7qVSje6n1rClIe5OqqjN0ERIg90TdhiiUTN
fyaam18/iBbyvblmX31c1hIqruR/ZNHVLcbN8zah78YuEyiQ7FrFErP5toE22AVF
citWRxMnrBG2F+o/XwG4k+wMjCRPtSgQ34RbwryQ6aBbYaC8NxSzygjMNaRzIOga
9QhT1jPA+OFOi4tdPi2+PSGzkJ8tb4a/FHdvsXOMdKrddkXsVkM8pTGkhWa8eyo7
tECjEXckZ5ru2v/D+2M2d342Xzi7UcaoUwMnv3ij2yVsSM9DoofcL04YOoeICVAo
w0yh/n6XIYANfMbTXatw3yfvNpxZ5tunb2OzBKZERGqmFCKsIE8SuVrbl+uoH7SO
2oGPQKnkcCNBidxUvPHSFiSzOg0smD0wmPAheG0y46i30I5Y1SogHaf3tQl6hogO
vjIAU1P7iRObBNZruLsw
=EPSt
-----END PGP SIGNATURE-----
--=-=-=--
