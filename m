From: Michael Heinemann <posted@heine.so>
Subject: Re: sbs-battery: Reading CHARGE in uAh
Date: Fri, 07 Jul 2017 10:01:39 +0200
Message-ID: <51e4c77c0a6a5fb9d31d2d79bb998235@heine.so>
References: <d760d0a1b38fbda966caaefc63677a56@heine.so>
 <164cda30-47ba-5289-a6c8-4740752b047d@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.stresser.de ([88.198.198.115]:41728 "EHLO mail.stresser.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751001AbdGGIBm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 7 Jul 2017 04:01:42 -0400
In-Reply-To: <164cda30-47ba-5289-a6c8-4740752b047d@electromag.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>
Cc: linux-pm@vger.kernel.org

Hi Phil,
On 2017-07-07 03:49, Phil Reid wrote:
> G'day Michael,
> On 6/07/2017 23:23, Michael Heinemann wrote:
>> 
>> 
>> I got an INSPIRED ENERGY NH2057 Battery which is compliant to SBS 
>> Specification Version 1.1.
>> 
>> The Battery is generally working but I noticed that the values I get 
>> from sysfs for the CHARGE values
>> are identical to the values I get as ENERGY and they are in uWh. 
>> According to the power_supply_class
>> documentation CHARGE should be in uAh and ENERGY in uWh.
>> 
>> So I took a look into the drivers/power/supply/sbs-battery.c and 
>> noticed a possible bug in the code
>> when switching from BATTERY_MODE_WATTS to BATTERY_MODE_AMPS:
>> 
>> The configuration bit, according to the SBS Spec, is bit 15 of the 
>> BatteryMode Register.
>> 
>> These two modes are reflected in the code as:
>> 
>> enum sbs_battery_mode {
>>      BATTERY_MODE_AMPS,
>>      BATTERY_MODE_WATTS
>> };
>> 
>> When I look into the 'sbs_set_battery_mode' function I don't see any 
>> point where these mode bits are
>> shifted to bit 15. When I debug I only see the register being changed 
>> from 0x8000 to 0x8001 and back.
>> 
>> So I'm a bit confused, is this actually working for somebody? I see in 
>> the 'for-next' branch [1] that
>> there is currently work done to add a mutex to the mode switch. So at 
>> least it seems to be working for
>> some people. But I don't see why. Am I missing something?
>> 
>> 
> 
> Your analyse looks correct. I've not look that closely at the data
> from the battery as yet.
> There's looks to be a few issues in there related to switching mode.
> 
> The return value from sbs_set_battery_mode also looks suspect.
> Perhaps it should just return 0 on success.
> 
> And then sbs_get_battery_capacity needs cleaning up as it's using the
> return value to set the mode at the end.
> 
> It setts the mode, and then I guess the intention was to set it back 
> again.
> But do we event need to do that? The next get is going to set the 
> correct mode.
> And the mode setting will soon be wrapped in a mutex.

I spend some more time to look at the code and my conclusion is that the 
cause
of the problem is a mix up of two different approaches for the mode.

The initial mode is passed in as 0 or 1 coming from enum 
sbs_battery_mode.
But when the setting back is done the value comes from the return value 
of
the previous call to sbs_set_battery_mode which is 0x8000 or 0x0000.

At least for my battery this leads to a situation where the status 
register is
0x8000 so it's in mWh Mode. Then the mode=0 is passed in to set uAh.

But this statement

if ((original_val & BATTERY_MODE_MASK) == mode)
		return mode;

is true by mistake ((0x8000 & 0x8000) == 0) so the function exits and 
never
sets anything.

What would be the "kernel style" way to fix this?
Define the sbs_battery_mode like this:

enum sbs_battery_mode {
	BATTERY_MODE_AMPS,
	BATTERY_MODE_WATTS
};

Or add a #define CAPACITY_MODE_OFFSET 0xf and shift the mode bit in the 
function?

I tested a bit with the shifted bit and the added mutex and get I 
correct values now.
Without the mutex it's more or less randomly changing between uAh and 
mWh.
I would writeup a patch and submit it as proposal.

 From my understanding of the SBS Spec (Page 19) the intention of the 
Mode setting is
to select one Mode for your power source and leave it at that. For 
Example the AtRate()
calculations become wrong when you change the mode. But as the driver is 
not using
these features that might not be an issue.

I would agree that the driver does not need to change back the Mode bit 
as it is
set on every read anyway. So this is unnecessary overhead.
If I find time I'll submit a patch to remove this and clean up a bit.

Regards,
Michael
