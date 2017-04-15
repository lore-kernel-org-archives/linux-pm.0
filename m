From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 12/14] power: max17042_battery: Add support for the
 CHARGE_NOW property
Date: Sat, 15 Apr 2017 12:39:41 +0200
Message-ID: <20170415103941.mgn7naa2cyi262wi@kozik-lap>
References: <20170414183259.24382-1-hdegoede@redhat.com>
 <20170414183259.24382-12-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32909 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753834AbdDOKjp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 15 Apr 2017 06:39:45 -0400
Received: by mail-wm0-f67.google.com with SMTP id o81so2009679wmb.0
        for <linux-pm@vger.kernel.org>; Sat, 15 Apr 2017 03:39:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170414183259.24382-12-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pm@vger.kernel.org

On Fri, Apr 14, 2017 at 08:32:57PM +0200, Hans de Goede wrote:
> Atleast upower prefers the more precise charge_now sysfs value over

s/Atleast/At least/ ?

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

> capacity and the max17042 has the info, so lets export it.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Take r_sns value into account when converting the register value to uAh
> ---
>  drivers/power/supply/max17042_battery.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
