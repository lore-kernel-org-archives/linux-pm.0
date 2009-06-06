From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: [PATCH v3] add MAX17040 Fuel Gauge driver
Date: Sat, 6 Jun 2009 22:29:03 +0530
Message-ID: <5d5443650906060959w678a29acn8200239d35869dca__12807.2887113833$1244308091$gmane$org@mail.gmail.com>
References: <4A28BC20.3010307@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4A28BC20.3010307@samsung.com>
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
Cc: linux-kernel@vger.kernel.org, Anton Vorontsov <cbou@mail.ru>, kyungmin.park@samsung.com, linux-i2c@vger.kernel.org, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi Minkyu Kang,

On Fri, Jun 5, 2009 at 12:03 PM, Minkyu Kang<mk7.kang@samsung.com> wrote:
> The MAX17040 is a I2C interfaced Fuel Gauge systems for lithium-ion batte=
ries
> This patch adds support the MAX17040 Fuel Gauge
>

Thanks for making change. Some more comments.

> =A0endif # POWER_SUPPLY
> diff --git a/drivers/power/Makefile b/drivers/power/Makefile
> index 2fcf41d..9c48995 100644
> --- a/drivers/power/Makefile
> +++ b/drivers/power/Makefile
> @@ -25,4 +25,5 @@ obj-$(CONFIG_BATTERY_TOSA) =A0 =A0+=3D tosa_battery.o
> =A0obj-$(CONFIG_BATTERY_WM97XX) =A0 +=3D wm97xx_battery.o
> =A0obj-$(CONFIG_BATTERY_BQ27x00) =A0+=3D bq27x00_battery.o
> =A0obj-$(CONFIG_BATTERY_DA9030) =A0 +=3D da9030_battery.o
> -obj-$(CONFIG_CHARGER_PCF50633) +=3D pcf50633-charger.o
> \ No newline at end of file
> +obj-$(CONFIG_BATTERY_MAX17040)) =A0 =A0 =A0 =A0+=3D max17040_battery.o

Are we following any alphabetical order in this Makefile?

> +static int max17040_suspend(struct i2c_client *client,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_message_t state)
> +{
> + =A0 =A0 =A0 struct max17040_chip *chip =3D i2c_get_clientdata(client);
> +
> + =A0 =A0 =A0 cancel_delayed_work(&chip->work);
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int max17040_resume(struct i2c_client *client)
> +{
> + =A0 =A0 =A0 struct max17040_chip *chip =3D i2c_get_clientdata(client);
> +
> + =A0 =A0 =A0 schedule_delayed_work(&chip->work, MAX17040_DELAY);
> + =A0 =A0 =A0 return 0;
> +}
> +

Please add #ifdef CONFIG_PM around suspend resume functions.

-- =

---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
