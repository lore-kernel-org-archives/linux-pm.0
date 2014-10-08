From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH V3 0/3] PM/CPU: Parallel enalbing nonboot cpus with
 resume devices
Date: Wed, 8 Oct 2014 22:54:41 +0200
Message-ID: <20141008205441.GJ4750@worktop.programming.kicks-ass.net>
References: <1411633925-9018-1-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:35642 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753439AbaJHUyu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Oct 2014 16:54:50 -0400
Content-Disposition: inline
In-Reply-To: <1411633925-9018-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: mingo@kernel.org, rafael.j.wysocki@intel.com, toshi.kani@hp.com, akpm@linux-foundation.org, ktkhai@parallels.com, fabf@skynet.be, laijs@cn.fujitsu.com, srivatsa.bhat@linux.vnet.ibm.com, ego@linux.vnet.ibm.com, srivatsa@mit.edu, viresh.kumar@linaro.org, todd.e.brandt@linux.intel.com, tipbot@zytor.com, wangyun@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>

On Thu, Sep 25, 2014 at 04:32:02PM +0800, Lan Tianyu wrote:
> This patchset is to parallel enabling nonboot cpus with resuming devices
> during system resume in order to accelerate S2RAM. From test result on
> a 8 logical core Haswell machine, system resume time reduces from 347ms
> to 217ms with this patchset.
> 
> In the current world, all nonboot cpus are enabled serially during system
> resume. System resume sequence is that boot cpu enables nonboot cpu one by
> one and then resume devices. Before resuming devices, there are few tasks
> assigned to nonboot cpus after they are brought up. This wastes cpu usage.
> 
> This patchset is to allow boot cpu to go forward to resume devices after
> bringing up one nonboot cpu and starting a thread. The thread will be in
> charge of bringing up other frozen cpus. The thread will be scheduled to
> the first online cpu to run . This makes enabling cpu2~x parallel with
> resuming devices.

So I feel we should really clean up hotplug before doing anything like
this. Its a trainwreck and just piling more and more hacks ontop isn't
going to help any.
