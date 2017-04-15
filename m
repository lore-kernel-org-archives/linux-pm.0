From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 01/14] power: Make power_supply_am_i_supplied return
 -ENODEV if there are no suppliers
Date: Sat, 15 Apr 2017 12:30:31 +0200
Message-ID: <20170415103031.foo7jf6pf7p6jpuy@kozik-lap>
References: <20170414183259.24382-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36581 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752497AbdDOKaf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 15 Apr 2017 06:30:35 -0400
Received: by mail-wm0-f65.google.com with SMTP id q125so1974785wmd.3
        for <linux-pm@vger.kernel.org>; Sat, 15 Apr 2017 03:30:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170414183259.24382-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pm@vger.kernel.org

On Fri, Apr 14, 2017 at 08:32:46PM +0200, Hans de Goede wrote:
> It is sensible to assume that the hardware actually always has a
> way of charging the battery so when power_supply_am_i_supplied does not
> find any suppliers, that does not mean that there are none, but simply
> that no power_supply-drivers are registered / bound for any suppliers for
> the supply calling power_supply_am_i_supplied.
> 
> At which point a fuel-gauge driver calling power_supply_am_i_supplied()
> cannot determine whether the battery is being charged or not.
> 
> Allow a caller of power_supply_am_i_supplied to differentiate between
> there not being any suppliers, vs no suppliers being online by returning
> -ENODEV if there are no suppliers matching supplied_to / supplied_from,
> which allows fuel-gauge drivers to return POWER_SUPPLY_STATUS_UNKNOWN
> rather then POWER_SUPPLY_STATUS_DISCHARGING if there are no suppliers.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Improve commit message
> ---
>  drivers/power/supply/power_supply_core.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
> index 1e0960b..13a39da 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -280,13 +280,19 @@ static inline int power_supply_check_supplies(struct power_supply *psy)
>  }
>  #endif
>  
> -static int __power_supply_am_i_supplied(struct device *dev, void *data)
> +struct am_i_supplied_data {
> +	struct power_supply *psy;
> +	unsigned int count;
> +};

I think you missed my previous comment about adding a prefix - psy?

Best regards,
Krzysztof
