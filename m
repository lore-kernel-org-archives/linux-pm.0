From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] drivers:cpufreq:unicore32: fix typo issue for 'clk'
Date: Mon, 7 Apr 2014 17:38:50 +0530
Message-ID: <CAKohpok189SxuJoGNvgshwEaUozMDM9mzA8wse5COkN8MBUaPg@mail.gmail.com>
References: <53429445.5000005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f48.google.com ([209.85.219.48]:53257 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754790AbaDGMIu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Apr 2014 08:08:50 -0400
Received: by mail-oa0-f48.google.com with SMTP id m1so6391781oag.7
        for <linux-pm@vger.kernel.org>; Mon, 07 Apr 2014 05:08:50 -0700 (PDT)
In-Reply-To: <53429445.5000005@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen Gang <gang.chen.5i5j@gmail.com>
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, stable@vger.kernel.org

On 7 April 2014 17:34, Chen Gang <gang.chen.5i5j@gmail.com> wrote:
> Need use 'clk' instead of 'mclk', which is the original removed local
> variable.
>
> The related original commit:
>
>   "652ed95 cpufreq: introduce cpufreq_generic_get() routine"
>
> The related error with allmodconfig for unicore32:
>
>     CC      drivers/cpufreq/unicore2-cpufreq.o
>   drivers/cpufreq/unicore2-cpufreq.c: In function 'ucv2_target':
>   drivers/cpufreq/unicore2-cpufreq.c:48: error: 'struct cpufreq_policy' has no member named 'mclk'
>   make[2]: *** [drivers/cpufreq/unicore2-cpufreq.o] Error 1
>   make[1]: *** [drivers/cpufreq] Error 2
>   make: *** [drivers] Error 2
>
>
> Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
> ---
>  drivers/cpufreq/unicore2-cpufreq.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Stupid mistake.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

@stable: please apply this for v3.14, as it broke in that cycle..
