From: mark gross <markgross@thegnar.org>
Subject: Re: [0/11] Energy-aware scheduling use-cases and scheduler issues
Date: Sun, 22 Dec 2013 08:28:22 -0800
Message-ID: <20131222162744.GB3250@mgross-Lenovo-Yoga-2-Pro>
References: <1387557951-21750-1-git-send-email-morten.rasmussen@arm.com>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:53926 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754288Ab3LVQ20 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 22 Dec 2013 11:28:26 -0500
Received: by mail-pa0-f41.google.com with SMTP id lf10so4537792pab.0
        for <linux-pm@vger.kernel.org>; Sun, 22 Dec 2013 08:28:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1387557951-21750-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: peterz@infradead.org, mingo@kernel.org, rjw@rjwysocki.net, markgross@thegnar.org, vincent.guittot@linaro.org, catalin.marinas@arm.com, linux-pm@vger.kernel.org

On Fri, Dec 20, 2013 at 04:45:40PM +0000, Morten Rasmussen wrote:
> Hi,
> 
> One of the requests from the scheduler maintainers at the Energy-aware
> Scheduling workshop at Kernel Summit this year was to provide plain text
> descriptions of use-cases (workloads) and system topologies. To get that
> moving I have written some short texts about some use-cases. In addition
> I described a list of issues that today prevent mainly the scheduler
> from achieving a good energy/performance balance in common use-cases.
> The follow-up emails are structured as follows:
> 
> 1-6:	Current issues related to energy/performance balance.
We have seen some of these issues as well.  Still from my point of view (which
may not be the most well informed) most of my issues are related to bad choices
on task migrations.

> 7-10:	Use-cases (overall behaviour and energy/performance goals)
I really like your break down of the use cases.  I like the Android focus as
well.  However; can we get some similar workload break downs for representive
data center workloads from other folks?

> 11:	DVFS example (for reference)
> 
> I'm hoping that this provides some of the background for why I'm
> interested in improving energy-awareness in the scheduler. I'm aware
> that the use-cases and issues/wishlist don't cover everyone's area of
> interest. Input is needed to fix that.
> 
> Comments and input are appreciated.
What is missing is more data or modeling tying the SoC charactoristics to
scheduling choices.  You have some (energy per instruction at different
P-states) but there are a lot more topological differences that are important
for proper scheduler choices.  Specifically shared L2's between some cores and
not others, or shared power rails, or if the cores are hyper threaded, or if
there are mutliple sockets.

--mark 
