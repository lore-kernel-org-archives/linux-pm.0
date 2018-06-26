From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] Documentation: intel_pstate: Describe hwp_dynamic_boost
 sysfs knob
Date: Tue, 26 Jun 2018 16:40:27 -0700
Message-ID: <b15934467c635e273aec812c894481403481df9f.camel@linux.intel.com>
References: <306013127.TOMvMKusHN@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <306013127.TOMvMKusHN@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>
Cc: Linux Documentation <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 2018-06-26 at 17:20 +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Document the recently introduced hwp_dynamic_boost sysfs knob
> allowing user space to tell intel_pstate to use iowait boosting
> in the active mode with HWP enabled (to improve performance).
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
>  Documentation/admin-guide/pm/intel_pstate.rst |   11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> Index: linux-pm/Documentation/admin-guide/pm/intel_pstate.rst
> ===================================================================
> --- linux-pm.orig/Documentation/admin-guide/pm/intel_pstate.rst
> +++ linux-pm/Documentation/admin-guide/pm/intel_pstate.rst
> @@ -378,6 +378,17 @@ argument is passed to the kernel in the
>  	but it affects the maximum possible value of per-policy P-
> state	limits
>  	(see `Interpretation of Policy Attributes`_ below for
> details).
>  
> +``hwp_dynamic_boost``
> +	This attribute is only present if ``intel_pstate`` works in
> the
> +	`active mode with the HWP feature enabled <Active Mode With
> HWP_>`_ in
> +	the processor.  If set (equal to 1), it causes the minimum
> P-state limit
> +	to be increased dynamically for a short time whenever a task
> previously
> +	waiting on I/O is selected to run on a given logical CPU
> (the purpose
> +	of this mechanism is to improve performance).
> +
> +	This setting has no effect on logical CPUs whose minimum P-
> state limit
> +	is directly set to the highest non-turbo P-state or above
> it.
> +
>  .. _status_attr:
>  
>  ``status``
> 
