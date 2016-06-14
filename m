From: Chris Lapa <chris@lapa.com.au>
Subject: Re: [PATCH v2 2/4] max8903: adds support for initiation via device
 tree.
Date: Tue, 14 Jun 2016 11:50:55 +1000
Message-ID: <110c1e80-eaf6-56c5-29ba-09925c945340@lapa.com.au>
References: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
 <1465561970-18377-1-git-send-email-chris@lapa.com.au>
 <1465561970-18377-3-git-send-email-chris@lapa.com.au>
 <575AC893.7030106@samsung.com>
Reply-To: chris@lapa.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <575AC893.7030106@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Krzysztof,

Appreciate the feedback, working on the fixups you pointed out now.

I'll ensure I send v3 of the patches to the actual maintainers and not 
just the list. Still getting my head around the lists mechanics :)

Thanks,
Chris:

On 11/06/2016 12:02 AM, Krzysztof Kozlowski wrote:
> On 06/10/2016 02:32 PM, Chris Lapa wrote:
>> From: Chris Lapa <chris@lapa.com.au>
>>
>> This commit also adds requesting gpio's via devm_gpio_request() to ensure
>> the gpio is available for usage by the driver.
>>
>> Signed-off-by: Chris Lapa <chris@lapa.com.au>
>> ---
>>  drivers/power/max8903_charger.c | 288 +++++++++++++++++++++++++++++++---------
>>  1 file changed, 225 insertions(+), 63 deletions(-)
>>
>> diff --git a/drivers/power/max8903_charger.c b/drivers/power/max8903_charger.c
>> index 17876ca..d7544c8 100644
>> --- a/drivers/power/max8903_charger.c
>> +++ b/drivers/power/max8903_charger.c
>> @@ -23,13 +23,16 @@
>>  #include <linux/gpio.h>
>>  #include <linux/interrupt.h>
>>  #include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/of_gpio.h>
>>  #include <linux/slab.h>
>>  #include <linux/power_supply.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/power/max8903_charger.h>
>>
>>  struct max8903_data {
>> -	struct max8903_pdata pdata;
>> +	struct max8903_pdata *pdata;
>
> Please split the conversion to '*pdata' to separate patch. It obfuscates
> a lot the patch so it is difficult to find the DT changes.
>
>>  	struct device *dev;
>>  	struct power_supply *psy;
>>  	struct power_supply_desc psy_desc;
>> @@ -53,8 +56,8 @@ static int max8903_get_property(struct power_supply *psy,
>>  	switch (psp) {
>>  	case POWER_SUPPLY_PROP_STATUS:
>>  		val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
>> -		if (data->pdata.chg) {
>> -			if (gpio_get_value(data->pdata.chg) == 0)
>> +		if (data->pdata->chg) {
>> +			if (gpio_get_value(data->pdata->chg) == 0)
>>  				val->intval = POWER_SUPPLY_STATUS_CHARGING;
>>  			else if (data->usb_in || data->ta_in)
>>  				val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
>> @@ -75,13 +78,14 @@ static int max8903_get_property(struct power_supply *psy,
>>  	default:
>>  		return -EINVAL;
>>  	}
>> +
>>  	return 0;
>>  }
>>
>>  static irqreturn_t max8903_dcin(int irq, void *_data)
>>  {
>>  	struct max8903_data *data = _data;
>> -	struct max8903_pdata *pdata = &data->pdata;
>> +	struct max8903_pdata *pdata = data->pdata;
>>  	bool ta_in;
>>  	enum power_supply_type old_type;
>>
>> @@ -122,7 +126,7 @@ static irqreturn_t max8903_dcin(int irq, void *_data)
>>  static irqreturn_t max8903_usbin(int irq, void *_data)
>>  {
>>  	struct max8903_data *data = _data;
>> -	struct max8903_pdata *pdata = &data->pdata;
>> +	struct max8903_pdata *pdata = data->pdata;
>>  	bool usb_in;
>>  	enum power_supply_type old_type;
>>
>> @@ -161,7 +165,7 @@ static irqreturn_t max8903_usbin(int irq, void *_data)
>>  static irqreturn_t max8903_fault(int irq, void *_data)
>>  {
>>  	struct max8903_data *data = _data;
>> -	struct max8903_pdata *pdata = &data->pdata;
>> +	struct max8903_pdata *pdata = data->pdata;
>>  	bool fault;
>>
>>  	fault = gpio_get_value(pdata->flt) ? false : true;
>> @@ -179,38 +183,132 @@ static irqreturn_t max8903_fault(int irq, void *_data)
>>  	return IRQ_HANDLED;
>>  }
>>
>> +static struct max8903_pdata *max8903_parse_dt_data(
>> +		struct device *dev)
>> +{
>> +	struct device_node *of_node = dev->of_node;
>> +	struct max8903_pdata *pdata = NULL;
>> +
>> +	if (!of_node)
>> +		return pdata;
>> +
>
> Unnecessary blank line.
>
> Just "return NULL", it is easier to read such code (no need to double
> check if pdata was initialized or not).
>
>> +
>> +	pdata = devm_kzalloc(dev, sizeof(struct max8903_pdata),
>
> sizeof(*pdata)
>
>> +				GFP_KERNEL);
>> +	if (!pdata)
>> +		return pdata;
>
> Ditto, return NULL.
>
>> +
>> +	if (of_get_property(of_node, "dc_valid", NULL))
>> +		pdata->dc_valid = true;
>> +
>> +	if (of_get_property(of_node, "usb_valid", NULL))
>> +		pdata->usb_valid = true;
>> +
>> +	pdata->cen = of_get_named_gpio(of_node, "cen-gpios", 0);
>> +	if (!gpio_is_valid(pdata->cen))
>> +		pdata->cen = 0;
>
> 0 could be a valid GPIO so probably you want:
> 	pdata->cen = -EINVAL;
>
>> +
>> +	pdata->chg = of_get_named_gpio(of_node, "chg-gpios", 0);
>> +	if (!gpio_is_valid(pdata->chg))
>> +		pdata->chg = 0;
>> +
>> +	pdata->flt = of_get_named_gpio(of_node, "flt-gpios", 0);
>> +	if (!gpio_is_valid(pdata->flt))
>> +		pdata->flt = 0;
>> +
>> +	pdata->usus = of_get_named_gpio(of_node, "usus-gpios", 0);
>> +	if (!gpio_is_valid(pdata->usus))
>> +		pdata->usus = 0;
>> +
>> +	pdata->dcm = of_get_named_gpio(of_node, "dcm-gpios", 0);
>> +	if (!gpio_is_valid(pdata->dcm))
>> +		pdata->dcm = 0;
>> +
>> +	pdata->dok = of_get_named_gpio(of_node, "dok-gpios", 0);
>> +	if (!gpio_is_valid(pdata->dok))
>> +		pdata->dok = 0;
>> +
>> +	pdata->uok = of_get_named_gpio(of_node, "uok-gpios", 0);
>> +	if (!gpio_is_valid(pdata->uok))
>> +		pdata->uok = 0;
>> +
>> +	return pdata;
>> +}
>> +
>>  static int max8903_probe(struct platform_device *pdev)
>>  {
>> -	struct max8903_data *data;
>> +	struct max8903_data *charger;
>>  	struct device *dev = &pdev->dev;
>> -	struct max8903_pdata *pdata = pdev->dev.platform_data;
>>  	struct power_supply_config psy_cfg = {};
>>  	int ret = 0;
>>  	int gpio;
>>  	int ta_in = 0;
>>  	int usb_in = 0;
>>
>> -	data = devm_kzalloc(dev, sizeof(struct max8903_data), GFP_KERNEL);
>> -	if (data == NULL) {
>> +	charger = devm_kzalloc(dev, sizeof(struct max8903_data), GFP_KERNEL);
>> +	if (charger == NULL) {
>>  		dev_err(dev, "Cannot allocate memory.\n");
>>  		return -ENOMEM;
>>  	}
>> -	memcpy(&data->pdata, pdata, sizeof(struct max8903_pdata));
>> -	data->dev = dev;
>> -	platform_set_drvdata(pdev, data);
>>
>> -	if (pdata->dc_valid == false && pdata->usb_valid == false) {
>> +	charger->pdata = pdev->dev.platform_data;
>> +	if (IS_ENABLED(CONFIG_OF) && !charger->pdata && dev->of_node) {
>> +		charger->pdata = max8903_parse_dt_data(dev);
>> +		if (!charger->pdata)
>> +			return -EINVAL;
>> +	}
>> +
>> +	charger->dev = dev;
>> +
>> +	platform_set_drvdata(pdev, charger);
>> +
>> +	charger->fault = false;
>> +	charger->ta_in = ta_in;
>> +	charger->usb_in = usb_in;
>> +
>> +	charger->psy_desc.name = "max8903_charger";
>> +	charger->psy_desc.type = (ta_in) ? POWER_SUPPLY_TYPE_MAINS :
>> +			((usb_in) ? POWER_SUPPLY_TYPE_USB :
>> +			 POWER_SUPPLY_TYPE_BATTERY);
>> +	charger->psy_desc.get_property = max8903_get_property;
>> +	charger->psy_desc.properties = max8903_charger_props;
>> +	charger->psy_desc.num_properties = ARRAY_SIZE(max8903_charger_props);
>> +
>> +	if (charger->pdata->dc_valid == false &&
>> +			charger->pdata->usb_valid == false) {
>>  		dev_err(dev, "No valid power sources.\n");
>>  		return -EINVAL;
>>  	}
>>
>> -	if (pdata->dc_valid) {
>> -		if (pdata->dok && gpio_is_valid(pdata->dok) &&
>> -				pdata->dcm && gpio_is_valid(pdata->dcm)) {
>> -			gpio = pdata->dok; /* PULL_UPed Interrupt */
>> +	if (charger->pdata->dc_valid) {
>> +		if (charger->pdata->dok &&
>> +				gpio_is_valid(charger->pdata->dok) &&
>> +				charger->pdata->dcm &&
>> +				gpio_is_valid(charger->pdata->dcm)) {
>> +			ret = devm_gpio_request(dev,
>> +						charger->pdata->dok,
>> +						charger->psy_desc.name);
>> +			if (ret) {
>> +				dev_err(dev,
>> +					"Failed GPIO request for dok: %d err %d\n",
>> +					charger->pdata->dok, ret);
>> +				return -EINVAL;
>> +			}
>> +
>> +			ret = devm_gpio_request(dev,
>> +						charger->pdata->dcm,
>> +						charger->psy_desc.name);
>> +			if (ret) {
>> +				dev_err(dev,
>> +					"Failed GPIO request for dcm: %d err %d\n",
>> +					charger->pdata->dcm, ret);
>> +				return -EINVAL;
>> +			}
>> +
>> +			gpio = charger->pdata->dok; /* PULL_UPed Interrupt */
>>  			ta_in = gpio_get_value(gpio) ? 0 : 1;
>>
>> -			gpio = pdata->dcm; /* Output */
>> +			gpio = charger->pdata->dcm; /* Output */
>>  			gpio_set_value(gpio, ta_in);
>>  		} else {
>>  			dev_err(dev, "When DC is wired, DOK and DCM should"
>> @@ -218,19 +316,39 @@ static int max8903_probe(struct platform_device *pdev)
>>  			return -EINVAL;
>>  		}
>>  	} else {
>> -		if (pdata->dcm) {
>> -			if (gpio_is_valid(pdata->dcm))
>> -				gpio_set_value(pdata->dcm, 0);
>> -			else {
>> +		if (charger->pdata->dcm) {
>> +			if (gpio_is_valid(charger->pdata->dcm)) {
>> +				ret = devm_gpio_request(dev,
>> +							charger->pdata->dcm,
>> +							charger->psy_desc.name);
>> +				if (ret) {
>> +					dev_err(dev,
>> +						"Failed GPIO request for dcm: %d err %d\n",
>> +						charger->pdata->dcm, ret);
>> +					return -EINVAL;
>> +				}
>> +
>> +				gpio_set_value(charger->pdata->dcm, 0);
>> +			} else {
>>  				dev_err(dev, "Invalid pin: dcm.\n");
>>  				return -EINVAL;
>>  			}
>>  		}
>>  	}
>>
>> -	if (pdata->usb_valid) {
>> -		if (pdata->uok && gpio_is_valid(pdata->uok)) {
>> -			gpio = pdata->uok;
>> +	if (charger->pdata->usb_valid) {
>> +		if (gpio_is_valid(charger->pdata->uok)) {
>> +			ret = devm_gpio_request(dev,
>> +						charger->pdata->uok,
>> +						charger->psy_desc.name);
>> +			if (ret) {
>> +				dev_err(dev,
>> +					"Failed GPIO request for uok: %d err %d\n",
>> +					charger->pdata->uok, ret);
>> +				return -EINVAL;
>> +			}
>> +
>> +			gpio = charger->pdata->uok;
>>  			usb_in = gpio_get_value(gpio) ? 0 : 1;
>>  		} else {
>>  			dev_err(dev, "When USB is wired, UOK should be wired."
>> @@ -239,91 +357,128 @@ static int max8903_probe(struct platform_device *pdev)
>>  		}
>>  	}
>>
>> -	if (pdata->cen) {
>> -		if (gpio_is_valid(pdata->cen)) {
>> -			gpio_set_value(pdata->cen, (ta_in || usb_in) ? 0 : 1);
>> +	if (charger->pdata->cen) {
>> +		if (gpio_is_valid(charger->pdata->cen)) {
>> +			ret = devm_gpio_request(dev,
>> +						charger->pdata->cen,
>> +						charger->psy_desc.name);
>> +			if (ret) {
>> +				dev_err(dev,
>> +					"Failed GPIO request for cen: %d err %d\n",
>> +					charger->pdata->cen, ret);
>> +				return -EINVAL;
>> +			}
>> +
>> +			gpio_set_value(charger->pdata->cen,
>> +					(ta_in || usb_in) ? 0 : 1);
>>  		} else {
>>  			dev_err(dev, "Invalid pin: cen.\n");
>>  			return -EINVAL;
>>  		}
>>  	}
>>
>> -	if (pdata->chg) {
>> -		if (!gpio_is_valid(pdata->chg)) {
>> +	if (charger->pdata->chg) {
>> +		if (gpio_is_valid(charger->pdata->chg)) {
>> +			ret = devm_gpio_request(dev,
>> +						charger->pdata->chg,
>> +						charger->psy_desc.name);
>> +			if (ret) {
>> +				dev_err(dev,
>> +					"Failed GPIO request for chg: %d err %d\n",
>> +					charger->pdata->chg, ret);
>> +				return -EINVAL;
>> +			}
>> +		} else {
>>  			dev_err(dev, "Invalid pin: chg.\n");
>>  			return -EINVAL;
>>  		}
>>  	}
>>
>> -	if (pdata->flt) {
>> -		if (!gpio_is_valid(pdata->flt)) {
>> +	if (charger->pdata->flt) {
>> +		if (gpio_is_valid(charger->pdata->flt)) {
>> +			ret = devm_gpio_request(dev,
>> +						charger->pdata->flt,
>> +						charger->psy_desc.name);
>> +			if (ret) {
>> +				dev_err(dev,
>> +					"Failed GPIO request for flt: %d err %d\n",
>> +					charger->pdata->flt, ret);
>> +				return -EINVAL;
>> +			}
>> +		} else {
>>  			dev_err(dev, "Invalid pin: flt.\n");
>>  			return -EINVAL;
>>  		}
>>  	}
>>
>> -	if (pdata->usus) {
>> -		if (!gpio_is_valid(pdata->usus)) {
>> +	if (charger->pdata->usus) {
>> +		if (gpio_is_valid(charger->pdata->usus)) {
>> +			ret = devm_gpio_request(dev,
>> +						charger->pdata->usus,
>> +						charger->psy_desc.name);
>> +			if (ret) {
>> +				dev_err(dev,
>> +					"Failed GPIO request for usus: %d err %d\n",
>> +					charger->pdata->usus, ret);
>> +				return -EINVAL;
>> +			}
>> +		} else {
>>  			dev_err(dev, "Invalid pin: usus.\n");
>>  			return -EINVAL;
>>  		}
>>  	}
>>
>> -	data->fault = false;
>> -	data->ta_in = ta_in;
>> -	data->usb_in = usb_in;
>> +	psy_cfg.supplied_to = NULL;
>> +	psy_cfg.num_supplicants = 0;
>
> Why? This is already set to 0. Additionally this does not look needded
> for conversion to DT. Please split out all unrelated changes to separate
> patches. It could be organized as:
> patch #1: Document DT bindings.
> patch #2: Some fix needed.
> patch #3: Some other cleanup
> patch #4: Store pointer to pdata instead of copying it
> patch #5: Add support for Device Tree
>
> Best regards,
> Krzysztof
>
