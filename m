From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] power: reset: Add qcom reboot mode driver
Date: Tue, 18 Oct 2016 09:12:15 -0500
Message-ID: <20161018141215.5qop6ow3qque5d33@rob-hp-laptop>
References: <1476410823-8912-1-git-send-email-xiaogang@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1476410823-8912-1-git-send-email-xiaogang@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Xiaogang Cui <xiaogang@codeaurora.org>
Cc: andy.gross@linaro.org, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Krzysztof Kozlowski <krzk@kernel.org>, Andy Yan <andy.yan@rock-chips.com>, John Stultz <john.stultz@linaro.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Chris Brand <chris.brand@broadcom.com>, Richard Weinberger <richard@nod.at>, Moritz Fischer <moritz.fischer@ettus.com>, Florian Fainelli <f.fainelli@gmail.com>, "open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS" <linux-pm@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.k>
List-Id: linux-pm@vger.kernel.org

On Fri, Oct 14, 2016 at 10:02:27AM +0800, Xiaogang Cui wrote:
> This is a initial version so it's very similar with syscon
> reboot mode driver. We will add more functionalities in the
> further after dependency is ready.
> 
> Signed-off-by: Xiaogang Cui <xiaogang@codeaurora.org>
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
> +	qcom,reboot-mode@88f {

Node names should be generic. Just reboot-mode@...

> +		compatible = "qcom,reboot-mode";
> +		offset = <0x88f>;
> +		mode-normal = <0x00>;
> +		mode-recovery = <0x04>;
> +		mode-bootloader = <0x08>;
> +		mode-rtc = <0x0C>;

In addition to what John said, I think vendor specfic modes should 
have a vendor prefix (e.g. qcom,mode-rtc). That will complicate parsing 
a bit though.

Rob
