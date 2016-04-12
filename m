From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 4/5] cpufreq: Loongson1: Use devm_kzalloc() instead of
 global structure
Date: Tue, 12 Apr 2016 10:50:14 +0530
Message-ID: <20160412052014.GR16238@vireshk-i7>
References: <1460375759-20705-1-git-send-email-keguang.zhang@gmail.com>
 <1460375759-20705-4-git-send-email-keguang.zhang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33074 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752861AbcDLFUT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Apr 2016 01:20:19 -0400
Received: by mail-pa0-f53.google.com with SMTP id zm5so6586913pac.0
        for <linux-pm@vger.kernel.org>; Mon, 11 Apr 2016 22:20:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1460375759-20705-4-git-send-email-keguang.zhang@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Keguang Zhang <keguang.zhang@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On 11-04-16, 19:55, Keguang Zhang wrote:
> From: Kelvin Cheung <keguang.zhang@gmail.com>
> 
> This patch uses devm_kzalloc() instead of global structure.
> 

Why are you doing this? The commit log should contain that.

> Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
> ---
>  drivers/cpufreq/loongson1-cpufreq.c | 63 ++++++++++++++++++++-----------------
>  1 file changed, 35 insertions(+), 28 deletions(-)

I don't have any issues with you doing this, but I don't think that's
necessary to do.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
