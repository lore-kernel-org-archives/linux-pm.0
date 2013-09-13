From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: cpufreq regression due to dceff5c "cpufreq: fix serialization
 issues with freq change notifiers"
Date: Fri, 13 Sep 2013 09:51:51 +0530
Message-ID: <CAKohponi51d1fPYMQsJ=ba1OAb9Rs2qUe+4gDqmK3bQoN4DVig@mail.gmail.com>
References: <5230ECB4.2090306@wwwdotorg.org>
	<13389782.ui3WXEBqQV@vostro.rjw.lan>
	<5230F46B.7070006@wwwdotorg.org>
	<CAKohpomqKgQumyEHQuuZ+SUHHULkJaAj5pgw1TFLVLsZzba_2Q@mail.gmail.com>
	<CAKohpo=pwSHF=WWmNfi6Mp3uKp-VdFki7+aXWdJNns=TSh_oGA@mail.gmail.com>
	<5231EB6C.6060504@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f41.google.com ([209.85.219.41]:46997 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915Ab3IMEVv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Sep 2013 00:21:51 -0400
Received: by mail-oa0-f41.google.com with SMTP id j6so722809oag.28
        for <linux-pm@vger.kernel.org>; Thu, 12 Sep 2013 21:21:51 -0700 (PDT)
In-Reply-To: <5231EB6C.6060504@wwwdotorg.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 12 September 2013 21:57, Stephen Warren <swarren@wwwdotorg.org> wrote:
> I'm not sure how relevant it is anymore given the discussion in response
> to the patches you posted, but I tested anyway. Let me know if there's
> anything else you need me to test; I'm a little confused with all the
> overlapping/alternate cpufreq patches flying by recently. git branches
> are easiest for me.

I believe everybody (hopefully leaving me) is confused :) ... There are so
many patches around same set of problems going on.. And most of them
came from me or Srivatsa, so I hope I know which ones to pick :)

And yes, thanks a lot for testing these..

> ==========
> Branch cpufreq-suspend-fix
> Commit 8f777cc "cpufreq: use correct values of cpus in
> __cpufreq_remove_dev_finish()"
>
> That works fine; I can both suspend/resume multiple times, and force
> cpufreq frequency, and everything appears to work.

Good.. So, it proves the theory that Myself and Srivatsa have discussed..
For single cluster platform my patch is fine and for multicluster ones
Srivatsa's patch is required..

> ==========
> Branch cpufreq-transition-ongoing
> Commit 42851e3 "cpufreq: fix notification serialization issues"
>
> Forcing cpufreq appears to work fine for me in this branch. However,
> suspend/resume has problems:
>
> 1) On the first resume, I see sysfs complaining:

Okay.. that's expected... Both sets are required for a perfect solution :)
These were two different bugs and so separate branches.
