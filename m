From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC] cpufreq: governor: Set MIN_LATENCY_MULTIPLIER to 20
Date: Tue, 26 Feb 2013 16:20:07 +0530
Message-ID: <CAKohpomt+7YtD5s+XJ5-boCu_atCB0kHhuifWOGVwy7DqnBLPA@mail.gmail.com>
References: <472e2bac1fc4a2589651beddbfaf6da53500d12e.1361871582.git.viresh.kumar@linaro.org>
	<1993068.XZh8f6yGqe@skinner.arch.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f43.google.com ([209.85.219.43]:49918 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752562Ab3BZKuI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 Feb 2013 05:50:08 -0500
Received: by mail-oa0-f43.google.com with SMTP id l10so4809230oag.16
        for <linux-pm@vger.kernel.org>; Tue, 26 Feb 2013 02:50:08 -0800 (PST)
In-Reply-To: <1993068.XZh8f6yGqe@skinner.arch.suse.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: rjw@sisk.pl, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com

On 26 February 2013 16:14, Thomas Renninger <trenn@suse.de> wrote:
> Redefining MIN_LATENCY_MULTIPLIER shouldn't hurt that much, but this looks
> like a workaround.
> It only modifies the minimal sampling rate that userspace can set.

Yes.

> You would still need to set something from userspace to get the perfect
> sampling rate for this platform.

Yes. We still need to fix sampling rate from userspace.

> I wonder where the cpufreq driver does get the 1ms latency from?
> Is this value valid?
> The driver should return the correct latency, then there is no need for
> workarounds like this.

I am talking about ARM Vexpress TC2 (Test Chip) big LITTLE SoC here. Its
not a production type SoC and freq change is a bit slow here. Its really around
1 ms :)

But the real systems may not have this big of latency.

Anyway, how do you come to 100 value in your initial patch. What motivated you
to fix it there?

--
viresh
