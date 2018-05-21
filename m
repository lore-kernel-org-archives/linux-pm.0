From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 18/33] power: supply: use match_string() helper
Date: Tue, 22 May 2018 00:58:14 +0300
Message-ID: <CAHp75VfnJQBdXiVuv9OOT6w=wD5rKDCJKA7M2iyxxmQndNhoRA@mail.gmail.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com> <1526903890-35761-19-git-send-email-xieyisheng1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1526903890-35761-19-git-send-email-xieyisheng1@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, May 21, 2018 at 2:57 PM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
> match_string() returns the index of an array for a matching string,
> which can be used intead of open coded variant.
>

This doesn't make code looks better anyhow. I even think it makes it
worse to read.
That's why I dropped my version of the change (and yes, I missed the
type conversion which looks here just ugly).

Sebastian, if my opinion makes any difference here, I would say NAK to this one.

> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> ---
>  drivers/power/supply/power_supply_core.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
> index feac7b0..84da3a2 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -36,8 +36,6 @@
>  static bool __power_supply_is_supplied_by(struct power_supply *supplier,
>                                          struct power_supply *supply)
>  {
> -       int i;
> -
>         if (!supply->supplied_from && !supplier->supplied_to)
>                 return false;
>
> @@ -45,18 +43,16 @@ static bool __power_supply_is_supplied_by(struct power_supply *supplier,
>         if (supply->supplied_from) {
>                 if (!supplier->desc->name)
>                         return false;
> -               for (i = 0; i < supply->num_supplies; i++)
> -                       if (!strcmp(supplier->desc->name, supply->supplied_from[i]))
> -                               return true;
> +               return match_string((const char **)supply->supplied_from,
> +                                   supply->num_supplies,
> +                                   supplier->desc->name) >= 0;
>         } else {
>                 if (!supply->desc->name)
>                         return false;
> -               for (i = 0; i < supplier->num_supplicants; i++)
> -                       if (!strcmp(supplier->supplied_to[i], supply->desc->name))
> -                               return true;
> +               return match_string((const char **)supplier->supplied_to,
> +                                   supplier->num_supplicants,
> +                                   supply->desc->name) >= 0;
>         }
> -
> -       return false;
>  }
>
>  static int __power_supply_changed_work(struct device *dev, void *data)
> --
> 1.7.12.4
>



-- 
With Best Regards,
Andy Shevchenko
