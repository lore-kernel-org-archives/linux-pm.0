From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 07/13] cpufreq: imx6q: call CPUFREQ_POSTCHANGE notfier in
 error cases
Date: Thu, 20 Jun 2013 10:52:28 +0800
Message-ID: <20130620025227.GC19896@S2101-09.ap.freescale.net>
References: <cover.1371630975.git.viresh.kumar@linaro.org>
 <ca85a6fad679b2e305a21893811474f5802f837e.1371630975.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from va3ehsobe003.messaging.microsoft.com ([216.32.180.13]:39335
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935534Ab3FTCyk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jun 2013 22:54:40 -0400
Content-Disposition: inline
In-Reply-To: <ca85a6fad679b2e305a21893811474f5802f837e.1371630975.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, arvind.chauhan@arm.com, dave.martin@arm.com

On Wed, Jun 19, 2013 at 02:23:01PM +0530, Viresh Kumar wrote:
> PRECHANGE and POSTCHANGE notifiers must be called in groups, i.e either both
> should be called or both shouldn't be.
> 
> In case we have started PRECHANGE notifier and found an error, we must call
> POSTCHANGE notifier with freqs.new = freqs.old to guarantee that sequence of
> calling notifiers is complete.
> 
> This patch fixes it.
> 
> This also moves PRECHANGE notifier down so that we call it just before starting
> frequency transition.
> 
> Cc: Shawn Guo <shawn.guo@linaro.org>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

