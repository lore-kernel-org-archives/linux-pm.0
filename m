From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v5 1/3] thermal: qcom-spmi: Use PMIC thermal stage 2 for
 critical trip points
Date: Fri, 27 Jul 2018 15:40:52 -0700
Message-ID: <20180727224050.GC4450@localhost.localdomain>
References: <20180724234636.57137-1-mka@chromium.org>
 <CAD=FV=VODGOE=qvJVeLGBs8xXQvbHZu7S9rqSpMY4AetUjd3fQ@mail.gmail.com>
 <20180726011228.GV129942@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180726011228.GV129942@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Doug Anderson <dianders@chromium.org>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Zhang Rui <rui.zhang@intel.com>, "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, David Collins <collinsd@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jul 25, 2018 at 06:12:28PM -0700, Matthias Kaehlcke wrote:
> Hi Doug,
> 
> On Wed, Jul 25, 2018 at 04:19:56PM -0700, Doug Anderson wrote:
> 
> > On Tue, Jul 24, 2018 at 4:46 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> > > +static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
> > > +                                            int temp)
> > > +{
> > > +       u8 reg;
> > > +       bool disable_s2_shutdown = false;
> > > +       int ret;
> > > +
> > > +       WARN_ON(!mutex_is_locked(&chip->lock));
> > > +
> > > +       /*
> > > +        * Default: S2 and S3 shutdown enabled, thresholds at
> > > +        * 105C/125C/145C, monitoring at 25Hz
> > > +        */
> > > +       reg = SHUTDOWN_CTRL1_RATE_25HZ;
> > > +
> > > +       if ((temp == THERMAL_TEMP_INVALID) ||
> > > +           (temp < STAGE2_THRESHOLD_MIN)) {
> > > +               chip->thresh = THRESH_MIN;
> > > +               goto skip;
> > > +       }
> > > +
> > > +       if (temp <= STAGE2_THRESHOLD_MAX) {
> > > +               chip->thresh = THRESH_MAX -
> > > +                       ((STAGE2_THRESHOLD_MAX - temp) /
> > > +                        TEMP_THRESH_STEP);
> > > +               disable_s2_shutdown = true;
> > > +       } else {
> > > +               chip->thresh = THRESH_MAX;
> > > +
> > > +               if (!IS_ERR(chip->adc))
> > > +                       disable_s2_shutdown = true;
> > > +               else
> > > +                       dev_warn(chip->dev,
> > > +                                "No ADC is configured and critical temperature is above the maximum stage 2 threshold of 140°C! Configuring stage 2 shutdown at 140°C.\n");
> > 
> > Putting a non-ASCII character (the degree symbol) in your commit
> > message is one thing, but are you sure it's wise to put it in the
> > kernel logs?
> 
> A few other drivers also do this
> (drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c,
> drivers/macintosh/windfarm_pm121.c), however that doesn't mean it's a
> good idea. Will change to degC or C.
> 
> > > +       }
> > > +
> > > +skip:
> > > +       reg |= chip->thresh;
> > > +       if (disable_s2_shutdown)
> > > +               reg |= SHUTDOWN_CTRL1_OVERRIDE_S2;
> > > +
> > > +       ret = qpnp_tm_write(chip, QPNP_TM_REG_SHUTDOWN_CTRL1, reg);
> > > +       if (ret < 0)
> > > +               return ret;
> > > +
> > > +       return ret;
> > 
> > Simplify the above lines to:
> > 
> > return qpnp_tm_write(chip, QPNP_TM_REG_SHUTDOWN_CTRL1, reg);
> 
> Ouch, my code is indeed dumb ...
> 
> > > @@ -313,12 +441,7 @@ static int qpnp_tm_probe(struct platform_device *pdev)
> > >         if (ret < 0)
> > >                 return ret;
> > >
> > > -       chip->tz_dev = devm_thermal_zone_of_sensor_register(&pdev->dev, 0, chip,
> > > -                                                       &qpnp_tm_sensor_ops);
> > > -       if (IS_ERR(chip->tz_dev)) {
> > > -               dev_err(&pdev->dev, "failed to register sensor\n");
> > > -               return PTR_ERR(chip->tz_dev);
> > > -       }
> > > +       chip->initialized = true;
> > 
> > Should we add "thermal_zone_device_update(chip->tz_dev,
> > THERMAL_EVENT_UNSPECIFIED);" here
> 
> Seems reasonable, will do.
> 
> > ...also: do we care about any type of locking for chip->initialized?
> > Technically we can be running on weakly ordered memory so if
> > qpnp_tm_update_temp_no_adc() is running on a different processor then
> > possibly it could still keep returning the default temperature for a
> > little while.  We could try to analyze whether there's some sort of
> > implicit barrier or we could add manual memory barriers, but generally
> > I try to avoid that and just do the simple locking...  What about just
> > setting chip-Initialized = true at the end of qpnp_tm_init() while the
> > mutex is still held?
> 
> Thanks for pointing that out. I agree that we should keep things
> simple, chip->initialized to true at the end of qpnp_tm_init() sounds
> good to me.
> 
> > I'd also love to hear from someone with more thermal framework
> > experience to make sure it's legit to return a default value if
> > someone calls us while we're initting.  It seems sane to me but nice
> > to confirm it's OK.
> 
> An alternative could be to return THERMAL_TEMP_INVALID, however I
> don't see this handled outside of thermal_core.c, not sure if it could
> throw some other code off.
> 
> Comments from thermal folks on either approach (or alternatives) are
> definitely welcome :)
> 
> > Overall I like the idea of this patch so hopefully others do too.
> > Thanks for sending it out!
> 

minor ask for next version


WARNING: line over 80 characters
#159: FILE: drivers/thermal/qcom-spmi-temp-alarm.c:65:
+#define STAGE2_THRESHOLD_MIN		125000	/* Stage 2 Threshold
Min: 125 C */

WARNING: line over 80 characters
#160: FILE: drivers/thermal/qcom-spmi-temp-alarm.c:66:
+#define STAGE2_THRESHOLD_MAX		140000	/* Stage 2 Threshold
Max: 140 C */

ERROR: trailing statements should be on next line
#201: FILE: drivers/thermal/qcom-spmi-temp-alarm.c:186:
+	if (!chip->adc)) {

CHECK: Unnecessary parentheses around 'temp == THERMAL_TEMP_INVALID'
#227: FILE: drivers/thermal/qcom-spmi-temp-alarm.c:220:
+	if ((temp == THERMAL_TEMP_INVALID) ||
+	    (temp < STAGE2_THRESHOLD_MIN)) {

CHECK: Unnecessary parentheses around 'temp < STAGE2_THRESHOLD_MIN'
#227: FILE: drivers/thermal/qcom-spmi-temp-alarm.c:220:
+	if ((temp == THERMAL_TEMP_INVALID) ||
+	    (temp < STAGE2_THRESHOLD_MIN)) {

CHECK: Unnecessary parentheses around 'trips[i].type ==
THERMAL_TRIP_CRITICAL'
#305: FILE: drivers/thermal/qcom-spmi-temp-alarm.c:302:
+		if (of_thermal_is_trip_valid(chip->tz_dev, i) &&
+		    (trips[i].type == THERMAL_TRIP_CRITICAL))

CHECK: Alignment should match open parenthesis
#386: FILE: drivers/thermal/qcom-spmi-temp-alarm.c:427:
+	chip->tz_dev = devm_thermal_zone_of_sensor_register(&pdev->dev,
0, chip,
+
&qpnp_tm_sensor_ops);

> Thanks for the review!
> 
> Matthias
