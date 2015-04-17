From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC/PATCH v2 3/5] devicetree: bindings: Add new cpuidle enable
 method for Renesas R-car SoCs
Date: Fri, 17 Apr 2015 13:46:25 +0100
Message-ID: <20150417124624.GD21904@leverpostej>
References: <1429180540-5692-1-git-send-email-keita.kobayashi.ym@renesas.com>
 <1429180540-5692-4-git-send-email-keita.kobayashi.ym@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1429180540-5692-4-git-send-email-keita.kobayashi.ym@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
Cc: "horms@verge.net.au" <horms@verge.net.au>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "magnus.damm@gmail.com" <magnus.damm@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 16, 2015 at 11:35:38AM +0100, Keita Kobayashi wrote:
> This patch add the ARM CPUs Device Tree binding to document a new
> enable method of Renesas cpuidle.
> 
> Signed-off-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
> ---
>  Documentation/devicetree/bindings/arm/cpus.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
> index 8b9e0a9..663ee11 100644
> --- a/Documentation/devicetree/bindings/arm/cpus.txt
> +++ b/Documentation/devicetree/bindings/arm/cpus.txt
> @@ -196,6 +196,7 @@ nodes to be present and contain the properties described below.
>  			    "qcom,gcc-msm8660"
>  			    "qcom,kpss-acc-v1"
>  			    "qcom,kpss-acc-v2"
> +			    "renesas,rcar-idle"

The enable-method is about how to bring the CPU up (and potentially
implies other things, like how to take it down again).

These is no code in this series to that effect, no semantics are
provided, and the name implies this is idle-specific.

So this doesn't look right, and makes no sense to me.

Mark.
