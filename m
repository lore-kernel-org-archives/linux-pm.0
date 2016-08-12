From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCHES] ARM: dts: update udoo and evi hubs to use pwrseq
Date: Fri, 12 Aug 2016 11:09:54 +0800
Message-ID: <20160812030954.GG18967@shlinux2>
References: <20160810030254.GD1879@shlinux2>
 <1470933632-22133-1-git-send-email-stillcompiling@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1470933632-22133-1-git-send-email-stillcompiling@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joshua Clayton <stillcompiling@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>, gregkh@linuxfoundation.org, stern@rowland.harvard.edu, ulf.hansson@linaro.org, broonie@kernel.org, sre@kernel.org, robh+dt@kernel.org, dbaryshkov@gmail.com, dwmw3@infradead.org, k.kozlowski@samsung.com, linux-arm-kernel@lists.infradead.org, p.zabel@pengutronix.de, devicetree@vger.kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, linux-usb@vger.kernel.org, arnd@arndb.de, s.hauer@pengutronix.de, mail@maciej.szmigiero.name, troy.kisky@boundarydevices.com, festevam@gmail.com, oscar@naiandei.net, stephen.boyd@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, mka@chromium.org
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 11, 2016 at 09:40:29AM -0700, Joshua Clayton wrote:
> 
> Hi Peter,
> 
> Consider this my attempt to squeeze my own dts into your patch series.
> These patches repalce patch 6 in V5. of the usb pwrseq series
> I adding a #address and #size to imx6qdl.dtsi in patch 1
> and remove those lines from imx6qdl-udoo.dtsi in patch 2 (formerly patch 6)
> Finally I make the change in imx6q-evi.dts and hope is can be slipped into
> the series with the others.
> 

Thanks, I will send them at next revision

-- 

Best Regards,
Peter Chen
