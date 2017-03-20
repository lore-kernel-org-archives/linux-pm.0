From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 4/4] PM / Domains: Don't warn about IRQ safe device for an
 always on PM domain
Date: Mon, 20 Mar 2017 18:14:18 +0100
Message-ID: <4551343.REDde4ApgN@amdc3058>
References: <1490005163-28633-1-git-send-email-ulf.hansson@linaro.org>
 <1490005163-28633-5-git-send-email-ulf.hansson@linaro.org>
 <CGME20170320171420epcas1p2f4598561c0bb9b81f8182a2566a4d93d@epcas1p2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:44871 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754624AbdCTROY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Mar 2017 13:14:24 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0ON402911IJYJV60@mailout1.samsung.com> for
 linux-pm@vger.kernel.org; Tue, 21 Mar 2017 02:14:22 +0900 (KST)
In-reply-to: <1490005163-28633-5-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Lina Iyer <lina.iyer@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>

On Monday, March 20, 2017 11:19:23 AM Ulf Hansson wrote:
> When an IRQ safe device is attached to a no sleep domain, genpd prints a
> warning once, as to indicate it is a suboptimal configuration from power
> consumption point of view.
> 
> However the warning doesn't make sense for an always on domain, since it
> anyway remains powered on. Therefore, let's change to not print the warning
> for this configuration.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
