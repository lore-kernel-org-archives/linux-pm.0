From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [Bug] ARM: mxs: STI: console can't wake up from freeze
Date: Mon, 31 Oct 2016 20:54:33 +0100 (CET)
Message-ID: <847975190.29034.38a9c7fa-bdf8-4732-ac8b-cf15c21e3ce8.open-xchange@email.1und1.de>
References: <315017958.66634.5d4fc19c-31cd-4900-8613-af4cadec5da4.open-xchange@email.1und1.de>
 <20161023133134.GI1041@n2100.armlinux.org.uk>
 <1709157673.85170.1cb53b4d-2805-48ea-aef1-dd282306d108.open-xchange@email.1und1.de>
 <20161031161700.GH1041@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.133]:63626 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S945779AbcJaTzR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Oct 2016 15:55:17 -0400
In-Reply-To: <20161031161700.GH1041@n2100.armlinux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, joerg.krause@embedded.rocks, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Fabio Estevam <fabio.estevam@nxp.com>


> Russell King - ARM Linux <linux@armlinux.org.uk> hat am 31. Oktober 2016 um
> 17:17 geschrieben:
> 
> 
> On Sat, Oct 29, 2016 at 01:44:14PM +0200, Stefan Wahren wrote:
> > unfortunately not:
> > 
> > Setting: no_console_suspend not in cmdline, Debug UART wakeup source enabled
> > 
> > echo mem > /sys/power/state
> > 
> > Result: Able to wakeup via Debug UART
> > Expected result: Able to wakeup via Debug UART
> > 
> > ---
> > 
> > Setting: no_console_suspend not in cmdline, Debug UART wakeup source enabled
> > 
> > echo freeze > /sys/power/state
> > 
> > Result: Unable to wakeup via Debug UART (no hung task warning)
> > Expected result: Able to wakeup via Debug UART
> 
> Okay - I know that certain actions are bypassed when no_console_suspend
> is set, which has detrimental effects on some ARM platforms, so it was
> worth testing - iirc, working no_console_suspend is reliant on the boot
> loader re-setting up the serial port after its lost state.
> 

I also made the basic PM debugging tests with the available options for pm_test:

freezer: suspend and resume as expected
devices: suspend and resume as expected
platform: suspend and resume as expected

Since these tests use a clock to wakeup, i assume my issue is related to the
debug UART and its required components.

Btw the irqchip/irq-mxs.c doesn't implement neither the irq_set_wake or the
syscore_ops. Could this be the problem?

FWIW here are the debug outputs for "echo mem > /sys/power/state" (no hang) and
"echo freeze > /sys/power/state" (hang). I need to mention that after adding
initcall_debug to the cmdline "echo mem > /sys/power/state" the system wakeups
immediately after the suspend.

echo mem > /sys/power/state

