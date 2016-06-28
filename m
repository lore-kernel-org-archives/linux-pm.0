From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 02/14] thermal: sun8i_ths: Add support
 for the thermal sensor on Allwinner H3
Date: Tue, 28 Jun 2016 13:39:31 +0200
Message-ID: <20160628113931.GD5550@lukather>
References: <20160625034511.7966-1-megous@megous.com>
 <20160625034511.7966-3-megous@megous.com>
 <20160625071044.GB4000@lukather>
 <4a43f993-6b58-8303-466b-a9115ed26fd6@megous.com>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Hf61M2y+wYpnELGG"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBBGEZG5QKGQEUR6YVLY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <4a43f993-6b58-8303-466b-a9115ed26fd6-5qf/QAjKc83QT0dZR+AlfA@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megous-5qf/QAjKc83QT0dZR+AlfA@public.gmane.org>
Cc: dev-3kdeTeqwOZ9EV1b7eY7vFQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:THERMAL" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--Hf61M2y+wYpnELGG
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 25, 2016 at 05:12:41PM +0200, Ond=C5=99ej Jirman wrote:
> >> +	data->calreg =3D devm_ioremap_resource(&pdev->dev, res);
> >> +	if (IS_ERR(data->calreg)) {
> >> +		ret =3D PTR_ERR(data->calreg);
> >> +		dev_err(&pdev->dev, "failed to ioremap THS registers: %d\n", ret);
> >> +		return ret;
> >> +	}
> >=20
> > Why did you remove the SID use through the nvmem framework ?!
>=20
> Because it's overkill for reading a single word from memeory, the sunxi
> nvmem driver doesn't support H3, the sid is not documented in the
> datasheet, aside from some registger name/offset dump on the mailing
> list some time ago.
>=20
> Aside from that, I've yet to see H3 soc that has anything else than 0 in
> the calibration data memory location. So this is basically nop.
>=20
> Proposed solution seems simpler with no drawbacks that I can see,
> without resorting to dropping the thing entirely from this driver. Which
> I would be fine with too. Calibration is optional feature in the BSP
> kernel, so I assume dropping it may not do too much harm either.
>=20
> If anyone wants to implement sid in the future, it will be easy enough
> to do with backwards compatibility. The second reg will become optional,
> and the driver can check for nvmem.

A lot of things in drivers boil down to "reading a single word from
memory". However, abstractions are here for a reason, and there's none
to not use it.

If that's not something we can use today, remove it entirely. And if
that becomes necessary, we will add an optional nvmem property.

> >> +
> >> +	irq =3D platform_get_irq(pdev, 0);
> >> +	if (irq < 0) {
> >> +		dev_err(&pdev->dev, "failed to get IRQ: %d\n", irq);
> >> +		return irq;
> >> +	}
> >> +
> >> +	ret =3D devm_request_threaded_irq(&pdev->dev, irq, NULL,
> >> +					sun8i_ths_irq_thread, IRQF_ONESHOT,
> >> +					dev_name(&pdev->dev), data);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	data->busclk =3D devm_clk_get(&pdev->dev, "ahb");
> >> +	if (IS_ERR(data->busclk)) {
> >> +		ret =3D PTR_ERR(data->busclk);
> >> +		dev_err(&pdev->dev, "failed to get ahb clk: %d\n", ret);
> >> +		return ret;
> >> +	}
> >> +
> >> +	data->clk =3D devm_clk_get(&pdev->dev, "ths");
> >> +	if (IS_ERR(data->clk)) {
> >> +		ret =3D PTR_ERR(data->clk);
> >> +		dev_err(&pdev->dev, "failed to get ths clk: %d\n", ret);
> >> +		return ret;
> >> +	}
> >> +
> >> +	data->reset =3D devm_reset_control_get(&pdev->dev, "ahb");
> >> +	if (IS_ERR(data->reset)) {
> >> +		ret =3D PTR_ERR(data->reset);
> >> +		dev_err(&pdev->dev, "failed to get reset: %d\n", ret);
> >> +		return ret;
> >> +	}
> >> +
> >> +	ret =3D clk_prepare_enable(data->busclk);
> >> +	if (ret) {
> >> +		dev_err(&pdev->dev, "failed to enable bus clk: %d\n", ret);
> >> +		return ret;
> >> +	}
> >> +
> >> +	ret =3D clk_prepare_enable(data->clk);
> >> +	if (ret) {
> >> +		dev_err(&pdev->dev, "failed to enable ths clk: %d\n", ret);
> >> +		goto err_disable_bus;
> >> +	}
> >> +
> >> +	ret =3D clk_set_rate(data->clk, THS_H3_CLK_IN);
> >> +	if (ret)
> >> +		goto err_disable_ths;
> >> +
> >> +	ret =3D reset_control_deassert(data->reset);
> >> +	if (ret) {
> >> +		dev_err(&pdev->dev, "reset deassert failed: %d\n", ret);
> >> +		goto err_disable_ths;
> >> +	}
> >=20
> > Having runtime_pm support would be great.
>=20
> Suspend/resume handling? I would have no way of testing it, other than
> blindly impelementing what BSP kernel does. Other than that, I can add
> it quite easily. It should be rather simple.

