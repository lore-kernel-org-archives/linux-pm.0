From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 1/1] cpufreq: exynos: Fix compilation warnings
Date: Tue, 19 Nov 2013 10:37:36 +0530
Message-ID: <CAK9yfHws8dkpQzWp2h-xHKvGVzefsXg4FmJM3no0qwnT49n+sA@mail.gmail.com>
References: <1384835019-3251-1-git-send-email-sachin.kamat@linaro.org>
	<CAKohpok34dKXAU2K-o4UpmWDq6Y8xcCuN2Cjk_AbbG5mL8Jf9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f42.google.com ([209.85.219.42]:42443 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120Ab3KSFHg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 Nov 2013 00:07:36 -0500
Received: by mail-oa0-f42.google.com with SMTP id i4so2653130oah.1
        for <linux-pm@vger.kernel.org>; Mon, 18 Nov 2013 21:07:36 -0800 (PST)
In-Reply-To: <CAKohpok34dKXAU2K-o4UpmWDq6Y8xcCuN2Cjk_AbbG5mL8Jf9w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lukasz Majewski <l.majewski@samsung.com>

Hi Viresh,

On 19 November 2013 10:29, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 19 November 2013 09:53, Sachin Kamat <sachin.kamat@linaro.org> wrote:
>> Commit a403797bbd81 ("cpufreq: exynos: Convert exynos-cpufreq
>> to platform driver") forgot to change the function prototype.
>
> I can't find this commit anywhere..

> And I can see that you had already given comments for the patch and
> so this should be fixed right there..

Sorry, please discard this patch. Looks like I had applied this patch
locally in my tree
when I was reviewing it. I did give my comments about this warning then.
Somehow I thought this patch got applied without my comment getting
addressed, hence I
fixed this myself. Sorry for the noise.

Lukasz, do you plan to send the updated the patch?

-- 
With warm regards,
Sachin
