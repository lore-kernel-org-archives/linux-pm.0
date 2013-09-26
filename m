From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4 1/2] cpuidle: simplify multiple driver support
Date: Thu, 26 Sep 2013 10:27:31 +0530
Message-ID: <CAKohponWjcmkku1NnMsYPJxPE9TvpJ-MQfs3EqJ1Vp4yFdXL0g@mail.gmail.com>
References: <1370641990-13884-1-git-send-email-daniel.lezcano@linaro.org>
	<CAKohponeFAc3EVEOO_Tpd61eE7UQmEmWfuaYd-VdR=UKnDFUgw@mail.gmail.com>
	<5242FAFC.8010905@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:45415 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795Ab3IZE5c (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Sep 2013 00:57:32 -0400
Received: by mail-qc0-f177.google.com with SMTP id x12so431152qcv.36
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2013 21:57:31 -0700 (PDT)
In-Reply-To: <5242FAFC.8010905@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, Len Brown <lenb@kernel.org>

On 25 September 2013 20:32, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> Where is it wrong in design ? If the multiple driver support is enabled
> in the kernel but the driver handles all the cpu, it works.

Yeah It works but I don't really support two separate code paths based
on how kernel is compiled.. For example:
Consider any ARM system which doesn't need multiple drivers support
and so must be using the non-per-cpu variable for holding drivers pointer..

Now the same driver is included as part of a multiplatform kernel and
now the same driver/platform is using the per-cpu variables for storing
driver pointer.. Even sysfs will have files with name "driver" to print
drivers name for CPUs..

I know it doesn't break anything but it didn't looked good design wise to me..
