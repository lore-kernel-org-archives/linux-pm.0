From: Sven Van Asbroeck <thesven73@gmail.com>
Subject: Re: [PATCH] power: supply: ds2782: fix possible use-after-free on remove
Date: Tue, 12 Feb 2019 11:16:58 -0500
Message-ID: <CAGngYiXOfL1MpTcpki-=h=bm0RMKBg0+65p2tCRmBSucnG5mVg@mail.gmail.com>
References: <20190212161450.17167-1-TheSven73@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190212161450.17167-1-TheSven73@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 12, 2019 at 11:14 AM Sven Van Asbroeck <thesven73@gmail.com> wrote:
>
> In remove(), use cancel_delayed_work_sync() to cancel the
> delayed work. Otherwise there's a chance that this work
> will continue to run until after the device has been removed.
>
> While we're here, fix the deallocation order in remove(),
> to correspond to the inverse of the probe() allocation
> order. This guarantees that any remaining work can run
> to completion with all driver structures still intact.
>
> This issue was detected with the help of Coccinelle.
>
> Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
> ---
>  drivers/power/supply/ds2782_battery.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/power/supply/ds2782_battery.c b/drivers/power/supply/ds2782_battery.c
> index 019c58493e3d..5853a66ff246 100644
> --- a/drivers/power/supply/ds2782_battery.c
> +++ b/drivers/power/supply/ds2782_battery.c
> @@ -321,15 +321,14 @@ static int ds278x_battery_remove(struct i2c_client *client)
>         struct ds278x_info *info = i2c_get_clientdata(client);
>
>         power_supply_unregister(info->battery);
> +       cancel_delayed_work_sync(&info->bat_work);
>         kfree(info->battery_desc.name);
> +       kfree(info);
>
>         mutex_lock(&battery_lock);
>         idr_remove(&battery_id, info->id);

argh, just a minute !

>         mutex_unlock(&battery_lock);
>
> -       cancel_delayed_work(&info->bat_work);
> -
> -       kfree(info);
>         return 0;
>  }
>
> --
> 2.17.1
>
