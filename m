From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 10/14] power: max17042_battery: mAh readings depend on
 r_sns value
Date: Sat, 15 Apr 2017 12:38:28 +0200
Message-ID: <20170415103828.itueccwnq2drm3xh@kozik-lap>
References: <20170414183259.24382-1-hdegoede@redhat.com>
 <20170414183259.24382-10-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36133 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752091AbdDOKic (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 15 Apr 2017 06:38:32 -0400
Received: by mail-wm0-f67.google.com with SMTP id q125so1995821wmd.3
        for <linux-pm@vger.kernel.org>; Sat, 15 Apr 2017 03:38:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170414183259.24382-10-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pm@vger.kernel.org

On Fri, Apr 14, 2017 at 08:32:55PM +0200, Hans de Goede wrote:
> The PROP_CHARGE_FULL code was hardcoded for the default sense
> resistor of 0.010 Ohm, make it use r_sns which contains the
> actual sense resistor value in micro-Ohms instead.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -This is a new patch in v2 of this patch-set
> ---
>  drivers/power/supply/max17042_battery.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
