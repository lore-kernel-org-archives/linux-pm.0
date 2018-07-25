From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v5 1/3] thermal: qcom-spmi: Use PMIC thermal stage 2 for
 critical trip points
Date: Wed, 25 Jul 2018 16:19:56 -0700
Message-ID: <CAD=FV=VODGOE=qvJVeLGBs8xXQvbHZu7S9rqSpMY4AetUjd3fQ@mail.gmail.com>
References: <20180724234636.57137-1-mka@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180724234636.57137-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, David Collins <collinsd@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Tue, Jul 24, 2018 at 4:46 PM, Matthias Kaehlcke <mka@chromium.org> wrote=
:
> +static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
> +                                            int temp)
> +{
> +       u8 reg;
> +       bool disable_s2_shutdown =3D false;
> +       int ret;
> +
> +       WARN_ON(!mutex_is_locked(&chip->lock));
> +
> +       /*
> +        * Default: S2 and S3 shutdown enabled, thresholds at
> +        * 105C/125C/145C, monitoring at 25Hz
> +        */
> +       reg =3D SHUTDOWN_CTRL1_RATE_25HZ;
> +
> +       if ((temp =3D=3D THERMAL_TEMP_INVALID) ||
> +           (temp < STAGE2_THRESHOLD_MIN)) {
> +               chip->thresh =3D THRESH_MIN;
> +               goto skip;
> +       }
> +
> +       if (temp <=3D STAGE2_THRESHOLD_MAX) {
> +               chip->thresh =3D THRESH_MAX -
> +                       ((STAGE2_THRESHOLD_MAX - temp) /
> +                        TEMP_THRESH_STEP);
> +               disable_s2_shutdown =3D true;
> +       } else {
> +               chip->thresh =3D THRESH_MAX;
> +
> +               if (!IS_ERR(chip->adc))
> +                       disable_s2_shutdown =3D true;
> +               else
> +                       dev_warn(chip->dev,
> +                                "No ADC is configured and critical tempe=
rature is above the maximum stage 2 threshold of 140=C2=B0C! Configuring st=
age 2 shutdown at 140=C2=B0C.\n");

Putting a non-ASCII character (the degree symbol) in your commit
message is one thing, but are you sure it's wise to put it in the
kernel logs?


> +       }
> +
> +skip:
> +       reg |=3D chip->thresh;
> +       if (disable_s2_shutdown)
> +               reg |=3D SHUTDOWN_CTRL1_OVERRIDE_S2;
> +
> +       ret =3D qpnp_tm_write(chip, QPNP_TM_REG_SHUTDOWN_CTRL1, reg);
> +       if (ret < 0)
> +               return ret;
> +
> +       return ret;

Simplify the above lines to:

return qpnp_tm_write(chip, QPNP_TM_REG_SHUTDOWN_CTRL1, reg);


> @@ -313,12 +441,7 @@ static int qpnp_tm_probe(struct platform_device *pde=
v)
>         if (ret < 0)
>                 return ret;
>
> -       chip->tz_dev =3D devm_thermal_zone_of_sensor_register(&pdev->dev,=
 0, chip,
> -                                                       &qpnp_tm_sensor_o=
ps);
> -       if (IS_ERR(chip->tz_dev)) {
> -               dev_err(&pdev->dev, "failed to register sensor\n");
> -               return PTR_ERR(chip->tz_dev);
> -       }
> +       chip->initialized =3D true;

Should we add "thermal_zone_device_update(chip->tz_dev,
THERMAL_EVENT_UNSPECIFIED);" here

...also: do we care about any type of locking for chip->initialized?
Technically we can be running on weakly ordered memory so if
qpnp_tm_update_temp_no_adc() is running on a different processor then
possibly it could still keep returning the default temperature for a
little while.  We could try to analyze whether there's some sort of
implicit barrier or we could add manual memory barriers, but generally
I try to avoid that and just do the simple locking...  What about just
setting chip-Initialized =3D true at the end of qpnp_tm_init() while the
mutex is still held?


I'd also love to hear from someone with more thermal framework
experience to make sure it's legit to return a default value if
someone calls us while we're initting.  It seems sane to me but nice
to confirm it's OK.


Overall I like the idea of this patch so hopefully others do too.
Thanks for sending it out!


-Doug
