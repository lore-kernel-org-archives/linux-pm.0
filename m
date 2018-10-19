From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 0/3] cpufreq: intel_pstate: Base frequency attribute
Date: Fri, 19 Oct 2018 12:17:24 +0200
Message-ID: <2009466.qjoMG8mNOh@aspire.rjw.lan>
References: <20181015173721.66147-1-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181015173721.66147-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: corbet@lwn.net, lenb@kernel.org, viresh.kumar@linaro.org, robert.moore@intel.com, erik.schmauss@intel.com, juri.lelli@redhat.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, devel@acpica.org, pprakash@codeaurora.org, george.cherian@cavium.com
List-Id: linux-pm@vger.kernel.org

On Monday, October 15, 2018 7:37:18 PM CEST Srinivas Pandruvada wrote:
> This series presents base frequency to cpufreq sysfs when intel_pstate
> is in use in HWP mode.
> 
> Changes:
> v4:
> - Documentation update only as suggested by Rafael
> 
> v3:
> - Update documentation
> v2
> - Removed guaranteed attribute addition to acpi_cppc sysfs
> - Using the cppc_acpi interface to get base frequency and present
> 
> Srinivas Pandruvada (3):
>   ACPI / CPPC: Add support for guaranteed performance
>   cpufreq: intel_pstate: Add base_frequency attribute
>   Documentation: intel_pstate: Add base_frequency information
> 
>  Documentation/admin-guide/pm/intel_pstate.rst |  7 ++++
>  drivers/acpi/cppc_acpi.c                      |  8 +++-
>  drivers/cpufreq/intel_pstate.c                | 38 +++++++++++++++++++
>  include/acpi/cppc_acpi.h                      |  1 +
>  4 files changed, 52 insertions(+), 2 deletions(-)
> 
> 

All three applied, thanks!
