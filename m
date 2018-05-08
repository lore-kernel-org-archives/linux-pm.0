From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 02/17] dt-bindings: rtc: mt6397: add bindings for
 MediaTek PMIC based RTC
Date: Tue, 8 May 2018 10:39:41 -0500
Message-ID: <20180508153941.GA23906@rob-hp-laptop>
References: <cover.1524646231.git.sean.wang@mediatek.com>
 <ae63c2a511e40ab4f6778197a1f15e41505d5682.1524646231.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ae63c2a511e40ab4f6778197a1f15e41505d5682.1524646231.git.sean.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sean.wang@mediatek.com
Cc: mark.rutland@arm.com, sre@kernel.org, lee.jones@linaro.org, a.zummo@towertech.it, alexandre.belloni@free-electrons.com, matthias.bgg@gmail.com, eddie.huang@mediatek.com, devicetree@vger.kernel.org, linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 25, 2018 at 05:32:28PM +0800, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Add device-tree binding for MediaTek PMIC based RTC
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  .../devicetree/bindings/rtc/rtc-mt6397.txt         | 29 ++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/rtc-mt6397.txt

Reviewed-by: Rob Herring <robh@kernel.org>
