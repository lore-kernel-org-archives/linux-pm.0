From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/4] CPUFreq Fixes for 3.9
Date: Thu, 7 Feb 2013 18:52:20 +0530
Message-ID: <CAKohponLrVG+ubf5Ok+7AvoWKRF16YLqUEWAU6hH7-H_R=r0Ow@mail.gmail.com>
References: <cover.1360232293.git.viresh.kumar@linaro.org>
	<2158181.aoVXdpLJe2@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:48792 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753067Ab3BGNWV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 Feb 2013 08:22:21 -0500
Received: by mail-ob0-f177.google.com with SMTP id wc18so2633677obb.8
        for <linux-pm@vger.kernel.org>; Thu, 07 Feb 2013 05:22:20 -0800 (PST)
In-Reply-To: <2158181.aoVXdpLJe2@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: valdis.kletnieks@vt.edu, artem.savkov@gmail.com, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-dev@lists.linaro.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, dirk.brandewie@gmail.com

On 7 February 2013 18:35, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> I think they all make sense, so applied to linux-next.
>
> I would prefer not to make any more changes to cpufreq before v3.9 from now on,
> except for fixes and maybe the Drik's patchset that I kind of scheduled for

Dirk :)

> merging into bleeding-edge later today.

I probably have few more for you. Some sparse warnings to be fixed for
Dirks work and an dangling exynos patch which is waiting for your reply :)

--
viresh
