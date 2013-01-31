From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: exynos: simplify .init() for setting policy->cpus
Date: Thu, 31 Jan 2013 10:23:37 +0530
Message-ID: <CAKohpo=eEnK8oJ1KEff=sBvyjZzdqmFKUgXe2+bhWAvyVVmzqg@mail.gmail.com>
References: <f216e85846c302756d55cb6753863a66697f79a6.1359599087.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f42.google.com ([209.85.219.42]:37038 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754216Ab3AaExi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 30 Jan 2013 23:53:38 -0500
Received: by mail-oa0-f42.google.com with SMTP id i18so2291598oag.15
        for <linux-pm@vger.kernel.org>; Wed, 30 Jan 2013 20:53:38 -0800 (PST)
In-Reply-To: <f216e85846c302756d55cb6753863a66697f79a6.1359599087.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, spear-devel@list.st.com, Viresh Kumar <viresh.kumar@linaro.org>

On 31 January 2013 10:22, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> With the recent changes in cpufreq core, we just need to set mask of all
> possible cpus into policy->cpus. Rest would be done by core.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Oops! Sent the wrong patch again. Ignore this mail :)
