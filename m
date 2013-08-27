From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [Query-CPUIdle]: Not much activity in C0 state
Date: Tue, 27 Aug 2013 15:53:01 +0530
Message-ID: <CAKohpo=OuYK7vhoG6a4REd-XuGMP63NTKhd8TWJmKo1R6rDp7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f48.google.com ([209.85.219.48]:41890 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753191Ab3H0KXD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Aug 2013 06:23:03 -0400
Received: by mail-oa0-f48.google.com with SMTP id o17so5047058oag.35
        for <linux-pm@vger.kernel.org>; Tue, 27 Aug 2013 03:23:02 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Suresh.Srinivasan@arm.com, Amit Kucheria <amit.kucheria@linaro.org>, Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>

Hi Guys,

I was trying to run following on my thinkpad:

watch -n1 cat /sys/devices/system/cpu/cpu*/cpuidle/state*/usage

I can see lots of activities on State 1-4, but not much on state 0..
I thought we should enter this state as soon as we come out to
non-idle state.. And so this count must be changing quite rapidly.

Is this a bug?

--
viresh
