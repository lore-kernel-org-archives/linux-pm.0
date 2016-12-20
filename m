From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH v10 0/8] power: add power sequence library
Date: Tue, 20 Dec 2016 12:31:12 +0800
Message-ID: <20161220043112.GA10071@b29397-desktop>
References: <1479087359-7547-1-git-send-email-peter.chen@nxp.com>
 <20161219191504.GA18988@kozik-lap>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36188 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755246AbcLTEat (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Dec 2016 23:30:49 -0500
Content-Disposition: inline
In-Reply-To: <20161219191504.GA18988@kozik-lap>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Peter Chen <peter.chen@nxp.com>, mark.rutland@arm.com, ulf.hansson@linaro.org, heiko@sntech.de, stephen.boyd@linaro.org, linux-kernel@vger.kernel.org, gary.bisson@boundarydevices.com, festevam@gmail.com, stillcompiling@gmail.com, arnd@arndb.de, dbaryshkov@gmail.com, vaibhav.hiremath@linaro.org, mka@chromium.org, stern@rowland.harvard.edu, devicetree@vger.kernel.org, mail@maciej.szmigiero.name, pawel.moll@arm.com, linux-pm@vger.kernel.org, s.hauer@pengutronix.de, troy.kisky@boundarydevices.com, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, oscar@naiandei.net, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, rjw@rjwysocki.net, sre@kernel.org, broonie@kernel.org, p.zabel@pengutronix.de, shawnguo@kernel.org

On Mon, Dec 19, 2016 at 09:15:04PM +0200, Krzysztof Kozlowski wrote:
> On Mon, Nov 14, 2016 at 09:35:51AM +0800, Peter Chen wrote:
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
> > Changes for v10:
> > - Improve the kernel-doc for power sequence core, including exported APIs and
> >   main structure. [Patch 2/8]
> > - Change Kconfig, and let the user choose power sequence. [Patch 2/8]
> > - Delete EXPORT_SYMBOL and change related APIs as local, these APIs do not
> >   be intended to export currently. [Patch 2/8]
> > - Selete POWER_SEQUENCE at USB core's Kconfig. [Patch 4/8]
> 
> Hi Peter,
> 
> It is great that you continued the work on this.
> 
> I saw (in some previous mails) your repo mentioned:
> https://git.kernel.org/cgit/linux/kernel/git/peter.chen/usb.git/
> Does it contain the recent version of this patchset?
> 
> I want to build on top of it fixes for usb3503 on Odroid U3 board.

Krzysztof, I put v10 patch set at branch: pwrseq-lib. 
It seems there are no more comments I will send my v11 patch set
after new year holiday.

-- 

Best Regards,
Peter Chen
