From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 1/4] PM / Domains: Clean up code validating genpd's status
Date: Mon, 20 Mar 2017 18:10:38 +0100
Message-ID: <3305095.GcIPqx65Co@amdc3058>
References: <1490005163-28633-1-git-send-email-ulf.hansson@linaro.org>
 <1490005163-28633-2-git-send-email-ulf.hansson@linaro.org>
 <CGME20170320171040epcas1p3ed2179e98b8dbeead3cb81571dd8fbf3@epcas1p3.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:44024 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753217AbdCTRnK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Mar 2017 13:43:10 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0ON401I3LIDTYG40@mailout4.samsung.com> for
 linux-pm@vger.kernel.org; Tue, 21 Mar 2017 02:10:41 +0900 (KST)
In-reply-to: <1490005163-28633-2-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Lina Iyer <lina.iyer@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>

On Monday, March 20, 2017 11:19:20 AM Ulf Hansson wrote:
> There exists several similar validations of the genpd->status, against
> GPD_STATE_ACTIVE and GPD_STATE_POWER_OFF. Let's clean up this code by
> converting to use a helper macro, genpd_status_on().
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
