From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCHv2] power_supply: Add support for Richtek rt9455 battery charger
Date: Thu, 30 Apr 2015 16:53:56 +0900
Message-ID: <CAJKOXPfb6-HY8XP-nqPziC=M-+w8PwLF-zgGr9HXiCotY=+XUg@mail.gmail.com>
References: <1430338406-24012-1-git-send-email-anda-maria.nicolae@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430338406-24012-1-git-send-email-anda-maria.nicolae@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anda-Maria Nicolae <anda-maria.nicolae@intel.com>
Cc: sre@kernel.org, dbaryshkov@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, dwmw2@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

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

> - replaced struct power_supply_desc rt9455_charger_desc with static const struct power_supply_desc rt9455_charger_desc
> - replaced if (IS_ERR_OR_NULL(info->charger)) with if (IS_ERR(info->charger))
> - replaced {"RTK9455", 0} with { "RTK9455", 0 }
> - removed .owner = THIS_MODULE
>
> Signed-off-by: Anda-Maria Nicolae <anda-maria.nicolae@intel.com>

You missed some of my comments. I mentioned wrong error paths around
put_usb_phy in probe. They do not seem to be fixed...

Just one hint - mostly new bindings are posted in separate patches at
the beginning of the patchset. I actually don't mind. but separating
them will probably give you higher chance of review from DT people.
This is also mentioned in:
Documentation/devicetree/bindings/submitting-patches.txt

Best regards,
Krzysztof
