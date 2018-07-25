From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v5 3/3] arm64: dts: qcom: pm8998: Add pm8998 thermal zone
Date: Wed, 25 Jul 2018 16:21:28 -0700
Message-ID: <CAD=FV=UATTxDxjtL7keOV9RDcPaT00+D8VXMFFaUixeKopJnmg@mail.gmail.com>
References: <20180724234636.57137-1-mka@chromium.org> <20180724234636.57137-3-mka@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180724234636.57137-3-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, David Collins <collinsd@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Tue, Jul 24, 2018 at 4:46 PM, Matthias Kaehlcke <mka@chromium.org> wrote=
:
> The thermal zone uses spmi-temp-alarm as sensor, the trip points
> correspond to the PMIC thermal stages 1 and 2. The critical trip
> point at 125=C2=B0C disables the partial PMIC shutdown at stage 2.
>
> Without an IIO input the sensor only reports a limited number of
> temperatures:
>
> - 37=C2=B0C for temperatures below 105=C2=B0C
> - 107=C2=B0C for temperatures >=3D 105=C2=B0C and < 125=C2=B0C
> - 127=C2=B0C for temperatures >=3D 125=C2=B0C
>
> (the numbers correspond to a stage 1 threshold of 105=C2=B0C)
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v5:
> - removed 'stage2-shutdown-disabled' property from spmi-temp-alarm
> - updated commit message
>
> Changes in v4:
> - updated trip point temperatures to match stage 1 and 2 ones
> - disabled stage 2 shutdown
> - updated commit message
>
> Changes in v3:
> - moved 'thermal-zones' node to the beginning of the .dtsi
>
> Changes in v2:
> - defined 'thermal-zones' node in pm8998.dtsi instead of using a label
>   to refer to it
> - use 105=C2=B0C hardware trip point as critical trip point
> - reduced number of trip points to 2
> - lowered temperature of passive trip point
> - updated trip point names and added labels
> - updated commit message
> ---
>  arch/arm64/boot/dts/qcom/pm8998.dtsi | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)

Looks great!

Reviewed-by: Douglas Anderson <dianders@chromium.org>
