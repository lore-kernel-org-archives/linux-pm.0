From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [RFC v2 08/12] Documentation / cpu_domains: Describe CPU PM
 domains setup and governor
Date: Fri, 26 Feb 2016 11:43:29 -0800
Message-ID: <20160226194329.GZ28849@codeaurora.org>
References: <1455310238-8963-1-git-send-email-lina.iyer@linaro.org>
 <1455310238-8963-9-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1455310238-8963-9-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com
List-Id: linux-pm@vger.kernel.org

On 02/12, Lina Iyer wrote:
> diff --git a/Documentation/power/cpu_domains.txt b/Documentation/power/cpu_domains.txt
> new file mode 100644
> index 0000000..5fdc66d
> --- /dev/null
> +++ b/Documentation/power/cpu_domains.txt
> @@ -0,0 +1,79 @@
> +CPU PM domains
> +==============
> +
> +Newer CPUs are grouped in SoCs as clusters. A cluster in addition to the CPUs
> +may have caches, VFP and architecture specific power controller that share the

caches, floating point units, and other architecture specific
hardware that share resources when any of the CPUs are active.

> +resources when any of the CPUs are active. When the CPUs are in idle, some of
> +these cluster components may also idle. A cluster may also be nested inside
> +another cluster that provides common coherency interfaces to share data
> +between the clusters. The organization of such clusters and CPU may be
> +descibed in DT, since they are SoC specific.
> +
> +CPUIdle framework enables the CPUs to determine the sleep time and enter low
> +power state to save power during periods of idle. CPUs in a cluster may enter
> +and exit idle state independently of each other. During the time when all the
> +CPUs are in idle state, the cluster may safely put some of the shared
> +resources in their idle state. The time between the last CPU to enter idle and
> +the first CPU to wake up is the time available for the cluster to enter its
> +idle state.
> +
> +When SoCs power down the CPU during cpuidle, they generally have supplemental
> +hardware that can handshake with the CPU with a signal that indicates that the
> +CPU has stopped execution. The hardware is also responsible for warm booting
> +the CPU on receiving an interrupt. With cluster architecture, common resources

In a cluster architecture,

> +that are shared by the cluster may also be powered down by an external

shared by a cluster

> +microcontroller or a processor. The microcontroller may be programmed in
> +advance to put the hardware blocks in a low power state, when the last active
> +CPU sends the idle signal. When the signal is received, the microcontroller
> +may trigger the hardware blocks to enter their low power state. When an
> +interrupt to wakeup the processor is received, the microcontroller is
> +responsible for bringing up the hardware blocks to its active state, before
> +waking up the CPU. The timelines for such operations should be in the
> +acceptable range for the for CPU idle to get power benefits.

acceptable range for CPU idle to get power benefits.

> +
> +CPU PM Domain Setup
> +-------------------
> +
> +PM domains  are represented in the DT as domain consumers and providers. A

              ^ extra space here

> +device may have a domain provider and a domain provider may support multiple
> +domain consumers. Domains like clusters, may also be nested inside one
> +another. A domain that has no active consumer, may be powered off and any
> +resuming consumer would trigger the domain back to active. Parent domains may
> +be powered off when the child domains are powered off. The CPU cluster can be
> +fashioned as a PM domain. When the CPU devices are powered off, the PM domain
> +may be powered off.
> +
> +Device idle is reference counted by runtime PM. When there is no active need
> +for the device, runtime PM invokes callbacks to suspend the parent domain.
> +Generic PM domain (genpd) handles the hierarchy of devices, domains and the
> +reference counting of objects leading to last man down and first man up in the
> +domain. The CPU domains helper functions defines PM domains for each CPU
> +cluster and attaches the CPU devices to the respective PM domains.
> +
> +Platform drivers may use the following API to register their CPU PM domains.
> +
> +of_setup_cpu_pd() -
> +Provides a single step registration of the CPU PM domain and attach CPUs to
> +the genpd. Platform drivers may additionally register callbacks for power_on
> +and power_off operations for the PM domain.
> +
> +of_setup_cpu_pd_single() -
> +Define PM domain for a single CPU and attach the CPU to its domain.
> +
> +
> +CPU PM Domain governor
> +----------------------
> +
> +CPUs have an unique ability to determine their next wakeup. CPUs may wake up

a unique

> +for known timer interrupts and unknown interrupts from idle. Prediction
> +algorithms and heuristic based algorithms like the Menu governor for cpuidle
> +can determine the next wakeup of the CPU. However, determining the wakeup
> +across a group of CPUs is a tough problem to solve.
> +

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
