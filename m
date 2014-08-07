From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq, store_scaling_governor requires policy->rwsem to
 be held for duration of changing governors [v2]
Date: Thu, 7 Aug 2014 15:45:32 +0530
Message-ID: <CAKohpokLsqMMxMwh_p+kUL=He9-8cSws6onG6DCBNBVzz1=5TA@mail.gmail.com>
References: <53DB6B81.6050400@redhat.com>
	<53DBCBE8.6010809@codeaurora.org>
	<53DBE764.8050109@redhat.com>
	<53DBEC27.7050803@codeaurora.org>
	<CAKohpombG3Gj4mbm02vPNnAxzaRvQP7rb=iQ14dCFH4_+71H3w@mail.gmail.com>
	<53E0B657.4070007@redhat.com>
	<CAKohponxBdYEgY2oYuzmdaqfSRS8Uq8bZOzcb1QDmKO-z5ZBFQ@mail.gmail.com>
	<53E1556B.5070304@codeaurora.org>
	<CAKohpoky1-hj7cwnKc58svh8Z1Yas1=q4uJEK8mWcb56uqAcng@mail.gmail.com>
	<53E1FEE5.80305@redhat.com>
	<20140806150831.GB32301@codeaurora.org>
	<CAKohponBRn9mwpPMinsjqpHe3wTFj6aNpYk5gZaWDKht3bd5NQ@mail.gmail.com>
	<53E35122.3040806@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:53092 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754303AbaHGKPd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 Aug 2014 06:15:33 -0400
Received: by mail-oi0-f45.google.com with SMTP id e131so2531334oig.18
        for <linux-pm@vger.kernel.org>; Thu, 07 Aug 2014 03:15:33 -0700 (PDT)
In-Reply-To: <53E35122.3040806@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Saravana Kannan <skannan@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lenny Szubowicz <lszubowi@redhat.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 7 August 2014 15:42, Prarit Bhargava <prarit@redhat.com> wrote:
> That should have done it.  What are your CPUFREQ configs?

You can check the same .config I attached last time for that :)

CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_STAT_DETAILS=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y


Anyway, has anybody tried to test what I have been trying now?
@Prarit: You can try that on your x86 box as well, which has a
single cluster or group of CPUs sharing clock line.
