From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: governors: clean timer init and exit code
Date: Thu, 31 Jan 2013 16:23:06 +0530
Message-ID: <CAKohpomTNkEOrnyQWKJ8siajg67-fpe4EnYxiipgmN8STMSwAQ@mail.gmail.com>
References: <1359554017-28620-1-git-send-email-fabio.baltieri@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:42717 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753297Ab3AaKxH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 31 Jan 2013 05:53:07 -0500
Received: by mail-ob0-f170.google.com with SMTP id wc20so2750462obb.1
        for <linux-pm@vger.kernel.org>; Thu, 31 Jan 2013 02:53:06 -0800 (PST)
In-Reply-To: <1359554017-28620-1-git-send-email-fabio.baltieri@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Fabio Baltieri <fabio.baltieri@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, swarren@wwwdotorg.org, linaro-dev@lists.linaro.org, Nicolas Pitre <nicolas.pitre@linaro.org>, mathieu.poirier@linaro.org, Joseph Lo <josephl@nvidia.com>, linux-kernel@vger.kernel.org

On 30 January 2013 19:23, Fabio Baltieri <fabio.baltieri@linaro.org> wrote:
> Drop unused arguments from dbs_timer_init and clean dbs_timer_exit and
> cpufreq_governor_dbs to remove non necessary special cases.
>
> Reported-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>

As discussed over IRC, you will fix following in few days:
- Code redundancy within governors
- Removing second_time: label and cdbs->enable field
- Fixing params to timer init and exit to make them more efficient.

And here is my ack for this patch:

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
