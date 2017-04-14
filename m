From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 07/13] power: max17042_battery: Add
 external_power_changed callback
Date: Fri, 14 Apr 2017 18:22:07 +0200
Message-ID: <20170414162207.tmojj4zxfoc5ofj6@kozik-lap>
References: <20170414125919.25771-1-hdegoede@redhat.com>
 <20170414125919.25771-7-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34783 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753238AbdDNQWN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Apr 2017 12:22:13 -0400
Received: by mail-wm0-f65.google.com with SMTP id x75so18492817wma.1
        for <linux-pm@vger.kernel.org>; Fri, 14 Apr 2017 09:22:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170414125919.25771-7-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pm@vger.kernel.org

On Fri, Apr 14, 2017 at 02:59:13PM +0200, Hans de Goede wrote:
> If our supplier changes status, chances are we've changed status too,
> let any listeners know about this.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/power/supply/max17042_battery.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