No, I mean runtime_pm, with runtime_suspend and runtime_resume, to
allow only powering up the device when it's used, and shut it down
when not used.

> >> +MODULE_AUTHOR("Ond=C5=99ej Jirman <megous-5qf/QAjKc83QT0dZR+AlfA@public.gmane.org>");
> >> +MODULE_DESCRIPTION("Thermal sensor driver for Allwinner H3 SoC");
> >> +MODULE_LICENSE("GPL v2");
> >=20
> > Looks quite good otherwise. It looks very similar to the older
> > touchscreen driver (without the touchscreen part).
> >=20
> > Have you tried to merge the two?
>=20
> What driver?

drivers/input/touchscreen/sun4i-ts.c

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

--Hf61M2y+wYpnELGG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXcmHzAAoJEBx+YmzsjxAgAG8P/i2yr5/IyZxHryyIDEtbYEby
Ox5HgherO+VcMqFeGkME2b0YoFvHwvfAV8S59KX3YCtoQnZAwC1CTperxUaFMiko
B8BsnazLETmI6wbW8kYEsDS0VhajDTldFoB1osjixo6m8j9A3MmhYA2dsuq/X6QK
brfPAbvh02lfhIQHFswf57ouqWkWfJC3WVPJinmewupZ+rPWenOWOu3/nA2rE6se
xp7Lvp1OHditKYq+/aytw85Rw8RXzhGNdU5TFGs5vG/QeB/5Gf2YRpcZIt8q9uP4
CBKo/jfBjvqsXdi1ZLDrTfTbved/jvE+s13P9DXBg69NinSch0z+lHWoadrBF2Ha
bsn7nun+voRtZ0zzra1mJBCdLekTDxASQa2VMbTzX77b34BoPjewJnkV/XvuCKfi
ciPyswF2TsoCK55Q2K78WFt2aI+oNm2t3vvX3nYi2Lm/H/Fa/blrJHUkH2W39JD9
obQLR7/oOTu9DtJOhx0WjfpZWyDZ9dWcZt4WcdibgeTSFB5x4pSu8Ybb95Cbtwl0
KmshkKMjn3gVl269TE8kZ0K4qczsJd4mRcfrLM7tIo51bFM2/mpYQma1ZeIOgT9c
XA5b7R8THT1LvkrSoJbrWVI/0bN9rSEITDIjTiQgC35K0Uw0Oxd6PnNdcu+zRlz2
xZ+D8IiEf7ozd20PCIKD
=mDmW
-----END PGP SIGNATURE-----

--Hf61M2y+wYpnELGG--
