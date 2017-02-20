From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC][PATCH] cpufreq: User/admin documentation update and
 consolidation
Date: Mon, 20 Feb 2017 15:26:08 +0530
Message-ID: <20170220095608.GS21911@vireshk-i7>
References: <6949552.t0rZsBY3Lp@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6949552.t0rZsBY3Lp@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Linux Documentation <linux-doc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 18-02-17, 02:36, Rafael J. Wysocki wrote:
> +CPU Initialization
> +==================
> +


> +Next, the scaling driver's ``->init()`` callback is invoked with the policy
> +pointer of the new CPU passed to it as the argument.  If the policy object
> +pointed to by it is new

The callbacks don't need to do anything special for a new policy.
Infact, ->init() is only called for new policies or policies which
don't have any active CPUs as of now.

> , that callback is expected to initialize the performance
> +scaling hardware interface for the given CPU (or, more precisely, for the set of
> +CPUs sharing the hardware interface it belongs to, represented by its policy
> +object) and to set parameters of the policy, like the minimum and maximum
> +frequencies supported by the hardware, the table of available frequencies (if
> +the set of supported P-states is not a continuous range), and the mask of CPUs
> +that belong to the same policy.

Maybe we should explicitly mention that both online and offline CPUs
should be set in the mask ?

> That mask is then used by the core to populate
> +the policy pointers for all of the CPUs in it.
> +
> +The next major initialization step for a new policy object is to attach a
> +scaling governor to it (to begin with, that is the default scaling governor
> +determined by the kernel configuration, but it may be changed later
> +via ``sysfs``).  First, a pointer to the new policy object is passed to the
> +governor's ``->init()`` callback which is expected to initialize all of the
> +data structures necessary to handle the given policy and, possibly, to add
> +a governor ``sysfs`` interface to it.  Next, the governor is started by
> +invoking its ``->start()`` callback.

The rest of it looked good. Nice work Rafael :)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
