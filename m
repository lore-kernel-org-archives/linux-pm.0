From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / Domains: Fix compilation error for devices that don't enable PM_SLEEP
Date: Wed, 12 Jul 2017 23:36:34 +0200
Message-ID: <14308983.sqd8SeZiOC@aspire.rjw.lan>
References: <20170710211448.11046-1-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:52938 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754342AbdGLVoW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jul 2017 17:44:22 -0400
In-Reply-To: <20170710211448.11046-1-fcooper@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Franklin S Cooper Jr <fcooper@ti.com>
Cc: mperttunen@nvidia.com, ulf.hansson@linaro.org, rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, ssantosh@kernel.org, linux-arm-kernel@lists.infradead.org

On Monday, July 10, 2017 04:14:48 PM Franklin S Cooper Jr wrote:
> Set pm_genpd_poweroff_noirq to NULL if CONFIG_PM_SLEEP isn't enabled.
> This is the same approach done for other PM_SLEEP related functions.
> 
> Without this patch building the kernel with the keystone_defconfig
> results in a compilation error.
> 
> Fixes: 10da65423fdb ("PM / Domains: Call driver's noirq callbacks")
> 
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>

That should be fixed already in the Linus' tree.

Thanks,
Rafael
