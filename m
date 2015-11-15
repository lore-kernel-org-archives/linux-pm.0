From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 1/1] iio: pulsedlight-lidar-lite: add runtime PM
Date: Sun, 15 Nov 2015 10:46:09 +0000
Message-ID: <56486271.9000607@kernel.org>
References: <1447014418-27849-1-git-send-email-mranostay@gmail.com>
 <1447014418-27849-2-git-send-email-mranostay@gmail.com>
 <5641E267.6010204@intel.com>
 <CAKzfze_Zozt4N13jJdAi2C03T57BqNRox3+tANK_hz4d1oiuyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAKzfze_Zozt4N13jJdAi2C03T57BqNRox3+tANK_hz4d1oiuyw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matt Ranostay <mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Adriana Reus <adriana.reus-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?UTF-8?Q?Krzysztof_Koz=c5=82owski?= <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 11/11/15 08:51, Matt Ranostay wrote:
> On Tue, Nov 10, 2015 at 4:26 AM, Adriana Reus <adriana.reus-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
>>
>>
>> On 08.11.2015 22:26, Matt Ranostay wrote:
>>>
>>> Add runtime PM support for the lidar-lite module to enable low power
>>> mode when last device requested reading is over a second.
>>>
>>> Signed-off-by: Matt Ranostay <mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>> ---
>>>   drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 54
>>> ++++++++++++++++++++++-
>>>   1 file changed, 53 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
>>> b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
>>> index 961f9f99..1a5481f 100644
>>> --- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
>>> +++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
>>> @@ -13,7 +13,7 @@
>>>    * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>>>    * GNU General Public License for more details.
>>>    *
>>> - * TODO: runtime pm, interrupt mode, and signal strength reporting
>>> + * TODO: interrupt mode, and signal strength reporting
>>>    */
>>>
>>>   #include <linux/err.h>
>>> @@ -21,6 +21,7 @@
>>>   #include <linux/i2c.h>
>>>   #include <linux/delay.h>
>>>   #include <linux/module.h>
>>> +#include <linux/pm_runtime.h>
>>>   #include <linux/iio/iio.h>
>>>   #include <linux/iio/sysfs.h>
>>>   #include <linux/iio/buffer.h>
>>> @@ -37,6 +38,7 @@
>>>
>>>   #define LIDAR_REG_DATA_HBYTE  0x0f
>>>   #define LIDAR_REG_DATA_LBYTE  0x10
>>> +#define LIDAR_REG_PWR_CONTROL  0x65
>>>
>>>   #define LIDAR_DRV_NAME "lidar"
>>>
>>> @@ -90,6 +92,12 @@ static inline int lidar_write_control(struct lidar_data
>>> *data, int val)
>>>         return i2c_smbus_write_byte_data(data->client, LIDAR_REG_CONTROL,
>>> val);
>>>   }
>>>
>>> +static inline int lidar_write_power(struct lidar_data *data, int val)
>>> +{
>>> +       return i2c_smbus_write_byte_data(data->client,
>>> +                                        LIDAR_REG_PWR_CONTROL, val);
>>> +}
>>> +
>>>   static int lidar_read_measurement(struct lidar_data *data, u16 *reg)
>>>   {
>>>         int ret;
>>> @@ -116,6 +124,8 @@ static int lidar_get_measurement(struct lidar_data
>>> *data, u16 *reg)
>>>         int tries = 10;
>>>         int ret;
>>>
>>> +       pm_runtime_get_sync(&client->dev);
>>> +
>>>         /* start sample */
>>>         ret = lidar_write_control(data, LIDAR_REG_CONTROL_ACQUIRE);
>>>         if (ret < 0) {
>>> @@ -144,6 +154,8 @@ static int lidar_get_measurement(struct lidar_data
>>> *data, u16 *reg)
>>>                 }
>>>                 ret = -EIO;
>>>         }
>>> +       pm_runtime_mark_last_busy(&client->dev);
>>> +       pm_runtime_put_autosuspend(&client->dev);
>>>
>>>         return ret;
>>>   }
>>> @@ -243,6 +255,15 @@ static int lidar_probe(struct i2c_client *client,
>>>         if (ret)
>>>                 goto error_unreg_buffer;
>>>
>>> +       pm_runtime_set_autosuspend_delay(&client->dev, 1000);
>>> +       pm_runtime_use_autosuspend(&client->dev);
>>> +
>>> +       pm_runtime_set_active(&client->dev);
>>
>> pm_runtime_set_active ^ may return an error code.
> 
> Ah true. But is the return value really needed in this case?
Why would it not be?  Something in the probe routine failed,
the driver should fail to probe...

If it is possible to muddle through, then you want to explicitly make
that clear by handling the error and perhaps outputting a warning...

J
> 
>>
>>> +       pm_runtime_enable(&client->dev);
>>> +
>>> +       pm_runtime_mark_last_busy(&client->dev);
>>> +       pm_runtime_idle(&client->dev);
>>> +
>>>         return 0;
>>>
>>>   error_unreg_buffer:
>>> @@ -258,6 +279,9 @@ static int lidar_remove(struct i2c_client *client)
>>>         iio_device_unregister(indio_dev);
>>>         iio_triggered_buffer_cleanup(indio_dev);
>>>
>>> +       pm_runtime_disable(&client->dev);
>>> +       pm_runtime_set_suspended(&client->dev);
>>> +
>>>         return 0;
>>>   }
>>>
>>> @@ -273,10 +297,38 @@ static const struct of_device_id lidar_dt_ids[] = {
>>>   };
>>>   MODULE_DEVICE_TABLE(of, lidar_dt_ids);
>>>
>>> +#ifdef CONFIG_PM
>>> +static int lidar_pm_runtime_suspend(struct device *dev)
>>> +{
>>> +       struct iio_dev *indio_dev =
>>> i2c_get_clientdata(to_i2c_client(dev));
>>> +       struct lidar_data *data = iio_priv(indio_dev);
>>> +
>>> +       return lidar_write_power(data, 0x0f);
>>> +}
>>> +
>>> +static int lidar_pm_runtime_resume(struct device *dev)
>>> +{
>>> +       struct iio_dev *indio_dev =
>>> i2c_get_clientdata(to_i2c_client(dev));
>>> +       struct lidar_data *data = iio_priv(indio_dev);
>>> +       int ret = lidar_write_power(data, 0);
>>> +
>>> +       /* regulator and FPGA needs settling time */
>>> +       usleep_range(15000, 20000);
>>> +
>>> +       return ret;
>>> +}
>>> +#endif
>>> +
>>> +static const struct dev_pm_ops lidar_pm_ops = {
>>> +       SET_RUNTIME_PM_OPS(lidar_pm_runtime_suspend,
>>> +                          lidar_pm_runtime_resume, NULL)
>>> +};
>>> +
>>>   static struct i2c_driver lidar_driver = {
>>>         .driver = {
>>>                 .name   = LIDAR_DRV_NAME,
>>>                 .of_match_table = of_match_ptr(lidar_dt_ids),
>>> +               .pm     = &lidar_pm_ops,
>>>         },
>>>         .probe          = lidar_probe,
>>>         .remove         = lidar_remove,
>>>
>>