[   62.010376] PM: Syncing filesystems ... [   65.607842] done.
[   65.660964] Freezing user space processes ... (elapsed 0.007 seconds) done.
[   65.676976] Freezing remaining freezable tasks ... (elapsed 0.003 seconds)
done.
[   65.697881] calling  mmc0:0007+ @ 93, parent: mmc0
[   65.704356] call mmc0:0007+ returned 0 after 1532 usecs
[   65.710605] calling  snd-soc-dummy+ @ 385, parent: platform
[   65.716472] call snd-soc-dummy+ returned 0 after 16 usecs
[   65.722356] calling  duckbill:red:status+ @ 385, parent: leds
[   65.728360] call duckbill:red:status+ returned 0 after 22 usecs
[   65.734417] calling  duckbill:green:status+ @ 385, parent: leds
[   65.740564] call duckbill:green:status+ returned 0 after 18 usecs
[   65.747329] calling  stmp3xxx_rtc_wdt+ @ 385, parent: 80056000.rtc
[   65.753600] call stmp3xxx_rtc_wdt+ returned 0 after 13 usecs
[   65.759529] calling  rtc0+ @ 385, parent: 80056000.rtc
[   65.765084] call rtc0+ returned 0 after 212 usecs
[   65.771252] calling  usb1+ @ 93, parent: ci_hdrc.0
[   65.805743] call usb1+ returned 0 after 28753 usecs
[   65.811994] calling  ci_hdrc.0+ @ 385, parent: 80080000.usb
[   65.819188] call ci_hdrc.0+ returned 0 after 1319 usecs
[   65.824875] calling  800f0000.etherne:00+ @ 385, parent: 800f0000.etherne
[   65.832856] call 800f0000.etherne:00+ returned 0 after 1072 usecs
[   65.839345] calling  Fixed MDIO bus.0+ @ 385, parent: platform
[   65.845388] call Fixed MDIO bus.0+ returned 0 after 13 usecs
[   65.851432] calling  alarmtimer+ @ 385, parent: platform
[   65.858186] call alarmtimer+ returned 0 after 1193 usecs
[   65.868024] calling  leds+ @ 385, parent: soc0
[   65.872567] call leds+ returned 0 after 12 usecs
[   65.877472] calling  regulators:regulator@0+ @ 385, parent: regulators
[   65.884088] call regulators:regulator@0+ returned 0 after 14 usecs
[   65.890534] calling  regulators+ @ 385, parent: soc0
[   65.895699] call regulators+ returned 0 after 14 usecs
[   65.900971] calling  iio-hwmon+ @ 385, parent: soc0
[   65.906096] call iio-hwmon+ returned 0 after 15 usecs
[   65.912643] calling  800f0000.ethernet+ @ 385, parent: 80080000.ahb
[   65.920952] call 800f0000.ethernet+ returned 0 after 1743 usecs
[   65.927181] calling  80080000.usb+ @ 385, parent: 80080000.ahb
[   65.933350] call 80080000.usb+ returned 0 after 243 usecs
[   65.939063] calling  80080000.ahb+ @ 385, parent: soc0
[   65.944289] call 80080000.ahb+ returned 0 after 14 usecs
[   65.949867] calling  8007c000.usbphy+ @ 385, parent: 80040000.apbx
[   65.956248] call 8007c000.usbphy+ returned 0 after 15 usecs
[   65.961960] calling  80074000.serial+ @ 385, parent: 80040000.apbx
[   65.968832] call 80074000.serial+ returned 0 after 472 usecs
[   65.974888] calling  80068000.timrot+ @ 385, parent: 80040000.apbx
[   65.981162] call 80068000.timrot+ returned 0 after 13 usecs
[   65.987008] calling  80056000.rtc+ @ 385, parent: 80040000.apbx
[   65.993012] call 80056000.rtc+ returned 0 after 14 usecs
[   65.998601] calling  80040000.apbx+ @ 385, parent: 80000000.apb
[   66.004720] call 80040000.apbx+ returned 0 after 13 usecs
[   66.010259] calling  8002c000.ocotp+ @ 385, parent: 80000000.apbh
[   66.016565] call 8002c000.ocotp+ returned 0 after 14 usecs
[   66.022191] calling  80028000.dcp+ @ 385, parent: 80000000.apbh
[   66.028322] call 80028000.dcp+ returned 0 after 13 usecs
[   66.033833] calling  80024000.dma-apbx+ @ 385, parent: 80000000.apbh
[   66.040396] call 80024000.dma-apbx+ returned 0 after 14 usecs
[   66.046474] calling  80018000.pinctrl:gpio@4+ @ 385, parent: 80018000.pinctrl
[   66.053695] call 80018000.pinctrl:gpio@4+ returned 0 after 15 usecs
[   66.060303] calling  80018000.pinctrl:gpio@3+ @ 385, parent: 80018000.pinctrl
[   66.067640] call 80018000.pinctrl:gpio@3+ returned 0 after 14 usecs
[   66.074124] calling  80018000.pinctrl:gpio@2+ @ 385, parent: 80018000.pinctrl
[   66.081478] call 80018000.pinctrl:gpio@2+ returned 0 after 13 usecs
[   66.088068] calling  80018000.pinctrl:gpio@1+ @ 385, parent: 80018000.pinctrl
[   66.095426] call 80018000.pinctrl:gpio@1+ returned 0 after 14 usecs
[   66.101917] calling  80018000.pinctrl:gpio@0+ @ 385, parent: 80018000.pinctrl
[   66.109292] call 80018000.pinctrl:gpio@0+ returned 0 after 14 usecs
[   66.115828] calling  80018000.pinctrl+ @ 385, parent: 80000000.apbh
[   66.122177] call 80018000.pinctrl+ returned 0 after 13 usecs
[   66.128103] calling  80010000.ssp+ @ 385, parent: 80000000.apbh
[   66.134173] call 80010000.ssp+ returned 0 after 73 usecs
[   66.139808] calling  80004000.dma-apbh+ @ 385, parent: 80000000.apbh
[   66.146361] call 80004000.dma-apbh+ returned 0 after 14 usecs
[   66.152266] calling  80000000.apbh+ @ 385, parent: 80000000.apb
[   66.158402] call 80000000.apbh+ returned 0 after 14 usecs
[   66.163947] calling  80000000.apb+ @ 385, parent: soc0
[   66.169297] call 80000000.apb+ returned 0 after 13 usecs
[   66.174993] calling  reg-dummy+ @ 385, parent: platform
[   66.180303] call reg-dummy+ returned 0 after 14 usecs
[   66.185780] PM: suspend of devices complete after 491.347 msecs
[   66.199593] PM: late suspend of devices complete after 7.795 msecs
[   66.213823] PM: noirq suspend of devices complete after 7.810 msecs
[   66.220384] PM: Calling sched_clock_suspend+0x0/0x30
[   66.225386] PM: Calling timekeeping_suspend+0x0/0x248
[   66.225386] PM: Calling irq_gc_suspend+0x0/0x6c
[   66.225386] PM: Calling fw_suspend+0x0/0x14
[   66.225386] PM: Calling cpu_pm_suspend+0x0/0x18
[   66.225386] PM: Calling cpu_pm_resume+0x0/0x10
[   66.225386] PM: Calling irq_gc_resume+0x0/0x68
[   66.225386] PM: Calling irq_pm_syscore_resume+0x0/0x8
[   66.225386] PM: Calling timekeeping_resume+0x0/0x388
[   66.225386] PM: Calling sched_clock_resume+0x0/0x50
[   66.235681] PM: noirq resume of devices complete after 9.970 msecs
[   66.249836] PM: early resume of devices complete after 6.354 msecs
[   66.257903] calling  reg-dummy+ @ 385, parent: platform
[   66.263393] call reg-dummy+ returned 0 after 14 usecs
[   66.269048] calling  80000000.apb+ @ 385, parent: soc0
[   66.274433] call 80000000.apb+ returned 0 after 14 usecs
[   66.279854] calling  80000000.apbh+ @ 385, parent: 80000000.apb
[   66.285986] call 80000000.apbh+ returned 0 after 13 usecs
[   66.291488] calling  80004000.dma-apbh+ @ 385, parent: 80000000.apbh
[   66.298050] call 80004000.dma-apbh+ returned 0 after 13 usecs
[   66.304032] calling  80010000.ssp+ @ 385, parent: 80000000.apbh
[   66.310100] call 80010000.ssp+ returned 0 after 71 usecs
[   66.315901] calling  mmc0:0007+ @ 390, parent: mmc0
[   66.322084] call mmc0:0007+ returned 0 after 1186 usecs
[   66.327863] calling  80018000.pinctrl+ @ 385, parent: 80000000.apbh
[   66.334390] call 80018000.pinctrl+ returned 0 after 14 usecs
[   66.340292] calling  80018000.pinctrl:gpio@0+ @ 385, parent: 80018000.pinctrl
[   66.347660] call 80018000.pinctrl:gpio@0+ returned 0 after 14 usecs
[   66.354395] calling  80018000.pinctrl:gpio@1+ @ 385, parent: 80018000.pinctrl
[   66.361622] call 80018000.pinctrl:gpio@1+ returned 0 after 13 usecs
[   66.368166] calling  80018000.pinctrl:gpio@2+ @ 385, parent: 80018000.pinctrl
[   66.375520] call 80018000.pinctrl:gpio@2+ returned 0 after 13 usecs
[   66.381932] calling  80018000.pinctrl:gpio@3+ @ 385, parent: 80018000.pinctrl
[   66.389309] call 80018000.pinctrl:gpio@3+ returned 0 after 12 usecs
[   66.399315] calling  80018000.pinctrl:gpio@4+ @ 385, parent: 80018000.pinctrl
[   66.406746] call 80018000.pinctrl:gpio@4+ returned 0 after 13 usecs
[   66.413534] calling  80024000.dma-apbx+ @ 385, parent: 80000000.apbh
[   66.420065] call 80024000.dma-apbx+ returned 0 after 15 usecs
[   66.426220] calling  80028000.dcp+ @ 385, parent: 80000000.apbh
[   66.432320] call 80028000.dcp+ returned 0 after 14 usecs
[   66.438018] calling  8002c000.ocotp+ @ 385, parent: 80000000.apbh
[   66.444341] call 8002c000.ocotp+ returned 0 after 14 usecs
[   66.449936] calling  80040000.apbx+ @ 385, parent: 80000000.apb
[   66.456067] call 80040000.apbx+ returned 0 after 13 usecs
[   66.461564] calling  80056000.rtc+ @ 385, parent: 80040000.apbx
[   66.467729] call 80056000.rtc+ returned 0 after 23 usecs
[   66.473447] calling  80068000.timrot+ @ 385, parent: 80040000.apbx
[   66.479804] call 80068000.timrot+ returned 0 after 14 usecs
[   66.485778] calling  80074000.serial+ @ 385, parent: 80040000.apbx
[   66.492439] call 80074000.serial+ returned 0 after 303 usecs
[   66.498644] calling  8007c000.usbphy+ @ 385, parent: 80040000.apbx
[   66.505118] call 8007c000.usbphy+ returned 0 after 14 usecs
[   66.511030] calling  80080000.ahb+ @ 385, parent: soc0
[   66.516461] call 80080000.ahb+ returned 0 after 13 usecs
[   66.522156] calling  80080000.usb+ @ 385, parent: 80080000.ahb
[   66.528349] call 80080000.usb+ returned 0 after 72 usecs
[   66.535063] calling  800f0000.ethernet+ @ 385, parent: 80080000.ahb
[   66.545846] call 800f0000.ethernet+ returned 0 after 4310 usecs
[   66.552190] calling  iio-hwmon+ @ 385, parent: soc0
[   66.557331] call iio-hwmon+ returned 0 after 13 usecs
[   66.562680] calling  regulators+ @ 385, parent: soc0
[   66.567874] call regulators+ returned 0 after 13 usecs
[   66.573247] calling  regulators:regulator@0+ @ 385, parent: regulators
[   66.580022] call regulators:regulator@0+ returned 0 after 15 usecs
[   66.587259] calling  leds+ @ 385, parent: soc0
[   66.591800] call leds+ returned 0 after 15 usecs
[   66.598846] calling  alarmtimer+ @ 385, parent: platform
[   66.604503] call alarmtimer+ returned 0 after 23 usecs
[   66.610176] calling  Fixed MDIO bus.0+ @ 385, parent: platform
[   66.616252] call Fixed MDIO bus.0+ returned 0 after 12 usecs
[   66.622674] calling  800f0000.etherne:00+ @ 385, parent: 800f0000.etherne
[   66.630092] call 800f0000.etherne:00+ returned 0 after 387 usecs
[   66.636354] calling  ci_hdrc.0+ @ 385, parent: 80080000.usb
[   66.647310] call ci_hdrc.0+ returned 0 after 5048 usecs
[   66.652757] calling  usb1+ @ 391, parent: ci_hdrc.0
[   66.658084] calling  rtc0+ @ 385, parent: 80056000.rtc
[   66.664251] call usb1+ returned 0 after 6224 usecs
[   66.670162] call rtc0+ returned 0 after 6462 usecs
[   66.675361] calling  stmp3xxx_rtc_wdt+ @ 385, parent: 80056000.rtc
[   66.681633] call stmp3xxx_rtc_wdt+ returned 0 after 13 usecs
[   66.687854] calling  duckbill:green:status+ @ 385, parent: leds
[   66.694074] call duckbill:green:status+ returned 0 after 22 usecs
[   66.700951] calling  duckbill:red:status+ @ 385, parent: leds
[   66.706956] call duckbill:red:status+ returned 0 after 20 usecs
[   66.713180] calling  snd-soc-dummy+ @ 385, parent: platform
[   66.718969] call snd-soc-dummy+ returned 0 after 13 usecs
[   66.725823] PM: resume of devices complete after 469.549 msecs
[   66.739348] Restarting tasks ... [   66.783319] done.

