From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/4] CPUFreq: Implement per policy instances of governors
Date: Mon, 4 Feb 2013 17:54:18 +0530
Message-ID: <CAKohpok7RiJ_HKGi3r0vU26kNEtFKq==pMMoshT6Z2yy9ghemA@mail.gmail.com>
References: <cover.1359976493.git.viresh.kumar@linaro.org>
	<5808458.pvV2iHpBWm@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:42143 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754237Ab3BDMYV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 Feb 2013 07:24:21 -0500
Received: by mail-ob0-f174.google.com with SMTP id 16so6244578obc.5
        for <linux-pm@vger.kernel.org>; Mon, 04 Feb 2013 04:24:21 -0800 (PST)
In-Reply-To: <5808458.pvV2iHpBWm@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-dev@lists.linaro.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com

On 4 February 2013 17:47, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> Well, [1-2/4] are things I can take for v3.9 no problem.  The other two I'd
> wait for the next cycle to be honest.  We already have 30+ cpufreq patches
> scheduled for v3.9 and some of them quite subtle for that matter.

To be honest, i wanted to get these in 3.9 :) .
And that's why hurried on them and got this full series working in a single
day of work :)

Anyway, i understand your point and i also believe last two patches require some
testing/review before these getting in.

One important point i would like to highlight is:
governors directory would be present in cpu/cpu*/cpufreq/ now instead
of cpu/cpufreq/.
