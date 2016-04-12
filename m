From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3] i2c: let I2C masters ignore their children for PM
Date: Tue, 12 Apr 2016 23:18:25 +0200
Message-ID: <20160412211825.GB1526@katana>
References: <1460447855-18050-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1460447855-18050-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-i2c@vger.kernel.org, Mark Brown <broonie@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 12, 2016 at 09:57:35AM +0200, Linus Walleij wrote:
> When using a certain I2C device with runtime PM enabled on
> a certain I2C bus adaper the following happens:
>=20
> struct amba_device *foo
>    \
>    struct i2c_adapter *bar
>       \
>       struct i2c_client *baz
>=20
> The AMBA device foo has its device PM struct set to ignore
> children with pm_suspend_ignore_children(&foo->dev, true).
> This makes runtime PM work just fine locally in the driver:
> the fact that devices on the bus are suspended or resumed
> individually does not affect its operation, and the hardware
> does not power up unless transferring messages.
>=20
> However this child ignorance property is not inherited into
> the struct i2c_adapter *bar.
>=20
> On system suspend things will work fine.
>=20
> On system resume the following annoying phenomenon occurs:
>=20
> - In the pm_runtime_force_resume() path of
>   struct i2c_client *baz, pm_runtime_set_active(&baz->dev); is
>   eventually called.
>=20
> - This becomes __pm_runtime_set_status(&baz->dev, RPM_ACTIVE);
>=20
> - __pm_runtime_set_status() detects that RPM state is changed,
>   and checks whether the parent is:
>   not active (RPM_ACTIVE) and not ignoring its children
>   If this happens it concludes something is wrong, because
>   a parent that is not ignoring its children must be active
>   before any children activate.
>=20
> - Since the struct i2c_adapter *bar does not ignore
>   its children, the PM core thinks that it must indeed go
>   online before its children, the check bails out with
>   -EBUSY, i.e. the i2c_client *baz thinks it can't work
>   because it's parent is not online, and it respects its
>   parent.
>=20
> - In the driver the .resume() callback returns -EBUSY from
>   the runtime_force_resume() call as per above. This leaves
>   the device in a suspended state, leading to bad behaviour
>   later when the device is used. The following debug
>   print is made with an extra printg patch but illustrates
>   the problem:
>=20
> [   17.040832] bh1780 2-0029: parent (i2c-2) is not active
>                parent->power.ignore_children =3D 0
> [   17.040832] bh1780 2-0029: pm_runtime_force_resume:
>                pm_runtime_set_active() failed (-16)
> [   17.040863] dpm_run_callback():
>                pm_runtime_force_resume+0x0/0x88 returns -16
> [   17.040863] PM: Device 2-0029 failed to resume: error -16
>=20
> Fix this by letting all struct i2c_adapter:s ignore their
> children: i2c children have no business doing keeping
> their parents awake: they are completely autonomous
> devices that just use their parent to talk, a usecase
> which must be power managed in the host on a per-message
> basis.
>=20
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied to for-next, thanks!


--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXDWYhAAoJEBQN5MwUoCm2ylsP/2NABR7+m7Ax0aDAxCGazyDf
kBn3cLr1EBL/1Zu+Gz5ugwax1qYNycTiIy6e363rSEyj4r+nKI106IFRlWn1XE3C
KuRPvciXLinLOosmaI6x7NZI/drMD+ZiBVxJpOQekrRXU1WviJsgdwt3GoNrN5bx
GizALWcBRRvJcOXMtIN1erlss/NOExB2zYhogXAEuMZXGTf9NtWMu42ZQcVN8fhW
VeEzGIvylVJ7DDZlbSphrVjc7yVfZFH/MaPOnfMJ0Z7xyJuxwtyLVu7aQNS9X8id
TpCf/GkgLz8DwgnL5JQhTH153Sls9bpNY2WBdBubDSYAhZcqyfMTEXlhBf1+GBd6
Sr9MJR8VubzQ/90w4wo4uPf5z1yxhPjAMqtvjAa9J5yELDqiTIrRZtd5hhrGvjAK
g992aAHstM6mkyr8u/+nEmOEvhwwaovQZ9ohir3B9xc3Mr4IpdpCU99Gl2vZdh6x
CAI6ihHKWDA2g35FjvIC1fRR5iGNrKdXVWL19uSXTOLJxT2OYOW6AfK9fuxM5khp
TjtF/gwLMREP4Dy2hVUykOR+uTvF9fKCJO50CS5UpTNm68Nk3nAkysHUxLJd3fuR
Se6AMXE55Cu9F33iOun37lXbnLX6hg5/LEahpd0TlAc4U37SYxjW2rtKKEl2TL++
9nzrHxejVbmG2dm0x38d
=8GG5
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--
