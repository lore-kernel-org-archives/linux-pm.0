From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 2/5] dt-bindings: thermal: qcom-spmi-temp-alarm:
 Improve thermal zone in example
Date: Tue, 31 Jul 2018 13:20:36 -0600
Message-ID: <20180731192036.GA3770@rob-hp-laptop>
References: <20180731185917.176074-1-mka@chromium.org>
 <20180731185917.176074-2-mka@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180731185917.176074-2-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, David Collins <collinsd@codeaurora.org>, Douglas Anderson <dianders@chromium.org>, Stephen Boyd <sboyd@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 31, 2018 at 11:59:14AM -0700, Matthias Kaehlcke wrote:
> The current example for a thermal zone isn't very useful as reference
> since it would result in a hardware shutdown at 145°C, instead of
> allowing the system to try to shutdown gracefully. Without an ADC
> channel a maximum of two trip points is useful in practice for this
> sensor, with temperatures corresponding to the stage 1 and stage 2
> 'hardware trip points'. A critical trip point at stage 2 may allow the
> system to shutdown before a hardware shutdown at stage 3 kicks in. It
> should be noted though that by default the chip performs a 'partial
> shutdown' when the temperature reaches stage 2, which may prevent an
> orderly shutdown. The 'partial shutdown' can be disabled by software.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
> Changes in v6:
> - patch added to the series
> ---
>  .../bindings/thermal/qcom-spmi-temp-alarm.txt         | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
