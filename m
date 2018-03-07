From: Sean Wang <sean.wang@mediatek.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: thermal: add binding for MT7622 SoC
Date: Wed, 7 Mar 2018 17:12:21 +0800
Message-ID: <1520413941.677.0.camel@mtkswgap22>
References: <c72262a17332a227aa2db39b682db50e2324821a.1518856935.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c72262a17332a227aa2db39b682db50e2324821a.1518856935.git.sean.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org
Cc: rui.zhang@intel.com, edubezval@gmail.com, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Shunli Wang <shunli.wang@mediatek.com>
List-Id: linux-pm@vger.kernel.org

Hi, Rui

just a gentle ping to the both patches

	Sean

On Sat, 2018-02-17 at 16:49 +0800, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Add devicetree bindings for MediaTek MT7622 thermal controller
> 
> Changes v1 -> v2: add tag from Rob
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Shunli Wang <shunli.wang@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/thermal/mediatek-thermal.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
> index 0d73ea5..41d6a44 100644
> --- a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
> @@ -12,6 +12,7 @@ Required properties:
>    - "mediatek,mt8173-thermal" : For MT8173 family of SoCs
>    - "mediatek,mt2701-thermal" : For MT2701 family of SoCs
>    - "mediatek,mt2712-thermal" : For MT2712 family of SoCs
> +  - "mediatek,mt7622-thermal" : For MT7622 SoC
>  - reg: Address range of the thermal controller
>  - interrupts: IRQ for the thermal controller
>  - clocks, clock-names: Clocks needed for the thermal controller. required
