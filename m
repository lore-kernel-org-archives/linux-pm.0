From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V1 1/5] cpufreq: Loongson1: Rename the file to
 loongson1-cpufreq.c
Date: Tue, 12 Apr 2016 16:13:19 +0530
Message-ID: <20160412104319.GA17650@vireshk-i7>
References: <1460457619-14786-1-git-send-email-keguang.zhang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33775 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753719AbcDLKnZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Apr 2016 06:43:25 -0400
Received: by mail-pf0-f176.google.com with SMTP id 184so11810007pff.0
        for <linux-pm@vger.kernel.org>; Tue, 12 Apr 2016 03:43:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1460457619-14786-1-git-send-email-keguang.zhang@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Keguang Zhang <keguang.zhang@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On 12-04-16, 18:40, Keguang Zhang wrote:
> From: Kelvin Cheung <keguang.zhang@gmail.com>
> 
> This patch renames the file to loongson1-cpufreq.c,
> and also includes some minor updates.
> 
> Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
> 
> ---
> V1:
>    Merge the minor updates into this patch.
> ---
>  drivers/cpufreq/Makefile                                |  2 +-
>  drivers/cpufreq/{ls1x-cpufreq.c => loongson1-cpufreq.c} | 10 +++++-----
>  2 files changed, 6 insertions(+), 6 deletions(-)
>  rename drivers/cpufreq/{ls1x-cpufreq.c => loongson1-cpufreq.c} (96%)

For the entire series.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
