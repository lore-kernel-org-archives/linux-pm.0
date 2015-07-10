From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Initialize the governor again while restoring policy
Date: Fri, 10 Jul 2015 09:08:51 +0530
Message-ID: <CAKohpomko4bnMN0SuqW8BAk6MUAyUNnFAWV4nmZNo6=_PS6JbA@mail.gmail.com>
References: <f428ecb0927075b25cf7e2ea5fb00eab3d254fdd.1436333568.git.viresh.kumar@linaro.org>
	<3814282.YWYCHNROVv@vostro.rjw.lan>
	<20150709051024.GJ1805@linux>
	<5369372.r4v2a9W8l1@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vn0-f42.google.com ([209.85.216.42]:36819 "EHLO
	mail-vn0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229AbbGJDiw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jul 2015 23:38:52 -0400
Received: by vnbg129 with SMTP id g129so36891274vnb.3
        for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2015 20:38:52 -0700 (PDT)
In-Reply-To: <5369372.r4v2a9W8l1@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Pi-Cheng Chen <pi-cheng.chen@linaro.org>, "Jon Medhurst (Tixy)" <tixy@linaro.org>, open list <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>

On 10 July 2015 at 05:35, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:

>> - Because governors matched, we skip governor initialization and return
>>   after calling __cpufreq_governor(CPUFREQ_GOV_LIMITS).
>
> But this sounds fragile in principle.  What's the benefit from skipping the
> governor initialization in that case?

So this is the case where we have changed some property of the governor,
and the governor is already initialised. We need to exit the earlier governor
and initialize the new one only when the governor is actually switched.
