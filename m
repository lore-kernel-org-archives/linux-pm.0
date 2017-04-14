From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 06/13] power: max17042_battery: Add support for the
 STATUS property
Date: Fri, 14 Apr 2017 18:11:25 +0200
Message-ID: <20170414161125.avoyao2gc4dqibom@kozik-lap>
References: <20170414125919.25771-1-hdegoede@redhat.com>
 <20170414125919.25771-6-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34652 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751147AbdDNQL2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Apr 2017 12:11:28 -0400
Received: by mail-wr0-f194.google.com with SMTP id u18so13002956wrc.1
        for <linux-pm@vger.kernel.org>; Fri, 14 Apr 2017 09:11:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170414125919.25771-6-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pm@vger.kernel.org

On Fri, Apr 14, 2017 at 02:59:12PM +0200, Hans de Goede wrote:
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
>  drivers/power/supply/max17042_battery.c | 49 +++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
> index f8a0384..1ea8368 100644
> --- a/drivers/power/supply/max17042_battery.c
> +++ b/drivers/power/supply/max17042_battery.c
> @@ -65,6 +65,9 @@
>  
>  #define MAX17042_VMAX_TOLERANCE		50 /* 50 mV */
>  
> +/* Consider RepCap which is less then 10 units below FullCAP full */
> +#define MAX17042_FULL_THRESHOLD		10

How about grouping all of defaults and configuration values in one
place? Some of them are already in
include/linux/power/max17042_battery.h.

Best regards,
Krzysztof
