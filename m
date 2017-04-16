From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3] power: Make power_supply_am_i_supplied return -ENODEV
 if there are no suppliers
Date: Sun, 16 Apr 2017 19:33:39 +0200
Message-ID: <20170416173339.sywagp3hns5sslb7@kozik-lap>
References: <20170416153031.11531-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35419 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756253AbdDPRdn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 16 Apr 2017 13:33:43 -0400
Received: by mail-wr0-f196.google.com with SMTP id l44so17974835wrc.2
        for <linux-pm@vger.kernel.org>; Sun, 16 Apr 2017 10:33:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170416153031.11531-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pm@vger.kernel.org

On Sun, Apr 16, 2017 at 05:30:31PM +0200, Hans de Goede wrote:
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
> Changes in v3:
> -s/am_i_supplied_data/psy_am_i_supplied_data/
> ---
>  drivers/power/supply/power_supply_core.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
