From: Anand Moon <linux.amoon@gmail.com>
Subject: Re: [PATCH 0/4] ARM: exynos: Fix Odroid U3 USB/LAN when TFTP booting
 (power sequence)
Date: Mon, 9 Jan 2017 23:56:41 +0530
Message-ID: <CANAwSgR7=cELNK9of5ngFTdhcxWn2KXL=R8tMsTKD7gecBcMYw@mail.gmail.com>
References: <20170107085203.4431-1-krzk@kernel.org> <CANAwSgSEZvxHje65Kk13fvD9NZGB+iHCJtoGJdQrUdS42ei_WA@mail.gmail.com>
 <20170109181703.436gv7bq76xuv35q@kozik-lap>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170109181703.436gv7bq76xuv35q@kozik-lap>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kukjin Kim <kgene@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, devicetree <devicetree@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Peter Chen <peter.chen@nxp.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>, sre@kernel.org, Rob Herring <robh+dt@kernel.org>, Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, hverkuil@xs4all.nl, Markus
List-Id: linux-pm@vger.kernel.org

Hi Krzysztof,

On 9 January 2017 at 23:47, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Mon, Jan 09, 2017 at 11:34:48PM +0530, Anand Moon wrote:
>> Hi Krzysztof,
>>
>> On 7 January 2017 at 14:21, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> > Hi,
>> >
>> > Thanks to Markus Reichl, I got an Odroid U3 to work with. Thanks to Peter
>> > Chen, we got a power sequence generic library which solves my long
>> > standing Odroid U3 problem - no LAN9730 if it was enabled by bootloader.
>> >
>> > My previous attempts for this can be found here [0].
>> >
>> > This patchset is based on Peter's v11 of power sequence [1].
>> > Patchset is available also on my Github [2].
>> >
>> > More detailed analysis is described in patch 2/4 ("ARM: dts: exynos: Fix
>> > LAN9730 on Odroid U3 after tftpboot").
>> >
>> >
>>
>> [snip]
>>
>> On which u-boot should this be tested.
>>
>> On HK u-boot tftp boot is not supported.
>
> ... so you gave an answer: you cannot test it on HK. How many other
> U-Boot flavors you know? :)
>

u-boot mainline have tftp support enable, so I will try to test on this u-boot.

Best Regards
-Anand

> Best regards,
> Krzysztof
>
>
>> ----------------------------------------------------------
>> U-Boot 2010.12-00000-g9777ca6-dirty (Nov 26 2015 - 10:10:11) for Exynox4412
>>
>>
>> CPU: S5PC220 [Samsung SOC on SMP Platform Base on ARM CortexA9]
>> APLL = 1000MHz, MPLL = 800MHz
>> DRAM:  2 GiB
>>
>> PMIC VERSION : 0x00, CHIP REV : 2
>> TrustZone Enabled BSP
>> BL1 version: 20121128
>>
>>
>> Checking Boot Mode ... SDMMC
>> MMC Device 0: 14804 MB
>> MMC Device 1 not found
>> *** Warning - using default environment
>>
>> USB3503 NINT = OUTPUT LOW!
>> ModeKey Check... run normal_boot
>> No ethernet found.
>> Hit any key to stop autoboot:  0
>> Exynos4412 #
>> Exynos4412 #
>> Exynos4412 #
>> Exynos4412 # usb start
>> (Re)start USB...
>> USB0:   Exynos4412-ehci: init hccr 12580000 and hcor 12580010 hc_length 16
>> usb: usb_refclk_enable is active low: NO
>> ProTIP: If usb doesn't work - try playing with 'usb_invert_clken' environment
>> USB EHCI 1.00
>> scanning bus 0 for devices... EHCI timed out on TD - token=0x80008c80
>> EHCI fail timeout STS_ASS set
>>
>>       USB device not accepting new address (error=80000000)
>> EHCI fail timeout STS_ASS set
>> 1 USB Device(s) found
>>        scanning usb for storage devices... 0 Storage Device(s) found
>>        scanning usb for ethernet devices... 0 Ethernet Device(s) found
>> Exynos4412 #
>>
>> Best Regards
>> -Anand
