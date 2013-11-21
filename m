From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 1/1] cpufreq: exynos: Fix line over 80 characters warning
Date: Thu, 21 Nov 2013 08:28:56 +0530
Message-ID: <CAK9yfHzCGbqtxVs9WqVLFJ-8v3jLU_B2ZDtWdAFUMEjeFShfwA@mail.gmail.com>
References: <1384837639-9252-1-git-send-email-sachin.kamat@linaro.org>
	<6133597.QYzlQUus4P@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f51.google.com ([209.85.219.51]:49862 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827Ab3KUC65 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Nov 2013 21:58:57 -0500
Received: by mail-oa0-f51.google.com with SMTP id i7so6394188oag.38
        for <linux-pm@vger.kernel.org>; Wed, 20 Nov 2013 18:58:57 -0800 (PST)
In-Reply-To: <6133597.QYzlQUus4P@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Jonghwan Choi <jhbird.choi@samsung.com>

On 21 November 2013 06:24, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, November 19, 2013 10:37:19 AM Sachin Kamat wrote:
>> Silences the checkpatch warning introduced by
>> commit 94aa44090eda ("cpufreq: exynos: Add missing static").
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> Cc: Jonghwan Choi <jhbird.choi@samsung.com>
>
> I'm not going to apply this and seriously if you care, please modify
> checkpatch.pl to stop emitting that warning.  It is silly and useless in
> my opinion, so I won't take any patches "fixing" it.

Agreed. However, the cpufreq drivers are pretty clean already and
this one just stands out. That was the only reason for doing this.

-- 
With warm regards,
Sachin
