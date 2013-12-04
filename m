From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH RFC 2/2] Documentation: arm: define DT C-states bindings
Date: Wed, 4 Dec 2013 15:20:10 +0000
Message-ID: <20131204152010.GC2323@e103592.cambridge.arm.com>
References: <1386001205-11978-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1386001205-11978-3-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1386001205-11978-3-git-send-email-lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-pm@vger.kernel.org, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Nicolas Pitre <nico@linaro.org>, Mark Hambleton <mark.hambleton@broadcom.com>, Grant Likely <grant.likely@linaro.org>, Charles Garcia Tobin <Charles.Garcia-Tobin@arm.com>, Rob Herring <rob.herring@calxeda.com>, linux-arm-kernel@lists.infradead.org, Hanjun Guo <hanjun.guo@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Dec 02, 2013 at 04:20:05PM +0000, Lorenzo Pieralisi wrote:
> ARM based platforms implement a variety of power management schemes that
> allow processors to enter at run-time low-power states, aka C-states
> in ACPI jargon. The parameters defining these C-states vary on a per-platform
> basis forcing the OS to hardcode the state parameters in platform
> specific static tables whose size grows as the number of platforms supported
> in the kernel increases and hampers device drivers standardization.
> 
> Therefore, this patch aims at standardizing C-state device tree bindings for
> ARM platforms. Bindings define C-state parameters inclusive of entry methods
> and state latencies, to allow operating systems to retrieve the
> configuration entries from the device tree and initialize the related
> power management drivers, paving the way for common code in the kernel
> to deal with power states and removing the need for static data in current
> and previous kernel versions.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> +

[...]

> +	- cpus

Because cpus is really a topology subtree, it might be good to have
different names.

To avoid confusion with Mark's affinity properties, maybe a different
word would be preferable instead of "affinity".

Maybe "topology" instead of "cpus", and "affected-topology" instead of
"affinity"?


cpufreq also has its concepts of "related" and "affected" cpus, which
tries to describe something similar (in all honesty, I always struggle
to remember which is which ... but if we were consistent with it, that
might help).

> +		Usage: Optional
> +		Value type: <phandle>
> +		Definition: If defined, the phandle points to a node in the
> +			    cpu-map[2] representing all CPUs on which C-state
> +			    is valid. If not present or system is UP, the
> +			    C-state has to be considered valid for all CPUs in
> +			    the system.
> +
> +	- affinity
> +		Usage: Optional
> +		Value type: <phandle>
> +		Definition: If defined, phandle points to a node in the
> +			    cpu-map[2] that represents all CPUs that are
> +			    affected (ie share) by the C-state and have to
> +			    be coordinated on C-state entry/exit. If not
> +			    present or system is UP, the C-state is local to
> +			    a CPU and need no coordination (ie it is a CPU
> +			    state, that does not require coordination with
> +			    other CPUs). If present, the affinity property
> +			    must contain a phandle to a cpu-map node that
> +			    represents a subset, possibly inclusive of the
> +			    CPUs described through the cpus property.

Can you elaborate on how cpus and affinity might be different?

The statement about "having to be coordainted" also feels a bit vague,
though I'm not sure how much we can usefully say here.

If we describe power domains more explicitly it might help with this,
because that could bring some description of what needs to be
coordinated.

> +
> +	- power-depth
> +		Usage: Required
> +		Value type: <u32>
> +		Definition: Integer value, starting from 2 (value 0 meaning
> +			    running and value 1 representing power depth of
> +			    wfi (C1)), that defines the level of depth of a
> +			    power state.
> +			    The system denotes power states with different
> +			    depths, an increasing value meaning less power
> +			    consumption and might involve powering down more
> +			    components.  Devices that are affected by
> +			    C-states entry must define the maximum power
> +			    depth supported in their respective device tree
> +			    bindings so that OSPM can take decision on how
> +			    to handle the device in question when the C-state
> +			    is entered. All devices (per-CPU or external) with
> +			    a power depth lower than the one defined in the
> +			    C-state entry stop operating when the C-state
> +			    is entered and action is required by OSPM to
> +			    guarantee their logic and memory content is saved
> +			    restored to guarantee proper functioning.

Any reason to use numbers instead of strings?

Strings make the DT more readable ... we would presumably only have to
parse this information once, so it shouldn't be an overhead, unless there
are hundreds of C-state nodes.

[...]

Cheers
---Dave
