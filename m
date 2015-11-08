From: Matt Ranostay <mranostay@gmail.com>
Subject: Re: [PATCH v2 1/1] iio: pulsedlight-lidar-lite: add runtime PM
Date: Sat, 7 Nov 2015 21:51:01 -0800
Message-ID: <CAKzfze-tbGcRJ1GgiiMSwJ4_5tBzAqYQSfBG8nyGAJygnCrL7A@mail.gmail.com>
References: <1446951024-7621-1-git-send-email-mranostay@gmail.com>
	<1446951024-7621-2-git-send-email-mranostay@gmail.com>
	<CAJKOXPe0tEnnibUFCX1LYETk2wKfu4DRxtRaa2pMihNK0s=GNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:34770 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753230AbbKHFvE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 8 Nov 2015 00:51:04 -0500
In-Reply-To: <CAJKOXPe0tEnnibUFCX1LYETk2wKfu4DRxtRaa2pMihNK0s=GNw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Jonathan Cameron <jic23@kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, linux-pm@vger.kernel.org

On Sat, Nov 7, 2015 at 9:28 PM, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:
> 2015-11-08 11:50 GMT+09:00 Matt Ranostay <mranostay@gmail.com>:
>> Add runtime PM support for the lidar-lite module to enable low power
>> mode when last device requested reading is over a second.
>>
>> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
>> ---
>>  drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 63 ++++++++++++++++++++++-
>>  1 file changed, 62 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
>> index 961f9f99..26fba20 100644
>> --- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
>> +++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
>> @@ -13,14 +13,16 @@
>>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>>   * GNU General Public License for more details.
>>   *
>> - * TODO: runtime pm, interrupt mode, and signal strength reporting
>> + * TODO: interrupt mode, and signal strength reporting
>>   */
>>
>>  #include <linux/err.h>
>>  #include <linux/init.h>
>>  #include <linux/i2c.h>
>>  #include <linux/delay.h>
>> +#include <linux/mutex.h>
>>  #include <linux/module.h>
>> +#include <linux/pm_runtime.h>
>>  #include <linux/iio/iio.h>
>>  #include <linux/iio/sysfs.h>
>>  #include <linux/iio/buffer.h>
>> @@ -37,12 +39,14 @@
>>
>>  #define LIDAR_REG_DATA_HBYTE   0x0f
>>  #define LIDAR_REG_DATA_LBYTE   0x10
>> +#define LIDAR_REG_PWR_CONTROL  0x65
>>
>>  #define LIDAR_DRV_NAME "lidar"
>>
>>  struct lidar_data {
>>         struct iio_dev *indio_dev;
>>         struct i2c_client *client;
>> +       struct mutex lock;
>>
>>         u16 buffer[8]; /* 2 byte distance + 8 byte timestamp */
>>  };
>> @@ -90,6 +94,12 @@ static inline int lidar_write_control(struct lidar_data *data, int val)
>>         return i2c_smbus_write_byte_data(data->client, LIDAR_REG_CONTROL, val);
>>  }
>>
>> +static inline int lidar_write_power(struct lidar_data *data, int val)
>> +{
>> +       return i2c_smbus_write_byte_data(data->client,
>> +                                        LIDAR_REG_PWR_CONTROL, val);
>> +}
>> +
>>  static int lidar_read_measurement(struct lidar_data *data, u16 *reg)
>>  {
>>         int ret;
>> @@ -113,9 +123,19 @@ static int lidar_read_measurement(struct lidar_data *data, u16 *reg)
>>  static int lidar_get_measurement(struct lidar_data *data, u16 *reg)
>>  {
>>         struct i2c_client *client = data->client;
>> +       int suspended;
>>         int tries = 10;
>>         int ret;
>>
>> +       mutex_lock(&data->lock);
>
> I did not receive any response from your after my previous feedback so
> my concerns are not fully resolved. First of all I am not sure what
> you want to achieve here with the mutex. Protect from waking up by
> concurrent lidar_read_measuremen()? I think that is not sufficient.
> Device may be woken up for example by user after changing the
> power/control to "on". Devices can also be resumed by child devices
> which is probably not the case here.
>
> What if someone will add another pm_runtime_get_sync() in other part
> of driver? You would have to duplicate this all over again.
>
> Anyway, why you need to check the suspended state? If only for a
> usleep_range() then maybe just move the sleep to runtime resume
> callback? Runtime resume callback is called if device was suspended.

That is the only reason.. So probably does make more sense to do that
in the resume callback.
Will fix in v3.

Thanks,

Matt


>
> Best regards,
> Krzysztof
>
>
>> +
>> +       suspended = pm_runtime_suspended(&client->dev);
>> +       pm_runtime_get_sync(&client->dev);
>> +
>> +       /* regulator and FPGA needs settling time */
>> +       if (suspended)
>> +               usleep_range(15000, 20000);
>> +
>>         /* start sample */
>>         ret = lidar_write_control(data, LIDAR_REG_CONTROL_ACQUIRE);
>>         if (ret < 0) {
>> @@ -144,6 +164,10 @@ static int lidar_get_measurement(struct lidar_data *data, u16 *reg)
>>                 }
>>                 ret = -EIO;
>>         }
>> +       pm_runtime_mark_last_busy(&client->dev);
>> +       pm_runtime_put_autosuspend(&client->dev);
>> +
>> +       mutex_unlock(&data->lock);
>>
>>         return ret;
>>  }
>> @@ -231,6 +255,7 @@ static int lidar_probe(struct i2c_client *client,
>>         data = iio_priv(indio_dev);
>>         i2c_set_clientdata(client, indio_dev);
>>
>> +       mutex_init(&data->lock);
>>         data->client = client;
>>         data->indio_dev = indio_dev;
>>
>> @@ -243,6 +268,15 @@ static int lidar_probe(struct i2c_client *client,
>>         if (ret)
>>                 goto error_unreg_buffer;
>>
>> +       pm_runtime_set_autosuspend_delay(&client->dev, 1000);
>> +       pm_runtime_use_autosuspend(&client->dev);
>> +
>> +       pm_runtime_set_active(&client->dev);
>> +       pm_runtime_enable(&client->dev);
>> +
>> +       pm_runtime_mark_last_busy(&client->dev);
>> +       pm_runtime_idle(&client->dev);
>> +
>>         return 0;
>>
>>  error_unreg_buffer:
>> @@ -258,6 +292,9 @@ static int lidar_remove(struct i2c_client *client)
>>         iio_device_unregister(indio_dev);
>>         iio_triggered_buffer_cleanup(indio_dev);
>>
>> +       pm_runtime_disable(&client->dev);
>> +       pm_runtime_set_suspended(&client->dev);
>> +
>>         return 0;
>>  }
>>
>> @@ -273,10 +310,34 @@ static const struct of_device_id lidar_dt_ids[] = {
>>  };
>>  MODULE_DEVICE_TABLE(of, lidar_dt_ids);
>>
>> +#ifdef CONFIG_PM
>> +static int lidar_pm_runtime_suspend(struct device *dev)
>> +{
>> +       struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
>> +       struct lidar_data *data = iio_priv(indio_dev);
>> +
>> +       return lidar_write_power(data, 0x0f);
>> +}
>> +
>> +static int lidar_pm_runtime_resume(struct device *dev)
>> +{
>> +       struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
>> +       struct lidar_data *data = iio_priv(indio_dev);
>> +
>> +       return lidar_write_power(data, 0);
>> +}
>> +#endif
>> +
>> +static const struct dev_pm_ops lidar_pm_ops = {
>> +       SET_RUNTIME_PM_OPS(lidar_pm_runtime_suspend,
>> +                          lidar_pm_runtime_resume, NULL)
>> +};
>> +
>>  static struct i2c_driver lidar_driver = {
>>         .driver = {
>>                 .name   = LIDAR_DRV_NAME,
>>                 .of_match_table = of_match_ptr(lidar_dt_ids),
>> +               .pm     = &lidar_pm_ops,
>>         },
>>         .probe          = lidar_probe,
>>         .remove         = lidar_remove,
>> --
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
