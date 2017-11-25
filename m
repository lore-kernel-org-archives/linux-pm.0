From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [RFC PATCH v2 6/7] typec: tcpm: Represent source supply through
 power_supply class
Date: Sat, 25 Nov 2017 15:03:02 +0100
Message-ID: <3f1b813d-a9a9-756e-718c-5b2aa2b72906@redhat.com>
References: <cover.1510657748.git.Adam.Thomson.Opensource@diasemi.com>
 <81dd8843163c9ca193f32d54adb6fece99e5f159.1510657748.git.Adam.Thomson.Opensource@diasemi.com>
 <20171124121902.GA2403@kuha.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56474 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751166AbdKYODH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 25 Nov 2017 09:03:07 -0500
In-Reply-To: <20171124121902.GA2403@kuha.fi.intel.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Yueyao Zhu <yueyao.zhu@gmail.com>, Rui Miguel Silva <rmfrfs@gmail.com>, linux-usb@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, support.opensource@diasemi.com

Hi,

On 11/24/2017 01:19 PM, Heikki Krogerus wrote:
> Hi,
> 
> On Tue, Nov 14, 2017 at 11:44:47AM +0000, Adam Thomson wrote:
>> diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
>> index 78983e1..7c26c3d 100644
>> --- a/drivers/usb/typec/tcpm.c
>> +++ b/drivers/usb/typec/tcpm.c
>> @@ -12,6 +12,7 @@
>>   #include <linux/kernel.h>
>>   #include <linux/module.h>
>>   #include <linux/mutex.h>
>> +#include <linux/power_supply.h>
>>   #include <linux/proc_fs.h>
>>   #include <linux/sched/clock.h>
>>   #include <linux/seq_file.h>
>> @@ -277,6 +278,10 @@ struct tcpm_port {
>>   	u32 current_limit;
>>   	u32 supply_voltage;
>>   
>> +	/* Used to export TA voltage and current */
>> +	struct power_supply *psy;
>> +	struct power_supply_desc psy_desc;
>> +
>>   	u32 bist_request;
>>   
>>   	/* PD state for Vendor Defined Messages */
>> @@ -1756,6 +1761,7 @@ static int tcpm_pd_select_pdo(struct tcpm_port *port)
>>   	int ret = -EINVAL;
>>   
>>   	port->pps_data.supported = false;
>> +	port->psy_desc.type = POWER_SUPPLY_TYPE_USB_PD;
>>   
>>   	/*
>>   	 * Select the source PDO providing the most power while staying within
>> @@ -1775,8 +1781,10 @@ static int tcpm_pd_select_pdo(struct tcpm_port *port)
>>   			mv = pdo_min_voltage(pdo);
>>   			break;
>>   		case PDO_TYPE_APDO:
>> -			if (pdo_apdo_type(pdo) == APDO_TYPE_PPS)
>> +			if (pdo_apdo_type(pdo) == APDO_TYPE_PPS) {
>>   				port->pps_data.supported = true;
>> +				port->psy_desc.type = POWER_SUPPLY_TYPE_USB_PD_PPS;
>> +			}
>>   			continue;
>>   		default:
>>   			tcpm_log(port, "Invalid PDO type, ignoring");
>> @@ -2248,6 +2256,9 @@ static void tcpm_reset_port(struct tcpm_port *port)
>>   	port->try_snk_count = 0;
>>   	port->supply_voltage = 0;
>>   	port->current_limit = 0;
>> +	port->psy_desc.type = POWER_SUPPLY_TYPE_USB_TYPE_C;
> 
> Is it OK to everybody that the type of the psy is changed like that?
> Hans?!
> 
> We do have drivers that already change the type, for example
> drivers/power/supply/isp1704_charger.c, but what does the user space
> expect? The ABI for the power supply class was never documented I
> guess.

The main userspace consumer of the power_supply sysfs class is upower,
upower knows about 3 types: "Mains", "Battery" and "USB", anything
else it gives a type of UP_DEVICE_KIND_UNKNOWN. So POWER_SUPPLY_TYPE_USB_TYPE_C
vs POWER_SUPPLY_TYPE_USB_PD_PPS does matter to it.

Regards,

Hans
