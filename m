From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: arm_big_little: check if the frequency is
 set correctly
Date: Mon, 13 Apr 2015 15:55:10 +0530
Message-ID: <CAKohpomxRZkUWQUjHhbQ=8nTA-vXwuOvOFqFX9ocm6x9-DWysQ@mail.gmail.com>
References: <1427718438-31098-1-git-send-email-sudeep.holla@arm.com>
	<CAKohponxEv3CjhVPAu2Ga5FeSSvtj_W6zGvL3oj2V247f94H=w@mail.gmail.com>
	<551951F4.9070804@arm.com>
	<20150331014854.25195.34023@quantum>
	<551A67CD.50602@arm.com>
	<20150401214814.14369.56281@quantum>
	<551D03E9.508@arm.com>
	<20150413050825.19585.17809@quantum>
	<552B989C.30805@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:36036 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753357AbbDMKZL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 13 Apr 2015 06:25:11 -0400
Received: by qku63 with SMTP id 63so172556114qku.3
        for <linux-pm@vger.kernel.org>; Mon, 13 Apr 2015 03:25:10 -0700 (PDT)
In-Reply-To: <552B989C.30805@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Michael Turquette <mike.turquette@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On 13 April 2015 at 15:51, Sudeep Holla <sudeep.holla@arm.com> wrote:
> Thanks Mike.
>
> Viresh, is it OK if we carry this patch until the clk framework can
> handle this case ? I will add a *TODO* stating it's temporary change
> and can be dropped once the clk layer handle it if that helps in any way
> :).
>
> This issue is seen on TC2 when firmware is stress tested with continuous
> DVFS requests.

Sure.
