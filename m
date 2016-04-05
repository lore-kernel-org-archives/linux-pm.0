From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v9 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Tue, 5 Apr 2016 09:53:05 -0700
Message-ID: <20160405165305.GD1924@sirena.org.uk>
References: <cover.1459494743.git.baolin.wang@linaro.org>
 <20160405064637.GA31351@shlinux2.ap.freescale.net>
 <CAMz4kuKWpFLbYJM+m3syT+aMNVxjBipU_3=qwz=X0L_oB5bR0w@mail.gmail.com>
 <20160405081222.GC31351@shlinux2.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iVCmgExH7+hIHJ1A"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160405081222.GC31351@shlinux2.ap.freescale.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Chen <hzpeterchen@gmail.com>
Cc: Baolin Wang <baolin.wang@linaro.org>, Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--iVCmgExH7+hIHJ1A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 05, 2016 at 04:12:22PM +0800, Peter Chen wrote:
> On Tue, Apr 05, 2016 at 03:54:31PM +0800, Baolin Wang wrote:
> > Hi Peter,

> > Yeah, this patchset did not give an example to read charger type from
> > PMIC registers. (Cause now the user 'wm831x_power' don't need this.)
> > But I think user can get it easily by implementing below callbacks.
> > (1) gadget->ops->get_charger_type();
> > (2) power_supply_get_property(uchger->psy, POWER_SUPPLY_PROP_CHARGE_TYPE, &val);
> > (3) uchger->get_charger_type();

> I just would like if you can have this, then, we (you) can test it, eg,
> you can test if the wm831x can charge more than 1500mA for DCP.

The hardware in the wm831x is extremely simple here - all it does is
take in the power rail from USB, apply a current limit to it and feed
it into the power source selection circuitry it has.  It doesn't see any
of the USB data signals, it relies on the rest of the system to identify
and configure the limit by writing a register.  The highest limit it
supports is 1.8A.

> > The framework does not want to focus on charger detection too much,
> > and just supplies one callback '->charger_detect()' for user to be
> > implemented if they ensure they need to do the SW charger detection
> > manually (Note: must at the right time to do the SW detection.). So
> > the usb charger just focus on dealing with the usb gadget power
> > negotiation, and it does not need to care much how to do charger
> > detection on your platform.

> No, this comment is common one, but only for SW detection. Eg, when
> the PMIC tells you it is a SDP, you can't notify to charger IC about
> 500mA at once, you need to do it after host allows you to do it.

Note that this isn't just the charger device that needs to constrain
current consumption - it's the entire system.  You can't charge to the
limit for system power draw if the USB controller is supplying the main
system rail.

--iVCmgExH7+hIHJ1A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXA+1tAAoJECTWi3JdVIfQX2IH+QEr2tHAwAGVsCI+YJqgRZXw
/dCbhw8yo2MnbVWALnfgbqzNjCXKPPExRUip3mx5KPspFdytSZeIjSYg1O7JJuJN
vX29sm7fkxLUQqpBt95s4Qh1VHcl7GdhckLyuxQF2mYum0B4pFbEZcEKV96nAu02
5IuVpIiuhnC9uLX/EVs+yVarHjYvwVV+v5AH/xaR/TKqUEvBCh+5Grndpb2VeBc8
9+zkctHc9I05+kv2fiOC0Up+w2PO9LDdiPXiKAFfOjZsRgOY0h/L5XVkZNaw0Kf1
LEBja2rCDKkxPs0KlIGJ/UrHml0vxe4Wy7iuiAzO8E0LoYcyds9WecUJpvm3sM4=
=JWD5
-----END PGP SIGNATURE-----

--iVCmgExH7+hIHJ1A--
