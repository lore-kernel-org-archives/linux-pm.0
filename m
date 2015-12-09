From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-binding: power: Add otg regulator binding
Date: Tue, 8 Dec 2015 22:11:53 -0600
Message-ID: <20151209041153.GA29549@rob-hp-laptop>
References: <1449621618-11900-1-git-send-email-tim.bird@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1449621618-11900-1-git-send-email-tim.bird@sonymobile.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tim Bird <tim.bird@sonymobile.com>
Cc: pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, agross@codeaurora.org, Bjorn.Andersson@sonymobile.com, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, tbird20d@gmail.com
List-Id: linux-pm@vger.kernel.org

On Tue, Dec 08, 2015 at 04:40:16PM -0800, Tim Bird wrote:
> Add a binding for the regulator which controls the OTG chargepath switch.
> The OTG switch gets its power from pm8941_5vs1, and that should be
> expressed as a usb-otg-in-supply property in the DT node for the
> charger driver.  The regulator name is "otg".
> 
> Signed-off-by: Tim Bird <tim.bird@sonymobile.com>
> ---
> Changes since v1
>  - switch supply name to have dashes instead of underscores
>  - remove superfluous DT explanations in the otg node description
> ---
>  .../devicetree/bindings/power_supply/qcom_smbb.txt    | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power_supply/qcom_smbb.txt b/Documentation/devicetree/bindings/power_supply/qcom_smbb.txt
> index 65b88fa..28b6da7 100644
> --- a/Documentation/devicetree/bindings/power_supply/qcom_smbb.txt
> +++ b/Documentation/devicetree/bindings/power_supply/qcom_smbb.txt
> @@ -105,6 +105,22 @@ PROPERTIES
>                 regulation must be done externally to fully comply with
>                 the JEITA safety guidelines if this flag is set.
>  
> +- usb-otg-in-supply:
> +  Usage: optional
> +  Value type: <phandle>
> +  Description: Reference to the regulator supplying power to the USB_OTG_IN
> +               pin.
> +
> +child nodes:
> +- otg:
> +  Usage: optional
> +  Description: This node defines a regulator used to control the direction
> +               of VBUS voltage - specifically: whether to supply voltage
> +               to VBUS for host mode operation of the OTG port, or allow
> +               input voltage from external VBUS for charging.  In the
> +               hardware, the supply for this regulator comes from
> +               usb-otg-in-supply.

Doesn't this regulator need to have a name defined?

Disabling this regulator (along with other setup) will enable charging?

Rob
