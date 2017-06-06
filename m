From: =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: Re: [PATCH 1/2] Documentation: devicetree: add binding for Broadcom
 STB AVS TMON
Date: Tue, 06 Jun 2017 14:21:54 +0200
Message-ID: <e5da2edfae3bd593fd7819db1d7e2337@milecki.pl>
References: <20170605210930.65432-1-code@mmayer.net>
 <20170605210930.65432-2-code@mmayer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170605210930.65432-2-code@mmayer.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Markus Mayer <code@mmayer.net>
Cc: Mark Rutland <mark.rutland@arm.com>, Device Tree List <devicetree@vger.kernel.org>, Doug Berger <opendmb@gmail.com>, Markus Mayer <mmayer@broadcom.com>, Power Management List <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Brian Norris <computersforpeace@gmail.com>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 2017-06-05 23:09, Markus Mayer wrote:
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/brcm,avs-tmon.txt
> @@ -0,0 +1,20 @@
> +* Broadcom STB thermal management
> +
> +Thermal management core, provided by the AVS TMON hardware block.
> +
> +Required properties:
> +- compatible: must be one of "brcm,avs-tmon" or 
> "brcm,avs-tmon-bcm7445"

Is the "one of" correct here? I'm not native English but it sounds like
setting both is a wrong thing.


> +- reg: address range for the AVS TMON registers
> +- interrupts: temperature monitor interrupt, for high/low threshold 
> triggers
> +- interrupt-names: should be "tmon"
> +- interrupt-parent: the parent interrupt controller
> +
> +Example:
> +
> +	thermal@f04d1500 {
> +		compatible = "brcm,avs-tmon-bcm7445", "brcm,avs-tmon";

Yet here you use both bindings.
