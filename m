From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Stop BUGing the system
Date: Fri, 19 Dec 2014 07:11:19 +0530
Message-ID: <CAKohponxz0=n5g9uBOt=JqBMdtdi9mnsrh34emxZDO=PJikVaw@mail.gmail.com>
References: <1418831495-26958-1-git-send-email-nm@ti.com>
	<CAKohponF61J6pWOtfg_722dQDbXtxrmt2dG+rKY7SKbE3xKGZg@mail.gmail.com>
	<20141218144915.GA29004@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:38361 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785AbaLSBlU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Dec 2014 20:41:20 -0500
Received: by mail-ob0-f177.google.com with SMTP id va2so9043640obc.8
        for <linux-pm@vger.kernel.org>; Thu, 18 Dec 2014 17:41:19 -0800 (PST)
In-Reply-To: <20141218144915.GA29004@kahuna>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Kevin Hilman <khilman@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 18 December 2014 at 20:19, Nishanth Menon <nm@ti.com> wrote:
> I can add "could be unstable" -> the point being there can be psuedo
> errors reported in the system - example - clock framework bugs. Dont
> just stop the boot. example: what if cpufreq was a driver module - it
> would not have rescued the system because cpufreq had'nt detected the
> logic - if we are going to force this on the system, we should probably
> not do this in cpufreq code, instead should be somewhere generic.
>
> While I do empathise (and had infact advocated in the past) of not
> favouring system attempting to continue at an invalid configuration and
> our attempt to rescue has failed - given that we cannot provide a
> consistent behavior (it is not a core system behavior) and potential of
> a false-postive (example clk framework or underlying bug), it should be
> good enough to "enhance" WARN to be "severe sounding enough" to
> flag it for developer and continue while keeping the system alive as
> much as possible.

There is no way out for the kernel to know if its a false positive or a real
bug. And in the worst case, it can screw up a platform completely.

I am still not sure if changing it to a WARN would be good idea.

@Rafael: Thoughts ?
