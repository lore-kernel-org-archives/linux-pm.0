From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] PM / Domains: Rename genpd internals from pm_genpd_* to
 genpd_*
Date: Fri, 6 Oct 2017 13:54:14 +0530
Message-ID: <20171006082414.GC18345@vireshk-i7>
References: <1507273326-26132-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51]:55183 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750714AbdJFIYU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Oct 2017 04:24:20 -0400
Received: by mail-pg0-f51.google.com with SMTP id c137so9596220pga.11
        for <linux-pm@vger.kernel.org>; Fri, 06 Oct 2017 01:24:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1507273326-26132-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Kevin Hilman <khilman@kernel.org>

On 06-10-17, 09:02, Ulf Hansson wrote:
> Most of the functions names has already moved the genpd naming rules,
> however let's make this complete to avoid any further confusions.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/power/domain.c | 104 +++++++++++++++++++++-----------------------
>  1 file changed, 50 insertions(+), 54 deletions(-)

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
