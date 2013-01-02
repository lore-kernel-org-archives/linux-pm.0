From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3] Fix problem with cpufreq_ondemand or cpufreq_conservative
Date: Wed, 2 Jan 2013 09:27:03 +0530
Message-ID: <CAOh2x==UHVyAoUpjUHozA17edhyNJ05j69HDEw1pbZTs39CL2g@mail.gmail.com>
References: <50de4d88.M3WYPilXC8de/dVl%Larry.Finger@lwfinger.net>
	<2035804.da5iyiYDGE@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vb0-f42.google.com ([209.85.212.42]:45869 "EHLO
	mail-vb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752516Ab3ABD5F (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Jan 2013 22:57:05 -0500
In-Reply-To: <2035804.da5iyiYDGE@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Larry Finger <Larry.Finger@lwfinger.net>, fabio.baltieri@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Sat, Dec 29, 2012 at 6:57 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Friday, December 28, 2012 07:55:20 PM Larry Finger wrote:
>> V3 changes only Kconfig and Makefile and avoids creating a new module.
>
> OK, thanks for the patch!
>
> If you don't mind, I'll rename CONFIG_CPU_FREQ_GOVERNOR to
> CONFIG_CPU_FREQ_GOV_COMMON when applying it, though.

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
