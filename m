From: Elaine Zhang <zhangqing@rock-chips.com>
Subject: Re: [PATCH v2] PM / Domains: Keep the pd status during system PM
 phases
Date: Tue, 07 Feb 2017 09:41:11 +0800
Message-ID: <589925B7.4020009@rock-chips.com>
References: <1484878893-25270-1-git-send-email-zhangqing@rock-chips.com> <CAPDyKFp0GrSQYftSk1UHUSL=+OR_BGf4OVxJDVht-eXnTX8CtQ@mail.gmail.com> <58842848.5090806@rock-chips.com> <CAPDyKFpHttGjKGJi5_TbaD0uepMRC8+NSUqAa5Pmg5j61PT4-Q@mail.gmail.com> <5896F1A5.9080405@rock-chips.com> <CAPDyKFpXXL+zpGZCYSEqtJ6_1=tH+FCths7HuuO5OdRcALoRRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.137]:54720 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751606AbdBGBoh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Feb 2017 20:44:37 -0500
In-Reply-To: <CAPDyKFpXXL+zpGZCYSEqtJ6_1=tH+FCths7HuuO5OdRcALoRRA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Feng Xiao <xf@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Tao Huang <huangtao@rock-chips.com>, xxx@rock-chips.com, Caesar Wang <wxt@rock-chips.com>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>



On 02/06/2017 08:46 PM, Ulf Hansson wrote:
> On 5 February 2017 at 10:34, Elaine Zhang <zhangqing@rock-chips.com> wrote:
>>
>>
>> On 01/26/2017 05:30 AM, Ulf Hansson wrote:
>>>
>>> On 22 January 2017 at 04:34, Elaine Zhang <zhangqing@rock-chips.com>
>>> wrote:
>>>>
>>>>
>>>>
>>>> On 01/20/2017 09:16 PM, Ulf Hansson wrote:
>>>>>
>>>>>
>>>>> On 20 January 2017 at 03:21, Elaine Zhang <zhangqing@rock-chips.com>
>>>>> wrote:
>>>>>>
>>>>>>
>>>>>> If a PM domain is powered off before system suspend,
>>>>>> we hope do nothing in system runtime suspend noirq phase
>>>>>> and system runtime resume noirq phase.
>>>>>
>>>>>
>>>>>
>>>>> One can hope, but that isn't good enough. :-)
>>>>>
>>>>>
>>>>>>
>>>>>> This modify is to slove system resume issue for RK3399.
>>>>>> RK3399 SOC pd_gpu have voltage domain vdd_gpu,
>>>>>> so we must follow open vdd_gpu and power on pd_gpu,
>>>>>> power off pd_gpu and disable vdd_gpu.
>>>>>> Fix up in runtime resume noirq phase power on all PDs.
>>>>>
>>>>>
>>>>>
>>>>> This doesn't make any sense to me. Can please try to explain this is
>>>>> in great more detail, then I can try to help.
>>>>>
>>>> For example:
>>>> -->device suspend
>>>>      (mali gpu driver set pd_gpu off by pm_runtime_put_sync(),
>>>
>>>
>>> This is the wrong approach, as runtime suspend is prevented by the PM
>>> core in this phase. More precisely, it does a
>>> pm_runtime_get_noresume() in the device prepare phase.
>>>
>>> I think it seems like you would benefit from using the so called the
>>> runtime PM centric approach, which gives you system PM support for
>>> "free". Please have a look at the pm_runtime_force_suspend|resume()
>>> helpers.
>>>
>>>>       and then disabled the vdd_gpu by regulator_disable().)
>>>>           --> system suspend
>>>>                   -->prepare
>>>>                           -->suspend_noirq():
>>>>                           (power off all pds)
>>>>           -->system resume
>>>>                   -->resume_noirq():
>>>>                   (power up all pds)
>>>>                   (in this case the vdd_gpu is still disabled,
>>>>                    if power on the pd_gpu maybe make the system crash)
>>>>           -->complete : power off the not used pd
>>>> -->device resuem
>>>>      (mali gpu driver enable vdd_gpu by regulator_enable(),
>>>>       and then power up the pd_gpu by pm_runtime_get_sync())
>>>
>>>
>>> Seems like there is also a missing configuration of the relationship
>>> between the PM domains. In the genpd terminology, you probably want to
>>> set pd_gpu as a subdomain of the vdd_gpu.
>>>
>>> In that way, the vdd_gpu is always powered on before pd_gpu is powered
>>> on. And vice verse when powering off.
>>>
>> I thought about this project, but can't slove the problem of sleep and wakp
>> up issue.
>> Because
>>          -->system resume
>>                   -->resume_noirq():
>>                    (power up all pds)
>> In this case, we set pd_gpu as a subdomain of the vdd_gpu.
>> And then to enable the vdd_gpu,but the system resume is not complete yet,
>> the regulator and i2c can't work.So the vdd_gpu enable will failed.
>
> Okay, I see.
>
>>
>> So I think the more appropriate solution is keep the pd status during system
>> PM phases.
>> If a PM domain is powered off before system suspend,
>> we hope do nothing in system runtime suspend noirq phase
>> and system runtime resume noirq phase.
>
> Unfortunate, I am still not fully understanding the scenarios. As you
> indicate, the problem seems related to wakeup settings.
>
> Could you please try to answer the below questions, hopefully it helps
> me to better understand.
>
> 1)
> While starting the system suspend sequence, under what circumstances
> are you expecting the vdd_gpu and pd_gpu to be powered on?
>

I don't want to power on the vdd_gpu and pd_gpu during the system 
suspend sequence.
I hope the pd_gpu and vdd_gpu power on/off just by gpu device.

> 2)
> While starting the system suspend sequence, under what circumstances
> are you expecting the vdd_gpu and the pd_gpu to be powered off?
>

I don't want to power off the vdd_gpu and pd_gpu during the system 
suspend sequence.
Because before the system suspend,the vdd_gpu and pd_gpu has been power 
off by gpu device(pm_ruantime_put).

> 3)
> What devices are attached to vdd_gpu?
>
just pd_gpu
> 4)
> What devices are attached to pd_gpu?
>
just gpu device(mali driver)

vdd_gpu
-------	pd_gpu
----------------devices/platform/ff9a0000.gpu
>
>>
>>>>
>>>> So for RK3399 soc, if to set pd_gpu the vdd_gpu must be enabled, or else
>>>> will can't get the ack back.
>>>> I hope the pd_gpu power up/off by the driver itself.
>>>>
>
> [...]
>
> Kind regards
> Uffe
>
>
>

