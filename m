From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/3] dt-bindings: power: supply: qcom_bms: Add bindings
Date: Thu, 26 Apr 2018 13:39:50 +0200
Message-ID: <CACRpkdZ4VO_9eNvJdznoqd0cdV2qCbnFjjhQOtZKgpxFES1-VQ@mail.gmail.com>
References: <20180407134712.23131-1-ctatlor97@gmail.com> <20180407134712.23131-2-ctatlor97@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180407134712.23131-2-ctatlor97@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Craig Tatlor <ctatlor97@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, Linux PM list <linux-pm@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Apr 7, 2018 at 3:46 PM, Craig Tatlor <ctatlor97@gmail.com> wrote:

This is very interesting bindings!

> Add bindings for the Qualcomm battery measurement system.
>
> Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>

Please expand on acronyms as requested by Rob.

> +Required properties:
> +- compatible:               Should contain "qcom,pm8941-bms".
> +- reg:                      Specifies the SPMI address and length of the
> +                           controller's registers.
> +- interrupts:               OCV threshold interrupt.
> +- io-channels:              Should contain IIO channel specifier for the
> +                           ADC channel that reports battery temperature.
> +- io-channel-names:         Should contain "temp".

These are fine (and good) as bindings go.

> +- qcom,fcc-temp-legend:     An array containing the temperature, in degC,
> +                           for each column of the FCC lookup table.
> +- qcom,fcc-lut:             An array of FCC values in mah, one entry for each
> +                           temperature defined in in qcom,fcc-temp-legend.
> +- qcom,ocv-temp-legend:     An array containing the temperature, in degC,
> +                           for each column of the OCV lookup table.
> +- qcom,ocv-capacity-legend: An array containing the capacity for each
> +                           row of the OCV lookup table.
> +- qcom,ocv-lut:             An array of OCV values in mV, one entry for each
> +                           capacity defined in qcom,ocv-capacity-legend.

I wonder if these are really Qualcomm-specific.

Can't we just cut the "qcom,*" prefix from all and simply define
these lookup tables in a way (with units) that makes sense to all
kinds of battery capacities?

Maybe spell them out though and avoid the abbreviations.

Just put those in the already existing
Documentation/devicetree/bindings/power/supply/battery.txt
so others can reuse them from there.

You will see that those bindings does not abbreviate but
spells out the natural sciences definitions to it's a bliss to
read for everyone.

Yours,
Linus Walleij
