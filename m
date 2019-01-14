From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [PATCH v2 0/9] Thermal throttling for SDM845
Date: Mon, 14 Jan 2019 22:22:54 +0530
Message-ID: <CAHLCerOH05ouDKuhe9Cz-qh-tJcqumHbrv7NqSc3STcH_UN-HA@mail.gmail.com>
References: <cover.1547458732.git.amit.kucheria@linaro.org>
 <CAJZ5v0h+m6sR=nFFXSMv_FKy=y0W4mSd3W34qW48-BpnGBPcZQ@mail.gmail.com> <CAHLCerM+bbXbUzoqm_5oPw_o-zEFCN4FjXRGVVqYkGYzC5upDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHLCerM+bbXbUzoqm_5oPw_o-zEFCN4FjXRGVVqYkGYzC5upDA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Eduardo Valentin <edubezval@gmail.com>, Andy Gross <andy.gross@linaro.org>, Taniya Das <tdas@codeaurora.org>, Stephen Boyd <swboyd@chromium.org>, Doug Anderson <dianders@chromium.org>, Matthias Kaehlcke <mka@chromium.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, David Brown <david.brown@linaro.org>, Javi Merino <javi.merino@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Zhang Rui <rui.zhang@intel.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree>
List-Id: linux-pm@vger.kernel.org

On Mon, Jan 14, 2019 at 4:04 PM Amit Kucheria <amit.kucheria@linaro.org> wrote:
>
> On Mon, Jan 14, 2019 at 3:57 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Mon, Jan 14, 2019 at 11:22 AM Amit Kucheria <amit.kucheria@linaro.org> wrote:
> > >
> > > Add support for thermal throttling on SDM845.
> > >
> > > We introduce a generic flag to be used by cpufreq drivers to tell the
> > > cpufreq core to auto-register a thermal cooling device.
> > >
> > > There are a few miscellaneous fixes to keep checkpatch happy.
> > >
> > > If this approach is acceptable I can send a series converting other cpufreq
> > > drivers to use this flag and get rid of driver code.
> > >
> > > Amit Kucheria (9):
> > >   [ALREADY QUEUED] cpufreq: qcom-hw: Move to device_initcall
> > >   drivers: thermal: of-thermal: Print name of device node with error
> > >   drivers: cpufreq: Add thermal_cooling_device pointer to struct
> > >     cpufreq_policy
> > >   cpufreq: Add a flag to auto-register a cooling device
> > >   cpufreq: Replace open-coded << with BIT()
> > >   cpufreq: qcom-hw: Register as a cpufreq cooling device
> > >   arm64: dts: sdm845: Increase alert trip point to 95 degrees
> > >   arm64: dts: sdm845: wireup the thermal trip points to cpufreq
> > >   thermal: cpu_cooling: Clarify error message
> > >
> > >  arch/arm64/boot/dts/qcom/sdm845.dtsi | 193 +++++++++++++++++++++++----
> > >  drivers/cpufreq/cpufreq.c            |  13 ++
> > >  drivers/cpufreq/qcom-cpufreq-hw.c    |   5 +-
> > >  drivers/thermal/cpu_cooling.c        |   2 +-
> > >  drivers/thermal/of-thermal.c         |   4 +-
> > >  include/linux/cpufreq.h              |  34 +++--
> > >  6 files changed, 210 insertions(+), 41 deletions(-)
> >
> > Would it be possible to split this series so as to put the cpufreq
> > patches separately?
>
> Sure, will send out another version.

I've now sent out a separate series just tackling the
auto-registration feature of a cooling device[1]. So the only bits in
this series needing separate review are patches 2, 7,8 and 9.

I'll wait couple of days to get some review on the other series before
sending out another version of the remaining patches listed above.
Feel free to comment on them in this thread, in the meanwhile.

Thanks.

[1] https://lore.kernel.org/patchwork/cover/1031909/
