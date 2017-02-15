From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH v13 00/12] power: add power sequence library
Date: Wed, 15 Feb 2017 09:38:09 +0800
Message-ID: <20170215013808.GB6579@b29397-desktop>
References: <1486776443-2280-1-git-send-email-peter.chen@nxp.com>
 <f34acc40-41e2-a7ea-a2aa-6cf604086182@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f34acc40-41e2-a7ea-a2aa-6cf604086182@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Peter Chen <peter.chen@nxp.com>, gregkh@linuxfoundation.org, stern@rowland.harvard.edu, ulf.hansson@linaro.org, broonie@kernel.org, sre@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org, rjw@rjwysocki.net, dbaryshkov@gmail.com, mark.rutland@arm.com, heiko@sntech.de, stephen.boyd@linaro.org, frank.li@nxp.com, gary.bisson@boundarydevices.com, festevam@gmail.com, stillcompiling@gmail.com, arnd@arndb.de, vaibhav.hiremath@linaro.org, krzk@kernel.org, mka@chromium.org, devicetree@vger.kernel.org, mail@maciej.szmigiero.name, pawel.moll@arm.com, linux-pm@vger.kernel.org, s.hauer@pengutronix.de, troy.kisky@boundarydevices.com, linux-arm-kernel@lists.infradead.org, hverkuil@xs4all.nl, oscar@naiandei.net, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, p.zabel@pengutronix.de
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 14, 2017 at 12:21:48PM +0200, Roger Quadros wrote:
> Peter,
> 
> On 11/02/17 03:27, Peter Chen wrote:
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
> 
> Can patches 3-7 can be sent independently of the power related patches?
> 

Yes, I had planned to submit patches 3-7 for v4.11-rc1 today first, but it
seems you still have comments for patch 6, let's wait a conclusion first.

-- 

Best Regards,
Peter Chen
