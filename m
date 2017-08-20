From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH 1/2] PM: docs: Describe high-level PM strategies and
 sleep states
Date: Sun, 20 Aug 2017 20:23:26 +0200
Message-ID: <20170820182326.GA29793@wunner.de>
References: <3053012.25nKXRPPaK@aspire.rjw.lan>
 <2269280.4Jsh6Gf7ai@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2269280.4Jsh6Gf7ai@aspire.rjw.lan>
Sender: linux-doc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Linux Documentation <linux-doc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Aug 20, 2017 at 06:05:05PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Reorganize the power management part of admin-guide by adding a
> description of major power management strategies supported by the
> kernel (system-wide and working-state power management) to it and
> dividing the rest of the material into the system-wide PM and
> working-state PM chapters.
> 
> On top of that, add a description of system sleep states to the
> system-wide PM chapter.

Found no typos and no factual inaccuracies, the only thing that
irritated me a bit was the part about "working state" power
management:

> +The other strategy, referred to as the
> +:doc:`working-state power management <working-state>`, is based on adjusting the
> +power states of individual hardware components of the system, as needed, in the
> +working state.  In consequence, if this strategy is in use, the working state
> +of the system usually does not correspond to any particular physical
> +configuration of it, but can be treated as a metastate covering a range of
> +different power states of the system in which the individual components of it
> +can be either ``active`` (in use) or ``inactive`` (idle).  If they are active,
> +they have to be in power states allowing them to process data and to be accessed
> +by software.  In turn, if they are inactive, they are expected to be in
> +low-power states in which they may not be accessible.
> +
> +If all of the system components are active, the system as a whole is regarded as
> +``runtime active`` and that situation typically corresponds to the maximum power
> +draw (or maximum energy usage) of it.  If all of them are inactive, the system
> +as a whole is regarded as ``runtime idle`` which may be very close to a sleep

The code uses the terms pm_runtime_active() and pm_runtime_suspended(),
not "runtime idle".  Taking the ->runtime_idle callback as guidance,
"runtime idle" would mean that a component is runtime active, but idling
and could thus be transitioned to runtime suspended state.  However above
it says that if it's idle, it's already "in low-power states and may
not be accessible".  For someone reading this it may be difficult to
reconcile it with the terminology used in the code.

Otherwise,
Reviewed-by: Lukas Wunner <lukas@wunner.de>

Thanks,

Lukas
