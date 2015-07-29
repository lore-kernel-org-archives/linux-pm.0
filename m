From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: Add scaling frequency range support
Date: Wed, 29 Jul 2015 02:15:02 +0200
Message-ID: <6482671.TgGT1bSQ5Q@vostro.rjw.lan>
References: <55B6F7C3.8040405@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57643 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750871AbbG1XsH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jul 2015 19:48:07 -0400
In-Reply-To: <55B6F7C3.8040405@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pan Xinhui <xinhuix.pan@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "mnipxh@163.com" <mnipxh@163.com>, "yanmin_zhang@linux.intel.com" <yanmin_zhang@linux.intel.com>

On Tuesday, July 28, 2015 11:32:19 AM Pan Xinhui wrote:
> From: Pan Xinhui <xinhuix.pan@intel.com>
> 
> Userspace at most time do cpufreq tests very much inconveniently.
> Currently they have to echo min and max cpu freq separately like below:
> echo 480000  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
> echo 2240000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq

And why is this a problem?

> Add scaling_freq_range cpufreq attr to support userspace's demand.
> Therefore it's easier for testers to write readable scripts like below: 
> echo 480000-2240000 >
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_freq_range

I'm not sure I agree with the statement that this is more readable.

Not applied.

Thanks,
Rafael

