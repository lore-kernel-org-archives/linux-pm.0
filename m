From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 13/13] power: max77693_charger: Add supplied_to info to
 power_supply_config
Date: Fri, 14 Apr 2017 18:44:14 +0200
Message-ID: <20170414164414.yj3xfl6dydpiv66k@kozik-lap>
References: <20170414125919.25771-1-hdegoede@redhat.com>
 <20170414125919.25771-13-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34226 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750739AbdDNQoS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Apr 2017 12:44:18 -0400
Received: by mail-wr0-f195.google.com with SMTP id u18so13089423wrc.1
        for <linux-pm@vger.kernel.org>; Fri, 14 Apr 2017 09:44:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170414125919.25771-13-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pm@vger.kernel.org

On Fri, Apr 14, 2017 at 02:59:19PM +0200, Hans de Goede wrote:
> On the exynos4412-trats2 the max77693 is used together with a
> max17047 fuel-gauge. Add supplied_to info containing "main-battery",
> so that the get_status code in the max17042_battery driver can use
> power_supply_am_i_supplied and can properly let userspace know
> if the battery is being charged or not.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/power/supply/max77693_charger.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
