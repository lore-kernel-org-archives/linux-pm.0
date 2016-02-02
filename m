From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH 11/19] cpufreq: assert policy->rwsem is held in
 __cpufreq_governor
Date: Tue, 2 Feb 2016 12:04:49 +0530
Message-ID: <20160202063449.GF31828@vireshk>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
 <20160112102025.GC1084@ubuntu>
 <56AC04E3.8090900@codeaurora.org>
 <1703921.2AHaiQoggk@vostro.rjw.lan>
 <20160201060943.GH13476@vireshk>
 <CAJZ5v0gzKkoKsbv_KG0qL-7=j4a3DU-nOTCG71fZcoumQ0UZUw@mail.gmail.com>
 <56AFBEE5.70501@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35800 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878AbcBBGew (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Feb 2016 01:34:52 -0500
Received: by mail-pa0-f54.google.com with SMTP id ho8so95809456pac.2
        for <linux-pm@vger.kernel.org>; Mon, 01 Feb 2016 22:34:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <56AFBEE5.70501@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Juri Lelli <juri.lelli@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Michael Turquette <mturquette@baylibre.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, dietmar.eggemann@arm.com

On 01-02-16, 12:24, Saravana Kannan wrote:
> On 02/01/2016 02:22 AM, Rafael J. Wysocki wrote:
> I'm not sure whose idea you are referring to. Viresh's (I don't think I saw
> his proposal) or mine.

http://git.linaro.org/people/viresh.kumar/linux.git/commit/57714d5b1778f2f610bcc5c74d85b29ba1cc1995

> Anyway, to explain my suggestion better, I'm proposing to make it so that we
> don't have a need for the AB BA locking. The only reason the governor needs
> to even grab the sysfs lock is to add/remove the sysfs attribute files.
> 
> That can be easily achieved if the policy struct has some "gov_attrs"
> field(s) that each governor populates. Then the framework just has to create
> them after POLICY_INIT is processed by the governor and remove them before
> POILICY_EXIT is sent to the governor.

What will that solve? It will stay exactly same then as well, as we
would be adding/removing these attributes from within the same
policy->rwsem ..

> That way, we also avoid having to worry about the gov attributes accessed by
> the show/store disappearing while the files are being accessed.

It can't happen. S_active lock should be taking care of that, isn't
it?

-- 
viresh
