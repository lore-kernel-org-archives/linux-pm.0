From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/4] PM / Domains: Some simplifications/clean-ups for genpd
Date: Fri, 23 Sep 2016 14:54 +0200
Message-ID: <2878937.BEb84IEckp@vostro.rjw.lan>
References: <1474465133-14865-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:51663 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1758823AbcIWMrr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Sep 2016 08:47:47 -0400
In-Reply-To: <1474465133-14865-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Hilman <khilman@kernel.org>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Jon Hunter <jonathanh@nvidia.com>

On Wednesday, September 21, 2016 03:38:49 PM Ulf Hansson wrote:
> Ulf Hansson (4):
>   PM / Domains: Simplify detaching a device from its genpd
>   PM / Domains: Remove redundant system PM callbacks
>   PM / Domains: Don't measure latency of ->power_on|off() during system
>     PM
>   PM / Domains: Rename pm_genpd_sync_poweron|poweroff()
> 
>  drivers/base/power/domain.c | 77 +++++++++++++++++++--------------------------
>  1 file changed, 33 insertions(+), 44 deletions(-)

This series is fine by me.

If there are no objections from Kevin or others, I'll queue it up later today.

Thanks,
Rafael

