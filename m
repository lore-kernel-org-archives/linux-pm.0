From: Matt Ranostay <matt@ranostay.consulting>
Subject: Re: [PATCH] power: supply: bq24910_charger: reset first_time check
Date: Mon, 26 Sep 2016 20:14:21 -0700
Message-ID: <CAJ_EiSST=n=-7WMO9+AHHf0BG5hp7geBbiP7HLpLqYN=NW5E1Q@mail.gmail.com>
References: <1474601549-23719-1-git-send-email-matt@ranostay.consulting>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33927 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933605AbcI0DOX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Sep 2016 23:14:23 -0400
Received: by mail-lf0-f66.google.com with SMTP id b71so194344lfg.1
        for <linux-pm@vger.kernel.org>; Mon, 26 Sep 2016 20:14:22 -0700 (PDT)
In-Reply-To: <1474601549-23719-1-git-send-email-matt@ranostay.consulting>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Matt Ranostay <mranostay@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>

Hold off on this one. Currently reworking a patch series that won't
need this change after all.

On Thu, Sep 22, 2016 at 8:32 PM, Matt Ranostay <mranostay@gmail.com> wrote:
> bq24190_register_reset() function needs to reset the bdi->first_time
> condition every time to avoid spurious interrupts in suspend/resume.
>
> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
> ---
>  drivers/power/supply/bq24190_charger.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
> index f5746b9f4e83..cc1dbdb1737f 100644
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -513,6 +513,8 @@ static int bq24190_register_reset(struct bq24190_dev_info *bdi)
>         int ret, limit = 100;
>         u8 v;
>
> +       bdi->first_time = true;
> +
>         /* Reset the registers */
>         ret = bq24190_write_mask(bdi, BQ24190_REG_POC,
>                         BQ24190_REG_POC_RESET_MASK,
> @@ -1375,7 +1377,6 @@ static int bq24190_probe(struct i2c_client *client,
>         bdi->model = id->driver_data;
>         strncpy(bdi->model_name, id->name, I2C_NAME_SIZE);
>         mutex_init(&bdi->f_reg_lock);
> -       bdi->first_time = true;
>         bdi->charger_health_valid = false;
>         bdi->battery_health_valid = false;
>         bdi->battery_status_valid = false;
> --
> 2.7.4
>
