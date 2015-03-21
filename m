From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] thermal: Do not log an error if thermal_zone_get_temp
 returns -EAGAIN
Date: Sat, 21 Mar 2015 14:59:48 +0100
Message-ID: <550D7954.9020006@redhat.com>
References: <1426000006-15729-1-git-send-email-hdegoede@redhat.com> <20150307065114.GA28318@developer>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45567 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751349AbbCUN77 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 21 Mar 2015 09:59:59 -0400
In-Reply-To: <20150307065114.GA28318@developer>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-pm@vger.kernel.org

Hi,

On 07-03-15 07:51, Eduardo Valentin wrote:
> Hans,
>
> Thanks for fixing this. One minor request though.
>
> On Tue, Mar 10, 2015 at 04:06:46PM +0100, Hans de Goede wrote:
>> Some temperature sensors only get updated every few seconds and while
>> waiting for the first irq reporting a (new) temperature to happen there
>> get_temp operand will return -EAGAIN as it does not have any data to report
>> yet.
>>
>> Not logging an error in this case avoids messages like these from showing
>> up in dmesg on affected systems:
>>
>> [    1.219353] thermal thermal_zone0: failed to read out thermal zone 0
>> [    2.015433] thermal thermal_zone0: failed to read out thermal zone 0
>> [    2.416737] thermal thermal_zone0: failed to read out thermal zone 0
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/thermal/thermal_core.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
>> index 48491d1..e3cbf34 100644
>> --- a/drivers/thermal/thermal_core.c
>> +++ b/drivers/thermal/thermal_core.c
>> @@ -458,8 +458,10 @@ static void update_temperature(struct thermal_zone_device *tz)
>>
>>   	ret = thermal_zone_get_temp(tz, &temp);
>>   	if (ret) {
>> -		dev_warn(&tz->device, "failed to read out thermal zone %d\n",
>> -			 tz->id);
>> +		if (ret != -EAGAIN)
>> +			dev_warn(&tz->device,
>> +				 "failed to read out thermal zone %d\n",
>> +				 tz->id);
>
> Can you please take the opportunity to add the error code in the
> message? Something like:
> +			dev_warn(&tz->device,
> +				 "failed to read out thermal zone (%d)\n",
> +				 ret);
>
> The thermal zone id (tz->id) is already included  in the error message
> as it is always appended to the thermal zone device name
> ("thermal_zone%d", tz->id).

Ok, v2 coming up.

Regards,

Hans
