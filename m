From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH 3/5] arm: dts: rockchip: add tsadc node for RV1108 SoC
Date: Tue, 17 Oct 2017 21:00:40 +0200
Message-ID: <1784322.nOOBHvxH5Z@phil>
References: <1503570475-7850-1-git-send-email-rocky.hao@rock-chips.com> <1503570475-7850-4-git-send-email-rocky.hao@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503570475-7850-4-git-send-email-rocky.hao@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rocky Hao <rocky.hao@rock-chips.com>
Cc: rui.zhang@intel.com, edubezval@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, shawn.lin@rock-chips.com, cl@rock-chips.com, william.wu@rock-chips.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, xxx@rock-chips.com, jay.xu@rock-chips.com, wxt@rock-chips.com, huangtao@rock-chips.com
List-Id: linux-pm@vger.kernel.org

Am Donnerstag, 24. August 2017, 18:27:53 CEST schrieb Rocky Hao:
> Add tsadc needed main information for RV1108 SoC.
> 750000Hz is the max clock rate supported by tsadc module.
> 
> Signed-off-by: Rocky Hao <rocky.hao@rock-chips.com>

applied for 4.15 with Eduardo's Ack.

Please make further adjustments for things like temperatures
in follow-up patches.


Thanks
Heiko
