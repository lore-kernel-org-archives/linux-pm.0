From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq-dt: fix handling regulator_get_voltage result
Date: Mon, 4 Jan 2016 10:58:56 +0530
Message-ID: <20160104052856.GA27177@ubuntu>
References: <1451474324-15481-1-git-send-email-a.hajda@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36575 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759AbcADF3A (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 Jan 2016 00:29:00 -0500
Received: by mail-pa0-f41.google.com with SMTP id yy13so99133823pab.3
        for <linux-pm@vger.kernel.org>; Sun, 03 Jan 2016 21:29:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1451474324-15481-1-git-send-email-a.hajda@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrzej Hajda <a.hajda@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, "open list:CPU FREQUENCY DRIVERS" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On 30-12-15, 12:18, Andrzej Hajda wrote:
> The function can return negative values so it should be assigned
> to signed type.
> 
> The problem has been detected using proposed semantic patch
> scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci [1].
> 
> [1]: http://permalink.gmane.org/gmane.linux.kernel/2038576
> 
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
>  drivers/cpufreq/cpufreq-dt.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
