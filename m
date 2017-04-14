From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 02/13] power: max17042_battery: Use sign_extend32 instead
 of DIY code
Date: Fri, 14 Apr 2017 17:29:56 +0200
Message-ID: <20170414152956.5o2hgb6xagtdojf7@kozik-lap>
References: <20170414125919.25771-1-hdegoede@redhat.com>
 <20170414125919.25771-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34895 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751371AbdDNPaA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Apr 2017 11:30:00 -0400
Received: by mail-wm0-f66.google.com with SMTP id d79so18344170wmi.2
        for <linux-pm@vger.kernel.org>; Fri, 14 Apr 2017 08:30:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170414125919.25771-2-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pm@vger.kernel.org

On Fri, Apr 14, 2017 at 02:59:08PM +0200, Hans de Goede wrote:
> Use sign_extend32 to sign-extend variables where necessary instead of
> DIY code.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/power/supply/max17042_battery.c | 24 +++---------------------
>  1 file changed, 3 insertions(+), 21 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
