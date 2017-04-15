From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 04/14] power: max17042_battery: Add default
 platform_data fallback data
Date: Sat, 15 Apr 2017 12:31:36 +0200
Message-ID: <20170415103136.n7r4w3sddzfnfq4q@kozik-lap>
References: <20170414183259.24382-1-hdegoede@redhat.com>
 <20170414183259.24382-4-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33003 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752136AbdDOKbk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 15 Apr 2017 06:31:40 -0400
Received: by mail-wr0-f195.google.com with SMTP id l28so14925072wre.0
        for <linux-pm@vger.kernel.org>; Sat, 15 Apr 2017 03:31:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170414183259.24382-4-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pm@vger.kernel.org

On Fri, Apr 14, 2017 at 08:32:49PM +0200, Hans de Goede wrote:
> Some x86 machines use a max17047 fuel-gauge and x86 might be missing
> platform_data if not provided by SFI.
> 
> This commit adds default platform_data as fallback option so that the
> driver can work on boards where no platform_data is provided.
> 
> Since not all boards have a thermistor hooked up, set temp_min to 0 and
> change the health checks from temp <= temp_min to temp < temp_min to
> not trigger on such boards (where temp reads 0).
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Reword commit message
> -Add MAX17042_DEFAULT_FOO defines to include/linux/power/max17042.h and
>  use these to set the default pdata values
> ---
>  drivers/power/supply/max17042_battery.c | 60 +++++++++++++++++++++++++++++----
>  include/linux/power/max17042_battery.h  |  6 +++-
>  2 files changed, 58 insertions(+), 8 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
