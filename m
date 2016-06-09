From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v3] power_supply: power_supply_read_temp only if use_cnt
 > 0
Date: Thu, 9 Jun 2016 22:58:47 +0200
Message-ID: <20160609205846.GA21947@earth>
References: <1465331163-16884-1-git-send-email-rklein@nvidia.com>
 <5757BCAD.4060101@samsung.com>
 <d5767cde-3275-36d7-08b8-335d7c4c8e3b@nvidia.com>
 <57593F65.2070900@samsung.com>
 <9ff350fd-3ccc-088e-8392-d575a64aaefd@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9ff350fd-3ccc-088e-8392-d575a64aaefd@nvidia.com>
Sender: stable-owner@vger.kernel.org
To: Rhyland Klein <rklein@nvidia.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 09, 2016 at 11:31:37AM -0400, Rhyland Klein wrote:
> On 6/9/2016 6:05 AM, Krzysztof Kozlowski wrote:
> > On 06/08/2016 05:26 PM, Rhyland Klein wrote:
> >> On 6/8/2016 2:35 AM, Krzysztof Kozlowski wrote:
> >>> On 06/07/2016 10:26 PM, Rhyland Klein wrote:
> >>>> Change power_supply_read_temp() to use power_supply_get_property()
> >>>> so that it will check the use_cnt and ensure it is > 0. The use_cnt
> >>>> will be incremented at the end of __power_supply_register, so this
> >>>> will block to case where get_property can be called before the supply
> >>>> is fully registered. This fixes the issue show in the stack below:
> >>>>
> >>>> [    1.452598] power_supply_read_temp+0x78/0x80
> >>>> [    1.458680] thermal_zone_get_temp+0x5c/0x11c
> >>>> [    1.464765] thermal_zone_device_update+0x34/0xb4
> >>>> [    1.471195] thermal_zone_device_register+0x87c/0x8cc
> >>>> [    1.477974] __power_supply_register+0x364/0x424
> >>>> [    1.484317] power_supply_register_no_ws+0x10/0x18
> >>>> [    1.490833] bq27xxx_battery_setup+0x10c/0x164
> >>>> [    1.497003] bq27xxx_battery_i2c_probe+0xd0/0x1b0
> >>>> [    1.503435] i2c_device_probe+0x174/0x240
> >>>> [    1.509172] driver_probe_device+0x1fc/0x29c
> >>>> [    1.515167] __driver_attach+0xa4/0xa8
> >>>> [    1.520643] bus_for_each_dev+0x58/0x98
> >>>> [    1.526204] driver_attach+0x20/0x28
> >>>> [    1.531505] bus_add_driver+0x1c8/0x22c
> >>>> [    1.537067] driver_register+0x68/0x108
> >>>> [    1.542630] i2c_register_driver+0x38/0x7c
> >>>> [    1.548457] bq27xxx_battery_i2c_driver_init+0x18/0x20
> >>>> [    1.555321] do_one_initcall+0x38/0x12c
> >>>> [    1.560886] kernel_init_freeable+0x148/0x1ec
> >>>> [    1.566972] kernel_init+0x10/0xfc
> >>>> [    1.572101] ret_from_fork+0x10/0x40
> >>>>
> >>>> Also make the same change to ps_get_max_charge_cntl_limit() and
> >>>> ps_get_cur_chrage_cntl_limit() to be safe. Lastly, change the return
> >>>> value of power_supply_get_property() to -EAGAIN from -ENODEV if
> >>>> use_cnt <=3D 0.
> >>>>
> >>>> Fixes: 297d716f6260 ("power_supply: Change ownership from driver to =
core")
> >>>> Cc: stable@vger.kernel.org
> >>>> Signed-off-by: Rhyland Klein <rklein@nvidia.com>
> >>>> ---
> >>>> v3:
> >>>>  - Changed calls to ->get_property() to use common
> >>>>    power_supply_get_property()
> >>>>  - reworded description, added "Fixes" line
> >>>>  - Changed return value of power_supply_get_property() to -EAGAIN
> >>>>
> >>>> v2:
> >>>>  - Added cc stable
> >>>>  - changed return to -EAGAIN in case of use_cnt < 1
> >>>>  - Removed WARNING
> >>>>  - return value check added in additional patch:
> >>>>    https://lkml.org/lkml/2016/6/6/706
> >>>>
> >>>>  drivers/power/power_supply_core.c | 26 ++++++++++++++++----------
> >>>>  1 file changed, 16 insertions(+), 10 deletions(-)
> >>>>
> >>>> diff --git a/drivers/power/power_supply_core.c b/drivers/power/power=
_supply_core.c
> >>>> index 456987c88baa..cccc630bd68e 100644
> >>>> --- a/drivers/power/power_supply_core.c
> >>>> +++ b/drivers/power/power_supply_core.c
> >>>> @@ -492,7 +492,7 @@ int power_supply_get_property(struct power_suppl=
y *psy,
> >>>>  			    union power_supply_propval *val)
> >>>>  {
> >>>>  	if (atomic_read(&psy->use_cnt) <=3D 0)
> >>>> -		return -ENODEV;
> >>>> +		return -EAGAIN;
> >>>
> >>> Wait, no. I was thinking of changing the return value in
> >>> power_supply_read_temp() if we really want EAGAIN:
> >>> ret =3D power_supply_get_property(...);
> >>> if (ret)
> >>> 	return -EAGAIN;
> >>>
> >>> On the other hand, here both return values look correct... the call c=
an
> >>> be executed too early (not very common) or too late after unbinding t=
he
> >>> driver (also kind of specific).
> >>
> >> I did have it that way, but it seemed a little weird to me, since both
> >> situations use the same condition (use_cnt <=3D 0) to trigger. I don't
> >> think we can differentiate, unless I missed something, so I'm not sure
> >> if it makes sense to override the return value after calling
> >> power_supply_get_property() or not.
> >>
> >> If I overrode the return value in get_temp, then assuming it was called
> >> after unbinding, it would return the wrong thing (-EAGAIN). If we want
> >> to support both EAGAIN and ENODEV, then maybe we need to use some
> >> additional check to know which to return from power_supply_get_propert=
y().
> >=20
> > Right, currently it is not possible to differentiate these two cases.
> > After quick look, I think the difference with EAGAIN would be only in
> > error message printed or not. It is not critical so maybe keep it with
> > ENODEV?
>=20
> I'm ok with that. Sebastian, are you ok with that? If so, I'll post a v4
> without the -EAGAIN change.

Yes.

-- Sebastian

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXWdiBAAoJENju1/PIO/qalMoP/0j/7egmX3gAmTArel54XkxG
eguClU/NFrMTyHXDJ/d4rWafM/cG9IvBKYeOhbjHlOjb2ttCxzC/kh2+rtf58E3u
h3NuSeI1gP9QpNgurRq4EXbQrrIFn7DWogQ6XKt7KqYAgA63sjogy4YL5N4InrDg
2dtMERHi4se0Go/lp6fOJYNoZZQ+Std7hIe/IBClguc4KYmhgzvDcuG0sau6keek
lpWL6MhVR1CAZMnDozE0+2wrBo2YRJAmb4PY6RUHUakv5GQqs6xzehD3hPVQI2Hj
dthOe9lEw0WitUtrjCdTzgxiVY7StMCZR1JUr/1oVnalxBk/6HbRTReiWbCrwmMI
iPQ4Axo8F8cKSM6jn6vDlNb79d7jvk6GI6LrX1MOqVPnHeaDBweCOx8SSHnCEtea
y358kek8MccWWF4SskGGRaTq5XWDVvsIA0kcJATADayq4boCImk9ESey1AClY9C9
Q970jpPdaAXsQA8ZhSjkJmGWDj3yoTvDehMKChY54ftXlaHl1OW2aFAFPkU9Cjaj
j72PfNJt8qKuseVVzMBFcC7YhpoEPRkOLOXGFZLzGIXRWXaHOqAYNnnsdhOxUlEE
0btKU6/w9fygaT41rMxaZN6bfkzFp5fX94OxYpXQa2HYus89tjj7nJHjUsISNBG0
vRN0hJckYndHivL2Fw+Z
=Gu4g
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
