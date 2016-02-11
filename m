From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V4 3/7] cpufreq: Remove cpufreq_governor_lock
Date: Thu, 11 Feb 2016 10:53:43 +0100
Message-ID: <CAJZ5v0g=pu=KXHVjfiOdOca18CkNenzCQPb9a7cMdsy60fdwmw@mail.gmail.com>
References: <cover.1454988792.git.viresh.kumar@linaro.org>
	<c8245033beab5fd4601439a9ef1b2d9dd802f9e4.1454988792.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33685 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959AbcBKJxp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Feb 2016 04:53:45 -0500
In-Reply-To: <c8245033beab5fd4601439a9ef1b2d9dd802f9e4.1454988792.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Juri Lelli <juri.lelli@arm.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, Feb 9, 2016 at 4:46 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> We used to drop policy->rwsem just before calling __cpufreq_governor()
> in some cases earlier and so it was possible that __cpufreq_governor()
> runs concurrently via separate threads.
>
> In order to guarantee valid state transitions for governors,
> 'governor_enabled' was required to be protected using some locking and
> we created cpufreq_governor_lock for that.
>
> But now, __cpufreq_governor() is always called from within policy->rwsem
> held and so 'governor_enabled' is protected against races even without
> cpufreq_governor_lock.
>
> Get rid of the extra lock now.

This one looks good, but depends on the [2/7].

Thanks,
Rafael
