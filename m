From: John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] power: reset: Add qcom reboot mode driver
Date: Thu, 13 Oct 2016 20:25:11 -0700
Message-ID: <CALAqxLXL+AHwchp8Ja2NAXt-=0xd87ojA4AGzT-n0oQFbwcCzw@mail.gmail.com>
References: <1476410823-8912-1-git-send-email-xiaogang@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1476410823-8912-1-git-send-email-xiaogang-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Xiaogang Cui <xiaogang-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Andy Gross <andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Andy Yan <andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Chris Brand <chris.brand-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>, Moritz Fischer <moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>open list <li>
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 13, 2016 at 7:02 PM, Xiaogang Cui <xiaogang-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
> This is a initial version so it's very similar with syscon
> reboot mode driver. We will add more functionalities in the
> further after dependency is ready.
>
> Signed-off-by: Xiaogang Cui <xiaogang-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> ---
>  .../bindings/power_supply/qcom-reboot-mode.txt     |  23 +++++
>  drivers/power/reset/Kconfig                        |  10 ++
>  drivers/power/reset/Makefile                       |   1 +
>  drivers/power/reset/qcom-reboot-mode.c             | 109 +++++++++++++++++++++
>  4 files changed, 143 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power_supply/qcom-reboot-mode.txt
>  create mode 100644 drivers/power/reset/qcom-reboot-mode.c
>
> diff --git a/Documentation/devicetree/bindings/power_supply/qcom-reboot-mode.txt b/Documentation/devicetree/bindings/power_supply/qcom-reboot-mode.txt
> new file mode 100644
> index 0000000..8b33592
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power_supply/qcom-reboot-mode.txt
> @@ -0,0 +1,23 @@
> +Qualcomm Reboot Mode Driver
> +
> +Qualcomm reboot mode driver based on reboot mode framework to update
> +SPMI specific bits.
> +
> +Required Properties:
> +-compatible: "qcom,reboot-mode"
> +-offset: offset of the SPMI reboot mode register
> +
> +Optional Properties:
> +-mask: mask of reboot mode
> +-mode-xxx: magic of reboot mode
> +
> +Example:
> +       qcom,reboot-mode@88f {
> +               compatible = "qcom,reboot-mode";
> +               offset = <0x88f>;
> +               mode-normal = <0x00>;
> +               mode-recovery = <0x04>;
> +               mode-bootloader = <0x08>;
> +               mode-rtc = <0x0C>;

So I don't think we've had a "rtc" mode before. This needs to be very
clearly documented (or maybe just skipped) so we don't start fraying
with all the various vendor specific modes.

thanks
-john
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
