From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 3/4] PM / Domains: Respect errors from genpd's
 ->power_off() callback
Date: Mon, 20 Mar 2017 18:14 +0100
Message-ID: <4830672.JUhSilAqla@amdc3058>
References: <1490005163-28633-1-git-send-email-ulf.hansson@linaro.org>
 <1490005163-28633-4-git-send-email-ulf.hansson@linaro.org>
 <CGME20170320171402epcas5p4f3e78dbbc7056aceda93501ae8af4a8c@epcas5p4.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:34466 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754960AbdCTROV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Mar 2017 13:14:21 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0ON401FIGIJGRQ40@mailout4.samsung.com> for
 linux-pm@vger.kernel.org; Tue, 21 Mar 2017 02:14:04 +0900 (KST)
In-reply-to: <1490005163-28633-4-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Lina Iyer <lina.iyer@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>

On Monday, March 20, 2017 11:19:22 AM Ulf Hansson wrote:
> The current code in genpd_sync_power_off(), doesn't care about potential
> errors being returned from genpd's ->power_off() callback.
> 
> Obviously this behaviour could lead to problems, such as incorrectly
> setting the genpd's status to GPD_STATE_POWER_OFF, but also to incorrectly
> decrease the subdomain count for the masters, which potentially allows them
> to be powered off in the next recursive call to genpd_sync_power_off().
> 
> Let's fix this behaviour by bailing out when the ->power_off() callback
> returns an error code.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
