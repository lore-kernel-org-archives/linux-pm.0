From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 01/18] staging: typec: tcpm: Add get_usb2_current_limit
 tcpc_dev callback
Date: Sun, 6 Aug 2017 16:29:07 +0200
Message-ID: <5c9f12b9-f121-d33d-33eb-922e9ddbd43c@redhat.com>
References: <20170806123555.5124-1-hdegoede@redhat.com>
 <20170806123555.5124-2-hdegoede@redhat.com>
 <24f52936-c07e-8e57-6c30-259dd3f36e61@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49794 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751301AbdHFO3M (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 6 Aug 2017 10:29:12 -0400
In-Reply-To: <24f52936-c07e-8e57-6c30-259dd3f36e61@roeck-us.net>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Wolfram Sang <wsa@the-dreams.de>, Sebastian Reichel <sre@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Liam Breck <liam@networkimprov.net>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, devel@driverdev.osuosl.org

Hi,

On 06-08-17 16:18, Guenter Roeck wrote:
> On 08/06/2017 05:35 AM, Hans de Goede wrote:
>> A Rp signalling the default current limit indicates that we're possibly
>> connected to an USB2 power-source. In some cases the type-c
>> port-controller may provide the capability to detect the current-limit
>> for USB2 power-sources (through e.g. BC1.2 detection).
>>
>> This commit adds an optional get_usb2_current_limit tcpc_dev callback
>> which allows the port-controller to return the detected current-limit
>> if the CC pin is pulled up with Rp.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/staging/typec/tcpm.c | 5 ++++-
>>   drivers/staging/typec/tcpm.h | 1 +
>>   2 files changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/staging/typec/tcpm.c b/drivers/staging/typec/tcpm.c
>> index 20eb4ebcf8c3..9f5adace4309 100644
>> --- a/drivers/staging/typec/tcpm.c
>> +++ b/drivers/staging/typec/tcpm.c
>> @@ -660,7 +660,10 @@ static u32 tcpm_get_current_limit(struct tcpm_port *port)
>>           break;
>>       case TYPEC_CC_RP_DEF:
>>       default:
>> -        limit = 0;
>> +        if (port->tcpc->get_usb2_current_limit)
> 
> I think this callback should just be get_current_limit.

This is only used in the Rp-def case, which usually indicates being connected
with an A->C cable to a USB-2 device and the intend is for the callback to
implement some USB-2 specific method to detect the supported current-limit,
hence the name. If you prefer to name it just get_current_limit I can
change it for v2, but IMHO the usb2 part of the name is important as this
will not get called when USB-PD negotiation is used, nor when Rp has the Rp15
or Rp30 values.

Regards,

Hans



> 
>> +            limit = port->tcpc->get_usb2_current_limit(port->tcpc);
>> +        else
>> +            limit = 0;
>>           break;
>>       }
>> diff --git a/drivers/staging/typec/tcpm.h b/drivers/staging/typec/tcpm.h
>> index 19c307d31a5a..01b7d89379a3 100644
>> --- a/drivers/staging/typec/tcpm.h
>> +++ b/drivers/staging/typec/tcpm.h
>> @@ -108,6 +108,7 @@ struct tcpc_dev {
>>       int (*init)(struct tcpc_dev *dev);
>>       int (*get_vbus)(struct tcpc_dev *dev);
>> +    int (*get_usb2_current_limit)(struct tcpc_dev *dev); /* Optional */
>>       int (*set_cc)(struct tcpc_dev *dev, enum typec_cc_status cc);
>>       int (*get_cc)(struct tcpc_dev *dev, enum typec_cc_status *cc1,
>>                 enum typec_cc_status *cc2);
>>
> 
