From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: exynos: simplify .init() for setting policy->cpus
Date: Mon, 4 Feb 2013 17:52:03 +0530
Message-ID: <CAKohpo=aWbJ9a9vKep1aGYTXr=5asYPCri1BPCww-3GxEo8F=w@mail.gmail.com>
References: <f216e85846c302756d55cb6753863a66697f79a6.1359599087.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f41.google.com ([209.85.219.41]:53596 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754064Ab3BDMWE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 Feb 2013 07:22:04 -0500
Received: by mail-oa0-f41.google.com with SMTP id i10so6547989oag.14
        for <linux-pm@vger.kernel.org>; Mon, 04 Feb 2013 04:22:03 -0800 (PST)
In-Reply-To: <f216e85846c302756d55cb6753863a66697f79a6.1359599087.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl, jc.lee@samsung.com
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-dev@lists.linaro.org, kgene.kim@samsung.com, Viresh Kumar <viresh.kumar@linaro.org>

On 31 January 2013 07:56, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> With the recent changes in cpufreq core, we just need to set mask of all
> possible cpus into policy->cpus. Rest would be done by core.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/exynos-cpufreq.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)

Hi Rafael,

Are you picking up this patch ?
