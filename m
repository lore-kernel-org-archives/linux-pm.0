From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH v3 2/3] power: supply: add cros-ec USBPD charger driver.
Date: Wed, 2 May 2018 17:40:04 +0200
Message-ID: <74e594f1-2c5c-b543-9e32-90c89f1bf3e3@collabora.com>
References: <20180502095343.17092-1-enric.balletbo@collabora.com>
 <20180502095343.17092-3-enric.balletbo@collabora.com>
 <20180502105710.bi3tztsjkpcby2ui@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180502105710.bi3tztsjkpcby2ui@earth.universe>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Lee Jones <lee.jones@linaro.org>, Gwendal Grignou <gwendal@chromium.org>, Sameer Nanda <snanda@chromium.org>, linux-pm@vger.kernel.org, Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>, miguel.ojeda.sandonis@gmail.com, kernel@collabora.com
List-Id: linux-pm@vger.kernel.org

Hi Sebastian,

On 02/05/18 12:57, Sebastian Reichel wrote:
> Hi,
> 
> I found one more issue, otherwise the driver looks fine to me.
> 
> On Wed, May 02, 2018 at 11:53:42AM +0200, Enric Balletbo i Serra wrote:
>> This driver gets various bits of information about what is connected to
>> USB PD ports from the EC and converts that into power_supply properties.
>>
>> Signed-off-by: Sameer Nanda <snanda@chromium.org>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> Acked-by: Lee Jones <lee.jones@linaro.org>
>> ---
> [...]
>> +static int cros_usbpd_charger_probe(struct platform_device *pd)
>> +{
> [...]
>> +	for (i = 0; i < charger->num_charger_ports; i++) {
> [...]
>> +		psy = devm_power_supply_register_no_ws(dev, psy_desc,
>> +						       &psy_cfg);
> [...]
>> +		ec_device->charger = psy;
>> + }
> [...]
>> diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
>> index f36125ee9245..a1eb39344231 100644
>> --- a/include/linux/mfd/cros_ec.h
>> +++ b/include/linux/mfd/cros_ec.h
>> @@ -19,6 +19,7 @@
>>  #include <linux/cdev.h>
>>  #include <linux/device.h>
>>  #include <linux/notifier.h>
>> +#include <linux/power_supply.h>
>>  #include <linux/mfd/cros_ec_commands.h>
>>  #include <linux/mutex.h>
>>  
>> @@ -143,6 +144,7 @@ struct cros_ec_device {
>>  			struct cros_ec_command *msg);
>>  	int (*pkt_xfer)(struct cros_ec_device *ec,
>>  			struct cros_ec_command *msg);
>> +	struct power_supply *charger;
>>  	struct mutex lock;
>>  	bool mkbp_event_supported;
>>  	struct blocking_notifier_head event_notifier;
> 
> I think cros_ec_device->charger can be dropped:
> 
>  * It is not cleared on power-supply removal
>  * It randomly points to the last registered power-supply
>  * It is only set, but never used
> 

Good catch, a v4 fixing this will be send very soon.

> -- Sebastian
> 
