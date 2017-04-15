From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 11/14] power: max17042_battery: Add support for the
 CHARGE_FULL_DESIGN property
Date: Sat, 15 Apr 2017 12:38:45 +0200
Message-ID: <20170415103845.hfljzgjnmwrui3nf@kozik-lap>
References: <20170414183259.24382-1-hdegoede@redhat.com>
 <20170414183259.24382-11-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f173.google.com ([209.85.128.173]:35441 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752091AbdDOKit (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 15 Apr 2017 06:38:49 -0400
Received: by mail-wr0-f173.google.com with SMTP id o21so61246247wrb.2
        for <linux-pm@vger.kernel.org>; Sat, 15 Apr 2017 03:38:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170414183259.24382-11-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pm@vger.kernel.org

On Fri, Apr 14, 2017 at 08:32:56PM +0200, Hans de Goede wrote:
> The info is there, lets export it as a property.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Take r_sns value into account when converting the register value to uAh
> ---
>  drivers/power/supply/max17042_battery.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
