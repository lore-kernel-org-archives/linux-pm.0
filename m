From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH RFC 18/27] drivers: cpu-pd: Add PM Domain governor for
 CPUs
Date: Fri, 20 Nov 2015 16:21:11 +0000
Message-ID: <20151120162111.GA17930@red-moon>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
 <1447799871-56374-19-git-send-email-lina.iyer@linaro.org>
 <20151118184245.GA28755@red-moon>
 <7hk2pdsg2a.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:47238 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759225AbbKTQUN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 20 Nov 2015 11:20:13 -0500
Content-Disposition: inline
In-Reply-To: <7hk2pdsg2a.fsf@deeprootsystems.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: Lina Iyer <lina.iyer@linaro.org>, ulf.hansson@linaro.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, ahaslam@baylibre.com, mtitinger@baylibre.com

On Thu, Nov 19, 2015 at 03:52:13PM -0800, Kevin Hilman wrote:
> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> writes:
> 
> > On Tue, Nov 17, 2015 at 03:37:42PM -0700, Lina Iyer wrote:
> >> A PM domain comprising of CPUs may be powered off when all the CPUs in
> >> the domain are powered down. Powering down a CPU domain is generally a
> >> expensive operation and therefore the power performance trade offs
> >> should be considered. The time between the last CPU powering down and
> >> the first CPU powering up in a domain, is the time available for the
> >> domain to sleep. Ideally, the sleep time of the domain should fulfill
> >> the residency requirement of the domains' idle state.
> >> 
> >> To do this effectively, read the time before the wakeup of the cluster's
> >> CPUs and ensure that the domain's idle state sleep time guarantees the
> >> QoS requirements of each of the CPU, the PM QoS CPU_DMA_LATENCY and the
> >> state's residency.
> >
> > To me this information should be part of the CPUidle governor (it is
> > already there), we should not split the decision into multiple layers.
> >
> > The problem you are facing is that the CPUidle governor(s) do not take
> > cross cpus relationship into account, I do not think that adding another
> > decision layer in the power domain subsystem helps, you are doing that
> > just because adding it to the existing CPUidle governor(s) is invasive.
> >
> > Why can't we use the power domain work you put together to eg disable
> > idle states that share multiple cpus and make them "visible" only
> > when the power domain that encompass them is actually going down ?
> >
> > You could use the power domains information to detect states that
> > are shared between cpus.
> >
> > It is just an idea, what I am saying is that having another governor in
> > the power domain subsytem does not make much sense, you split the
> > decision in two layers while there is actually one, the existing
> > CPUidle governor and that's where the decision should be taken.
> 
> Hmm, considering "normal" devices in "normal" power domains, and
> following the same logic, the equivalent would be to say that the
> decision to gate the power domain belongs to the individual drivers
> in the domain instead of in the power domain layer.  I disagree.
> 
> IMO, there are different decision layers because there are different
> hardware layers.  Devices (including CPUs) are reponsible for handling
> device-local idle states, based on device-local conditions (e.g. local
> wakeups, timers, etc.)  and domains are responsible for handling
> decisions based on conditions of the whole domain.

After going through the series for the second time (it is quite complex and
should probably be split) I understood your point of view and I agree with
it, I will review it more in-depth to understand the details.

One thing that is not clear to me is how we would end up handling
cluster states in platform coordinated mode with this series (and
I am actually referring to the data we would add in the idle-states,
such as min-residency). I admit that data for cluster states at present
is not extremely well defined, because we have to add latencies for
the cluster state even if the state itself may be just a cpu one (by
definition a cluster state is entered only if all cpus in the cluster
enter it, otherwise FW or power controller demote them automatically).

I would like to take this series as an opportunity to improve the
current situation in a clean way (and without changing the bindings,
only augmenting them).

On a side note, I think we should give up the concept of cluster
entirely, to me they are just a group of cpus, I do not see any reason
why we should group cpus this way and I do not like the dependencies
of this series on the cpu-map either, I do not see the reason but I
will go through code again to make sure I am not missing anything.

To be clear, to me the cpumask should be created with all cpus belonging
in a given power domain, no cluster dependency (and yes the CPU PM
notifiers are not appropriate at present - eg on
cpu_cluster_pm_{enter/exit} we save and restore the GIC distributor state
even on multi-cluster systems, that's useless and has no connection with
the real power domain topology at all, so the concept of cluster as it
stands is shaky to say the least).

Thanks,
Lorenzo
