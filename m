From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V1 2/7] cpufreq: Loongson1: Update cpufreq of Loongson1B
Date: Thu, 7 Apr 2016 12:26:55 +0530
Message-ID: <20160407065655.GH14903@vireshk-i7>
References: <1459946095-7637-1-git-send-email-keguang.zhang@gmail.com>
 <1459946095-7637-3-git-send-email-keguang.zhang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36659 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840AbcDGG47 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 Apr 2016 02:56:59 -0400
Received: by mail-pf0-f173.google.com with SMTP id e128so49976656pfe.3
        for <linux-pm@vger.kernel.org>; Wed, 06 Apr 2016 23:56:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1459946095-7637-3-git-send-email-keguang.zhang@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Keguang Zhang <keguang.zhang@gmail.com>
Cc: linux-mips@linux-mips.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, dmaengine@vger.kernel.org, linux-gpio@vger.kernel.org, linux-mtd@lists.infradead.org, Ralf Baechle <ralf@linux-mips.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>

On 06-04-16, 20:34, Keguang Zhang wrote:
> From: Kelvin Cheung <keguang.zhang@gmail.com>
> 
> - Rename the file to loongson1-cpufreq.c
> - Use kcalloc() instead of kzalloc()
> - Use devm_kzalloc() instead of global structure
> - Use dev_get_platdata() to access the platform_data field
>   instead of referencing it directly
> - Remove superfluous error messages
> 
> Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
> ---
>  drivers/cpufreq/Makefile            |   2 +-
>  drivers/cpufreq/loongson1-cpufreq.c | 230 ++++++++++++++++++++++++++++++++++++
>  drivers/cpufreq/ls1x-cpufreq.c      | 222 ----------------------------------
>  3 files changed, 231 insertions(+), 223 deletions(-)
>  create mode 100644 drivers/cpufreq/loongson1-cpufreq.c
>  delete mode 100644 drivers/cpufreq/ls1x-cpufreq.c

This can't be reviewed. I am not going to compare them line by line to
see what you might have changed in between.

Please use '-C -M' options of git format-patch to generate this, it
will give a review-able output of this.
-- 
viresh
