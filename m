From: Nicolas Saenz Julienne <nicolas.saenz@prodys.net>
Subject: Re: [PATCH 1/2] power: supply: sbs-battery: use fixed device name
Date: Tue, 22 Nov 2016 16:31:51 +0100
Message-ID: <271e2a75-4676-b9ac-296b-282effc73d47@prodys.net>
References: <1479751491-8849-1-git-send-email-nicolas.saenz@prodys.net>
 <1479751491-8849-2-git-send-email-nicolas.saenz@prodys.net>
 <20161122152348.ip3gz3mea4fgrejl@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161122152348.ip3gz3mea4fgrejl@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Sebastian,
sorry I wasn't aware of that feature, I'll have a look at the whole
thing and rework the patch.

Regards,
Nicolas

On 22/11/16 16:23, Sebastian Reichel wrote:
> Hi,
> 
> On Mon, Nov 21, 2016 at 07:04:50PM +0100, Nicola Saenz Julienne wrote:
>> The current device name for sbs-battery is derived from it's i2c address.
>> This is not acceptable if we want to be able to trigger the
>> "external_power_changed()" routine from a charger driver.
>>
>> Signed-off-by: Nicola Saenz Julienne <nicolas.saenz@prodys.net>
>> ---
>>  drivers/power/supply/sbs-battery.c | 6 +-----
>>  1 file changed, 1 insertion(+), 5 deletions(-)
>>
>> diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
>> index 8bb2eb3..9565c696 100644
>> --- a/drivers/power/supply/sbs-battery.c
>> +++ b/drivers/power/supply/sbs-battery.c
>> @@ -740,6 +740,7 @@ static void sbs_delayed_work(struct work_struct *work)
>>  }
>>  
>>  static const struct power_supply_desc sbs_default_desc = {
>> +	.name = "sbs-battery",
>>  	.type = POWER_SUPPLY_TYPE_BATTERY,
>>  	.properties = sbs_properties,
>>  	.num_properties = ARRAY_SIZE(sbs_properties),
>> @@ -762,11 +763,6 @@ static int sbs_probe(struct i2c_client *client,
>>  	if (!sbs_desc)
>>  		return -ENOMEM;
>>  
>> -	sbs_desc->name = devm_kasprintf(&client->dev, GFP_KERNEL, "sbs-%s",
>> -			dev_name(&client->dev));
>> -	if (!sbs_desc->name)
>> -		return -ENOMEM;
>> -
>>  	chip = devm_kzalloc(&client->dev, sizeof(struct sbs_info), GFP_KERNEL);
>>  	if (!chip)
>>  		return -ENOMEM;
> 
> NAK. This is not ok for systems using multiple sbs-batteries.
> Also please read:
> 
> Documentation/devicetree/bindings/power/supply/power_supply.txt
> 
> -- Sebastian
> 
