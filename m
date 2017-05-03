From: Phil Reid <preid@electromag.com.au>
Subject: Re: [PATCH v6 3/8] i2c: i2c-smbus: add of_i2c_setup_smbus_alert
Date: Wed, 3 May 2017 16:31:07 +0800
Message-ID: <941fa093-5cdd-c3f3-1447-b564b5181961@electromag.com.au>
References: <1493716346-58517-1-git-send-email-preid@electromag.com.au>
 <1493716346-58517-4-git-send-email-preid@electromag.com.au>
 <20170502102013.GB2382@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from anchovy1.45ru.net.au ([203.30.46.145]:42119 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751913AbdECIbO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 May 2017 04:31:14 -0400
In-Reply-To: <20170502102013.GB2382@mail.corp.redhat.com>
Content-Language: en-AU
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org, peda@axentia.se, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org

G'day Benjamin,

On 2/05/2017 18:20, Benjamin Tissoires wrote:
> Hi Phil,
> 
> On May 02 2017 or thereabouts, Phil Reid wrote:
>> This commit adds of_i2c_setup_smbus_alert which allows the smbalert
>> driver to be attached to an i2c adapter via the device tree.
>>
>> Signed-off-by: Phil Reid <preid@electromag.com.au>
>> ---
>>   Documentation/devicetree/bindings/i2c/i2c.txt |  4 +--
>>   drivers/i2c/i2c-smbus.c                       | 35 +++++++++++++++++++++++++++
>>   include/linux/i2c-smbus.h                     |  9 +++++++
>>   3 files changed, 46 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/i2c/i2c.txt b/Documentation/devicetree/bindings/i2c/i2c.txt
>> index cee9d50..1126398 100644
>> --- a/Documentation/devicetree/bindings/i2c/i2c.txt
>> +++ b/Documentation/devicetree/bindings/i2c/i2c.txt
>> @@ -59,8 +59,8 @@ wants to support one of the below features, it should adapt the bindings below.
>>   	interrupts used by the device.
>>   
>>   - interrupt-names
>> -	"irq" and "wakeup" names are recognized by I2C core, other names are
>> -	left to individual drivers.
>> +	"irq", "wakeup" and "smbus_alert" names are recognized by I2C core,
>> +	other names are	left to individual drivers.
>>   
>>   - host-notify
>>   	device uses SMBus host notify protocol instead of interrupt line.
>> diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
>> index df0e2fa..a8f8439 100644
>> --- a/drivers/i2c/i2c-smbus.c
>> +++ b/drivers/i2c/i2c-smbus.c
>> @@ -21,6 +21,7 @@
>>   #include <linux/interrupt.h>
>>   #include <linux/kernel.h>
>>   #include <linux/module.h>
>> +#include <linux/of_irq.h>
>>   #include <linux/slab.h>
>>   #include <linux/workqueue.h>
>>   
>> @@ -238,6 +239,40 @@ struct i2c_client *i2c_setup_smbus_alert(struct i2c_adapter *adapter,
>>   }
>>   EXPORT_SYMBOL_GPL(i2c_setup_smbus_alert);
>>   
>> +int of_i2c_setup_smbus_alert(struct i2c_adapter *adap)
>> +{
>> +	struct i2c_client *client;
>> +	struct i2c_smbus_alert_setup *setup;
>> +	struct i2c_board_info info = {
>> +		I2C_BOARD_INFO("smbus_alert", 0x0c),
>> +	};
> 
> Shouldn't you use i2c_setup_smbus_alert() instead of manually recreating
> the board_info?
Yes looks like that could be cleaned up I think.
Look at i2c_new_device also it looks like client needs to be kept around and
i2c_unregister_device. I was assuming the apdater would clean it up.
But I'm not sure that's the case when looking again. That makes the change
more invasive into the adpater. would need to add an i2c_client ptr to the
i2c_adapter struct. Thoughts?

> Also i2c_setup_smbus_alert() mentions that the level trigger has to be
> explicitely mentioned, and I can't find if this is the case in your
> patch.
I'm not too sure how this wrks with the device tree / OF stuff.
But initally I had the device tree irq type set incorrectly and things
didn't work. Fixing that up and everything flow thru to the request irq
and was set for the correct mode. So I guessed there was some "magic" in
the core irq code somewhere.
I actually think the thread irq handler should be able to handle everything
and the work queue should disappear. Pretty sure the irq core handles disabling
level interrupts will the threaded handler services things now. But I don't
quite understand how the original code was handle edge vs level trigger irq's.
Not having access to test that I was reluctant to change the hard irq.
Any suggestions helpful...

> 
>> +	int irq;
>> +
>> +	if (!adap->dev.of_node)
>> +		return 0;
>> +
>> +	irq = of_irq_get_byname(adap->dev.of_node, "smbus_alert");
>> +	if (irq == -EINVAL || irq == -ENODATA)
>> +		return 0;
>> +	else if (irq < 0)
>> +		return irq;
>> +
>> +	setup = devm_kzalloc(&adap->dev, sizeof(struct i2c_smbus_alert_setup),
>> +		GFP_KERNEL);
> 
> Problem is i2c-core doesn't use devres at all for now. So the code is
> correct here as it won't segfault but mixing both devres and non-devres
> is error prone.
Ok I look at how to avoid the devm alloc.

> 
>> +	if (!setup)
>> +		return -ENOMEM;
>> +
>> +	setup->irq = irq;
>> +	info.platform_data = setup;
>> +
>> +	client = i2c_new_device(adap, &info);
>> +	if (!client)
>> +		return -ENODEV;
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(of_i2c_setup_smbus_alert);
>> +
>>   /**
>>    * i2c_handle_smbus_alert - Handle an SMBus alert
>>    * @ara: the ARA client on the relevant adapter
>> diff --git a/include/linux/i2c-smbus.h b/include/linux/i2c-smbus.h
>> index a138502..4732d09 100644
>> --- a/include/linux/i2c-smbus.h
>> +++ b/include/linux/i2c-smbus.h
>> @@ -50,4 +50,13 @@ struct i2c_client *i2c_setup_smbus_alert(struct i2c_adapter *adapter,
>>   					 struct i2c_smbus_alert_setup *setup);
>>   int i2c_handle_smbus_alert(struct i2c_client *ara);
>>   
>> +#if IS_ENABLED(CONFIG_I2C_SMBUS)
>> +int of_i2c_setup_smbus_alert(struct i2c_adapter *adap);
>> +#else
>> +static inline int of_i2c_setup_smbus_alert(struct i2c_adapter *adap)
>> +{
>> +	return 0;
>> +}
>> +#endif
>> +
>>   #endif /* _LINUX_I2C_SMBUS_H */
>> -- 
>> 1.8.3.1
> 
> Cheers,
> Benjamin
> 
> 


-- 
Regards
Phil Reid
