From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 7/7] doc: bindings: act8945a-charger: Update properties
Date: Tue, 28 Jun 2016 15:57:50 -0500
Message-ID: <20160628205750.GZ3737@rob-hp-laptop>
References: <1467076970-12206-1-git-send-email-wenyou.yang@atmel.com>
 <1467076970-12206-8-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1467076970-12206-8-git-send-email-wenyou.yang@atmel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wenyou Yang <wenyou.yang@atmel.com>
Cc: devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-pm@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Kumar Gala <galak@codeaurora.org>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jun 28, 2016 at 09:22:50AM +0800, Wenyou Yang wrote:
> Due the driver improvements, update the properties,
>  - Remove "active-semi,check-battery-temperature" property.
>  - Add the properties, "active-semi,irq_gpio"
>    and "active-semi,lbo-gpios".
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> ---
> 
> Changes in v2: None
> 
>  Documentation/devicetree/bindings/power/act8945a-charger.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/act8945a-charger.txt b/Documentation/devicetree/bindings/power/act8945a-charger.txt
> index bea254c..d7cf05b 100644
> --- a/Documentation/devicetree/bindings/power/act8945a-charger.txt
> +++ b/Documentation/devicetree/bindings/power/act8945a-charger.txt
> @@ -4,10 +4,12 @@ Required properties:
>   - compatible: "active-semi,act8945a", please refer to ../mfd/act8945a.txt.
>   - active-semi,chglev-gpios: charge current level phandle with args
>     as described in ../gpio/gpio.txt.
> + - active-semi,irq_gpios: specify the charger interrupt input phanle
> +   with args as as described in ../gpio/gpio.txt.

Use "interrupts" property instead.

> + - active-semi,lbo-gpios: specify the low battery voltage detect phandle
> +   with args as as described in ../gpio/gpio.txt.
>  
>  Optional properties:
> - - active-semi,check-battery-temperature: boolean to check the battery
> -   temperature or not.
>   - active-semi,input-voltage-threshold-microvolt: unit: mV;
>     Specifies the charger's input over-voltage threshold value;
>     The value can be: 6600, 7000, 7500, 8000; default: 6600
> -- 
> 2.7.4
> 
