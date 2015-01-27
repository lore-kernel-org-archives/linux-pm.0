From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 16/17] cpufreq: remove check for cpufreq_disabled() from cpufreq_cpu_{get|put}()
Date: Tue, 27 Jan 2015 09:17:09 +0530
Message-ID: <CAKohpokYdvH6teUU_sZm+dxVTe7E83Dkh2TqWKvtLXLfODNptA@mail.gmail.com>
References: <cover.1420181916.git.viresh.kumar@linaro.org>
	<49250a2946ff12500a5474eb9384c125b3ede23c.1420181916.git.viresh.kumar@linaro.org>
	<CAKohpomwDr2B+4ncjFyfem1o03gJ+N6bdDEDtdJTvreN6ivp9Q@mail.gmail.com>
	<1867080.dIa4P6m09i@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:60576 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236AbbA0DrK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 26 Jan 2015 22:47:10 -0500
Received: by mail-ob0-f176.google.com with SMTP id va2so11513085obc.7
        for <linux-pm@vger.kernel.org>; Mon, 26 Jan 2015 19:47:09 -0800 (PST)
In-Reply-To: <1867080.dIa4P6m09i@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Prarit Bhargava <prarit@redhat.com>, Saravana Kannan <skannan@codeaurora.org>

On 26 January 2015 at 06:09, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> It depended on [15/17] that I didn't apply.

That's all I wanted to know.

>> The WARN here might not be a good idea as this can be called by
>> users while cpufreq is disabled. But we don't need this check because
>> of the reasons I mentioned in commit log.
>
> I'm not sure which commit log are you talking about, this one or the [15/17] one?

This one.
