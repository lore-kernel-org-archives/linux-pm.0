From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [PATCH 5/7] thermal/drivers/core: Remove depends on THERMAL in Kconfig
Date: Tue, 23 Apr 2019 16:05:18 +0530
Message-ID: <CAHLCerMMQRY-zjjKbaLA=OXQPo-oS76yNYYhTOBmG05jSS8RtA@mail.gmail.com>
References: <20190402161256.11044-1-daniel.lezcano@linaro.org>
 <20190402161256.11044-5-daniel.lezcano@linaro.org> <CAHLCerNvp9Bb0TwCcO91ecrbzKGe7epCHFk=fx4RGJgHDE_BRA@mail.gmail.com>
 <9afb2911-512a-9048-9ed8-6aa9dd29a848@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9afb2911-512a-9048-9ed8-6aa9dd29a848@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Stephen Rothwell <sfr@canb.auug.org.au>, "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 3, 2019 at 9:03 AM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> Hi Amit,
>
> On 02/04/2019 20:51, Amit Kucheria wrote:
> > On Tue, Apr 2, 2019 at 11:14 PM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> The dependency on the THERMAL option to be set is already there implicitly
> >> by the "if THERMAL" conditionnal option. The sub Kconfigs do not have to
> >> check against the THERMAL option as they are called from a Kconfig block
> >> which is enabled by the conditionnal option.
> >>
> >> Remove the useless "depends on THERMAL" in the Kconfigs.
> >>
> >> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >> ---
> >>  drivers/thermal/Kconfig       | 2 --
> >>  drivers/thermal/intel/Kconfig | 1 -
> >>  drivers/thermal/qcom/Kconfig  | 1 -
> >>  3 files changed, 4 deletions(-)
> >>
> >> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> >> index ccf5b9408d7a..d8aa7fac8c56 100644
> >> --- a/drivers/thermal/Kconfig
> >> +++ b/drivers/thermal/Kconfig
> >> @@ -24,7 +24,6 @@ config THERMAL_STATISTICS
> >>
> >>  config THERMAL_EMERGENCY_POWEROFF_DELAY_MS
> >>         int "Emergency poweroff delay in milli-seconds"
> >> -       depends on THERMAL
> >>         default 0
> >>         help
> >>           Thermal subsystem will issue a graceful shutdown when
> >> @@ -152,7 +151,6 @@ config CPU_THERMAL
> >>         bool "generic cpu cooling support"
> >>         depends on CPU_FREQ
> >>         depends on THERMAL_OF
> >> -       depends on THERMAL=y
> >
> > This will break the intention of afa1f2ab43d48d0e1. At the moment, we
> > need THERMAL=y if we want cpu_cooling.
>
> The patch 1/7 changes the thermal option from tristate to bool, so the
> thermal is compiled-in always. The dependency is no longer needed in
> this case. Did I miss something?

Sorry, the threading of this series was a bit strange and there was no
cover letter. I wasn't cc'ed on the other patches, so missed the
earlier changes. This series looks good.

FWIW,

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
