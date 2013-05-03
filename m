From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH, RFC 02/22] cpufreq: ARM_DT_BL_CPUFREQ needs ARM_CPU_TOPOLOGY
Date: Fri, 3 May 2013 18:31:52 +0530
Message-ID: <CAKohpon9qmowJ4PmL-nvnoaCzJSC-ZSPv8EUOyoFcTdRqNRwnw@mail.gmail.com>
References: <1367507786-505303-1-git-send-email-arnd@arndb.de>
	<1367507786-505303-3-git-send-email-arnd@arndb.de>
	<CAKohpomBKuaxk+sSF63cu6JKut1uV7J7Sj2o85c3wQ=fodx+Ow@mail.gmail.com>
	<5563691.6kxbXZTjH5@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:36217 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761723Ab3ECNBx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 May 2013 09:01:53 -0400
Received: by mail-ob0-f182.google.com with SMTP id eh20so1380510obb.27
        for <linux-pm@vger.kernel.org>; Fri, 03 May 2013 06:01:52 -0700 (PDT)
In-Reply-To: <5563691.6kxbXZTjH5@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org

On 3 May 2013 17:45, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> In this particular case I think it is OK to make both ARM_DT_BL_CPUFREQ and
> ARM_BIG_LITTLE_CPUFREQ depend on ARM_CPU_TOPOLOGY, because (in theory?) the
> latter may be set without the former (unless you want to make ARM_DT_BL_CPUFREQ
> depend on ARM_BIG_LITTLE_CPUFREQ, but then it may be kind of confusing to
> users).

ARM_BIG_LITTLE_CPUFREQ is the core cpufreq code for big LITTLE SoC's and every
other driver will be a glue providing ops to it. So, ARM_DT_BL_CPUFREQ
does depend
on ARM_BIG_LITTLE_CPUFREQ and that's why i added depends on
ARM_CPU_TOPOLOGY in ARM_BIG_LITTLE_CPUFREQ only and depends on
ARM_BIG_LITTLE_CPUFREQ in ARM_DT_BL_CPUFREQ.

But the problem is if ARM_DT_BL_CPUFREQ isn't selected then we still get
ARM_DT_BL_CPUFREQ enabled in menuconfig but a warning just before compilation.
Which Arnd pointed to..
