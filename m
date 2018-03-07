From: Sean Wang <sean.wang@mediatek.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: soc: add SCPSYS binding for MT7623
 and MT7623A SoC
Date: Wed, 7 Mar 2018 17:17:04 +0800
Message-ID: <1520414224.677.2.camel@mtkswgap22>
References: <ecfc548fc3d22aa335b50e552ad2ad88427a0bb2.1517998367.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <ecfc548fc3d22aa335b50e552ad2ad88427a0bb2.1517998367.git.sean.wang@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, ulf.hansson@linaro.org, linux-pm@vger.kernel.org, khilman@baylibre.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi, Matthias

just a gentle ping to the four related patches

	Sean

On Wed, 2018-02-07 at 18:22 +0800, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> document the binding for enabling SCPSYS on MediaTek MT7623 and MT7623A
> SoC. Where MT7623 SoC has the same definition about power domains with
> MT2701, so it's fine to using MT2701 ones as MT7623's fallback.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/soc/mediatek/scpsys.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
> index 76bf45b..d6fe16f 100644
> --- a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
> +++ b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
> @@ -21,6 +21,8 @@ Required properties:
>  	- "mediatek,mt2712-scpsys"
>  	- "mediatek,mt6797-scpsys"
>  	- "mediatek,mt7622-scpsys"
> +	- "mediatek,mt7623-scpsys", "mediatek,mt2701-scpsys": For MT7623 SoC
> +	- "mediatek,mt7623a-scpsys": For MT7623A SoC
>  	- "mediatek,mt8173-scpsys"
>  - #power-domain-cells: Must be 1
>  - reg: Address range of the SCPSYS unit
> @@ -28,10 +30,11 @@ Required properties:
>  - clock, clock-names: clocks according to the common clock binding.
>                        These are clocks which hardware needs to be
>                        enabled before enabling certain power domains.
> -	Required clocks for MT2701: "mm", "mfg", "ethif"
> +	Required clocks for MT2701 or MT7623: "mm", "mfg", "ethif"
>  	Required clocks for MT2712: "mm", "mfg", "venc", "jpgdec", "audio", "vdec"
>  	Required clocks for MT6797: "mm", "mfg", "vdec"
>  	Required clocks for MT7622: "hif_sel"
> +	Required clocks for MT7622A: "ethif"
>  	Required clocks for MT8173: "mm", "mfg", "venc", "venc_lt"
>  
>  Optional properties:
