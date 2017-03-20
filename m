From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 10/15] power: supply: bq24190_charger: Use extcon to
 determine ilimit, 5v boost
Date: Mon, 20 Mar 2017 23:38:19 +0100
Message-ID: <b40e333a-1d30-fc79-038e-75c2cc3a98cc@redhat.com>
References: <20170317095527.10487-1-hdegoede@redhat.com>
 <20170317095527.10487-11-hdegoede@redhat.com>
 <1489772011.19767.75.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <1489772011.19767.75.camel@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-acpi@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 17-03-17 18:33, Andy Shevchenko wrote:
> On Fri, 2017-03-17 at 10:55 +0100, Hans de Goede wrote:
>> Add support for monitoring an extcon device with SDP/CDP/DCP and HOST
>> cables and adjust ilimit and enable/disable the 5v boost converter
>> accordingly. This is necessary on systems where the PSEL pin is
>> hardwired
>> high and ILIM needs to be set by software based on the detected
>> charger
>> type.
>>
>
>>  config CHARGER_BQ24190
>>  	tristate "TI BQ24190 battery charger driver"
>>  	depends on I2C
>
>> +	depends on EXTCON
>
> I dunno what is preferred here, but if we would like to keep
> compatibility with previous configurations "select" should be used over
> "depends on".

select really should only be used for hidden options,
using select in other scenarios leads to all sort of
problems (hard to debug Kconfig dependency loops).

>
>> +static void bq24190_extcon_work(struct work_struct *work)
>> +{
>> +	struct bq24190_dev_info *bdi =
>> +		container_of(work, struct bq24190_dev_info,
>> extcon_work);
>> +	int ret, iinlim = 0;
>> +
>> +	if (extcon_get_state(bdi->extcon, EXTCON_CHG_USB_SDP) == 1)
>> +		iinlim = 500000;
>> +	else if (extcon_get_state(bdi->extcon, EXTCON_CHG_USB_CDP) ==
>> 1 ||
>> +		 extcon_get_state(bdi->extcon, EXTCON_CHG_USB_ACA) ==
>> 1)
>> +		iinlim = 1500000;
>> +	else if (extcon_get_state(bdi->extcon, EXTCON_CHG_USB_DCP) ==
>> 1)
>> +		iinlim = 2000000;
>> +
>
>> +	if (iinlim) {
>
> Could be possible to call below unconditionally here (use 0)?

If there is no Vbus setting iinlim is not useful, the charger
will reset it to a default as soon as Vbus comes up and i2c
transactions are not free.

>
>> +		ret = bq24190_set_field_val(bdi, BQ24190_REG_ISC,
>> +				BQ24190_REG_ISC_IINLIM_MASK,
>> +				BQ24190_REG_ISC_IINLIM_SHIFT,
>> +				bq24190_iinlim_values,
>> +				ARRAY_SIZE(bq24190_iinlim_values),
>> +				iinlim);
>> +		if (ret)
>> +			dev_err(bdi->dev, "Can't set IINLIM: %d\n",
>> ret);
>> +	}
>
> Perhaps make above as a helper?
>
> In that case no need for "if (iinlim)" and perhaps switch-case might be
> used instead of if-else-if (latter is up to you).

I prefer to keep this as is.

Thanks & Regards,

Hans
