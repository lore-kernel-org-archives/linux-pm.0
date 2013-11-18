From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/1] cpufreq: exynos: Remove unwanted EXPORT_SYMBOL
Date: Mon, 18 Nov 2013 20:14:57 +0530
Message-ID: <CAKohpomKmJyJ_=Rd=7EMbQJixzumdTkOtK50xxFVZiyv5fLjmw@mail.gmail.com>
References: <1384775486-31660-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:43376 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199Ab3KROo6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 Nov 2013 09:44:58 -0500
Received: by mail-ob0-f173.google.com with SMTP id gq1so1924248obb.18
        for <linux-pm@vger.kernel.org>; Mon, 18 Nov 2013 06:44:57 -0800 (PST)
In-Reply-To: <1384775486-31660-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On 18 November 2013 17:21, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> The init functions are linked statically (no support for
> dynamic loading) and have no other users. Hence remove
> EXPORT_SYMBOL for these functions.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/cpufreq/exynos4210-cpufreq.c |    1 -
>  drivers/cpufreq/exynos4x12-cpufreq.c |    1 -
>  drivers/cpufreq/exynos5250-cpufreq.c |    1 -
>  3 files changed, 3 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
