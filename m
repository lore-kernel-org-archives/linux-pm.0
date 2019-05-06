From: Eddie Huang <eddie.huang@mediatek.com>
Subject: Re: [PATCH 3/8] arm64: dts: mt8183: Add #cooling-cells to CPU nodes
Date: Mon, 6 May 2019 13:25:32 +0800
Message-ID: <1557120332.13225.2.camel@mtksdaap41>
References: <1556793795-25204-1-git-send-email-michael.kao@mediatek.com>
 <1556793795-25204-4-git-send-email-michael.kao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1556793795-25204-4-git-send-email-michael.kao@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "michael.kao" <michael.kao@mediatek.com>
Cc: Mark Rutland <mark.rutland@arm.com>, JamesJJ Liao =?UTF-8?Q?=28=E5=BB=96=E5=BB=BA=E6=99=BA=29?= <jamesjj.liao@mediatek.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Louis Yu =?UTF-8?Q?=28=E6=B8=B8=E6=94=BF=E9=8C=95=29?= <louis.yu@mediatek.com>, Dawei Chien =?UTF-8?Q?=28=E9=8C=A2=E5=A4=A7=E8=A1=9B=29?= <Dawei.Chien@mediatek.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Roger Lu =?UTF-8?Q?=28=E9=99=B8=E7=91=9E=E5=82=91=29?= <Roger.Lu@mediatek.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Fan Chen =?UTF-8?Q?=28=E9=99=B3=E5=87=A1=29?= <fan.chen@mediatek.com>, Rob Herring <robh+dt@kernel.org>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, Zhang Rui <rui.zhang@intel>
List-Id: linux-pm@vger.kernel.org

Hi Michael,

On Thu, 2019-05-02 at 18:43 +0800, michael.kao wrote:
> The #cooling-cells property needs to be specified to allow a CPU
> to be used as cooling device.
> 
> Signed-off-by: michael.kao <Michael.Kao@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index 5668fb8..95f1d7b 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -11,6 +11,8 @@
>  #include <dt-bindings/power/mt8183-power.h>
>  #include <dt-bindings/reset-controller/mt8183-resets.h>
>  #include "mt8183-pinfunc.h"
> +#include <dt-bindings/thermal/thermal.h>
> +
>  / {
>  	compatible = "mediatek,mt8183";
>  	interrupt-parent = <&sysirq>;

It seems this patch don't have #cooling-cells but in your 2/8 patch in
this series