echo freeze > /sys/power/state

[  189.939554] PM: Syncing filesystems ... [  191.084732] done.
[  191.090589] Freezing user space processes ... [  191.100074] (elapsed 0.004
seconds) done.
[  191.104444] Freezing remaining freezable tasks ... (elapsed 0.002 seconds)
done.
[  191.121118] calling  mmc0:0007+ @ 391, parent: mmc0
[  191.126437] calling  snd-soc-dummy+ @ 385, parent: platform
[  191.132104] call snd-soc-dummy+ returned 0 after 14 usecs
[  191.139007] call mmc0:0007+ returned 0 after 12458 usecs
[  191.144846] calling  duckbill:red:status+ @ 385, parent: leds
[  191.150693] call duckbill:red:status+ returned 0 after 20 usecs
[  191.156887] calling  duckbill:green:status+ @ 385, parent: leds
[  191.163035] call duckbill:green:status+ returned 0 after 20 usecs
[  191.169680] calling  stmp3xxx_rtc_wdt+ @ 385, parent: 80056000.rtc
[  191.176097] call stmp3xxx_rtc_wdt+ returned 0 after 14 usecs
[  191.181889] calling  rtc0+ @ 385, parent: 80056000.rtc
[  191.187289] call rtc0+ returned 0 after 58 usecs
[  191.193635] calling  usb1+ @ 391, parent: ci_hdrc.0
[  191.223649] call usb1+ returned 0 after 24451 usecs
[  191.228801] calling  ci_hdrc.0+ @ 385, parent: 80080000.usb
[  191.234867] call ci_hdrc.0+ returned 0 after 249 usecs
[  191.240183] calling  800f0000.etherne:00+ @ 385, parent: 800f0000.etherne
[  191.247628] call 800f0000.etherne:00+ returned 0 after 428 usecs
[  191.254012] calling  Fixed MDIO bus.0+ @ 385, parent: platform
[  191.259933] call Fixed MDIO bus.0+ returned 0 after 12 usecs
[  191.266098] calling  alarmtimer+ @ 385, parent: platform
[  191.271513] call alarmtimer+ returned 0 after 31 usecs
[  191.280964] calling  leds+ @ 385, parent: soc0
[  191.285646] call leds+ returned 0 after 15 usecs
[  191.290408] calling  regulators:regulator@0+ @ 385, parent: regulators
[  191.297152] call regulators:regulator@0+ returned 0 after 14 usecs
[  191.303602] calling  regulators+ @ 385, parent: soc0
[  191.308648] call regulators+ returned 0 after 13 usecs
[  191.314044] calling  iio-hwmon+ @ 385, parent: soc0
[  191.319008] call iio-hwmon+ returned 0 after 13 usecs
[  191.324325] calling  800f0000.ethernet+ @ 385, parent: 80080000.ahb
[  191.330828] call 800f0000.ethernet+ returned 0 after 152 usecs
[  191.336942] calling  80080000.usb+ @ 385, parent: 80080000.ahb
[  191.343135] call 80080000.usb+ returned 0 after 62 usecs
[  191.348600] calling  80080000.ahb+ @ 385, parent: soc0
[  191.353949] call 80080000.ahb+ returned 0 after 13 usecs
[  191.359397] calling  8007c000.usbphy+ @ 385, parent: 80040000.apbx
[  191.365789] call 8007c000.usbphy+ returned 0 after 14 usecs
[  191.371504] calling  80074000.serial+ @ 385, parent: 80040000.apbx
[  191.377944] call 80074000.serial+ returned 0 after 51 usecs
[  191.383782] calling  80068000.timrot+ @ 385, parent: 80040000.apbx
[  191.390043] call 80068000.timrot+ returned 0 after 13 usecs
[  191.395885] calling  80056000.rtc+ @ 385, parent: 80040000.apbx
[  191.401889] call 80056000.rtc+ returned 0 after 14 usecs
[  191.407472] calling  80040000.apbx+ @ 385, parent: 80000000.apb
[  191.413607] call 80040000.apbx+ returned 0 after 12 usecs
[  191.419146] calling  8002c000.ocotp+ @ 385, parent: 80000000.apbh
[  191.425447] call 8002c000.ocotp+ returned 0 after 13 usecs
[  191.431064] calling  80028000.dcp+ @ 385, parent: 80000000.apbh
[  191.437198] call 80028000.dcp+ returned 0 after 13 usecs
[  191.442706] calling  80024000.dma-apbx+ @ 385, parent: 80000000.apbh
[  191.449272] call 80024000.dma-apbx+ returned 0 after 14 usecs
[  191.455345] calling  80018000.pinctrl:gpio@4+ @ 385, parent: 80018000.pinctrl
[  191.462570] call 80018000.pinctrl:gpio@4+ returned 0 after 14 usecs
[  191.469179] calling  80018000.pinctrl:gpio@3+ @ 385, parent: 80018000.pinctrl
[  191.476533] call 80018000.pinctrl:gpio@3+ returned 0 after 13 usecs
[  191.483150] calling  80018000.pinctrl:gpio@2+ @ 385, parent: 80018000.pinctrl
[  191.490374] call 80018000.pinctrl:gpio@2+ returned 0 after 15 usecs
[  191.496983] calling  80018000.pinctrl:gpio@1+ @ 385, parent: 80018000.pinctrl
[  191.504340] call 80018000.pinctrl:gpio@1+ returned 0 after 14 usecs
[  191.510828] calling  80018000.pinctrl:gpio@0+ @ 385, parent: 80018000.pinctrl
[  191.518177] call 80018000.pinctrl:gpio@0+ returned 0 after 13 usecs
[  191.524725] calling  80018000.pinctrl+ @ 385, parent: 80000000.apbh
[  191.531076] call 80018000.pinctrl+ returned 0 after 14 usecs
[  191.536998] calling  80010000.ssp+ @ 385, parent: 80000000.apbh
[  191.543197] call 80010000.ssp+ returned 0 after 72 usecs
[  191.548705] calling  80004000.dma-apbh+ @ 385, parent: 80000000.apbh
[  191.555270] call 80004000.dma-apbh+ returned 0 after 14 usecs
[  191.561178] calling  80000000.apbh+ @ 385, parent: 80000000.apb
[  191.567310] call 80000000.apbh+ returned 0 after 13 usecs
[  191.573063] calling  80000000.apb+ @ 385, parent: soc0
[  191.578290] call 80000000.apb+ returned 0 after 11 usecs
[  191.583997] calling  reg-dummy+ @ 385, parent: platform
[  191.589308] call reg-dummy+ returned 0 after 12 usecs
[  191.594782] PM: suspend of devices complete after 474.663 msecs
[  191.608635] PM: late suspend of devices complete after 7.831 msecs
[  191.622637] PM: noirq suspend of devices complete after 7.569 msecs
[  366.696043] INFO: task ext4lazyinit:70 blocked for more than 120 seconds.
[  366.703046]       Not tainted 4.9.0-rc1 #7
[  366.707188] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
message.
[  366.715161] ext4lazyinit    D c05aa6ac     0    70      2 0x00000000
[  366.721713] [<c05aa6ac>] (__schedule) from [<c05aafb8>] (schedule+0x3c/0xbc)
[  366.728972] [<c05aafb8>] (schedule) from [<c05aee38>]
(schedule_timeout+0x23c/0x3d8)
[  366.736917] [<c05aee38>] (schedule_timeout) from [<c05aa398>]
(io_schedule_timeout+0xb8/0x13c)
[  366.745721] [<c05aa398>] (io_schedule_timeout) from [<c05ab9d8>]
(T.1434+0xac/0x12c)
[  366.753671] [<c05ab9d8>] (T.1434) from [<c02c7668>]
(submit_bio_wait+0x50/0x68)
[  366.761078] [<c02c7668>] (submit_bio_wait) from [<c02d9a58>]
(blkdev_issue_zeroout+0x174/0x1ec)
[  366.769984] [<c02d9a58>] (blkdev_issue_zeroout) from [<c0196e4c>]
(ext4_init_inode_table+0x1ac/0x3b0)
[  366.779410] [<c0196e4c>] (ext4_init_inode_table) from [<c01ba770>]
(ext4_lazyinit_thread+0x280/0x398)
[  366.788803] [<c01ba770>] (ext4_lazyinit_thread) from [<c003bce4>]
(kthread+0xc4/0xe0)
[  366.796828] [<c003bce4>] (kthread) from [<c000a34c>]
(ret_from_fork+0x14/0x28)
[  366.804200]
[  366.804200] Showing all locks held in the system:
[  366.810465] 2 locks held by khungtaskd/10:
[  366.814707]  #0: [  366.816500]  (
rcu_read_lock[  366.819360] ){......}
, at: [  366.822236] [<c0093a10>] watchdog+0xb4/0x61c
[  366.826656]  #1: [  366.828450]  (
tasklist_lock[  366.831312] ){.+.+..}
, at: [  366.834320] [<c0051dbc>] debug_show_all_locks+0x28/0x1bc
[  366.839701] 4 locks held by ext4lazyinit/70:
[  366.844107]  #0: [  366.845897]  (
&type->s_umount_key[  366.849280] #22
){++++++}[  366.851866] , at:
[  366.854044] [<c01ba5c4>] ext4_lazyinit_thread+0xd4/0x398
[  366.859400]  #1: [  366.861178]  (
sb_writers[  366.863897] #3
){.+.+.+}[  366.866412] , at:
[  366.868475] [<c01ba5dc>] ext4_lazyinit_thread+0xec/0x398
[  366.873925]  #2: [  366.875716]  (
jbd2_handle[  366.878405] ){++++..}
, at: [  366.881292] [<c01f661c>] start_this_handle+0xec/0x404
[  366.886492]  #3: [  366.888284]  (
&meta_group_info[i]->alloc_sem[  366.892620] ){++++..}
, at: [  366.895624] [<c0196d58>] ext4_init_inode_table+0xb8/0x3b0
[  366.901093] 4 locks held by bash/385:
[  366.904895]  #0: [  366.906686]  (
sb_writers[  366.909288] #4
){.+.+.+}[  366.911787] , at:
[  366.913972] [<c011f7d4>] vfs_write+0x194/0x1a4
[  366.918456]  #1: [  366.920234]  (
&of->mutex[  366.922824] ){+.+.+.}
, at: [  366.925940] [<c019029c>] kernfs_fop_write+0xc0/0x1d0
[  366.930942]  #2: [  366.932714]  (
s_active[  366.935265] #43
){.+.+.+}[  366.937864] , at:
[  366.939927] [<c01902a4>] kernfs_fop_write+0xc8/0x1d0
[  366.945029]  #3: [  366.946818]  (
pm_mutex[  366.949242] ){+.+.+.}
, at: [  366.952111] [<c005b7e4>] pm_suspend+0x90/0x81c
[  366.956697]
[  366.958229] =============================================
