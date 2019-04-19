From: Matheus Castello <matheus@castello.eng.br>
Subject: Re: [PATCH v2 1/4] power: supply: max17040: Add IRQ handler for low
 SOC alert
Date: Fri, 19 Apr 2019 15:12:48 -0300
Message-ID: <c4bffa4d-36bb-1f6c-cf56-69a990d9b832@castello.eng.br>
References: <CAJKOXPfvs=uETF0-xpwCWc5khSpWjpz2zz354Jcx1bVjm9cG2A@mail.gmail.com>
 <20190415012635.6369-1-matheus@castello.eng.br>
 <20190415012635.6369-2-matheus@castello.eng.br>
 <CAJKOXPfXS_L992rPdHqitFyRmw93En9GRLVOjRRnwGgiEwV28Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJKOXPfXS_L992rPdHqitFyRmw93En9GRLVOjRRnwGgiEwV28Q@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, Chanwoo Choi <cw00.choi@samsung.com>, =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?= <b.zolnierkie@samsung.com>, lee.jones@linaro.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



Em 4/15/19 4:10 AM, Krzysztof Kozlowski escreveu:
> On Mon, 15 Apr 2019 at 03:49, Matheus Castello <matheus@castello.eng.br> wrote:
>>
>> According datasheet max17040 has a pin for alert host for low SOC.
>> This pin can be used as external interrupt, so we need to check for
>> interrupts assigned for device and handle it.
>>
>> In hadler we are checking and storing fuel gauge registers values
>> and send an uevent to notificate user space, so user space can decide
>> save work or turn off since the alert demonstrate that the battery may
>> no have the power to keep the system turned on for much longer.
>>
>> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
>> ---
>>   drivers/power/supply/max17040_battery.c | 69 +++++++++++++++++++++++--
>>   1 file changed, 64 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
>> index 91cafc7bed30..8d2f8ed3f44c 100644
>> --- a/drivers/power/supply/max17040_battery.c
>> +++ b/drivers/power/supply/max17040_battery.c
>> @@ -13,6 +13,7 @@
>>   #include <linux/err.h>
>>   #include <linux/i2c.h>
>>   #include <linux/delay.h>
>> +#include <linux/interrupt.h>
>>   #include <linux/power_supply.h>
>>   #include <linux/max17040_battery.h>
>>   #include <linux/slab.h>
>> @@ -160,21 +161,40 @@ static void max17040_get_status(struct i2c_client *client)
>>                  chip->status = POWER_SUPPLY_STATUS_FULL;
>>   }
>>
>> +static void max17040_check_changes(struct i2c_client *client)
>> +{
>> +       max17040_get_vcell(client);
>> +       max17040_get_soc(client);
>> +       max17040_get_online(client);
>> +       max17040_get_status(client);
>> +}
>> +
>>   static void max17040_work(struct work_struct *work)
>>   {
>>          struct max17040_chip *chip;
>>
>>          chip = container_of(work, struct max17040_chip, work.work);
>> -
>> -       max17040_get_vcell(chip->client);
>> -       max17040_get_soc(chip->client);
>> -       max17040_get_online(chip->client);
>> -       max17040_get_status(chip->client);
>> +       max17040_check_changes(chip->client);
>>
>>          queue_delayed_work(system_power_efficient_wq, &chip->work,
>>                             MAX17040_DELAY);
>>   }
>>
>> +static irqreturn_t max17040_thread_handler(int id, void *dev)
>> +{
>> +       struct max17040_chip *chip = dev;
>> +       struct i2c_client *client = chip->client;
>> +
>> +       dev_warn(&client->dev, "IRQ: Alert battery low level");
>> +       /* read registers */
>> +       max17040_check_changes(chip->client);
>> +
>> +       /* send uevent */
>> +       power_supply_changed(chip->battery);
>> +
>> +       return IRQ_HANDLED;
>> +}
>> +
>>   static enum power_supply_property max17040_battery_props[] = {
>>          POWER_SUPPLY_PROP_STATUS,
>>          POWER_SUPPLY_PROP_ONLINE,
>> @@ -217,6 +237,27 @@ static int max17040_probe(struct i2c_client *client,
>>                  return PTR_ERR(chip->battery);
>>          }
>>
>> +       /* check interrupt */
>> +       if (client->irq) {
>> +               int ret;
>> +               unsigned int flags;
>> +
>> +               dev_info(&client->dev, "IRQ: enabled\n");
>> +               flags = IRQF_TRIGGER_FALLING | IRQF_ONESHOT;
>> +
>> +               ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
>> +                                               max17040_thread_handler, flags,
>> +                                               chip->battery->desc->name,
>> +                                               chip);
>> +
>> +               if (ret) {
>> +                       client->irq = 0;
>> +                       if (ret != -EBUSY)
> 
> Why not on EBUSY?
> 
>> +                               dev_warn(&client->dev,
>> +                                       "Failed to get IRQ err %d\n", ret);
>> +               }
>> +       }
>> +
>>          max17040_reset(client);
>>          max17040_get_version(client);
>>
>> @@ -224,6 +265,8 @@ static int max17040_probe(struct i2c_client *client,
>>          queue_delayed_work(system_power_efficient_wq, &chip->work,
>>                             MAX17040_DELAY);
>>
>> +       device_init_wakeup(&client->dev, 1);
> 
> Either you parse DT for wakeup-source property and use it... or you
> unconditionally enable wakeup. In the second case - there is no point
> to check later for device_may_wakeup(). Instead check the return value
> of device_init_wakeup().
> 
>> +
>>          return 0;
>>   }
>>
>> @@ -244,6 +287,14 @@ static int max17040_suspend(struct device *dev)
>>          struct max17040_chip *chip = i2c_get_clientdata(client);
>>
>>          cancel_delayed_work(&chip->work);
>> +
>> +       if (client->irq) {
>> +               if (device_may_wakeup(dev))
>> +                       enable_irq_wake(client->irq);
>> +               else
>> +                       disable_irq_wake(client->irq);
> 
> Did you try the wakeup from suspend? You do not have a disable_irq()
> here which usually was needed for interrupts to work properly on
> suspend. Maybe this was fixed?
> 
> Best regards,
> Krzysztof
> 
Hi Krzysztof,

I test it using mem state and suspend, resuming seems to have worked 
correctly ...

Thanks for the review, I'm working in your suggestions and I expect to 
send v3 this weekend.

Best Regards,
Matheus Castello
