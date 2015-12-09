From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH V6 1/3] cpufreq: intel_pstate: configurable algorithm to get target pstate
Date: Wed, 09 Dec 2015 15:34:56 +0100
Message-ID: <1536293.WV9n2YBamr@skinner>
References: <1449247235-29389-1-git-send-email-philippe.longepe@linux.intel.com> <3600864.XZTfEJ2ljK@skinner> <1449597743.3240.171.camel@spandruv-desk3.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38132 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750826AbbLIOe7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 9 Dec 2015 09:34:59 -0500
In-Reply-To: <1449597743.3240.171.camel@spandruv-desk3.jf.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>
Cc: Philippe Longepe <philippe.longepe@linux.intel.com>, linux-pm@vger.kernel.org

On Tuesday, December 08, 2015 10:02:23 AM Srinivas Pandruvada wrote:
> On Tue, 2015-12-08 at 16:27 +0100, Thomas Renninger wrote:
> > Hi,

> > There may be atoms clustered in server platforms and there may be
> > performance oriented CPU models built into laptops.
> 
> You mean BYT/CHT ATOM used as servers not Avaton, which has different
> id.

I have no idea.
And since Intel does not build mainboards anymore afaik or most
are built by OEMs, you also have no idea which CPUs end up on which kind
of system, right?

Default policy to go for performance, IO, workload based switching or
whatever tunables are modified should be, as you said, platform oriented.

So instead of calling the params:
silvermont, airmont, knl_params (knights landing, right?), whatever CPU...
Better call them:
laptop, io_optimized, performance params, whatever ...
And later set them according to pm_profile, not CPU id and still
provide something to override via userspace (I hope this is
what you want to do anyway, right?).
Even someone buys a tablet, there are Linux guys around who use them as
their homeserver in 2 years and they want to override...

Hm, in fact what you are doing is you implement your own governors/policies 
inside intel_pstate driver now, right?
If not done already, you should name it in dmesg what kind of algorithm is 
used (cmp with my patch). This makes it easier to find powersave
or performance regressions that will come up with the new default settings
and pin point them to intel_pstate.

Even better would be if intel_pstate could set it's own governor string.
Then there wouldn't be any mixture with ondemand or whatever.
But again.., those should not be named "airmont" policy/governor.

I had a quick look, but providing whole governors seem to be a lot overhead.
But with some luck you do not have to fill up whole structures you have to
pass to cpufreq_register_governor(..).

        Thomas
