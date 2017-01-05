From: Lee Jones <lee.jones@linaro.org>
Subject: Re: Immutable branch for axp288 power-supply/mfd
Date: Thu, 5 Jan 2017 08:13:30 +0000
Message-ID: <20170105081330.GM24225@dell>
References: <20170104211349.mwqlokjwytg2sn2e@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wj0-f171.google.com ([209.85.210.171]:34336 "EHLO
        mail-wj0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761059AbdAEIJt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Jan 2017 03:09:49 -0500
Received: by mail-wj0-f171.google.com with SMTP id tn15so29006662wjb.1
        for <linux-pm@vger.kernel.org>; Thu, 05 Jan 2017 00:09:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170104211349.mwqlokjwytg2sn2e@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org

On Wed, 04 Jan 2017, Sebastian Reichel wrote:

> Hi Lee,
> 
> Here is the promised immutable branch for the axp288 power-supply
> changes, that also touch the mfd subsystem.
> 
> -- Sebastian
> 
> The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:
> 
>   Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git psy-mfd-axp288-immutable

Did you tag the branch and push the tag?

> for you to fetch changes up to 888f97435a856c2c5c6ca0b3337b68d595b5639e:
> 
>   power: supply: axp288_fuel_gauge: Drop platform_data dependency (2017-01-04 21:56:10 +0100)
> 
> ----------------------------------------------------------------
> Hans de Goede (3):
>       power: supply: axp288_charger: Make charger_init_hw_regs propagate i2c errors
>       power: supply: axp288_charger: Drop platform_data dependency
>       power: supply: axp288_fuel_gauge: Drop platform_data dependency
> 
>  drivers/power/supply/axp288_charger.c    | 132 +++++-----
>  drivers/power/supply/axp288_fuel_gauge.c | 405 +++----------------------------
>  include/linux/mfd/axp20x.h               |  29 ---
>  3 files changed, 96 insertions(+), 470 deletions(-)



-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
