From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v11 0/8] power: add power sequence library
Date: Fri, 6 Jan 2017 19:08:32 +0200
Message-ID: <20170106170832.jxthwq5sabpyskui@kozik-lap>
References: <1483596119-27508-1-git-send-email-peter.chen@nxp.com>
 <20170106151841.l6ehqmpben4ilkaf@kozik-lap>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170106151841.l6ehqmpben4ilkaf@kozik-lap>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Peter Chen <peter.chen@nxp.com>, gregkh@linuxfoundation.org, stern@rowland.harvard.edu, ulf.hansson@linaro.org, broonie@kernel.org, sre@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org, rjw@rjwysocki.net, dbaryshkov@gmail.com, heiko@sntech.de, linux-arm-kernel@lists.infradead.org, p.zabel@pengutronix.de, devicetree@vger.kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, linux-usb@vger.kernel.org, arnd@arndb.de, s.hauer@pengutronix.de, mail@maciej.szmigiero.name, troy.kisky@boundarydevices.com, festevam@gmail.com, oscar@naiandei.net, stephen.boyd@linaro.org, linux-pm@vger.kernel.org, stillcompiling@gmail.com, linux-kernel@vger.kernel.org, mka@chromium.org, vaibhav.hiremath@linaro.org, gary.bisson@boundarydevices.com, hverkuil@xs4all.nl
List-Id: linux-pm@vger.kernel.org

On Fri, Jan 06, 2017 at 05:18:41PM +0200, Krzysztof Kozlowski wrote:
> On Thu, Jan 05, 2017 at 02:01:51PM +0800, Peter Chen wrote:
> > Hi all,
> > 
> > This is a follow-up for my last power sequence framework patch set [1].
> > According to Rob Herring and Ulf Hansson's comments[2]. The kinds of
> > power sequence instances will be added at postcore_initcall, the match
> > criteria is compatible string first, if the compatible string is not
> > matched between dts and library, it will try to use generic power sequence.
> > 	 
> > The host driver just needs to call of_pwrseq_on/of_pwrseq_off
> > if only one power sequence instance is needed, for more power sequences
> > are used, using of_pwrseq_on_list/of_pwrseq_off_list instead (eg, USB hub driver).
> > 
> > In future, if there are special power sequence requirements, the special
> > power sequence library can be created.
> > 
> > This patch set is tested on i.mx6 sabresx evk using a dts change, I use
> > two hot-plug devices to simulate this use case, the related binding
> > change is updated at patch [1/6], The udoo board changes were tested
> > using my last power sequence patch set.[3]
> > 
> > Except for hard-wired MMC and USB devices, I find the USB ULPI PHY also
> > need to power on itself before it can be found by ULPI bus.
> > 
> > [1] http://www.spinics.net/lists/linux-usb/msg142755.html
> > [2] http://www.spinics.net/lists/linux-usb/msg143106.html
> > [3] http://www.spinics.net/lists/linux-usb/msg142815.html
> > 
> 
> Unfortunately I was unable to utilize this library to solve Odroid U3
> usb3503/lan9730 power sequence (as a continuation of my old series [0][1]).
> 
> The main problem is that power sequence instance (pwrseq_generic.c) is
> not a device. I don't get why it is not a device. It would be rather
> intuitive to me to make it a device. Also it would make life easier
> because you could use all device-like consumer APIs (of getting clocks,
> GPIOs etc). Since it is not a device, it is not possible to use
> regulator consumer API.
> 
> I need a regulator because I need to toggle the power.
> 
> Other encountered issue is that power sequence happens early, before the
> unused regulators are turned off by the system. However maybe this is
> the necessity from other point of view.
> 
> My case is annoyingly over-complicated so I am slowly getting sertain
> that it is not generic. Anyway it looks like this:
> 
> EHCI controller
>      |
>      |--HSIC0--lan9730 (reset is done only through regulator)
>      |--HSIC1--usb3504 (it has a reset GPIO... but it is toggled by
>                         usb3504 driver)
> 
> Overall, I want to reset the lan9730. This can be done only through
> power - buck8. buck8 state is an logical OR of register set by I2C and
> GPIO. Thus to turn it off, it is not sufficient just to set register to
> 0x0 because the GPIO is keeping it on. The best way is to switch the
> buck8 to gpio-enable-control thus only GPIO will be toggling it... still
> through the regulator consumer API (because it is an GPIO for the
> regulator, not for the reset!).
> 
> However these two seems coupled. On invalid reset sequence, both chips
> die. The usb3504 has its own existing reset sequence and my findings
> show that it should happen after lan9730 reset sequence. Otherwise all
> devices might be lost...

Update - it's working! I skipped entirely the regulator API and I am
playing with its GPIO. This sounds like a hack but finally after few
days of different tries I was able to find a working, reproducible
solution. It turned out that the yours pwrseq is working quite good.

I'll send a follow-up for my board soon.

Best regards,
Krzysztof


> 
> [0] http://www.spinics.net/lists/linux-mmc/msg37386.html
> [1] https://github.com/krzk/linux/commits/for-next/odroid-u3-usb3503-lan-boot-fixes-v4
> 
