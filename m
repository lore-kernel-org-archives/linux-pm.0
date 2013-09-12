From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: cpufreq regression due to dceff5c "cpufreq: fix serialization
 issues with freq change notifiers"
Date: Thu, 12 Sep 2013 06:01:55 +0530
Message-ID: <CAKohpo=pwSHF=WWmNfi6Mp3uKp-VdFki7+aXWdJNns=TSh_oGA@mail.gmail.com>
References: <5230ECB4.2090306@wwwdotorg.org>
	<13389782.ui3WXEBqQV@vostro.rjw.lan>
	<5230F46B.7070006@wwwdotorg.org>
	<CAKohpomqKgQumyEHQuuZ+SUHHULkJaAj5pgw1TFLVLsZzba_2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:65458 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103Ab3ILAb4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Sep 2013 20:31:56 -0400
Received: by mail-ob0-f181.google.com with SMTP id dn14so9279782obc.12
        for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2013 17:31:55 -0700 (PDT)
In-Reply-To: <CAKohpomqKgQumyEHQuuZ+SUHHULkJaAj5pgw1TFLVLsZzba_2Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 12 September 2013 05:56, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> For the record this is where this problem is getting discussed:
>
> https://lkml.org/lkml/2013/9/9/270

Can you help us a bit here? That patch was reverted for now but we are planning
to get it back and I have few patches which must help us here...

If you can try them on Tegra, it would be great!!
All are present here:

https://git.linaro.org/gitweb?p=people/vireshk/linux.git;a=shortlog;h=refs/heads/cpufreq-transition-ongoing
