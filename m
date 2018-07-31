From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 1/4] power: bq25890_charger.c: Add debugging output of
 failed initialization
Date: Tue, 31 Jul 2018 18:57:46 +0200
Message-ID: <CAJKOXPeaNpdPbhJuc5FcPKdCq_FPr70_PCSuNMmZ5wJAhBXvmQ@mail.gmail.com>
References: <CAJKOXPczJWdNugbHiLRQv1krUFhZH=muix3M9R2LUT5=4zypYA@mail.gmail.com>
 <20180731164316.32696-1-angus@akkea.ca> <20180731164316.32696-2-angus@akkea.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180731164316.32696-2-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc: angus.ainslie@puri.sm, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 31 July 2018 at 18:43, Angus Ainslie (Purism) <angus@akkea.ca> wrote:
> To ease adding a new part variant some debugging is handy.
>
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>

You missed my tag - I already reviewed it. Unless you change
something, the tag should be added to commit msg:
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Krzysztof

> ---
>  drivers/power/supply/bq25890_charger.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
> index 8e2c41ded171..7f0b3a46c50c 100644
> --- a/drivers/power/supply/bq25890_charger.c
> +++ b/drivers/power/supply/bq25890_charger.c
> @@ -608,30 +608,40 @@ static int bq25890_hw_init(struct bq25890_device *bq)
>         };
>
>         ret = bq25890_chip_reset(bq);
> -       if (ret < 0)
> +       if (ret < 0) {
> +               dev_dbg(bq->dev, "Reset failed %d\n", ret);
>                 return ret;
> +       };
>
>         /* disable watchdog */
>         ret = bq25890_field_write(bq, F_WD, 0);
> -       if (ret < 0)
> +       if (ret < 0) {
> +               dev_dbg(bq->dev, "Disabling watchdog failed %d\n", ret);
>                 return ret;
> +       };
>
>         /* initialize currents/voltages and other parameters */
>         for (i = 0; i < ARRAY_SIZE(init_data); i++) {
>                 ret = bq25890_field_write(bq, init_data[i].id,
>                                           init_data[i].value);
> -               if (ret < 0)
> +               if (ret < 0) {
> +                       dev_dbg(bq->dev, "Writing init data failed %d\n", ret);
>                         return ret;
> +               };
>         }
>
>         /* Configure ADC for continuous conversions. This does not enable it. */
>         ret = bq25890_field_write(bq, F_CONV_RATE, 1);
> -       if (ret < 0)
> +       if (ret < 0) {
> +               dev_dbg(bq->dev, "Config ADC failed %d\n", ret);
>                 return ret;
> +       };
>
>         ret = bq25890_get_chip_state(bq, &state);
> -       if (ret < 0)
> +       if (ret < 0) {
> +               dev_dbg(bq->dev, "Get state failed %d\n", ret);
>                 return ret;
> +       };
>
>         mutex_lock(&bq->lock);
>         bq->state = state;
> @@ -767,6 +777,9 @@ static int bq25890_fw_read_u32_props(struct bq25890_device *bq)
>                         if (props[i].optional)
>                                 continue;
>
> +                       dev_err(bq->dev, "Unable to read property %d %s\n", ret,
> +                               props[i].name);
> +
>                         return ret;
>                 }
>
> --
> 2.17.1
>
