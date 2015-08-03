From: Radivoje Jovanovic <radivoje.jovanovic@linux.intel.com>
Subject: Re: [PATCH] thermal/cpu_cooling: remove local cooling state
 variable
Date: Mon, 3 Aug 2015 12:28:39 -0700
Message-ID: <20150803122839.5fb1d472@radivoje-desk2>
References: <1437516835-198750-1-git-send-email-radivoje.jovanovic@linux.intel.com>
	<9hhegjxbmqz.fsf@e105922-lin.cambridge.arm.com>
	<20150724100905.7e2e53f4@radivoje-desk2>
	<9hhoaiuap3m.fsf@e105922-lin.cambridge.arm.com>
	<20150730080541.GD31351@linux>
	<20150730132130.3c957267@radivoje-desk2>
	<20150731031841.GH17794@linux>
	<20150731083003.2f47ca5f@radivoje-desk2>
	<20150801113405.GL899@linux>
	<20150803031325.GU899@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:46329 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752171AbbHCTbX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 3 Aug 2015 15:31:23 -0400
In-Reply-To: <20150803031325.GU899@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Punit Agrawal <punit.agrawal@arm.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Radivoje Jovanovic <radivoje.jovanovic@intel.com>

On Mon, 3 Aug 2015 08:43:25 +0530
Viresh Kumar <viresh.kumar@linaro.org> wrote:

> On 01-08-15, 17:04, Viresh Kumar wrote:
> > On 31-07-15, 08:30, Radivoje Jovanovic wrote:
> 
> > > I agree with you that this patch is trivial for the current
> > > implementation since the notifier, as it is currently, will
> > > enforce cpu_cooling policy change at every CPUFREQ_ADJUST which
> > > would cause problems in our current implementation. In our
> > > implementation there is a cpufreq driver that will also change
> > > policies during CPUFREQ_ADJUST, once the request comes from the
> > > underlying FW so there would be a fight who gets there first
> > > since cpu_cooling will change the policy in CPUFREQ_ADJUST
> > > notifier_chain and the driver would do the same thing.
> 
> Okay, I had a detailed look this morning. cpufreq-notifier is designed
> this way that policy->max can be updated by drivers.. So, that's fine.
> 
> Now coming to your problem. So, there are two users: fw and thermal,
> which can affect policy->max. Now, both of them need to respect the
> limits set by others and only decrease policy->max from the notifier
> if it doesn't suit them.
> 
> I think it should work pretty well, unless you know you have triggered
> a corner case somewhere, that I am not able to imagine.
> 
> Please let me know in case I am wrong.
>
I will port the upstream driver to our platfrom, test for all corner
cases and update this thread once I have the data
Thank you for all the help
 

