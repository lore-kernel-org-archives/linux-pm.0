From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH v3 1/2] power: supply: ltc2941-battery-gauge: Add OF
 device ID table
Date: Wed, 15 Mar 2017 17:59:24 -0300
Message-ID: <4554bede-4977-c0b3-d9d8-468b0faae3d0@osg.samsung.com>
References: <20170315034349.8494-1-javier@osg.samsung.com>
 <20170315205518.sjzijt6likrrau7b@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:49637
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751822AbdCOU7g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Mar 2017 16:59:36 -0400
In-Reply-To: <20170315205518.sjzijt6likrrau7b@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

Hello Sebastian,

On 03/15/2017 05:55 PM, Sebastian Reichel wrote:
> Hi,
> 
> On Wed, Mar 15, 2017 at 12:43:48AM -0300, Javier Martinez Canillas wrote:
>> The driver doesn't have a struct of_device_id table but supported devices
>> are registered via Device Trees. This is working on the assumption that a
>> I2C device registered via OF will always match a legacy I2C device ID and
>> that the MODALIAS reported will always be of the form i2c:<device>.
> 
> I don't get hits for "grep -r ltc294[13]" in arch/.
>

There isn't a mainline DTS that use these but the compatible strings (without a
vendor prefix) are listed in the following DT binding document:

Documentation/devicetree/bindings/power/supply/ltc2941.txt.
 
>> But this could change in the future so the correct approach is to have an
>> OF device ID table if the devices are registered via OF.
>>
>> The compatible strings don't have a vendor prefix because that's how it's
>> used currently, and changing this will be a Device Tree ABI break.
> 
> I think the DT strings should have a vendor prefix.
> So I will only queue this with an explicit Acked-By from Rob or Mark.
>

Yes, I agree with you. I don't know though what should happen with DT bindings
that mentions a compatible without a vendor prefix as the one for this driver.

> -- Sebastian
> 
>> Changes in v3:
>> - Don't use of_match_ptr() to avoid build warning when CONFIG_OF is disabled.
>>
>> Changes in v2:
>>  Fix build warning reported by kbuild test robot.
>> - Fix wrong compatible strings due a copy & paste error.
>>
>>  drivers/power/supply/ltc2941-battery-gauge.c | 19 +++++++++++++++++--
>>  1 file changed, 17 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/power/supply/ltc2941-battery-gauge.c b/drivers/power/supply/ltc2941-battery-gauge.c
>> index 4adf2ba021ce..d3052be1bead 100644
>> --- a/drivers/power/supply/ltc2941-battery-gauge.c
>> +++ b/drivers/power/supply/ltc2941-battery-gauge.c
>> @@ -9,6 +9,7 @@
>>   */
>>  #include <linux/kernel.h>
>>  #include <linux/module.h>
>> +#include <linux/of_device.h>
>>  #include <linux/types.h>
>>  #include <linux/errno.h>
>>  #include <linux/swab.h>
>> @@ -61,7 +62,7 @@ struct ltc294x_info {
>>  	struct power_supply *supply;	/* Supply pointer */
>>  	struct power_supply_desc supply_desc;	/* Supply description */
>>  	struct delayed_work work;	/* Work scheduler */
>> -	int num_regs;	/* Number of registers (chip type) */
>> +	unsigned long num_regs;	/* Number of registers (chip type) */
>>  	int charge;	/* Last charge register content */
>>  	int r_sense;	/* mOhm */
>>  	int Qlsb;	/* nAh */
>> @@ -387,7 +388,7 @@ static int ltc294x_i2c_probe(struct i2c_client *client,
>>  
>>  	np = of_node_get(client->dev.of_node);
>>  
>> -	info->num_regs = id->driver_data;
>> +	info->num_regs = (unsigned long)of_device_get_match_data(&client->dev);
>>  	info->supply_desc.name = np->name;
>>  
>>  	/* r_sense can be negative, when sense+ is connected to the battery
>> @@ -497,9 +498,23 @@ static const struct i2c_device_id ltc294x_i2c_id[] = {
>>  };
>>  MODULE_DEVICE_TABLE(i2c, ltc294x_i2c_id);
>>  
>> +static const struct of_device_id ltc294x_i2c_of_match[] = {
>> +	{
>> +		.compatible = "ltc2941",
>> +		.data = (void *)LTC2941_NUM_REGS
>> +	},
>> +	{
>> +		.compatible = "ltc2943",
>> +		.data = (void *)LTC2943_NUM_REGS
>> +	},
>> +	{ },
>> +};
>> +MODULE_DEVICE_TABLE(of, ltc294x_i2c_of_match);
>> +
>>  static struct i2c_driver ltc294x_driver = {
>>  	.driver = {
>>  		.name	= "LTC2941",
>> +		.of_match_table = ltc294x_i2c_of_match,
>>  		.pm	= LTC294X_PM_OPS,
>>  	},
>>  	.probe		= ltc294x_i2c_probe,
>> -- 
>> 2.9.3
>>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
