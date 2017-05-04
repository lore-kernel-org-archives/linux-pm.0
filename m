From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH] power: supply: bq27xxx: make bq27xxx_battery_settings static
Date: Wed, 3 May 2017 23:30:51 -0700
Message-ID: <CAKvHMgRGv_7VVgE+jio6L0uU86KRaL6sV2sSsTuRgwe9pF-OmQ@mail.gmail.com>
References: <20170503104554.23019-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:34426 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751691AbdEDGaw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 May 2017 02:30:52 -0400
Received: by mail-it0-f68.google.com with SMTP id c26so623412itd.1
        for <linux-pm@vger.kernel.org>; Wed, 03 May 2017 23:30:52 -0700 (PDT)
In-Reply-To: <20170503104554.23019-1-colin.king@canonical.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: "Andrew F . Davis" <afd@ti.com>, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org

[dropped some CCs]

Hi Colin,

On Wed, May 3, 2017 at 3:45 AM, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> The function bq27xxx_battery_settings can be made static as it
> does not need to be in global scope.

Thanks for flagging that. I've fixed it in the v13 series (just posted
to linux-pm); v12 landed in -next prematurely.


> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/power/supply/bq27xxx_battery.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
> index 7152370b9d61..06f15da32464 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -1251,7 +1251,7 @@ static void bq27xxx_battery_set_config(struct bq27xxx_device_info *di,
>         /* assume bq27xxx_battery_update() is called hereafter */
>  }
>
> -void bq27xxx_battery_settings(struct bq27xxx_device_info *di)
> +static void bq27xxx_battery_settings(struct bq27xxx_device_info *di)
>  {
>         struct power_supply_battery_info info = {};
>         unsigned int min, max;
> --
> 2.11.0
>
