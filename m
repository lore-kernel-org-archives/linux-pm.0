From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 2/2] dt: power: st: Provide bindings for ST's OPPs
Date: Tue, 28 Jul 2015 08:55:33 -0500
Message-ID: <CAL_JsqL=e+fL_67_GPKjt_7wJ81GfFx7m9gjxmBDvW_JBXWpfQ@mail.gmail.com>
References: <1438010430-5802-1-git-send-email-lee.jones@linaro.org> <1438010430-5802-2-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1438010430-5802-2-git-send-email-lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, ajitpal.singh-qxv4g6HH51o@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Mon, Jul 27, 2015 at 10:20 AM, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> These OPPs are used in ST's CPUFreq implementation.
>
> Signed-off-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>
> Changelog:
>  - None, new patch
>
>  Documentation/devicetree/bindings/power/opp-st.txt | 76 ++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/opp-st.txt
>
> diff --git a/Documentation/devicetree/bindings/power/opp-st.txt b/Documentation/devicetree/bindings/power/opp-st.txt
> new file mode 100644
> index 0000000..6eb2a91
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/opp-st.txt
> @@ -0,0 +1,76 @@
> +STMicroelectronics OPP (Operating Performance Points) Bindings
> +--------------------------------------------------------------
> +
> +Frequency Scaling only
> +----------------------
> +
> +Located in CPU's node:
> +
> +- operating-points     : [See: ./opp.txt]
> +
> +Example [safe]
> +--------------
> +
> +cpus {
> +       cpu@0 {
> +                                /* kHz     uV   */
> +               operating-points = <1500000 0
> +                                   1200000 0
> +                                   800000  0
> +                                   500000  0>;
> +       };
> +};
> +
> +Dynamic Voltage and Frequency Scaling (DVFS)
> +--------------------------------------------
> +
> +Located in 'cpu0-opp-list' node [to be provided ONLY by the bootloader]:
> +
> +- compatible           : Should be "operating-points-v2-sti"
> +- opp{1..N}            : Each 'oppX' subnode will contain the following properties:
> + - opp-hz              : CPU frequency [Hz] for this OPP [See: ./opp.txt]
> + - st,avs              : List of available voltages [uV] indexed by process code

Add a unit suffix (-microvolt).

> + - st,cuts             : Cut version this OPP is suitable for [0xFF means ALL]
> + - st,substrate                : Substrate version this OPP is suitable for [0xFF means ALL]

How about not present means all?

> +- st,syscfg            : Phandle to Major number register
> +                               First cell: offset to major number
> +- st,syscfg-eng                : Phandle to Minor number and Pcode registers
> +                               First cell: offset to process code
> +                               Second cell: offset to minor number

Would the proposed nvmem binding work for this?

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
