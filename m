From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/1] cpufreq: SPEAr: Fix incorrect variable type
Date: Thu, 26 Sep 2013 11:08:51 +0530
Message-ID: <CAKohponXRVe3+RAgSSV0jrmck-_aGtv11LoSLiZ8dTL3mooXAA@mail.gmail.com>
References: <1380173202-12624-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qe0-f52.google.com ([209.85.128.52]:61557 "EHLO
	mail-qe0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811Ab3IZFiw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Sep 2013 01:38:52 -0400
Received: by mail-qe0-f52.google.com with SMTP id i11so468160qej.25
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2013 22:38:51 -0700 (PDT)
In-Reply-To: <1380173202-12624-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

On 26 September 2013 10:56, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> 'clk_round_rate' returns a negative error code upon failure. This
> will never get detected by unsigned 'newfreq'. Make it signed.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/cpufreq/spear-cpufreq.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
