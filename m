From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [RFC PATCH v2 0/4] CPUs capacity information for heterogeneous
 systems
Date: Fri, 15 Jan 2016 11:50:31 -0800
Message-ID: <56994D87.6000709@linaro.org>
References: <1452262172-31861-1-git-send-email-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452262172-31861-1-git-send-email-juri.lelli@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>, linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, peterz@infradead.org, vincent.guittot@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@arm.linux.org.uk, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, broonie@kernel.org
List-Id: linux-pm@vger.kernel.org

On 01/08/2016 06:09 AM, Juri Lelli wrote:
>  2. Dynamic profiling at boot (v2)
> 
>     pros: - does not require a standardized definition of capacity
>           - cannot be incorrectly tuned (once benchmark is fixed)
>           - does not require user/integrator work
> 
>     cons: - not easy to come up with a clean solution, as it seems interaction
>             with several subsystems (e.g., cpufreq) is required
>           - not easy to agree upon a single benchmark (that has to be both
>             representative and simple enough to run at boot)
>           - numbers might (and do) vary from boot to boot

An important additional con that was mentioned earlier IIRC was the
additional boot time required for the benchmark. Perhaps there could be
a kernel command line argument to bypass the benchmark if it is known
that predetermined values will be provided via sysfs later?

Though there may be another issue with that as mentioned below.

>  3. sysfs (v1)
> 
>     pros: - clean and super easy to implement
>           - values don't require to be physical properties, defining them is
>             probably easier
> 
>     cons: - CPUs capacity have to be provided after boot (by some init script?)
>           - API is modified, still some discussion/review is needed
>           - values can still be incorrectly used for runtime tuning purposes

Initializing the values via userspace init will cause more of the boot
process to run with incorrect CPU capacity values. Boot times may be
increased with tasks running on suboptimal CPUs. Such increases may also
not be deterministic.

Extending the kernel command line idea above, perhaps capacity values
could be provided there as well, similar to the lpj parameter? That has
scalability issues though if there's a huge highly heterogeneous platform...

DT solves these issues and would be the perfect place for this - we are
defining the compute capacity of a CPU which is a property of the
hardware. However there are a couple things forcing us to compromise.
One is that the amount and detail of information required to adequately
capture the computational abilities of a CPU across all possible
workloads seem onerous to collect and enumerate. The second is that even
if we were willing to undertake that, CPU vendors probably won't be
forthcoming with that information.

Despite this DT still seems to me like the best way to go. At their
heart these are properties of the hardware, even if we can't specify
them as such per se because of the problems above. The capacity would
have to be defined as a relative value among CPUs. And while it's true
it may be abused for tuning purposes, that's true of any strategy.
Certainly the sysfs strategy and even if only a dynamic option is
provided, it is guaranteed to be hacked by platform vendors.

thanks,
Steve
