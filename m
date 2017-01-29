From: Guy Shapiro <guy.shapiro@mobi-wize.com>
Subject: Re: imx6ul: power-up using the RTC
Date: Sun, 29 Jan 2017 09:36:40 +0200
Message-ID: <516ed11f-4a03-8e3d-ae61-3a422e4c5cf6@mobi-wize.com>
References: <b516070d-6539-98d1-c832-d79ac89e8d43@mobi-wize.com>
 <20170120121210.gm3wcg4yyvrigpn3@earth>
 <20170120153459.tewyg54dcgqnpz2j@piout.net>
 <089d1044-275a-1fdc-f0d6-f21c1253b0ab@mobi-wize.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gateway21.websitewelcome.com ([192.185.45.250]:47715 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750728AbdA2Hgx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Jan 2017 02:36:53 -0500
Received: from cm2.websitewelcome.com (cm2.websitewelcome.com [192.185.178.13])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id EEFA6400C4D07
        for <linux-pm@vger.kernel.org>; Sun, 29 Jan 2017 01:36:49 -0600 (CST)
In-Reply-To: <089d1044-275a-1fdc-f0d6-f21c1253b0ab@mobi-wize.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Sebastian Reichel <sre@kernel.org>
Cc: b20788@freescale.com, shawnguo@kernel.org, Frank.Li@freescale.com, kernel@pengutronix.de, fabio.estevam@nxp.com, a.zummo@towertech.it, linux-arm-kernel@lists.infradead.org, rtc-linux@googlegroups.com, linux-pm@vger.kernel.org

On 22/01/2017 13:17, Guy Shapiro wrote:

> On 20/01/2017 17:34, Alexandre Belloni wrote:
>> On 20/01/2017 at 13:12:10 +0100, Sebastian Reichel wrote :
>>> Hi,
>>>
>>> On Wed, Jan 18, 2017 at 04:49:11PM +0200, Guy Shapiro wrote:
>>>> I'm trying to use the low power RTC of the i.MX6UL to start from
>>>> power-off state.
>>>>
>>>> I started by hopefully running: # echo +30 >
>>>> /sys/class/rtc/rtc0/wakealarm && shutdown -h now The system was
>>>> powered down, but it didn't come up after 30 seconds as expected.
>>>>
>>>> So I dug into the datasheet and the source...
>>>> To activate the power on alarm, the flags SRTC_ENV, LPTA_EN and LPWUI_EN on
>>>> the SNVS_LP Control register (LPCR) should be asserted. The wakeup time
>>>> should be written to the SNVS_LP Time alarm register (LPTA). The code that
>>>> does this is on drivers/rtc/rtc-snvs.c:snvs_rtc_set_alarm().
>>>>
>>>> The first problem I found was with the use of the syscon-poweroff driver.
>>>> The "Turn off System Power" flag is part of the same register (LPCR). The
>>>> current code of syscon-poweroff set the register to the "mask" property from
>>>> the device tree on power off, overriding all the existing flags.
>>>> After setting the "mask" property on the device tree to 0x6b instead of
>>>> 0x60 (asserting the mentioned bits), the system do power up on timer, as
>>>> expected.
>>>>
>>>> However, I didn't like the idea of keeping those flags on even when no one
>>>> set the alarm.
>>>> As a quick test, I modified the syscon-poweroff driver to ignore the bits
>>>> that are not on the mask:
>>>>
>>>> diff --git a/drivers/power/reset/syscon-poweroff.c
>>>> b/drivers/power/reset/syscon-poweroff.c
>>>> index b683383..a5da02b 100644
>>>> --- a/drivers/power/reset/syscon-poweroff.c
>>>> +++ b/drivers/power/reset/syscon-poweroff.c
>>>> @@ -33,7 +33,7 @@ static u32 mask;
>>>> static void syscon_poweroff(void)
>>>> {
>>>>         /* Issue the poweroff */
>>>> -       regmap_write(map, offset, mask);
>>>> +       regmap_update_bits(map, offset, mask, mask);
>>>>         mdelay(1000);
>>>>
>>>>
>>>> After applying this fix, the wake up alarm didn't work. Strangely, when I
>>>> added some debug prints to investigate the case, it worked again
>>>> (sometimes... depends on the exact places I add the prints).
>>>> I suspect that some other driver clears the flags during the power down, but
>>>> I couldn't find such driver.
>>>>
>>>> Do you have any clue what code may change this register during the shutdown
>>>> process? Any other insights are welcomed as well :)
>>> To summarize it looks like this?
>>>
>>> | regmap_write       | 0x60 | broken                     |
>>> | regmap_write       | 0x6b | works stable               |
>>> | regmap_update_bits | 0x60 | works only with dbg prints |
>>>
>>> For me it looks like the debug prints may delay the poweroff driver
>>> long enough, that some other driver (rtc?) writes the 0x0b bits.
>>>
>> Is snvs_rtc_alarm_irq_enable() waiting long enough? I'd say yes but you
>> never know... You can also use the kernel tracin infrastructure to trace
>> every accesses made to that regmap. That could give you a hint.
>>
>> At least you can try a regmap_read before returning from
>> snvs_rtc_alarm_irq_enable() and see whether SNVS_LPCR_LPTA_EN and
>> SNVS_LPCR_LPWUI_EN are still there.
>>
> I added a debug print on snvs_rtc_alarm_irq_enable. It reads and prints the
> value of the control register after the write & sync operation.
>
> Immediately after the write to /sys/class/rtc/rtc0/wakealarm the
> register value is correct (0x2b).
> However, during the shutdown process the function is called again via the
> rtc_timer_do_work(). I still do not fully understand this flow. This call is
> done with the enable parameter == 1, but my debug print shows 0x29,
> meaning the LPTA_EN bit stays low.
>
> My current guess is that the clear of LPTA_EN in snvs_rtc_set_alarm have
> internal race with the afterward bit set.
> I'll try to check this and update.
Adding rtc_write_sync_lp after the LPTA_EN clear solved the issue.
The data sheet mentions that clearing this flag can take few cycles and
that the alarm can only be programmed with the flag low.
I'll send a patch soon.

Thanks for the help.
Guy.
