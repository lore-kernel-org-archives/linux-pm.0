From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH v2] add MAX17040 Fuel Gauge driver
Date: Thu, 4 Jun 2009 11:35:04 +0200
Message-ID: <20090604113504.5370775b__37458.2098251723$1244138326$gmane$org@hyperion.delvare>
References: <4A278C08.5000206@samsung.com>
	<5d5443650906040216h2314b7bbt1ae2e89c709b566e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <5d5443650906040216h2314b7bbt1ae2e89c709b566e@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Minkyu Kang <mk7.kang@samsung.com>
Cc: Trilok Soni <soni.trilok@gmail.com>, Anton@smtp1.linux-foundation.org, linux-kernel@vger.kernel.org, Vorontsov <cbou@mail.ru>, kyungmin.park@samsung.com, linux-i2c@vger.kernel.org, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 4 Jun 2009 14:46:45 +0530, Trilok Soni wrote:
> Hi Minkyu Kang,
> =

> Adding linux-i2c mailing list, so not deleting any code.
> =

> On Thu, Jun 4, 2009 at 2:25 PM, Minkyu Kang <mk7.kang@samsung.com> wrote:
> > The MAX17040 is a I2C interfaced Fuel Gauge systems for lithium-ion bat=
teries
> > This patch adds support the MAX17040 Fuel Gauge
> >
> > Cc: Anton Vorontsov <cbou@mail.ru>
> > Signed-off-by: Minkyu Kang <mk7.kang@samsung.com>
> > ---
> > =A0drivers/power/Kconfig =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A08 +
> > =A0drivers/power/Makefile =A0 =A0 =A0 =A0 =A0 | =A0 =A03 +-
> > =A0drivers/power/max17040_battery.c | =A0306 ++++++++++++++++++++++++++=
++++++++++++
> > =A0include/linux/max17040_battery.h | =A0 19 +++
> > =A04 files changed, 335 insertions(+), 1 deletions(-)
> > =A0create mode 100644 drivers/power/max17040_battery.c
> > =A0create mode 100644 include/linux/max17040_battery.h
> > (...)
> > +static u8 max17040_read_reg(int reg)
> > +{
> > + =A0 =A0 =A0 int ret;
> > +
> > + =A0 =A0 =A0 ret =3D i2c_smbus_read_byte_data(max17040->client, reg);
> > +
> > + =A0 =A0 =A0 if (ret < 0) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&max17040->client->dev,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%s: reg =
0x%x, err %d\n",
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__,=
 reg, ret);
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 return ret;
> > +}

In case of error, this will wrap the error code into a u8 and the
caller won't notice. So you'll return a random value, depending on the
actual error which happened. No good.

You should either return an int there, and have the caller check for
errors, or if you don't want to care about errors, return an arbitrary
value on error (e.g. 0.)

> > (...)
> > +static int __devinit max17040_probe(struct i2c_client *client,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const struct i2c_device_i=
d *id)
> > +{
> > + =A0 =A0 =A0 struct max17040_chip *chip;
> > + =A0 =A0 =A0 int ret;
> > +
> > + =A0 =A0 =A0 chip =3D kzalloc(sizeof(struct max17040_chip), GFP_KERNEL=
);
> > + =A0 =A0 =A0 if (!chip)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> > +
> > + =A0 =A0 =A0 chip->client =3D client;
> > + =A0 =A0 =A0 pdata =3D client->dev.platform_data;
> > +
> > + =A0 =A0 =A0 i2c_set_clientdata(client, chip);
> =

> Please add i2c_check_functionality check before doing any smbus
> read/write operations.
> =

> > + =A0 =A0 =A0 max17040 =3D chip;
> =

> This means that we support only one instance of this chip, right?
> =

> > +
> > + =A0 =A0 =A0 max17040_reset();
> > +
> > + =A0 =A0 =A0 max17040_get_version();
> > +
> > + =A0 =A0 =A0 INIT_DELAYED_WORK_DEFERRABLE(&chip->work, max17040_work);
> > + =A0 =A0 =A0 schedule_delayed_work(&chip->work, MAX17040_DELAY);
> > +
> > + =A0 =A0 =A0 bat_ps.properties =3D max17040_battery_props;
> > + =A0 =A0 =A0 bat_ps.num_properties =3D ARRAY_SIZE(max17040_battery_pro=
ps);
> > +
> > + =A0 =A0 =A0 ret =3D power_supply_register(&client->dev, &bat_ps);
> > + =A0 =A0 =A0 if (ret) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&max17040->client->dev,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "failed: =
power supply register\n");
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cancel_delayed_work(&chip->work);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c_set_clientdata(client, NULL);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(chip);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 max17040 =3D NULL;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;

Please come up with a better error code.

> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 return 0;
> > +}

-- =

Jean Delvare
