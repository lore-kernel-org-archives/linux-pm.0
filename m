From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: cpufreq governors broken with !CONFIG_SMP?
Date: Fri, 6 May 2016 13:49:30 +0200
Message-ID: <20160506114930.GY3430@twins.programming.kicks-ass.net>
References: <20160505234922.GA14673@sky.smuckle.net>
 <1961527.dEtpL4HAvs@vostro.rjw.lan>
 <20160506002519.GB14673@sky.smuckle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:57709 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757956AbcEFLtb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 6 May 2016 07:49:31 -0400
Content-Disposition: inline
In-Reply-To: <20160506002519.GB14673@sky.smuckle.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Thu, May 05, 2016 at 05:25:19PM -0700, Steve Muckle wrote:
> On Fri, May 06, 2016 at 02:09:07AM +0200, Rafael J. Wysocki wrote:
> > In turn, schedutil should probably depend on CONFIG_SMP.
> 
> In the long term I wonder if it's worth putting PELT under its own
> separate feature or just removing #ifdef CONFIG_SMP.

Probably should do that eventually yeah. It started out with being
smp&&cgroup only, then we started using it for regular balancing and it
became smp, and since we're now wanting to use it for pretty much
everything we should just remove that.


