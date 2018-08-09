From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v6 3/5] thermal: qcom-spmi: Use PMIC thermal stage 2 for
 critical trip points
Date: Thu, 9 Aug 2018 14:28:12 -0700
Message-ID: <CAD=FV=Us-Cp6AEUfbNbAuRwri4y1opiGY6O+HHModserppYdxQ@mail.gmail.com>
References: <20180731185917.176074-1-mka@chromium.org> <20180731185917.176074-3-mka@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180731185917.176074-3-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, David Collins <collinsd@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Tue, Jul 31, 2018 at 11:59 AM, Matthias Kaehlcke <mka@chromium.org> wrot=
e:
> There are three thermal stages defined in the PMIC:
>
> stage 1: warning
> stage 2: system should shut down
> stage 3: emergency shut down
>
> By default the PMIC assumes that the OS isn't doing anything and thus
> at stage 2 it does a partial PMIC shutdown and at stage 3 it kills
> all power. When switching between thermal stages the PMIC generates an
> interrupt which is handled by the driver. The partial PMIC shutdown at
> stage 2 can be disabled by software, which allows the OS to initiate a
> shutdown at stage 2 with a thermal zone configured accordingly.
>
> If a critical trip point is configured in the thermal zone the driver
> adjusts the stage 1-3 temperature thresholds to (closely) match the
> critical temperature with a stage 2 threshold (125/130/135/140 =C2=B0C).
> If a suitable match is found the partial shutdown at stage 2 is
> disabled. If for some reason the system doesn't shutdown at stage 2
> the emergency shutdown at stage 3 kicks in.
>
> The partial shutdown at stage 2 remains enabled in these cases:
> - no critical trip point defined
> - the temperature of the critical trip point is < 125=C2=B0C
> - the temperature of the critical trip point is > 140=C2=B0C and no
>   ADC channel is configured (thus the OS is not notified when the critica=
l
>   temperature is reached)
>
> Suggested-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v6:
> - fixed condition to check if ADC is configured in
>   qpnp_tm_update_critical_trip_temp()
> - changed =C2=B0C in logs to C
> - removed needless evaluation of qpnp_tm_write() return value in
>   qpnp_tm_update_critical_trip_temp()
> - move assignment of chip->initialized to true to qpnp_tm_init(),
>   where the lock is held
> - call thermal_zone_device_update() after initialization is
>   completed
> - split some #define + comment in two lines to avoid exceeding
>   chars per line limit
> - removed extra closing parenthesis in qpnp_tm_get_temp()
> - remove unnecessary parentheses around conditions in
>   qpnp_tm_update_critical_trip_temp() and qpnp_tm_get_critical_trip_temp(=
)
> - fixed indentation of call devm_thermal_zone_of_sensor_register() call
>   in qpnp_tm_probe()
>
> Changes in v5:
> - patch added to the series
> ---
>  drivers/thermal/qcom-spmi-temp-alarm.c | 158 ++++++++++++++++++++++---
>  1 file changed, 140 insertions(+), 18 deletions(-)

I won't claim to have spent too much time in the thermal framework,
but from what I can tell everything looks supergreat now.  FWIW:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

One minor comment I'd have is that I personally would have ordered
this in the series before the patch ("dt-bindings: thermal:
qcom-spmi-temp-alarm: Improve thermal zone in example") just because
that patch only really makes sense after this one lands.  ...but I
don't think it's terribly important.


-Doug
