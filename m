From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 0/4] constify thermal_zone_of_device_ops structures
Date: Tue, 08 Aug 2017 21:43:58 +0800
Message-ID: <1502199838.4296.64.camel@intel.com>
References: <1501965437-30730-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:18467 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751880AbdHHNoG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 8 Aug 2017 09:44:06 -0400
In-Reply-To: <1501965437-30730-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>, linux-arm-kernel@lists.infradead.org
Cc: bhumirks@gmail.com, kernel-janitors@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, linux-rpi-kernel@lists.infradead.org

On Sat, 2017-08-05 at 22:37 +0200, Julia Lawall wrote:
> The thermal_zone_of_device_ops structures are only passed as the
> fourth
> argument to thermal_zone_of_sensor_register, which is declared as
> const.
> Thus the thermal_zone_of_device_ops structures themselves can be
> const.
> 
> Done with the help of Coccinelle.

I still see the same problem in other thermal drivers, which is not
covered by this patch set. Can we fix them all in one time?

thanks,
rui
> 
> ---
> 
>  drivers/thermal/broadcom/bcm2835_thermal.c |    2 +-
>  drivers/thermal/qoriq_thermal.c            |    2 +-
>  drivers/thermal/samsung/exynos_tmu.c       |    2 +-
>  drivers/thermal/zx2967_thermal.c           |    2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
