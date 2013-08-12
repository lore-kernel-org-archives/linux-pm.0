From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/3] cpufreq: pmac64: speed up frequency switch
Date: Mon, 12 Aug 2013 11:07:48 +1000
Message-ID: <1376269668.32100.148.camel@pasglop>
References: <1374611079-28091-1-git-send-email-aaro.koskinen@iki.fi>
	 <9298823.WUCyZreP9q@vostro.rjw.lan> <1374614043.3916.84.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:49388 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755206Ab3HLBIP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 11 Aug 2013 21:08:15 -0400
In-Reply-To: <1374614043.3916.84.camel@pasglop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nick Piggin <npiggin@suse.de>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Aaro Koskinen <aaro.koskinen@iki.fi>

On Wed, 2013-07-24 at 07:14 +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2013-07-23 at 23:20 +0200, Rafael J. Wysocki wrote:
> > All looks good in the patchset from 10000 feet (or more), but I need
> > Ben to speak here.
> 
> I want to give it a quick spin on the HW here, I'll ack then. But yes,
> it looks good.

Seems to work here on the quad G5.

However, If I use on-demand, there's a huge latency of switch as far as
I can tell (about 10s) after I start/stop a bunch of CPU eaters... I
quite like how the userspace "powernowd" which I used to use switches
more aggressively.

Is that expected ?

Cheers,
Ben.


