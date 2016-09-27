From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH v7 0/8] power: add power sequence library
Date: Wed, 28 Sep 2016 01:30:17 +0200
Message-ID: <57EB0109.4070000@maciej.szmigiero.name>
References: <1474342607-27512-1-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1474342607-27512-1-git-send-email-peter.chen@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Chen <peter.chen@nxp.com>
Cc: gregkh@linuxfoundation.org, stern@rowland.harvard.edu, ulf.hansson@linaro.org, broonie@kernel.org, sre@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org, dbaryshkov@gmail.com, dwmw3@infradead.org, k.kozlowski@samsung.com, linux-arm-kernel@lists.infradead.org, p.zabel@pengutronix.de, devicetree@vger.kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, linux-usb@vger.kernel.org, arnd@arndb.de, s.hauer@pengutronix.de, troy.kisky@boundarydevices.com, festevam@gmail.com, oscar@naiandei.net, stephen.boyd@linaro.org, linux-pm@vger.kernel.org, stillcompiling@gmail.com, linux-kernel@vger.kernel.org, mka@chromium.org, vaibhav.hiremath@linaro.org
List-Id: linux-pm@vger.kernel.org

On 20.09.2016 05:36, Peter Chen wrote:
> Hi all,
> 
> This is a follow-up for my last power sequence framework patch set [1].
> According to Rob Herring and Ulf Hansson's comments[2]. The kinds of
> power sequence instances will be added at postcore_initcall, the match
> criteria is compatible string first, if the compatible string is not
> matched between dts and library, it will try to use generic power sequence.
> 	 
> The host driver just needs to call of_pwrseq_on/of_pwrseq_off
> if only one power sequence instance is needed, for more power sequences
> are used, using of_pwrseq_on_list/of_pwrseq_off_list instead (eg, USB hub driver).
> 
> In future, if there are special power sequence requirements, the special
> power sequence library can be created.
> 
> This patch set is tested on i.mx6 sabresx evk using a dts change, I use
> two hot-plug devices to simulate this use case, the related binding
> change is updated at patch [1/6], The udoo board changes were tested
> using my last power sequence patch set.[3]
> 
> Except for hard-wired MMC and USB devices, I find the USB ULPI PHY also
> need to power on itself before it can be found by ULPI bus.
> 
> [1] http://www.spinics.net/lists/linux-usb/msg142755.html
> [2] http://www.spinics.net/lists/linux-usb/msg143106.html
> [3] http://www.spinics.net/lists/linux-usb/msg142815.html

Just tested this patch set on UDOO board again to make sure that it still
works after all changes done since it was last tested there and can confirm
that it does work correctly.

Maciej
