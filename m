From: Phil Reid <preid@electromag.com.au>
Subject: Re: sbs-battery: Reading CHARGE in uAh
Date: Mon, 10 Jul 2017 16:04:38 +0800
Message-ID: <8ec0d59a-6d31-fe3c-8f86-f1bc761d53b0@electromag.com.au>
References: <d760d0a1b38fbda966caaefc63677a56@heine.so>
 <164cda30-47ba-5289-a6c8-4740752b047d@electromag.com.au>
 <51e4c77c0a6a5fb9d31d2d79bb998235@heine.so>
 <058c8617-3b9b-58b8-1fae-056ee90fed80@electromag.com.au>
 <1c63583aadf77510ce85946f7fe3c815@heine.so>
 <5aaaba0a-d52e-eb0f-cbb0-24a0078aa059@electromag.com.au>
 <06932b6865de4abf20330903fd554056@heine.so>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from anchovy2.45ru.net.au ([203.30.46.146]:36974 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753480AbdGJIEq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Jul 2017 04:04:46 -0400
In-Reply-To: <06932b6865de4abf20330903fd554056@heine.so>
Content-Language: en-AU
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Heinemann <posted@heine.so>
Cc: linux-pm@vger.kernel.org

On 10/07/2017 15:54, Michael Heinemann wrote:
> On 2017-07-10 03:35, Phil Reid wrote:
>> On 7/07/2017 21:06, Michael Heinemann wrote:
>>> On 2017-07-07 10:27, Phil Reid wrote:
>>>> On 7/07/2017 16:01, Michael Heinemann wrote:
>>>>> Hi Phil,
>>>>> On 2017-07-07 03:49, Phil Reid wrote:
>>>>>> G'day Michael,
>>>>>> On 6/07/2017 23:23, Michael Heinemann wrote:
>>>>>>>
>>>>>>>
>>>>>>> I got an INSPIRED ENERGY NH2057 Battery which is compliant to SBS Specification Version 1.1.
>>>>>>>
>>>>>>> The Battery is generally working but I noticed that the values I get from sysfs for the CHARGE values
>>>>>>> are identical to the values I get as ENERGY and they are in uWh. According to the power_supply_class
>>>>>>> documentation CHARGE should be in uAh and ENERGY in uWh.
>>>>>>>
>>>>>>> So I took a look into the drivers/power/supply/sbs-battery.c and noticed a possible bug in the code
>>>>>>> when switching from BATTERY_MODE_WATTS to BATTERY_MODE_AMPS:
>>>>>>>
>>>>>>> The configuration bit, according to the SBS Spec, is bit 15 of the BatteryMode Register.
>>>>>>>
>>>>>>> These two modes are reflected in the code as:
>>>>>>>
>>>>>>> enum sbs_battery_mode {
>>>>>>>      BATTERY_MODE_AMPS,
>>>>>>>      BATTERY_MODE_WATTS
>>>>>>> };
>>>>>>>
>>>>>>> When I look into the 'sbs_set_battery_mode' function I don't see any point where these mode bits are
>>>>>>> shifted to bit 15. When I debug I only see the register being changed from 0x8000 to 0x8001 and back.
>>>>>>>
>>>>>>> So I'm a bit confused, is this actually working for somebody? I see in the 'for-next' branch [1] that
>>>>>>> there is currently work done to add a mutex to the mode switch. So at least it seems to be working for
>>>>>>> some people. But I don't see why. Am I missing something?
>>>>>>>
>>>>>>>
>>>>>>
>>>>>> Your analyse looks correct. I've not look that closely at the data
>>>>>> from the battery as yet.
>>>>>> There's looks to be a few issues in there related to switching mode.
>>>>>>
>>>>>> The return value from sbs_set_battery_mode also looks suspect.
>>>>>> Perhaps it should just return 0 on success.
>>>>>>
>>>>>> And then sbs_get_battery_capacity needs cleaning up as it's using the
>>>>>> return value to set the mode at the end.
>>>>>>
>>>>>> It setts the mode, and then I guess the intention was to set it back again.
>>>>>> But do we event need to do that? The next get is going to set the correct mode.
>>>>>> And the mode setting will soon be wrapped in a mutex.
>>>>>
>>>>> I spend some more time to look at the code and my conclusion is that the cause
>>>>> of the problem is a mix up of two different approaches for the mode.
>>>>>
>>>>> The initial mode is passed in as 0 or 1 coming from enum sbs_battery_mode.
>>>>> But when the setting back is done the value comes from the return value of
>>>>> the previous call to sbs_set_battery_mode which is 0x8000 or 0x0000.
>>>>>
>>>>> At least for my battery this leads to a situation where the status register is
>>>>> 0x8000 so it's in mWh Mode. Then the mode=0 is passed in to set uAh.
>>>>>
>>>>> But this statement
>>>>>
>>>>> if ((original_val & BATTERY_MODE_MASK) == mode)
>>>>>          return mode;
>>>>>
>>>>> is true by mistake ((0x8000 & 0x8000) == 0) so the function exits and never
>>>>> sets anything.
>>>> Yeap that what I thought.
>>>>
>>>>>
>>>>> What would be the "kernel style" way to fix this?
>>>> That I'm not sure of. My personal style would be against using the enum value.
>>>> Unless is was set to a constant. ie:
>>>> BATTERY_MODE_AMPS  = 0,
>>>> BATTERY_MODE_WATTS = 0x8000
>>>> But I'd probably make the enum a #define instead with above value
>>>>
>>>>
>>>>> Define the sbs_battery_mode like this:
>>>>>
>>>>> enum sbs_battery_mode {
>>>>>      BATTERY_MODE_AMPS,
>>>>>      BATTERY_MODE_WATTS
>>>>> };
>>>>>
>>>>> Or add a #define CAPACITY_MODE_OFFSET 0xf and shift the mode bit in the function?
>>>>>
>>>>> I tested a bit with the shifted bit and the added mutex and get I correct values now.
>>>>> Without the mutex it's more or less randomly changing between uAh and mWh.
>>>>> I would writeup a patch and submit it as proposal.
>>>>>
>>>>>  From my understanding of the SBS Spec (Page 19) the intention of the Mode setting is
>>>>> to select one Mode for your power source and leave it at that. For Example the AtRate()
>>>>> calculations become wrong when you change the mode. But as the driver is not using
>>>>> these features that might not be an issue.
>>>> Had a quick look at that and it'd have to do the same thing as the
>>>> sbs_get_battery_capacity
>>>> call and use the mutex if it was implemented. Don't think we need to
>>>> wrory about it at present thou.
>>>>
>>>>>
>>>>> I would agree that the driver does not need to change back the Mode bit as it is
>>>>> set on every read anyway. So this is unnecessary overhead.
>>>>> If I find time I'll submit a patch to remove this and clean up a bit.
>>>>>
>>>> I like any speed improvement. It takes a while to poll all the values
>>>> from the battery.
>>>
>>> I did some more testing and came to a bit disappointing outcome. I
>>> don't know if this is specific to my battery or a general thing with
>>> SBS devices.
>>> When I set the CAPACITY_MODE bit the change is not always effective
>>> immediately. Sometimes it works, sometimes it takes a few ms and
>>> sometimes the bit never changes and I have to write it again.
>>>
>>> So there seems to be no guarantee to get the reading in the expected
>>> format.
>>>
>>> How could this be handled? Return an error when the CAPACITY_MODE bit
>>> was not set succesfully? Retry setting it (which takes time)?
>>
>> Where you getting an i2c error or it just failing to set.
>> I've got a number of different Inspired Energy batteries on hand that
>> I can test against.
>> I'll try and run some tests with you patch today and see what I get with them.
>>
> The i2c calls return successfully. The value reported is in the wrong unit and
> the status register is also not changed.
> 
> I saw that you introduced a delay, this should help at least in
> ~50% of the times. Do you always see correct values with your
> batteries?

Yeah I also saw no error messaging. Battery acks the command ok.
I hooked a scope up to the sda / scl lines and there was also no evidence of bus
stretching by the battery to force the host to wait.

Prior to adding the delay I applied the changes to not reset the mode bit.
That allowed me to poll the charge / energy registers without the mode change reseting.

I've got a 4 battery system and I'd see some of the batteries change mode.
Continuously polling them for say energy when they'd all been in charge "mode"
they'd eventually set themselves to the correct mode and stay there. But it was very random.

After the delay I've done hundreds of cycle on each battery and they seem to be behaving.
Just reading the status register after the set seemed to upset them and they wouldn't change mode.
Bus had to be completely idle.

Thought I'd post the patches for you to have a play with and anyone else to comment on.

I was also going to send Insipred Energy support an email to see what they had to say.


> 
> I added something like this at the end of sbs_set_battery_mode
> 
>      ret = sbs_read_word_data(client, BATTERY_MODE_OFFSET);
>      if ((ret & BATTERY_MODE_MASK) != mode)
>                 return -ENODATA;
> 
> In this way one knows if the value is actually in the right unit
> which as it is currently implemented is not the case. But this of
> course adds more delay.
> 
> I will now do some tests with your submitted patches.
> 



-- 
Regards
Phil Reid
