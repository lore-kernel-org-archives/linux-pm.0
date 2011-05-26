From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCH 2/3] introduce intel_rapl driver
Date: Thu, 26 May 2011 11:55:39 +0100
Message-ID: <20110526105527.GA27748__28165.4183789671$1306423638$gmane$org@console-pimps.org>
References: <1306398857.2207.157.camel@rui>
 <1306403003.1200.41.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1306403003.1200.41.camel@twins>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Peter Zijlstra <a.p.zijlstra@chello.nl>, Zhang Rui <rui.zhang@intel.com>
Cc: ming.m.lin@intel.com, LKML <linux-kernel@vger.kernel.org>, acme@redhat.com, linux-pm <linux-pm@lists.linux-foundation.org>, mingo@elte.hu
List-Id: linux-pm@vger.kernel.org

On Thu, May 26, 2011 at 11:43:23AM +0200, Peter Zijlstra wrote:
>
> That's just wrong.. the reason you're wanting to have this timer is to
> avoid the RAPL MSRs from overflowing and you loosing offsets, right?
> 
> But the above is actually forcing the event to create samples on a
> totally unrelated time base.
> 
> RAPL should fail to create a sampling event since it doesn't have the
> capability to trigger overflow interrupts based on its events.
> 
> If you want a timer, add one, but don't do this.
> 
> If you expect you actually want to sample, use this event as part of a
> group and add a sampling event in there and use PERF_FORMAT_GROUP, Matt
> was working on patches to make perf-record capable of this.

Yep, I have some unfinished patches around here somewhere...

*rummage*

OK, they're in this repository on the perf/group-events branch,

    git://git.kernel.org/pub/scm/linux/kernel/git/mfleming/sh-2.6.git

Obviously since I last touched them in November of last year they're
more than likely not going to apply cleanly to tip, and perhaps more
importantly, I don't think I ever submitted them to LKML for review.

Rui, I'll try to look at your patch series over the weekend and get my
sampling patches into a state where they can be submitted for review
and used by the intel_rapl driver. Does that sound OK?

Or if you want to take a more proactive approach, you're welcome to
finish and submit them ;-)

--
Matt Fleming, Intel Open Source Technology Center
