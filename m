From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: governors: fix misuse of cdbs.cpu
Date: Thu, 31 Jan 2013 16:17:08 +0530
Message-ID: <CAKohpokq3p9Yz5771nuz0AiOfavg59t6xamdob-=5h02vOPK=g@mail.gmail.com>
References: <1359628759-15006-1-git-send-email-fabio.baltieri@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:38860 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753534Ab3AaKrK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 31 Jan 2013 05:47:10 -0500
Received: by mail-ob0-f173.google.com with SMTP id dn14so2748477obc.18
        for <linux-pm@vger.kernel.org>; Thu, 31 Jan 2013 02:47:10 -0800 (PST)
In-Reply-To: <1359628759-15006-1-git-send-email-fabio.baltieri@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Fabio Baltieri <fabio.baltieri@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linaro-dev@lists.linaro.org, linux-kernel@vger.kernel.org

On 31 January 2013 16:09, Fabio Baltieri <fabio.baltieri@linaro.org> wrote:
> Fix governors code to set all cpu's cdbs->cpu to the the actual cpu id
> and use cur_policy->cpu istead of cdbs->cpu to track current governor's
> leader cpu.
>
> Reported-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
> ---
>  drivers/cpufreq/cpufreq_conservative.c | 5 +++--
>  drivers/cpufreq/cpufreq_governor.c     | 2 +-
>  drivers/cpufreq/cpufreq_ondemand.c     | 5 +++--
>  3 files changed, 7 insertions(+), 5 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
