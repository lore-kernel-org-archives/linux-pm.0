From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/4] PM / Domains: Clean up code validating genpd's status
Date: Mon, 20 Mar 2017 16:37:35 +0530
Message-ID: <20170320110735.GH25659@vireshk-i7>
References: <1490005163-28633-1-git-send-email-ulf.hansson@linaro.org>
 <1490005163-28633-2-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f43.google.com ([74.125.83.43]:36107 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754223AbdCTLIP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Mar 2017 07:08:15 -0400
Received: by mail-pg0-f43.google.com with SMTP id g2so75377001pge.3
        for <linux-pm@vger.kernel.org>; Mon, 20 Mar 2017 04:07:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1490005163-28633-2-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Lina Iyer <lina.iyer@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Marek Szyprowski <m.szyprowski@samsung.com>

On 20-03-17, 11:19, Ulf Hansson wrote:
> There exists several similar validations of the genpd->status, against
> GPD_STATE_ACTIVE and GPD_STATE_POWER_OFF. Let's clean up this code by
> converting to use a helper macro, genpd_status_on().
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/power/domain.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
