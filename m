From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RESEND][PATCH] cpufreq: stats: Add 'load_table' sysfs file to
 show accumulated data of CPU
Date: Wed, 12 Jun 2013 09:32:16 +0530
Message-ID: <CAKohpomwDonECPOPoSZvrOS+mRyNARX4Sk1XoEAGLXrOQQjYjA@mail.gmail.com>
References: <1370419882-16831-1-git-send-email-cw00.choi@samsung.com>
	<11735265.3zXb8Z81XT@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:54133 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747Ab3FLECR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jun 2013 00:02:17 -0400
Received: by mail-ob0-f180.google.com with SMTP id eh20so12507133obb.39
        for <linux-pm@vger.kernel.org>; Tue, 11 Jun 2013 21:02:16 -0700 (PDT)
In-Reply-To: <11735265.3zXb8Z81XT@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, kyungmin.park@samsung.com, myungjoo.ham@samsung.com

On 12 June 2013 03:44, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Wednesday, June 05, 2013 05:11:22 PM Chanwoo Choi wrote:
>> This patch add new sysfs file to show previous accumulated data of CPU load
>> as following path. This sysfs file is used to judge the correct system state
>> or determine suitable system resource on user-space.
>> - /sys/devices/system/cpu/cpu0/cpufreq/stats/load_table
>>
>> This sysfs file include following data:
>> - Measurement point of time
>> - CPU frequency
>> - Per-CPU load
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Myungjoo Ham <myungjoo.ham@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>
> Well, first of all, there is the "one value per file" rule for sysfs attributes
> which is evidently violated by this code.

Even this was enclosed in CONFIG_CPU_FREQ_STAT_DETAILS,
so even sysfs isn't that bad as we already had something similar here.

> Second, this looks like a feature needed to handle one particular platform, so
> why do you want to add it to the cpufreq core?

I really felt this would be useful to others. They can track the load on
all cores for some time and that will really be useful. People can
understand their loads and system more easily with this patch in.
