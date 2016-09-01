From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v4 1/1] power: sbs-battery: Use gpio_desc and sleeping
 calls for battery detect
Date: Thu, 1 Sep 2016 14:43:29 +0200
Message-ID: <20160901124329.3lgtdhtnns3uqrd6@earth>
References: <1472716252-42087-1-git-send-email-preid@electromag.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="si7tqapwjctesbbb"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754187AbcIAMni (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 1 Sep 2016 08:43:38 -0400
Content-Disposition: inline
In-Reply-To: <1472716252-42087-1-git-send-email-preid@electromag.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>
Cc: dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org


--si7tqapwjctesbbb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 01, 2016 at 03:50:52PM +0800, Phil Reid wrote:
> Switch to using new gpio_desc interface and devm gpio get calls to
> automatically manage gpio resource. Use gpiod_get_value which handles
> active high / low calls.
>=20
> If gpio_detect is set then force loading of the driver as it is
> reasonable to assume that the battery may not be present.
>=20
> Update the is_present flag immediately in the IRQ.
>=20
> Remove legacy gpio specification from platform data.
>=20
> Signed-off-by: Phil Reid <preid@electromag.com.au>
> ---
>=20
> Notes:
>     Sebastian, I have not implemented all the changes you highlighted.
>     I've sort of headed back to a minimal changeset that I think doesn't =
change
>     existing behaviour as much. In particular the driver will load if pla=
tform_data
>     is not set and of_node is not set. I'm not sure if this is valid case=
 or not.
>     And the non OF build will also load if platform_data is not set.
>     Happy to change this but perhaps they should be another patch. WDYR?
>    =20
>     Changes from V3:
>     - Fix gpiod interface for platform data.
>       Due to my complete misunderstanding of gpiod interface with platfor=
m data.
>       devm_gpiod_get_optional now called in the probe function.
>     - Revert changes to always create pdata. As gpio_detect is now a memb=
er
>       of chip structure.
>    =20
>     Changes from V2:
>     - add the correct gpiod include: <include/linux/gpio/consumer.h>
>     - rebase on power-supply's next branch
>     - remove battery_detect and battery_detect_present from the
>       struct sbs_platform_data and always use the gpiod API.
>     - Ensure pdata is always valid and remove pdata null checks.
>    =20
>     Changes from V1:
>     - Fix sbs_of_populate_pdata params for non OF builds.
>     - Fix title of summary message.
>=20
>  drivers/power/supply/sbs-battery.c | 99 +++++++++++++-------------------=
------
>  include/linux/power/sbs-battery.h  |  4 --
>  2 files changed, 33 insertions(+), 70 deletions(-)

[...]

> Happy to change this but perhaps they should be another patch. WDYR?

I had another look at the driver and I think there are a couple of
cleanups possible for the sbs-battery driver:

1. Changing the platform_data interface to unsigned values means
all "max(value + 1, 1)" can be simplified to "value + 1" and neg.
retry values do not make sense.

2. I would welcome a patch dropping sbs_info.pdata alltogether and
instead add sbs_info.i2c_retry_count + sbs_info.poll_retry_count.
During probe it will be either filled by platform data, or by DT.
That way it will always be there and no further checks are needed.
Should be enough to reduce probe to this:

chip->poll_retry_count =3D 1;
chip->i2c_retry_count =3D 1;
if (pdata) {
    chip->poll_retry_count =3D pdata->poll_retry_count;
    chip->i2c_retry_count =3D pdata->i2c_retry_count;
} else if (client->dev.of_node) {
    /* include linux/property.h instead of linux/of.h */
    device_property_read_u32(&client->dev, "sbs,poll-retry-count" &chip->po=
ll_retry_count);
    device_property_read_u32(&client->dev, "sbs,i2c-retry-count" &chip->i2c=
_retry_count);
}

3. Last but not least the exit_psupply label can be removed from
sbs_probe()

Anyways, this patch looks fine, so I queued it. Thanks for the
cleanup.

-- Sebastian

--si7tqapwjctesbbb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXyCJvAAoJENju1/PIO/qaRiIP/jTcI6IKO8pi4SRuznd2aMJF
X4VZ5HStFXsLR6PI4TUUqvNJbLWpVp2sFJq+E1k/Z/fNoZVVj/5RFn4XYq3qaZ7+
A8PJ4KbWG4SFueASuEMCjyaXUxGHhScj0sdhn6mXWhHOBlBW/sqOdMFVwGT9+qgE
K2ZWAkpy0G2ONrpdiuCezmEskU3yhiHcU/n6iyVSUjlz0Z2ptW+q6Ov0khCGouQ7
o0/ndBT6yHBlDJb+LyPYhBGrehdopn9YAqauR/TF8len4KFuo74x82rabNPoiBCv
hsYOorkxyRKkLIQ+R/m0ByoUh4LNWSLyXgO4EI2MFtztGDlU6VlZ0Cp6GXzX/bxG
7LOVNsKO10tU/aaXBQVEMFrWlMTMbNexisJ5GVJ8HbESVl7W3oDA1R4E6CkhnFrg
VsWDshlWXObvTzzni91rGGXOk2kbamJTu7RZw6EypLfEz0FMwzd/r+U3O8rGRnMo
AiAA2ORAdUF5dAlM0+L2RGqseo4clBRyAgn9yXuAhfroYR1lCzzdZKheY32OFnsc
t1WhDFkP7jZ58+Mm/uGxGtG7D0ju5GyIdkzAR7KnYSqkakfLfnuYEXLbXQaEra1Z
xTS75b8U9EBkNzz6mdRsEFDwy1PVRozPZf3zXrQmYmAPBBaA/wXHhc11fJ2JdvPf
+zqGcYT6kF8wLk7H/8OX
=yn4H
-----END PGP SIGNATURE-----

--si7tqapwjctesbbb--
