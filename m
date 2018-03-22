From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v5 4/5] typec: tcpm: Represent source supply through
 power_supply
Date: Thu, 22 Mar 2018 06:20:09 -0700
Message-ID: <03fddd26-f554-b4a5-3fd3-04a7921a9f29@roeck-us.net>
References: <cover.1521552959.git.Adam.Thomson.Opensource@diasemi.com>
 <510c0897961f234daca295b273bf4e5047498c55.1521552959.git.Adam.Thomson.Opensource@diasemi.com>
 <b2d508dc-c344-6447-1c50-69f268fdbb83@roeck-us.net>
 <2E89032DDAA8B9408CB92943514A0337014C1E28A3@SW-EX-MBX01.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2E89032DDAA8B9408CB92943514A0337014C1E28A3@SW-EX-MBX01.diasemi.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Jun Li <jun.li@nxp.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Support Opensource <Support.Opensource@diasemi.com>
List-Id: linux-pm@vger.kernel.org

On 03/22/2018 03:40 AM, Adam Thomson wrote:
> On 22 March 2018 04:09, Guenter Roeck wrote:
> 
>>> +static int tcpm_psy_set_prop(struct power_supply *psy,
>>> +			     enum power_supply_property psp,
>>> +			     const union power_supply_propval *val)
>>> +{
>>> +	struct tcpm_port *port = power_supply_get_drvdata(psy);
>>> +	int ret = 0;
>>> +
>>> +	switch (psp) {
>>> +	case POWER_SUPPLY_PROP_ONLINE:
>>> +		ret = tcpm_psy_set_online(port, val);
>>> +		break;
>>> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
>>> +		if ((val->intval < (port->pps_data.min_volt * 1000)) ||
>>> +		    (val->intval > (port->pps_data.max_volt * 1000)))
>>> +			ret = -EINVAL;
>>> +		else
>>> +			ret = tcpm_pps_set_out_volt(port, (val->intval / 1000));
>>> +		break;
>>> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
>>> +		if (val->intval > (port->pps_data.max_curr * 1000))
>>> +			ret = -EINVAL;
>>> +		else
>>> +			ret = tcpm_pps_set_op_curr(port, (val->intval / 1000));
>>
>> I am really not a friend of excessive ( ).
> 
> Yes, I got that. :) I am of the opinion that they should be used to enforce
> precedence. This to me is good coding practice and makes it unambiguous for the
> reader. That's why I use them as above. Do you think the above uses make it
> harder to understand or more difficult to maintain?
> 
It confuses me and makes me think I am missing something, and causes me to miss
the _real_ problems. If the compiler is not able to enforce precedence, even more so
in situations like the above, I think it is about time to dump it.

Either case, your call to make. I wont give patches with excessive ( ) a Reviewed-by:,
but then others can review the code.

Thanks,
Guenter
