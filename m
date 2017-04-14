From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 01/13] power: Make power_supply_am_i_supplied return
 -ENODEV if there are no suppliers
Date: Fri, 14 Apr 2017 15:56:38 +0200
Message-ID: <20170414135638.pbcjxvvf6a7gfizw@kozik-lap>
References: <20170414125919.25771-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35076 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751896AbdDNN4m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Apr 2017 09:56:42 -0400
Received: by mail-wr0-f193.google.com with SMTP id l44so12545109wrc.2
        for <linux-pm@vger.kernel.org>; Fri, 14 Apr 2017 06:56:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170414125919.25771-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pm@vger.kernel.org

On Fri, Apr 14, 2017 at 02:59:07PM +0200, Hans de Goede wrote:
> Allow a caller of power_supply_am_i_supplied to differentiate between
> there not being any suppliers, vs no suppliers being online by returning
> -ENODEV if there are no suppliers matching supplied_to / supplied_from.
> 

This is missing important piece of information - why you need to
differentiate that? What is the difference for you between no supplies
at all and not-being-supplied?


> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
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

How about a prefix, e.g.: "psy_am_i_supplied_data"?

Best regards,
Krzysztof
