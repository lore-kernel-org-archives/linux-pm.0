From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 09/13] power: max17042_battery: Add support for the
 VOLT_MIN property
Date: Fri, 14 Apr 2017 18:29:25 +0200
Message-ID: <20170414162925.ygo6bqupjqyivfx3@kozik-lap>
References: <20170414125919.25771-1-hdegoede@redhat.com>
 <20170414125919.25771-9-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33838 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751473AbdDNQ33 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Apr 2017 12:29:29 -0400
Received: by mail-wm0-f68.google.com with SMTP id x75so18519373wma.1
        for <linux-pm@vger.kernel.org>; Fri, 14 Apr 2017 09:29:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170414125919.25771-9-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pm@vger.kernel.org

On Fri, Apr 14, 2017 at 02:59:15PM +0200, Hans de Goede wrote:
> The info is there, so lets export it, like we already do for VOLT_MAX.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/power/supply/max17042_battery.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
