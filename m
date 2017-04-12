From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v4 1/3] power: supply: bq24190_charger: Use new extcon_register_notifier_all()
Date: Wed, 12 Apr 2017 15:28:05 -0700
Message-ID: <CAKvHMgRhyHUx=AN_wJgEPZgQka_Uq6GXYreJe-hCWNRQDegoMw@mail.gmail.com>
References: <20170412181808.31768-1-hdegoede@redhat.com> <20170412181808.31768-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:33479 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752227AbdDLW2H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Apr 2017 18:28:07 -0400
Received: by mail-io0-f194.google.com with SMTP id k87so9544745ioi.0
        for <linux-pm@vger.kernel.org>; Wed, 12 Apr 2017 15:28:06 -0700 (PDT)
In-Reply-To: <20170412181808.31768-2-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org

Hi Hans,

On Wed, Apr 12, 2017 at 11:18 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> When I submitted the extcon handling I had a patch pending for the
> extcon sub-system for extcon_register_notifier to take -1 as cable id
> for listening for all type cable events on an extcon with a single
> notifier.
>
> In the end it was decided to instead add a new
> extcon_register_notifier_all function for this, switch to using this.

Oop. Let's try to see pending dependencies land in -next before we
land clients :-)

Acked-by: Liam Breck <kernel@networkimprov.net>


> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v4:
> -This is a new patch in v4 of this patch-set
> ---
>  drivers/power/supply/bq24190_charger.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
> index 7c893c0..bd9e5c3 100644
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -1502,8 +1502,8 @@ static int bq24190_probe(struct i2c_client *client,
>         if (bdi->extcon) {
>                 INIT_DELAYED_WORK(&bdi->extcon_work, bq24190_extcon_work);
>                 bdi->extcon_nb.notifier_call = bq24190_extcon_event;
> -               ret = devm_extcon_register_notifier(dev, bdi->extcon, -1,
> -                                                   &bdi->extcon_nb);
> +               ret = devm_extcon_register_notifier_all(dev, bdi->extcon,
> +                                                       &bdi->extcon_nb);
>                 if (ret) {
>                         dev_err(dev, "Can't register extcon\n");
>                         goto out_sysfs;
> --
> 2.9.3
>
