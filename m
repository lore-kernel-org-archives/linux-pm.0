From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 06/14] power: max17042_battery: Add support for the
 STATUS property
Date: Sat, 15 Apr 2017 12:32:44 +0200
Message-ID: <20170415103244.acnvbn2ry2d2tbeu@kozik-lap>
References: <20170414183259.24382-1-hdegoede@redhat.com>
 <20170414183259.24382-6-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34360 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752136AbdDOKcs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 15 Apr 2017 06:32:48 -0400
Received: by mail-wm0-f68.google.com with SMTP id x75so1988377wma.1
        for <linux-pm@vger.kernel.org>; Sat, 15 Apr 2017 03:32:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170414183259.24382-6-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pm@vger.kernel.org

On Fri, Apr 14, 2017 at 08:32:51PM +0200, Hans de Goede wrote:
> Userspace prefers the driver having a status property over having to guess
> itself. Specifically this will properly make the GNOME3 UI (and likely
> others) properly show discharging / charging / full status, instead
> of always showing discharging as status.
> 
> Note that in the case there is no charger driver supplying the max17042,
> then a status of unknown will get returned. At least upower treats
> this the same as not having a status attribute, so in this case nothing
> changes from a userspace pov.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Move MAX17042_FULL_THRESHOLD define to max17042.h
> ---
>  drivers/power/supply/max17042_battery.c | 46 +++++++++++++++++++++++++++++++++
>  include/linux/power/max17042_battery.h  |  3 +++
>  2 files changed, 49 insertions(+)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
