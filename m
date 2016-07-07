From: Keerthy <a0393675-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/3] dt-bindings: thermal: Add binding document for
 Mediatek thermal controller
Date: Thu, 7 Jul 2016 16:39:16 +0530
Message-ID: <577E385C.9080501@ti.com>
References: <1467882386-40544-1-git-send-email-dawei.chien@mediatek.com>
 <1467882386-40544-2-git-send-email-dawei.chien@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1467882386-40544-2-git-send-email-dawei.chien-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Dawei Chien <dawei.chien-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Erin Lo <erin.lo-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fan Chen <fan.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org



On Thursday 07 July 2016 02:36 PM, Dawei Chien wrote:
> This adds the device tree binding documentation for the mediatek thermal
> controller found on Mediatek MT2701.
>
> Signed-off-by: Dawei Chien <dawei.chien-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> ---
>   .../bindings/thermal/mediatek-thermal.txt          |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
> index 81f9a51..bb55e79 100644
> --- a/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
> @@ -8,7 +8,7 @@ apmixedsys register space via AHB bus accesses, so a phandle to the APMIXEDSYS
>   is also needed.
>
>   Required properties:
> -- compatible: "mediatek,mt8173-thermal"
> +- compatible: "mediatek,mt8173-thermal" or "mediatek,mt2701-thermal"

- compatible :
  - "mediatek,mt8173-thermal" : For MT8173 family of SoCs
  - "mediatek,mt2701-thermal" : For MT2701 family of SoCs

>   - reg: Address range of the thermal controller
>   - interrupts: IRQ for the thermal controller
>   - clocks, clock-names: Clocks needed for the thermal controller. required
>
