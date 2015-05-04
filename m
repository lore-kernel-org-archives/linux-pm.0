From: "Nicolae, Anda-maria" <anda-maria.nicolae@intel.com>
Subject: RE: [PATCHv2] power_supply: Add support for Richtek rt9455 battery
 charger
Date: Mon, 4 May 2015 12:48:45 +0000
Message-ID: <11982715D62E664DBACA4351A418B0581437E15D@IRSMSX107.ger.corp.intel.com>
References: <1430338406-24012-1-git-send-email-anda-maria.nicolae@intel.com>,<CAJKOXPfb6-HY8XP-nqPziC=M-+w8PwLF-zgGr9HXiCotY=+XUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJKOXPfb6-HY8XP-nqPziC=M-+w8PwLF-zgGr9HXiCotY=+XUg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: "sre@kernel.org" <sre@kernel.org>, "dbaryshkov@gmail.com" <dbaryshkov@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Krzysztof,

Inline are the answers to your questions.

Thanks,
Anda

________________________________________
From: k.kozlowski.k@gmail.com [k.kozlowski.k@gmail.com] on behalf of Krzysztof Kozlowski [k.kozlowski@samsung.com]
Sent: Thursday, April 30, 2015 10:53 AM
To: Nicolae, Anda-maria
Cc: sre@kernel.org; dbaryshkov@gmail.com; robh+dt@kernel.org; pawel.moll@arm.com; mark.rutland@arm.com; ijc+devicetree@hellion.org.uk; galak@codeaurora.org; dwmw2@infradead.org; linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org; devicetree@vger.kernel.org
Subject: Re: [PATCHv2] power_supply: Add support for Richtek rt9455 battery charger

2015-04-30 5:13 GMT+09:00 Anda-Maria Nicolae <anda-maria.nicolae@intel.com>:
> Based on the datasheet found here:
> http://www.richtek.com/download_ds.jsp?p=RT9455
>
> Updates from the previous version:
> - replaced license GPLv2 with GPL
> - replaced vendor prefix rt with richtek
> - replaced uppercase properties names from devicetree with lowercase separated by dash properties names
> - replaced I/O read/write API with regmap_read/write and regmap_field_read/write
> - used kernel multiline comment
> - used DELAYED_WORK and scheduled the works in system_power_efficient_wq. It is high probability that the device is in suspend state while charging (i.e. the user leaves the device to charge during night) and it is needed that the scheduled works to be executed as planned.

I think when device is suspended (e.g. to RAM) no work will ever be
executed. The timers (for delayed work) will not wake up the device...
RTC could wake but this is different story. My proposal of deferred
timers is affected by idle CPU time. Are you sure that you want to
wake up from the system suspend?

Oh, now I better understand it. I don't think I need this feature. Also, the expire times that I use in the driver are not defined in the datasheet, so it should not be a problem if they are fired later.
So, I will use INIT_DEFERRABLE_WORK instead of INIT_DELAYED_WORK.

> - replaced struct power_supply_desc rt9455_charger_desc with static const struct power_supply_desc rt9455_charger_desc
> - replaced if (IS_ERR_OR_NULL(info->charger)) with if (IS_ERR(info->charger))
> - replaced {"RTK9455", 0} with { "RTK9455", 0 }
> - removed .owner = THIS_MODULE
>
> Signed-off-by: Anda-Maria Nicolae <anda-maria.nicolae@intel.com>

You missed some of my comments. I mentioned wrong error paths around
put_usb_phy in probe. They do not seem to be fixed...

Now I see what you meant. I looked at usb_get_phy() implementation and I saw that I cannot return NULL. So I replaced IS_ERR_OR_NULL() with IS_ERR(). I did this in rt9455_remove() and in rt9455_irq_handler_thread() functions, too.
Also, this replacement (IS_ERR() instead of IS_ERR_OR_NULL()) should also be done in other power charger drivers: 
drivers/power/pda_power.c lines 319, 375, 410, 445; 
drivers/power/ab8500_charger.c line 3651;
drivers/power/twl4030_charger.c lines 642, 674 and 706.
I will send the patch for RT9455 charger soon. I will also send a patch to replace IS_ERR_OR_NULL() with IS_ERR() in the drivers listed above.



Just one hint - mostly new bindings are posted in separate patches at
the beginning of the patchset. I actually don't mind. but separating
them will probably give you higher chance of review from DT people.
This is also mentioned in:
Documentation/devicetree/bindings/submitting-patches.txt

Best regards,
Krzysztof
