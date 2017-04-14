From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 12/13] power: max17042_battery: Add support for SCOPE
 property
Date: Fri, 14 Apr 2017 18:43:12 +0200
Message-ID: <20170414164312.o5q4anawrrbldrvm@kozik-lap>
References: <20170414125919.25771-1-hdegoede@redhat.com>
 <20170414125919.25771-12-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33896 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750739AbdDNQnQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Apr 2017 12:43:16 -0400
Received: by mail-wm0-f65.google.com with SMTP id x75so18566537wma.1
        for <linux-pm@vger.kernel.org>; Fri, 14 Apr 2017 09:43:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170414125919.25771-12-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pm@vger.kernel.org

On Fri, Apr 14, 2017 at 02:59:18PM +0200, Hans de Goede wrote:
> Add support for the SCOPE property, always return SCOPE_SYSTEM,
> as the max170xx is used for the main battery on all known systems
> with a max170xx.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/power/supply/max17042_battery.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
