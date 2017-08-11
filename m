From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 4/4] cpufreq: dbx500: Delete obsolete driver
Date: Fri, 11 Aug 2017 10:47:09 +0530
Message-ID: <20170811051709.GE3638@vireshk-i7>
References: <20170810125221.25818-1-linus.walleij@linaro.org>
 <20170810125221.25818-5-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f43.google.com ([74.125.83.43]:37178 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752312AbdHKFRM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Aug 2017 01:17:12 -0400
Received: by mail-pg0-f43.google.com with SMTP id y129so11394106pgy.4
        for <linux-pm@vger.kernel.org>; Thu, 10 Aug 2017 22:17:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170810125221.25818-5-linus.walleij@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Lee Jones <lee.jones@linaro.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>

On 10-08-17, 14:52, Linus Walleij wrote:
> We have moved the Ux500 over to use the generic DT based
> cpufreq driver, so delete the old custom driver.
> 
> At the same time select CPUFREQ_DT from the machine's
> Kconfig in order to satisfy the "default ARCH_U8500"
> selection on the old driver.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/mach-ux500/Kconfig      |   1 +
>  drivers/cpufreq/Kconfig.arm      |   9 ----
>  drivers/cpufreq/Makefile         |   1 -
>  drivers/cpufreq/dbx500-cpufreq.c | 103 ---------------------------------------
>  4 files changed, 1 insertion(+), 113 deletions(-)
>  delete mode 100644 drivers/cpufreq/dbx500-cpufreq.c

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
