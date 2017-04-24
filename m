From: Mel Gorman <mgorman@techsingularity.net>
Subject: Re: Performance of low-cpu utilisation benchmark regressed severely
 since 4.6
Date: Mon, 24 Apr 2017 11:01:06 +0100
Message-ID: <20170424100106.tihasxnvnaotp6rw@techsingularity.net>
References: <20170410084117.rjh3mtdx7hd2i5ze@techsingularity.net>
 <000a01d2b9e6$393afef0$abb0fcd0$@net>
 <000301d2bb31$c0037790$400a66b0$@net>
 <8915951.Nmj3GAYbcQ@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from outbound-smtp07.blacknight.com ([46.22.139.12]:39792 "EHLO
        outbound-smtp07.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1166653AbdDXKBJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Apr 2017 06:01:09 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp07.blacknight.com (Postfix) with ESMTPS id 6FFD91C17C8
        for <linux-pm@vger.kernel.org>; Mon, 24 Apr 2017 11:01:07 +0100 (IST)
Content-Disposition: inline
In-Reply-To: <8915951.Nmj3GAYbcQ@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Doug Smythies <dsmythies@telus.net>, 'Rafael Wysocki' <rafael.j.wysocki@intel.com>, =?iso-8859-15?Q?'J=F6rg?= Otte' <jrg.otte@gmail.com>, 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, 'Linux PM' <linux-pm@vger.kernel.org>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>

On Sat, Apr 22, 2017 at 11:07:44PM +0200, Rafael J. Wysocki wrote:
> > By far, and with any code, I get the fastest elapsed time, of course next
> > to performance mode, but not by much, by limiting the test to only use
> > just 1 cpu: 1814.2 Seconds.
> 
> Interesting.
> 
> It looks like the cost is mostly related to moving the load from one CPU to
> another and waiting for the new one to ramp up then.
> 

We've had that before although arguably it means this will generally be a
problem on older CPUs or CPUs with high exit latencies. It goes back to the
notion that it should be possible to tune such platforms to optionally ramp
up fast and ramp down slowly withour resorting to the performance governor.

> I guess the workload consists of many small tasks that each start on new CPUs
> and cause that ping-pong to happen.
> 

Yes, not unusual in itself.

> > (performance governor, restated from a previous e-mail: 1776.05 seconds)
> 
> But that causes the processor to stay in the maximum sustainable P-state all
> the time, which on Sandy Bridge is quite costly energetically.
> 
> We can do one more trick I forgot about.  Namely, if we are about to increase
> the P-state, we can jump to the average between the target and the max
> instead of just the target, like in the appended patch (on top of linux-next).
> 
> That will make the P-state selection really aggressive, so costly energetically,
> but it shoud small jumps of the average load above 0 to case big jumps of
> the target P-state.
> 

So I took a look where we currently stand and it's not too bad if you
accept that decisions made for newer CPUs do not always suit old CPUs.
That's inevitable unfortunately.

gitsource
                                 4.5.0            4.11.0-rc7            4.11.0-rc7            4.11.0-rc7            4.11.0-rc7            4.11.0-rc7
                               vanilla               vanilla      pm-next-20170421           revert-v1r1        loadbased-v1r1          bigjump-v1r1
Elapsed min          1827.70 (  0.00%)     3747.00 (-105.01%)     2501.39 (-36.86%)     2908.72 (-59.15%)     2501.01 (-36.84%)     2452.83 (-34.20%)
Elapsed mean         1830.72 (  0.00%)     3748.80 (-104.77%)     2504.02 (-36.78%)     2917.28 (-59.35%)     2503.74 (-36.76%)     2454.15 (-34.05%)
Elapsed stddev          2.18 (  0.00%)        1.33 ( 39.22%)        1.84 ( 15.88%)        5.16 (-136.32%)        1.84 ( 15.69%)        0.91 ( 58.48%)
Elapsed coeffvar        0.12 (  0.00%)        0.04 ( 70.32%)        0.07 ( 38.50%)        0.18 (-48.30%)        0.07 ( 38.36%)        0.04 ( 69.03%)
Elapsed max          1833.91 (  0.00%)     3751.00 (-104.54%)     2506.46 (-36.67%)     2924.93 (-59.49%)     2506.78 (-36.69%)     2455.44 (-33.89%)

At this point, pm-next is better than a plain revert of the patch so
that's great. It's still not as good as 4.5.0 but it's perfectly possible
something else is now at play. Your patch that "jump to the average between
the target and the max" helps a little bit before but given that it
doesn't bring things in like with 4.5.0, I wouldn't worry too much about
it making the merge window. I'll see how things look on a range of
machines after the next merge window.
