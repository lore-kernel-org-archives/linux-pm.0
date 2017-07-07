From: Phil Reid <preid@electromag.com.au>
Subject: Re: sbs-battery: Reading CHARGE in uAh
Date: Fri, 7 Jul 2017 09:49:52 +0800
Message-ID: <164cda30-47ba-5289-a6c8-4740752b047d@electromag.com.au>
References: <d760d0a1b38fbda966caaefc63677a56@heine.so>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from anchovy1.45ru.net.au ([203.30.46.145]:59831 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753181AbdGGBus (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Jul 2017 21:50:48 -0400
In-Reply-To: <d760d0a1b38fbda966caaefc63677a56@heine.so>
Content-Language: en-AU
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Heinemann <posted@heine.so>, linux-pm@vger.kernel.org

G'day Michael,
On 6/07/2017 23:23, Michael Heinemann wrote:
> 
> 
> I got an INSPIRED ENERGY NH2057 Battery which is compliant to SBS Specification Version 1.1.
> 
> The Battery is generally working but I noticed that the values I get from sysfs for the CHARGE values
> are identical to the values I get as ENERGY and they are in uWh. According to the power_supply_class
> documentation CHARGE should be in uAh and ENERGY in uWh.
> 
> So I took a look into the drivers/power/supply/sbs-battery.c and noticed a possible bug in the code
> when switching from BATTERY_MODE_WATTS to BATTERY_MODE_AMPS:
> 
> The configuration bit, according to the SBS Spec, is bit 15 of the BatteryMode Register.
> 
> These two modes are reflected in the code as:
> 
> enum sbs_battery_mode {
>      BATTERY_MODE_AMPS,
>      BATTERY_MODE_WATTS
> };
> 
> When I look into the 'sbs_set_battery_mode' function I don't see any point where these mode bits are
> shifted to bit 15. When I debug I only see the register being changed from 0x8000 to 0x8001 and back.
> 
> So I'm a bit confused, is this actually working for somebody? I see in the 'for-next' branch [1] that
> there is currently work done to add a mutex to the mode switch. So at least it seems to be working for
> some people. But I don't see why. Am I missing something?
> 
> 

Your analyse looks correct. I've not look that closely at the data from the battery as yet.
There's looks to be a few issues in there related to switching mode.

The return value from sbs_set_battery_mode also looks suspect.
Perhaps it should just return 0 on success.

And then sbs_get_battery_capacity needs cleaning up as it's using the return value to set the mode at the end.

It setts the mode, and then I guess the intention was to set it back again.
But do we event need to do that? The next get is going to set the correct mode.
And the mode setting will soon be wrapped in a mutex.


-- 
Regards
Phil Reid
