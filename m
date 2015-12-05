From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v6 1/4] gadget: Introduce the usb charger framework
Date: Sat, 5 Dec 2015 17:27:21 +0100
Message-ID: <20151205162721.GB30410@earth>
References: <cover.1447654605.git.baolin.wang@linaro.org>
 <2ae29947ff92198d5613bfb2b925f3f4ba3b2a53.1447654606.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i0/AhcQY5QxfSsSZ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2ae29947ff92198d5613bfb2b925f3f4ba3b2a53.1447654606.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: balbi@ti.com, gregkh@linuxfoundation.org, dbaryshkov@gmail.com, dwmw2@infradead.org, peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, yoshihiro.shimoda.uh@renesas.com, lee.jones@linaro.org, broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--i0/AhcQY5QxfSsSZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Mon, Nov 16, 2015 at 02:33:31PM +0800, Baolin Wang wrote:
> +static ssize_t cur_limit_show(struct device *dev,
> +			      struct device_attribute *attr,
> +			      char *buf)
> +{
> +	struct usb_charger *uchger = dev_to_uchger(dev);
> +
> +	return scnprintf(buf, PAGE_SIZE, "%d %d %d %d\n",
> +			 uchger->cur_limit.sdp_cur_limit,
> +			 uchger->cur_limit.dcp_cur_limit,
> +			 uchger->cur_limit.cdp_cur_limit,
> +			 uchger->cur_limit.aca_cur_limit);
> +}
> +
> +static ssize_t cur_limit_store(struct device *dev,
> +			       struct device_attribute *attr,
> +			       const char *buf, size_t count)
> +{
> +	struct usb_charger *uchger = dev_to_uchger(dev);
> +	struct usb_charger_cur_limit cur;
> +	int ret;
> +
> +	ret = sscanf(buf, "%d %d %d %d",
> +		     &cur.sdp_cur_limit, &cur.dcp_cur_limit,
> +		     &cur.cdp_cur_limit, &cur.aca_cur_limit);
> +	if (ret == 0)
> +		return -EINVAL;
> +
> +	ret = usb_charger_set_cur_limit(uchger, &cur);
> +	if (ret < 0)
> +		return ret;
> +
> +	return count;
> +}
> +static DEVICE_ATTR_RW(cur_limit);

I think this functionality should be provided with one file per
type. This makes it easier to parse the values from userspace
and makes it possible to extend the frameworks functionality
(e.g. when new types are added in a newer revision of the USB
standard).

-- Sebastian

--i0/AhcQY5QxfSsSZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWYxBmAAoJENju1/PIO/qaB9UQAJ51S+/sdRRob7W76WIWew/R
u0B9tMQxEzNaSP0YfjiW1A7y/L4LRlYJzGnVy41uX/MAcpL0r1fMikXaFurQz7Mp
VW2135DEmk1/i3PqmC9ybwlEPrqW8zGPrAjQ+l2W/z+bOd2sDyMYXRG410hCAGTa
6TrqRKN9EkZhQLSgZZFiTwlwBlHWsPRdMW7/hOSAURRYFEltWs49Xjc1G+HU3mIq
bz/tobum3RlqUnjsE9IFsC+eAqUsqqaD8b430Wnjh7IbJ+6KhnX13BvIRIkH0X0n
31kam483stwq5LoGvTkRYhV/sshjHXlV5vlkGoRvjFtg2BV41x+aPk43NphcydYM
L1IfC+F5Iyc4fOkdT7zhCzbdeGZCyZJELt20M2skSf8Y78JiyWia7bGntiflYI5v
iaIevjV8NYF0N3Y/VmLs7eHbTc3cdhwbKcPF4meOVbelPCGKvxYO+j/6n+/uxtaU
yHLsCcDyOW3B0kI1A2FAtLCauxd8j3SaGhue/a3z7bi7Qd3Px12rb4RENsJkJOCh
s08KY5BQLkXcBE0cRk8ZXS9Arac9X9jR1TL/kCOxAvj9aUGwJDO+QpWyUn2rZvwV
g1iY2EkpeT0hw/25XMNUEM+37okyDpSDAhWAMrXZiCJQatTkbYI8M5F/ykOfhzeK
qL2vqSQoxpK/eBRoAHIl
=8D7T
-----END PGP SIGNATURE-----

--i0/AhcQY5QxfSsSZ--
