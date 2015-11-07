From: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] iio: pulsedlight-lidar-lite: add runtime PM
Date: Sat, 7 Nov 2015 23:08:05 +0900
Message-ID: <CAJKOXPcjH4hQf8ukUwwCRs3U3Dre+wBvisG0nxu2ZGES3a+unQ@mail.gmail.com>
References: <1446874643-28020-1-git-send-email-mranostay@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1446874643-28020-1-git-send-email-mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matt Ranostay <mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

2015-11-07 14:37 GMT+09:00 Matt Ranostay <mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> Add runtime PM support for the lidar-lite module to enable low power
> mode when last device requested reading is over a second ago.
>
> Signed-off-by: Matt Ranostay <mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 54 ++++++++++++++++++++++-
>  1 file changed, 53 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> index e544fcf..e015a89 100644
> --- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> +++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> @@ -13,7 +13,7 @@
>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>   * GNU General Public License for more details.
>   *
> - * TODO: runtime pm, interrupt mode, and signal strength reporting
> + * TODO: interrupt mode, and signal strength reporting
>   */
>
>  #include <linux/err.h>
> @@ -21,6 +21,7 @@
>  #include <linux/i2c.h>
>  #include <linux/delay.h>
>  #include <linux/module.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/buffer.h>
> @@ -37,6 +38,7 @@
>
>  #define LIDAR_REG_DATA_HBYTE   0x0f
>  #define LIDAR_REG_DATA_LBYTE   0x10
> +#define LIDAR_REG_PWR_CONTROL  0x65
>
>  #define LIDAR_DRV_NAME "lidar"
>
> @@ -90,6 +92,12 @@ static inline int lidar_write_control(struct lidar_data *data, int val)
>         return i2c_smbus_write_byte_data(data->client, LIDAR_REG_CONTROL, val);
>  }
>
> +static inline int lidar_write_power(struct lidar_data *data, int val)
> +{
> +       return i2c_smbus_write_byte_data(data->client,
> +                                        LIDAR_REG_PWR_CONTROL, val);
> +}
> +
>  static int lidar_read_measurement(struct lidar_data *data, u16 *reg)
>  {
>         int ret;
> @@ -114,8 +122,15 @@ static int lidar_get_measurement(struct lidar_data *data, u16 *reg)
>  {
>         struct i2c_client *client = data->client;
>         int tries = 10;
> +       int suspended = pm_runtime_suspended(&client->dev);
>         int ret;
>

That's racy. You have a gap here between check of the status, resuming
the device and actual use of the status.

> +       pm_runtime_get(&client->dev);

Are you sure you want to use pm_runtime_get()? The async method? You
won't have any kind of certainty that resume really finished, even
after the usleep().

> +
> +       /* regulator and FPGA needs settling time */
> +       if (suspended)
> +               usleep_range(15000, 20000);
> +
>         /* start sample */
>         ret = lidar_write_control(data, LIDAR_REG_CONTROL_ACQUIRE);
>         if (ret < 0) {
> @@ -144,6 +159,7 @@ static int lidar_get_measurement(struct lidar_data *data, u16 *reg)
>                 }
>                 ret = -EIO;
>         }
> +       pm_runtime_put_autosuspend(&client->dev);

mark last busy?

Best regards,
Krzysztof
