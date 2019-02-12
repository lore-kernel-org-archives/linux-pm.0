From: Moritz Fischer <moritz.fischer@ettus.com>
Subject: Re: [RFC 1/6] mfd: Support for Ettus Research E31x devices PMU
Date: Tue, 12 Feb 2019 02:51:51 -0800
Message-ID: <CAAtXAHd=-8H7AYpApe1B+WRWCv54GhxJBv1BD4bc-C9rnScU+w@mail.gmail.com>
References: <20190212010143.3729-1-virendra.kakade@ni.com> <20190212010143.3729-2-virendra.kakade@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190212010143.3729-2-virendra.kakade@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Virendra Kakade <virendra.kakade@ni.com>
Cc: Devicetree List <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Virendra,

On Mon, Feb 11, 2019 at 5:02 PM Virendra Kakade <virendra.kakade@ni.com> wrote:
>
> Document bindings for E31x device PMU MFD driver.
>
> Signed-off-by: Virendra Kakade <virendra.kakade@ni.com>
> ---
>  Documentation/devicetree/bindings/mfd/e31x-pmu.txt | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/e31x-pmu.txt
>
> diff --git a/Documentation/devicetree/bindings/mfd/e31x-pmu.txt b/Documentation/devicetree/bindings/mfd/e31x-pmu.txt
> new file mode 100644
> index 000000000000..ebb5625f6c74
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/e31x-pmu.txt
> @@ -0,0 +1,14 @@
> +Ettus Research/National Instruments E31x PMU MFD driver
> +
> +Required properties:
> +- compatible : Must be "ni,e31x-pmu"
> +- regmap     : Must be <&regmapnode>
> +
> +Example:
> +
> +pmu {
> +       compatible = "ni,e31x-pmu";
> +       regmap = <&devctrl>;
> +       status = "okay";

Please drop this.
>
> +};
> +
> --
> 2.17.1
>

Your binding patches should have "dt-bindings: ... " in the commit message.

Please fix that when you resubmit your series.

Cheers,
Moritz
