From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 11/21] cpuidle: replace multiline statements with single
 line in cpuidle_idle_call()
Date: Thu, 26 Sep 2013 11:21:35 +0530
Message-ID: <CAKohpokM2JLyjq3cTw=GMDx8S+_fZU1qxxavKoZ-roC2PXukNA@mail.gmail.com>
References: <cover.1379779777.git.viresh.kumar@linaro.org>
	<c79ae2ab0a5a3946fcd0e68c855742f06f695f0f.1379779777.git.viresh.kumar@linaro.org>
	<52435DA4.3080204@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f45.google.com ([209.85.216.45]:34811 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024Ab3IZFvg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Sep 2013 01:51:36 -0400
Received: by mail-qa0-f45.google.com with SMTP id k4so4095128qaq.11
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2013 22:51:36 -0700 (PDT)
In-Reply-To: <52435DA4.3080204@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 26 September 2013 03:33, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> I splitted these lines because they have 81 cols.

>> -             clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER,
>> -                                &dev->cpu);
>> +             clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &dev->cpu);

This one comes in 80 columns

>> -             clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT,
>> -                                &dev->cpu);
>> +             clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &dev->cpu);

And this one in 79..

And so I did this change.. I have checked it again now..
