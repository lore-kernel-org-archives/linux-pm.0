From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 2/2] dt-bindings: document Rockchip thermal
Date: Wed, 27 Aug 2014 22:17:19 +0200
Message-ID: <5911166.ElkaNhDZrP@wuerfel>
References: <1409096503-7081-1-git-send-email-caesar.wang@rock-chips.com> <1409096503-7081-3-git-send-email-caesar.wang@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1409096503-7081-3-git-send-email-caesar.wang@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Caesar Wang <caesar.wang@rock-chips.com>
Cc: heiko@sntech.de, rui.zhang@intel.com, edubezval@gmail.com, grant.likely@linaro.org, robh+dt@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, huangtao@rock-chips.com, cf@rock-chips.com, dianders@chromium.org, dtor@chromium.org, zyw@rock-chips.com, addy.ke@rock-chips.com, zhaoyifeng <zyf@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday 27 August 2014 07:41:43 Caesar Wang wrote:
> +- clock-names : Shall be "tsadc_clk" for the transfer-clock, and "tsadc_pclk" for
> +    the peripheral clock.
> 

Why not just name them "clk" and "pclk"? The "tsadc" part seems highly redundant.

Alternatively, how about "transfer" and "peripheral"?

	Arnd
