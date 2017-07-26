From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v3 2/3] usb: phy: Add USB charger support
Date: Wed, 26 Jul 2017 11:19:00 +0800
Message-ID: <CAMz4kuKCj6nGTpCKjQy4sFK=iEvy_YVm4dhCnwnZ15MrGGBYEA@mail.gmail.com>
References: <cover.1500968744.git.baolin.wang@linaro.org> <0bfc4d3534a7cc735ef213da8d280a4a79629c0d.1500968745.git.baolin.wang@linaro.org>
 <a4cdd6e0-83a2-7946-9ca3-986f9ff13315@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a4cdd6e0-83a2-7946-9ca3-986f9ff13315@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Manu Gautam <mgautam@codeaurora.org>
Cc: Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jun Li <jun.li@nxp.com>, Peter Chen <peter.chen@freescale.com>, Mark Brown <broonie@kernel.org>, John Stultz <john.stultz@linaro.org>, NeilBrown <neilb@suse.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Manu,

On 25 July 2017 at 19:19, Manu Gautam <mgautam@codeaurora.org> wrote:
> Hi,
>
>
> On 7/25/2017 1:30 PM, Baolin Wang wrote:
>> This patch introduces the usb charger support based on usb phy that
>> makes an enhancement to a power driver. The basic conception of the
>> usb charger is that, when one usb charger is added or removed by
>> reporting from the extcon device state change, the usb charger will
>> report to power user to set the current limitation.
>>
>> Power user can register a notifiee on the usb phy by issuing
>> usb_register_notifier() to get notified by charger status changes
>> or charger current changes.
>
> Why can't we use power_supply framework for this?
> Power user can register usb power_supply and USB PHY driver
> can update charging current using - power_supply_set_property().

No. We can get the current can be drawn from USB layer not from power
supply framework, moreover some USB controller can detect the charger
type and power supply framework can not. I think you missed lots of
previous discussion, maybe you can check below links to follow what we
have discussed before.
https://lists.gt.net/linux/kernel/2546730
https://patchwork.kernel.org/patch/9601973/


>> we can notify what current to be drawn to power user according to
>> different charger type, and now we have 2 methods to get charger type.
>> One is get charger type from extcon subsystem, which also means the
>> charger state changes. Another is we can get the charger type from
>> USB controller detecting or PMIC detecting, and the charger state
>> changes should be told by issuing usb_phy_set_charger_state().
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> ---
>>  drivers/usb/phy/phy.c   |  272 +++++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/usb/phy.h |   49 +++++++++
>
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>



-- 
Baolin.wang
Best Regards
