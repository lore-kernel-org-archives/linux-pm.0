From: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v3 1/1] iio: pulsedlight-lidar-lite: add runtime PM
Date: Sun, 8 Nov 2015 15:40:14 +0900
Message-ID: <CAJKOXPe+qoD3=rmxZpHCFdue9EHNjO5NCGk_m+gbMhX8kiYBHg@mail.gmail.com>
References: <1446963015-17828-1-git-send-email-mranostay@gmail.com>
	<1446963015-17828-2-git-send-email-mranostay@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1446963015-17828-2-git-send-email-mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matt Ranostay <mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

2015-11-08 15:10 GMT+09:00 Matt Ranostay <mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> Add runtime PM support for the lidar-lite module to enable low power
> mode when last device requested reading is over a second.
>
> Signed-off-by: Matt Ranostay <mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 53 ++++++++++++++++++++++-
>  1 file changed, 52 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> index 961f9f99..768b944 100644
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
> @@ -116,6 +124,8 @@ static int lidar_get_measurement(struct lidar_data *data, u16 *reg)
>         int tries = 10;
>         int ret;
>
> +       pm_runtime_get_sync(&client->dev);
> +
>         /* start sample */
>         ret = lidar_write_control(data, LIDAR_REG_CONTROL_ACQUIRE);
>         if (ret < 0) {
> @@ -144,6 +154,7 @@ static int lidar_get_measurement(struct lidar_data *data, u16 *reg)
>                 }
>                 ret = -EIO;
>         }
> +       pm_runtime_put_autosuspend(&client->dev);

Now you lost pm_runtime_mark_last_busy() which was present in last version.

Rest looks good.

Best regards,
Krzysztof
