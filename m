From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [0/11] Energy-aware scheduling use-cases and scheduler issues
Date: Mon, 30 Dec 2013 12:10:10 +0000
Message-ID: <20131230121010.GA2936@e103034-lin>
References: <1387557951-21750-1-git-send-email-morten.rasmussen@arm.com>
 <20131222162744.GB3250@mgross-Lenovo-Yoga-2-Pro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.austin.arm.com ([217.140.110.23]:39916 "EHLO
	collaborate-mta1.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755517Ab3L3MKO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 Dec 2013 07:10:14 -0500
Content-Disposition: inline
In-Reply-To: <20131222162744.GB3250@mgross-Lenovo-Yoga-2-Pro>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: mark gross <markgross@thegnar.org>
Cc: "peterz@infradead.org" <peterz@infradead.org>, "mingo@kernel.org" <mingo@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Sun, Dec 22, 2013 at 04:28:22PM +0000, mark gross wrote:
> On Fri, Dec 20, 2013 at 04:45:40PM +0000, Morten Rasmussen wrote:
> > Hi,
> > 
> > One of the requests from the scheduler maintainers at the Energy-aware
> > Scheduling workshop at Kernel Summit this year was to provide plain text
> > descriptions of use-cases (workloads) and system topologies. To get that
> > moving I have written some short texts about some use-cases. In addition
> > I described a list of issues that today prevent mainly the scheduler
> > from achieving a good energy/performance balance in common use-cases.
> > The follow-up emails are structured as follows:
> > 
> > 1-6:	Current issues related to energy/performance balance.
> We have seen some of these issues as well.  Still from my point of view (which
> may not be the most well informed) most of my issues are related to bad choices
> on task migrations.

Thanks for sharing your view. In my opinion, all of these issues relate
to task migration choices in one way or another. Lack of knowledge about
the power topology, frequency scaling, and different types of cores
(e.g. big.LITTLE) lead to bad migration choices.

> 
> > 7-10:	Use-cases (overall behaviour and energy/performance goals)
> I really like your break down of the use cases.  I like the Android focus as
> well.  However; can we get some similar workload break downs for representive
> data center workloads from other folks?

I don't have much insight into data center workloads, so I was hoping
for input from other folks.

> 
> > 11:	DVFS example (for reference)
> > 
> > I'm hoping that this provides some of the background for why I'm
> > interested in improving energy-awareness in the scheduler. I'm aware
> > that the use-cases and issues/wishlist don't cover everyone's area of
> > interest. Input is needed to fix that.
> > 
> > Comments and input are appreciated.
> What is missing is more data or modeling tying the SoC charactoristics to
> scheduling choices.  You have some (energy per instruction at different
> P-states) but there are a lot more topological differences that are important
> for proper scheduler choices.  Specifically shared L2's between some cores and
> not others, or shared power rails, or if the cores are hyper threaded, or if
> there are mutliple sockets.

Agree. This is the missing power topology information in the scheduler.
Power domain information (power rail sharing), including the cost of
waking up the first cpu and additional cpus in the domain, is required.
I guess multi-socket can be modelled that way too?

Most aspects of power management is implementation dependent on ARM, but
a typical big.LITTLE system looks like this:

      little  big
cpu   0   1   2   3
L1   |-| |-| |-| |-|
L2   |-----| |-----|

Two clusters (cpu groups), one little and one big. Cluster shared L2
cache. cpus have (depending on implementation) per cpu C-states and
deeper C-states apply to the entire cluster including the L2. P-states
often apply to the entire cluster (cpu 0-1 and 2-3 in this example).
Clusters may have 1-4 cpus each and doesn't have to be the same for all
clusters (e.g. ARM TC2 is 2+3).

Is that fundamentally different from the systems that you are working
on?

I was hoping that we could come up with a fairly simplistic energy model
that could guide the scheduling decisions based on data provided by the
vendor. I would start we something very simple and see far we can get
and which data that is necessary.

Morten
