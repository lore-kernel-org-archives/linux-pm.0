From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v12 4/4] power: wm831x_power: Support USB charger current limit management
Date: Tue, 21 Jun 2016 14:50:27 +0300
Message-ID: <87r3bqn4l8.fsf@linux.intel.com>
References: <cover.1466497505.git.baolin.wang@linaro.org> <7dc384248d51b1de0df54909f3c5550584b31357.1466497506.git.baolin.wang@linaro.org> <878txyomue.fsf@linux.intel.com> <20160621110332.GC26099@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160621110332.GC26099@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Baolin Wang <baolin.wang@linaro.org>, gregkh@linuxfoundation.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, robh@kernel.org, jun.li@nxp.com, m.szyprowski@samsung.com, ruslan.bilovol@gmail.com, peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, lee.jones@linaro.org, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Mark Brown <broonie@kernel.org> writes:
> [ Unknown signature status ]
> On Tue, Jun 21, 2016 at 01:30:49PM +0300, Felipe Balbi wrote:
>> Baolin Wang <baolin.wang@linaro.org> writes:
>> > @@ -607,8 +647,31 @@ static int wm831x_power_probe(struct platform_dev=
ice *pdev)
>> >  		}
>> >  	}
>
>> > +	if (wm831x_pdata && wm831x_pdata->usb_gadget) {
>> > +		power->usb_charger =3D
>> > +			usb_charger_find_by_name(wm831x_pdata->usb_gadget);
>
>> the fact that you rely on strings and pass them via pdata is an
>> indication that you don't have enough description of the HW. Seems like
>> we need to come up with a set of DT properties which tie a charger to a
>> UDC.
>
>> I'm thinking a phandle would be enough?
>
> The wm831x has no DT support currently.

okay, perhaps its time to add it.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXaSoEAAoJEIaOsuA1yqREXEwP/1RL6zdMe0dpVPxr93DesIHN
AmP7xF30P/ZeVySuEuKARhuOy8ZImA67kMgH20GAygHEL22ETIOYVBPJ1SGArWVx
yUF4qoUAF5gaB+bjLQBZJ4uP4AbWeQuHIzAf67jaADfmk0p7TLECWMQhYkqTfldK
Rj6MUqbqLNQmRFhgAmeBqOp/jE4uvDw5PM0ZybJnruMm2tI9D7wGDn2RIs6zvGal
ymznO4AqqwUc2rkytLV1zR0uh1JdgKPQBOsBBXRytmMA+HBvXo6t4LpXf4E2NcUt
+JqNwnNodgGzMiIpOR1I/SwwoeSNAiXaeNbREvyYSi+LEMiNcL0vdNok2tDw5B2R
o9Gen+uuwIcPNXbX4jfHzH6qtCRc1Db8QFsUsdhARyJnCKpGyafkZsTj+nLs/x36
oawiaqyKiQwF1lfsMYBxzHXWZb+xz3IlfJzGzMoigrso2q2WsqmFAaMPK/RCiT+3
R6Lo45WxJVsOXr361Oy/4uSEZ9Ah2tMd6m3cfKEk0DoGwKnjhQOZb7aoo2YxbGOf
wqnW7IbdQBhaFuHriC6ULQO95v78f1In569C8iJYXvKI0NlXM9uC7/5LLEKheMGt
402a1xuicWpoPlIf+ID7U06rh96lxcI3QMppVHx1HkHLsQHwIlIwIqyX30dJxY54
MZAnyMFGcOQ5IHztcOSB
=pI57
-----END PGP SIGNATURE-----
--=-=-=--
