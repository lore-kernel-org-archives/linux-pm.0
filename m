From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Fix unsigned variable being checked for negative value
Date: Mon, 18 Mar 2013 13:59:12 +0530
Message-ID: <CAKohponm1s9GkBML3+O1tjoiB=ZUUvj_X1yi5j3X0qk8_p8vxA@mail.gmail.com>
References: <000001ce23af$f51b0240$df5106c0$%choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:33793 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724Ab3CRI3M (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 Mar 2013 04:29:12 -0400
Received: by mail-ob0-f173.google.com with SMTP id dn14so5088971obc.32
        for <linux-pm@vger.kernel.org>; Mon, 18 Mar 2013 01:29:12 -0700 (PDT)
In-Reply-To: <000001ce23af$f51b0240$df5106c0$%choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jonghwan Choi <jhbird.choi@samsung.com>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Shawn Guo <shawn.guo@linaro.org>

On 18 March 2013 13:39, Jonghwan Choi <jhbird.choi@samsung.com> wrote:
> clk_round_rate() returns singed value which was assigned to an unsigned
> variable.
> So it can't be checked for negative.
>
> Signed-off-by: Jonghwan Choi <jhbird.choi@samsung.com>
> ---
>  drivers/cpufreq/cpufreq-cpu0.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
