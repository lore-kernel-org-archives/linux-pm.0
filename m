From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 02/14] cpufreq: stats: return -EEXIST when stats are
 already allocated
Date: Sun, 4 Jan 2015 08:48:21 +0530
Message-ID: <CAKohponEXJUbxUSJJJ_=2rwA28keSQ8L+NzhY7c_67ZCo+1aRg@mail.gmail.com>
References: <cover.1420177186.git.viresh.kumar@linaro.org>
	<85e5b1e6e871fdd8e7a80bba310a7b2948b52917.1420177186.git.viresh.kumar@linaro.org>
	<1494840.aVYkdgdxZS@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:64605 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751768AbbADDSW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 3 Jan 2015 22:18:22 -0500
Received: by mail-oi0-f52.google.com with SMTP id a3so13511047oib.11
        for <linux-pm@vger.kernel.org>; Sat, 03 Jan 2015 19:18:22 -0800 (PST)
In-Reply-To: <1494840.aVYkdgdxZS@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Prarit Bhargava <prarit@redhat.com>, Saravana Kannan <skannan@codeaurora.org>

On 4 January 2015 at 03:28, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Friday, January 02, 2015 11:16:39 AM Viresh Kumar wrote:
>> __cpufreq_stats_create_table() is called from:
>> - policy create notifier: stats will always be NULL here
>> - cpufreq_stats_init() calls it for all CPUs as cpufreq-stats can be initialized
>>   after cpufreq driver. Because CPUs share clock lines, 'stats' will be NULL
>>   here for the first cpu only and will return back for others.
>>
>> While we return for other CPUs, we don't return the right error value. We must
>> return -EEXIST, as that is the case here.
>
> What exactly is wrong with -EBUSY, then?

Its not that could would fail with EBUSY but this is what I thought.
Generally:
- Returning EBUSY means: we are busy right not try again. And that might be
immediate.
- Returning EEXIST means: We already have what you are trying to create and
there is no need to create it again, and so no more tries are required.

That's all..
