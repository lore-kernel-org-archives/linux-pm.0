From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 2/4] PM / Domains: Enable users of genpd to specify always
 on PM domains
Date: Mon, 20 Mar 2017 18:10:55 +0100
Message-ID: <106439272.Agr7nxKMxr@amdc3058>
References: <1490005163-28633-1-git-send-email-ulf.hansson@linaro.org>
 <1490005163-28633-3-git-send-email-ulf.hansson@linaro.org>
 <CGME20170320171057epcas1p2b7c3a9d663e86df6e29e7e6ceb582a70@epcas1p2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:38318 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753217AbdCTRnB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Mar 2017 13:43:01 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0ON402LE6IE9VM50@mailout2.samsung.com> for
 linux-pm@vger.kernel.org; Tue, 21 Mar 2017 02:10:57 +0900 (KST)
In-reply-to: <1490005163-28633-3-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Lina Iyer <lina.iyer@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>

On Monday, March 20, 2017 11:19:21 AM Ulf Hansson wrote:
> The current way to implement an always on PM domain consists of returning
> -EBUSY from the ->power_off() callback. This is a bit different compared to
> using the always on genpd governor, which prevents the PM domain from being
> powered off via runtime suspend, but not via system suspend.
> 
> The approach to return -EBUSY from the ->power_off() callback to support
> always on PM domains in genpd is suboptimal. That is because it requires
> genpd to follow the regular execution path of the power off sequence, which
> ends by invoking the ->power_off() callback.
> 
> To enable genpd to early abort the power off sequence for always on PM
> domains, it needs static information about these configurations. Therefore
> let's add a new genpd configuration flag, GENPD_FLAG_ALWAYS_ON.
> 
> Users of the new GENPD_FLAG_ALWAYS_ON flag, are by genpd required to make
> sure the PM domain is powered on before calling pm_genpd_init(). Moreover,
> users don't need to implement the ->power_off() callback, as genpd doesn't
> ever invoke it.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
