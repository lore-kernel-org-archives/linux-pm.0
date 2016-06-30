From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v14 1/4] usb: gadget: Introduce the usb charger framework
Date: Thu, 30 Jun 2016 13:30:40 +0300
Message-ID: <87y45nezov.fsf@linux.intel.com>
References: <cover.1467264233.git.baolin.wang@linaro.org> <374f15d1aa524a1550ebf757d3e14adba5680c5d.1467264233.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:62768 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752053AbcF3Kbc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 30 Jun 2016 06:31:32 -0400
In-Reply-To: <374f15d1aa524a1550ebf757d3e14adba5680c5d.1467264233.git.baolin.wang@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: gregkh@linuxfoundation.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: robh@kernel.org, jun.li@nxp.com, m.szyprowski@samsung.com, ruslan.bilovol@gmail.com, peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, lee.jones@linaro.org, broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, baolin.wang@linaro.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Baolin Wang <baolin.wang@linaro.org> writes:
> +static ssize_t charger_state_show(struct device *dev,
> +				  struct device_attribute *attr,
> +				  char *buf)
> +{
> +	struct usb_charger *uchger =3D dev_to_uchger(dev);
> +	int cnt;
> +
> +	switch (uchger->state) {
> +	case USB_CHARGER_PRESENT:
> +		cnt =3D sprintf(buf, "%s\n", "PRESENT");
> +		break;
> +	case USB_CHARGER_REMOVE:
> +		cnt =3D sprintf(buf, "%s\n", "REMOVE");
> +		break;
> +	default:
> +		cnt =3D sprintf(buf, "%s\n", "UNKNOWN");
> +		break;

are these the only states we need? Don't we need at least "CHARGING" and
"ERROR" or something like that? Maybe those are exposed elsewhere,
dunno.

> +static int __usb_charger_set_cur_limit_by_type(struct usb_charger *uchge=
r,
> +					       enum usb_charger_type type,
> +					       unsigned int cur_limit)
> +{
> +	if (WARN(!uchger, "charger can not be NULL"))
> +		return -EINVAL;

IIRC, I mentioned that this should assume charger to be a valid
pointer. Look at this, for a second:

You check that you have a valid pointer here...

> +int usb_charger_set_cur_limit_by_type(struct usb_charger *uchger,
> +				      enum usb_charger_type type,
> +				      unsigned int cur_limit)
> +{
> +	int ret;
> +
> +	if (WARN(!uchger, "charger can not be NULL"))
> +		return -EINVAL;

... and here, before calling the other function. This is the only place
which should check for valid uchger.

> +	mutex_lock(&uchger->lock);
> +	ret =3D __usb_charger_set_cur_limit_by_type(uchger, type, cur_limit);
> +	mutex_unlock(&uchger->lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(usb_charger_set_cur_limit_by_type);
> +
> +/*
> + * usb_charger_set_cur_limit() - Set the current limitation.
> + * @uchger - the usb charger instance.
> + * @cur_limit_set - the current limitation.
> + */
> +int usb_charger_set_cur_limit(struct usb_charger *uchger,
> +			      struct usb_charger_cur_limit *cur_limit_set)
> +{
> +	if (WARN(!uchger || !cur_limit_set, "charger or setting can't be NULL"))
> +		return -EINVAL;

I can see a pattern here. Not *all* errors need a splat. Sometimes a
simple pr_err() or dev_err() (when you have a valid dev pointer) are
enough.

> diff --git a/include/linux/usb/charger.h b/include/linux/usb/charger.h
> new file mode 100644
> index 0000000..d2e745e
> --- /dev/null
> +++ b/include/linux/usb/charger.h
> @@ -0,0 +1,164 @@
> +#ifndef __LINUX_USB_CHARGER_H__
> +#define __LINUX_USB_CHARGER_H__
> +
> +#include <uapi/linux/usb/ch9.h>
> +#include <uapi/linux/usb/charger.h>
> +
> +#define CHARGER_NAME_MAX 30
> +
> +/* Current limitation by charger type */
> +struct usb_charger_cur_limit {
> +	unsigned int sdp_cur_limit;
> +	unsigned int dcp_cur_limit;
> +	unsigned int cdp_cur_limit;
> +	unsigned int aca_cur_limit;
> +};
> +
> +struct usb_charger_nb {
> +	struct notifier_block	nb;
> +	struct usb_charger	*uchger;
> +};
> +

please add KernelDoc here. And mention the fields which aren't supposed
to be accessed directly but should rely on the accessor functions. At
least type and state prefer to be accessed by their respective
getter/setter methods.

> +struct usb_charger {
> +	char			name[CHARGER_NAME_MAX];
> +	struct list_head	list;
> +	struct raw_notifier_head	uchger_nh;
> +	/* protect the notifier head and charger */
> +	struct mutex		lock;
> +	int			id;
> +	enum usb_charger_type	type;
> +	enum usb_charger_state	state;
> +
> +	/* for supporting extcon usb gpio */
> +	struct extcon_dev	*extcon_dev;
> +	struct usb_charger_nb	extcon_nb;
> +
> +	/* for supporting usb gadget */
> +	struct usb_gadget	*gadget;
> +	enum usb_device_state	old_gadget_state;
> +
> +	/* for supporting power supply */
> +	struct power_supply	*psy;
> +
> +	/* user can get charger type by implementing this callback */
> +	enum usb_charger_type	(*get_charger_type)(struct usb_charger *);
> +	/*
> +	 * charger detection method can be implemented if you need to
> +	 * manually detect the charger type.
> +	 */
> +	enum usb_charger_type	(*charger_detect)(struct usb_charger *);
> +
> +	/* current limitation */
> +	struct usb_charger_cur_limit	cur_limit;
> +	/* to check if it is needed to change the SDP charger default current */
> +	unsigned int		sdp_default_cur_change;
> +};

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXdPTRAAoJEIaOsuA1yqREt8gP+wfzh+qUcwaOs3eb1p3LoNAv
qEJxlEMCXyJZhzM2cN5IBrE69qgCZ6F0YoL9plMDMMacRvRcFsx4Xh2zJnZW46Iw
SwEch+nK+tZM6eWxg6U+cEkRbGdaNHZnVBAvdRWJI5U9Vh//N2WWba1a6v7Ayqkh
0KLedXOb4elV1WmEMBOiiE2cFxtAEFlO847JhDA3mn5T93yt1YpzHPtTnGUItl4W
xYQq2w8dwlxgLHdtdQ8cbUMFlOQNK/e3kQ1YrJCE6Obsln+cKE/1mF6V9IIh55fI
1r63jIEy1mUuklFSrsCl3TLJmQj6vOX7OXjKM6JrtGB4LWWzPG47lHzaeGFDZeQa
EUaFDUKWfjKGJHiwvPj4aDIcNxEZISGDdTvGO6lBAlq5CP/5YgapQtAQ9eMABnkm
oIY9XBT7odWnI5+8QRM40iOZT7mn6KEQenE8KE5ARHGS8X8htlAQmIYGlcMfTPUj
vaaQ8BnLEG11SGHO1hb73+XwD9hVBKVMvkaXVXBd4TY5I8H+guuZIuJQ/3cTtpva
lN7nKYN6E2VvKGwBhMJ5zIYPhmuJgyGLLwTDSb59FF+SF0eWkDR5znWRs2wPqqLk
Arw/U+/ECZYcC46eUSF8oBN7cQofJMXR/AmxtVYEIQ/wpl5hUFvU3myFi2kdlbzM
Dozw/JR1YkmZeSs8m+vy
=PGPo
-----END PGP SIGNATURE-----
--=-=-=--
