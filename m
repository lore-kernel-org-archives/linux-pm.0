From: mark gross <markgross@thegnar.org>
Subject: Re: [1/11] issue 1: Missing power topology information in scheduler
Date: Sun, 22 Dec 2013 07:19:05 -0800
Message-ID: <20131222151905.GA3250@mgross-Lenovo-Yoga-2-Pro>
References: <1387557951-21750-1-git-send-email-morten.rasmussen@arm.com>
 <1387557951-21750-2-git-send-email-morten.rasmussen@arm.com>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:57406 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753843Ab3LVPTQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 22 Dec 2013 10:19:16 -0500
Received: by mail-pb0-f43.google.com with SMTP id rq2so4428116pbb.30
        for <linux-pm@vger.kernel.org>; Sun, 22 Dec 2013 07:19:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1387557951-21750-2-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: peterz@infradead.org, mingo@kernel.org, rjw@rjwysocki.net, markgross@thegnar.org, vincent.guittot@linaro.org, catalin.marinas@arm.com, linux-pm@vger.kernel.org

On Fri, Dec 20, 2013 at 04:45:41PM +0000, Morten Rasmussen wrote:
> The current mainline scheduler has no power topology information
> available to enable it to make energy-aware decisions. The energy cost
> of running a cpu at different frequencies and the energy cost of waking
> up another cpu are needed.
> 
> One example where this could be useful is audio on Android. With the
> current mainline scheduler it would utilize three cpus when active. Due
> to the size of the tasks it is still possible to meet the performance
> criteria when execution is serialized on a single cpu. Depending on the
> power topology leaving two cpus idle and running one longer may lead to
> energy savings if the cpus can be power-gated individually.
> 
> The audio performance requirements can be satisfied by most cpus at the
> lowest frequency. Video is a more interesting use-case due to its higher
> performance requirements. Running all tasks on a single cpu is likely to
> require a higher frequency than if the tasks are spread out across
> more cpus.
> 
> Running Android video playback on an ARM Cortex-A7 platform with 1, 2,
> and 4 cpus online has lead to the following power measurements
> (normalized):
> 
> video 720p (Android)
> cpus	power
> 1	1.59
> 2	1.00
> 4	1.10

I wonder what 3 CPU's shows?  Also, is this "display-on" power measured from
the battery?  The variance seems too big for a display-on measurement.

Here we seem to have a workload consisting of about 2 threads and where if we
use more than 2 CPUs' we pay a penalty for task migration.  There is no tie to
cpu L2 or power rail topology in this example.  From this data alown the
scheduler simply needs to avoid using more CPU's until the workload truely has
more threads.

What data do you have on the actual video workload in terms of threads?  My
guess is we are looking an audio decode and video decode processing.  Is this
video playback measurement including any rendering power or is all CPU?

I guess what I'm calling out is it is not clear what the right thing for the
scheduer to do as there is no physical model coupling power to SoC topology and
workload charactoristics.

I'll see if the folks at work who are hands on with similar KPI measureing can
share similar data.  (they read this list too) It may be easier for them to
share if we can agree on a normalization of the power data.  Say 100 "lumps"
(of coal) measured from the battery or psu output rails as the power burned on
a workload if run by booting with MAXCPUS=1 kernel command line?  (or should it
be measured from the SoC power rails?) That way we don't need to worry as much
about exposing competitive sensitive data in physical units.  FWIW I would go
with display off measurements (in "airplane mode"?) from the battery or
equivelent.

BTW remember my comment about power measuring being a path to hell?  Agreeing
on what workloads to measure, how to normalize, what to measure and from where
on a device, and how to report it (statistical data across multiple runs) is a
pain.  Details on screen on vrs off and reproducibilty of data by a third party
quickly come into play. 

--mark
 
> Restricting the number of cpus to one forces the frequency up to cope
> with the load, but the overall cpu load is only ~60% (busy %-age). Using
> two cpus keeps the frequency in the more power efficient range and gives
> a ~37% power reduction. With four cpus the power consumption is worse,
> likely due to the wake/idle transitions increase (~100%).
> 
> For this use-case it appears that the optimal busy %-age is ~30% (use
> two cpus). However, that is likely to vary depending on the use-case.
> 
> Proposed solution: Represent energy costs for each P-states and C-states
> in the topology to enable the scheduler to estimate the energy cost of
> the scheduling decisions. Coupled with P-state awareness that would
> allow the scheduler to avoid expensive high P-states.
> 
> 
