From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [1/11] issue 1: Missing power topology information in scheduler
Date: Mon, 30 Dec 2013 14:00:25 +0000
Message-ID: <20131230140024.GB2936@e103034-lin>
References: <1387557951-21750-1-git-send-email-morten.rasmussen@arm.com>
 <1387557951-21750-2-git-send-email-morten.rasmussen@arm.com>
 <20131222151905.GA3250@mgross-Lenovo-Yoga-2-Pro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.austin.arm.com ([217.140.110.23]:22424 "EHLO
	collaborate-mta1.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755892Ab3L3OA3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 Dec 2013 09:00:29 -0500
Content-Disposition: inline
In-Reply-To: <20131222151905.GA3250@mgross-Lenovo-Yoga-2-Pro>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: mark gross <markgross@thegnar.org>
Cc: "peterz@infradead.org" <peterz@infradead.org>, "mingo@kernel.org" <mingo@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Sun, Dec 22, 2013 at 03:19:05PM +0000, mark gross wrote:
> On Fri, Dec 20, 2013 at 04:45:41PM +0000, Morten Rasmussen wrote:
> > The current mainline scheduler has no power topology information
> > available to enable it to make energy-aware decisions. The energy cost
> > of running a cpu at different frequencies and the energy cost of waking
> > up another cpu are needed.
> > 
> > One example where this could be useful is audio on Android. With the
> > current mainline scheduler it would utilize three cpus when active. Due
> > to the size of the tasks it is still possible to meet the performance
> > criteria when execution is serialized on a single cpu. Depending on the
> > power topology leaving two cpus idle and running one longer may lead to
> > energy savings if the cpus can be power-gated individually.
> > 
> > The audio performance requirements can be satisfied by most cpus at the
> > lowest frequency. Video is a more interesting use-case due to its higher
> > performance requirements. Running all tasks on a single cpu is likely to
> > require a higher frequency than if the tasks are spread out across
> > more cpus.
> > 
> > Running Android video playback on an ARM Cortex-A7 platform with 1, 2,
> > and 4 cpus online has lead to the following power measurements
> > (normalized):
> > 
> > video 720p (Android)
> > cpus	power
> > 1	1.59
> > 2	1.00
> > 4	1.10
> 
> I wonder what 3 CPU's shows?  Also, is this "display-on" power measured from
> the battery?  The variance seems too big for a display-on measurement.

These are cpus-only measurements excluding gpu, dram, and other
peripherals. So yes, the relative total power saving is much smaller.

I don't have numbers for 3 cpus, but I will see if I can get them. Based
on the traces for 2 and 4 cpus my guess is that 3 cpus would be very
close to 2 cpus if not slightly better. The available parallelism seems
limited. The fourth cpu is hardly used and the third is only used for
short periods. 

> 
> Here we seem to have a workload consisting of about 2 threads and where if we
> use more than 2 CPUs' we pay a penalty for task migration.  There is no tie to
> cpu L2 or power rail topology in this example.  From this data alown the
> scheduler simply needs to avoid using more CPU's until the workload truely has
> more threads.

We have more threads in this workload (use-case 3), but rarely more than
two of them running (or runnable) simultaneously. I agree, that the
scheduler needs to avoid using more cpus than necessary.

The scheduler is particularly bad at this for thread patterns like the
ones observed for audio and video playback. Both have chains of threads
that wake up the next thread and then go to sleep. Since the current
thread continues to run for a moment after the next one has been woken
up, the wakee tends to be placed on a new cpu rather than waiting a few
tens of microseconds for the current cpu to be vacant.

            t0                     t0
cpu 0	===========            ===========
	         |             ^
                 v   t1        |
cpu 1	         ===========   |
                          |    |
                          v t2 |
cpu 2                     =======


> 
> What data do you have on the actual video workload in terms of threads?  My
> guess is we are looking an audio decode and video decode processing.  Is this
> video playback measurement including any rendering power or is all CPU?

As said above, these are cpus-only power numbers, so any gpu rendering is
excluded. The cpu workload includes both partial video decoding and
audio decoding. I'm not sure how much is offloaded to the gpu. use-case
3 has a short description of the main threads.

What sort of data are you looking for?

> 
> I guess what I'm calling out is it is not clear what the right thing for the
> scheduer to do as there is no physical model coupling power to SoC topology and
> workload charactoristics.
> 
> I'll see if the folks at work who are hands on with similar KPI measureing can
> share similar data.  (they read this list too) It may be easier for them to
> share if we can agree on a normalization of the power data.  Say 100 "lumps"
> (of coal) measured from the battery or psu output rails as the power burned on
> a workload if run by booting with MAXCPUS=1 kernel command line?  (or should it
> be measured from the SoC power rails?) That way we don't need to worry as much
> about exposing competitive sensitive data in physical units.  FWIW I would go
> with display off measurements (in "airplane mode"?) from the battery or
> equivelent.

Good question. System power (battery) seems right if you have your SoC
on a board which is fairly similar to the end product. That is not always
the case, so I tend to look at SoC power instead. How large is the
difference if the display is off and in airplane mode? Would it work if
we just state the measurement method when posting numbers?

Normalizing to single cpu (MAXCPUS=1 or equivalent) would work I think.

> 
> BTW remember my comment about power measuring being a path to hell?  Agreeing
> on what workloads to measure, how to normalize, what to measure and from where
> on a device, and how to report it (statistical data across multiple runs) is a
> pain.  Details on screen on vrs off and reproducibilty of data by a third party
> quickly come into play. 

Yes :) I don't think we necessarily have to have a fully specified test
suite. As long as each interested party makes sure to test whatever
patches that might eventually come out of this, we have the proof
whether it works or not. Third party reproducibility is more difficult.

Morten
