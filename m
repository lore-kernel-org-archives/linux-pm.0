From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 0/5] Intel P states enhancements
Date: Thu, 15 Oct 2015 02:31 +0200
Message-ID: <6382651.sBYEmNhDsd@vostro.rjw.lan>
References: <1444864323-4196-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58656 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753766AbbJOACR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 14 Oct 2015 20:02:17 -0400
In-Reply-To: <1444864323-4196-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: kristen.c.accardi@intel.com, rafael.j.wysocki@intel.com, len.brown@intel.com, linux-pm@vger.kernel.org

On Wednesday, October 14, 2015 04:11:58 PM Srinivas Pandruvada wrote:
> This series enhances Intel P state drivers with the following features:
> - Use Turbo Activation Ratio, when calculating max non turbo P state. This will
> show now correct percentage in turbo range
> - To calculate busy percent, the estimate is not correct when the max non turbo
> is limited by tar, hence using physical max non turbo as before.
> - Use ACPI _PSS and _PPC in intel_ptate driver.
> - Avoid calculation for P state control value when cpufreq policy requests
> frequency limits when matched in _PSS. Sometime calculations causes reduced
> control value in boundary conditions.
> Although they are independent patches, sending as series to help applying and
> testing.
> I appreciate review and testing on multiple platforms.
> 
> v4:
> - Dropped patch 1/6 : cpufreq: intel_p_state: Fix limiting turbo sub states
> Will submit it separately. The other patches are not dependent on this
> change.
> 
> v3:
> - Added function : convert_to_native_pstate_format to convert from
> perf_ctl value to pstate used ratios.
> - Fix bug identified by Rafael
> 
> v2:
> - When CONFIG_ACPI not defined, then acpi/processor.h can't be included.
> Also some variables will be unused when CONFIG_ACPI is not defined, so there
> were warnings. Fixed all these compile issues.
> 
> v1:
> - Change the command line option to "no_acpi"
> - changed kernel parameter documentation file and added "no_acpi" parameter
> - pr_debug prefixed with "intel_pstate" as suggested by Doug
> - Changed the logic to determine turbo freq in _PSS using odd/even convention,
> although this is the way it is defined in _PSS. But atleast two reviewers has
> questioned the source of this. This is defined usually in non public documents
> like BIOS writer guides. Now using the control field value to determine the
> turbo and non turbo max.
> - Fix the Kconfig dependency on ACPI for ACPI_PROCESSOR
> - multi line comment styles
> 
> v0:
> Base version
> 
> 
> Srinivas Pandruvada (5):
>   cpufreq: intel_pstate: get P1 from TAR when available
>   cpufreq: intel-pstate: Use separate max pstate for scaling
>   cpufreq: intel_pstate: Use ACPI perf configuration
>   Documentation: kernel_parameters for Intel P state driver
>   cpufreq: intel_pstate: Avoid calculation for max/min
> 
>  Documentation/kernel-parameters.txt |   3 +
>  arch/x86/include/asm/msr-index.h    |   7 +
>  drivers/cpufreq/Kconfig.x86         |   1 +
>  drivers/cpufreq/intel_pstate.c      | 276 ++++++++++++++++++++++++++++++++++--
>  4 files changed, 277 insertions(+), 10 deletions(-)

Series queued up for v4.4, thanks!

Rafael

