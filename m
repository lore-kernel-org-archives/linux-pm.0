From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 1/6] dt-bindings: power: supply: add
 AXP20X/AXP22X battery DT binding
Date: Thu, 20 Apr 2017 10:58:20 -0500
Message-ID: <20170420155820.tzvvwqnl2ze63jel@rob-hp-laptop>
References: <20170418073421.31351-1-quentin.schulz@free-electrons.com>
 <20170418073421.31351-2-quentin.schulz@free-electrons.com>
Reply-To: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDJIP47K7MERBHNV4PDQKGQENTVUYEQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20170418073421.31351-2-quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, icenowy-ymACFijhrKM@public.gmane.org, liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 18, 2017 at 09:34:16AM +0200, Quentin Schulz wrote:
> The X-Powers AXP20X and AXP22X PMICs can have a battery as power supply.
> 
> This patch adds the DT binding documentation for the battery power
> supply which gets various data from the PMIC, such as the battery status
> (charging, discharging, full, dead), current max limit, current current,
> battery capacity (in percentage), voltage max and min limits, current
> voltage and battery capacity (in Ah).
> 
> Signed-off-by: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> Acked-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
> Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> ---
> v6:
>   - removed mention to monitored-battery, will be sent when the battery
>   framework has been merged,
> 
> v5:
>   - removed DT property example from monitored-battery,
> 
> v4:
>  - added monitored-battery optional property,
>  - added example with battery,
> 
> v3:
>  - removed constant charge current property, now should use the WIP
>  battery framework,
> 
> v2:
>  - changed DT node name from ac_power_supply to ac-power-supply,
>  - removed io-channels and io-channel-names from DT (the IIO mapping is
>  done in the IIO ADC driver now),
>  - added x-powers,constant-charge-current property to set the maximal
>  default constant current charge of the battery,
> 
>  .../bindings/power/supply/axp20x_battery.txt         | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/axp20x_battery.txt

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
