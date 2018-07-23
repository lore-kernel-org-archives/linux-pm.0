From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v4 1/3] thermal: qcom-spmi: Allow to disable stage 2
 shutdown
Date: Mon, 23 Jul 2018 08:49:53 -0700
Message-ID: <20180723154953.GJ129942@google.com>
References: <20180717210815.245639-1-mka@chromium.org>
 <CAD=FV=V1=P-Vq-VFXDfZGPMTVFvZK5cwaK_-Kxf8MwATJNwQSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAD=FV=V1=P-Vq-VFXDfZGPMTVFvZK5cwaK_-Kxf8MwATJNwQSg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, David Collins <collinsd@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Jul 20, 2018 at 11:42:40AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Tue, Jul 17, 2018 at 2:08 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> > When the temperature reaches stage 2 the PMIC performs by default a
> > 'partial shutdown', unless software override is enabled. It is not well
> > defined which peripherals are affected by a 'partial shutdown'. Drivers
> > might be unhappy when their devices suddenly disappear and prevent an
> > orderly shutdown.
> >
> > Add an optional device tree property that allows to disable stage 2
> > shutdown.
> >
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > Changes in v4:
> > - patch added to the series
> > ---
> >  .../bindings/thermal/qcom-spmi-temp-alarm.txt |  3 ++
> >  drivers/thermal/qcom-spmi-temp-alarm.c        | 28 +++++++++++++------
> >  2 files changed, 23 insertions(+), 8 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt b/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
> > index 290ec06fa33a..377c94fa1821 100644
> > --- a/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
> > +++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
> > @@ -15,6 +15,8 @@ Optional properties:
> >  - io-channels:     Should contain IIO channel specifier for the ADC channel,
> >                     which report chip die temperature.
> >  - io-channel-names: Should contain "thermal".
> > +- stage2-shutdown-disabled: boolean to disable a partial shutdown of the PMIC
> > +                            when the temperature reaches stage 2
> 
> With my understanding of device tree I believe that this should be
> "qcom,stage2-shutdown-disabled".  If something isn't a generic
> property affecting a whole group of bindings I believe it's supposed
> to have a company prefix.
> 
> From the device tree specification (wow, this exists now?  ...and is public?)
> 
> https://github.com/devicetree-org/devicetree-specification/releases/tag/v0.2
> 
> I find:
> 
> > Nonstandard property names should specify a unique string prefix, such
> > as a stock ticker symbol, identifying the name of the company or
> > organization that defined the property. Examples:
>   fsl,channel-fifo-len
>   ibm,ppc-interrupt-server#s
>   linux,network-index

Ok, I'll update the property name in case we keep using one.

> =====
> 
> I would also perhaps add a bit more verbose justification to your
> description of this property.  Specifically there should be some
> indication in the bindings doc of when you'd want this property.  From
> what David Collins said, I'd maybe write something like:
> 
> ---
> 
> You want to disable the partial "stage 2" shutdown any time you've
> properly defined thermal zones in such a way that the OS will try to
> shut down at that stage anyway.  Said another way, there are three
> thermal stages defined in the PMIC:
> 
> stage 1: warning
> stage 2: system should shut down
> stage 3: emergency shut down
> 
> By default the PMIC assumes that the OS isn't doing anything and thus
> at stage 2 it does the partial PMIC shutdown and at stage 3 it kills
> all power.  If we have thermal zones defined such that the OS will
> initiate the shutdown at stage 2 then we want to disable the PMIC's
> automatic mode for stage 2.  That still leaves us with the emergency
> at stage 3.

Thanks, I'll add something along these lines (or bluntly copy them ;-)

> ===
> 
> Actually, after writing all the above I wonder if perhaps there's a
> way to do this all automatically.  AKA: if someone has specified a
> "critical" level can we automatically disable the partial PMIC
> shutdown and we don't need the extra property?  Bonus points if we can
> check to see if the thermal zones defined actually match reality and
> even more bonus points if you can automatically adjust the settings in
> the PMIC based on the thermal zones...
> 
> I did find that in "struct thermal_zone_of_device_ops" there appears
> to be a "set_trip_temp" function you can fill in.  When I tried that
> quickly I saw that I got called when I echoed into
> "/sys/class/thermal/thermal_zone0/trip_point_1_temp" but not at
> bootup, but I didn't debug more than that...
> 
> 
> >  Example:
> >
> > @@ -23,6 +25,7 @@ Example:
> >                 reg = <0x2400 0x100>;
> >                 interrupts = <0 0x24 0 IRQ_TYPE_EDGE_RISING>;
> >                 #thermal-sensor-cells = <0>;
> > +               stage2-shutdown-disabled;
> >
> >                 io-channels = <&pm8941_vadc VADC_DIE_TEMP>;
> >                 io-channel-names = "thermal";
> 
> BTW: can you update the "example" in this file?  Based on the PMIC
> docs I saw it's likely that it should be:
> 
> stage1 {
>   temperature = <1050000>;
>   hysteresis = <2000>;
>   type = "passive";
> };
> stage2 {
>   temperature = <125000>;
>   hysteresis = <2000>;
>   type = "critical";
> };
> 
> ...and I guess we don't specify the final one because by that time
> Linux is kaput.
> 
> 
> > diff --git a/drivers/thermal/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom-spmi-temp-alarm.c
> > index ad4f3a8d6560..acbb0dbec79e 100644
> > --- a/drivers/thermal/qcom-spmi-temp-alarm.c
> > +++ b/drivers/thermal/qcom-spmi-temp-alarm.c
> 
> Sometimes people like bindings and code change to be separate patches.
> Maintainer can specify what's desired in this case, but I find it
> generally pleases more people to make them separate.
> 
> ...though I guess if we can figure out how to do this automatically we
> will have no bindings change...

Thanks for the suggestions, I'll look into them for the next version!
