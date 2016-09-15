From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] PM / OPP: avoid maybe-uninitialized warning
Date: Thu, 15 Sep 2016 14:45:49 -0700
Message-ID: <1289252d-4af8-4ffb-051b-6d2f460dd69f@codeaurora.org>
References: <20160915153917.3001855-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:53497 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753951AbcIOVpv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Sep 2016 17:45:51 -0400
In-Reply-To: <20160915153917.3001855-1-arnd@arndb.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 09/15/2016 08:38 AM, Arnd Bergmann wrote:
> When CONFIG_OPTIMIZE_INLINING is set and we are building with -Wmaybe-uninitialized
> enabled, we can get a warning for the opp core driver:
>
> drivers/base/power/opp/core.c: In function 'dev_pm_opp_set_rate':
> drivers/base/power/opp/core.c:560:8: warning: 'ou_volt_min' may be used uninitialized in this function [-Wmaybe-uninitialized]
>
> This has only now appeared as a result of commit 797da5598f3a ("PM / devfreq:
> Add COMPILE_TEST for build coverage"), which makes the driver visible in
> some configurations that didn't have it before.
>
> The warning is a false positive that I got with gcc-6.1.1, but there is
> a simple workaround in removing the local variables that we get warnings
> for (all three are affected depending on the configuration). This also
> makes the code easier to read.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

