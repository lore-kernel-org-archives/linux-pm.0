From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 05/13] power: max17042_battery: Change name in
 power_supply_desc to "main-battery"
Date: Fri, 14 Apr 2017 17:37:38 +0200
Message-ID: <20170414153738.7ceyzxmcu4ondops@kozik-lap>
References: <20170414125919.25771-1-hdegoede@redhat.com>
 <20170414125919.25771-5-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34189 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754161AbdDNPhm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Apr 2017 11:37:42 -0400
Received: by mail-wm0-f68.google.com with SMTP id x75so18323292wma.1
        for <linux-pm@vger.kernel.org>; Fri, 14 Apr 2017 08:37:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170414125919.25771-5-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pm@vger.kernel.org

On Fri, Apr 14, 2017 at 02:59:11PM +0200, Hans de Goede wrote:
> The max17042 will typically be couple with some charger IC, almost all

s/couple/coupled/


Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

> charger drivers contain:
> 
> static char *xxx_charger_supplied_to[] = {
>         "main-battery",
> };
> 
> probe()
> {
> 	struct power_supply_config cfg;
> 
> 	cfg.supplied_to = xxx_charger_supplied_to;
> 	cfg.num_supplicants = ARRAY_SIZE(xxx_charger_supplied_to);
> 	xxx->charger = power_supply_register(dev, &x_charger_desc, &_cfg);
> }
> 
> Change the name in max17042's power_supply_desc to "main-battery" to
> match, so that power_supply_am_i_supplied() can be used to implement
> POWER_SUPPLY_PROP_STATUS.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/power/supply/max17042_battery.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
