From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 0/6] Intel P states enhancements
Date: Thu, 15 Oct 2015 01:50:08 +0200
Message-ID: <1731548.RAm8BY1duS@vostro.rjw.lan>
References: <1443567248-27134-1-git-send-email-srinivas.pandruvada@linux.intel.com> <3622861.qdYqraFPgE@vostro.rjw.lan> <1444864541.6025.2.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57181 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753717AbbJNXVZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 14 Oct 2015 19:21:25 -0400
In-Reply-To: <1444864541.6025.2.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: kristen.c.accardi@intel.com, rafael.j.wysocki@intel.com, len.brown@intel.com, linux-pm@vger.kernel.org

On Wednesday, October 14, 2015 04:15:41 PM Srinivas Pandruvada wrote:
> On Wed, 2015-10-14 at 02:52 +0200, Rafael J. Wysocki wrote:
> > On Tuesday, September 29, 2015 03:54:02 PM Srinivas Pandruvada wrote:
> > > This series enhances Intel P state drivers with the following
> > > features:
> > > - When max_perf_pct is reduced in turbo range, we can change the
> > > turbo ratios
> > > when platform allows. This is particularly useful in limiting
> > > performance with
> > > HWP where whole range is turbo.
> > > - Use Turbo Activation Ratio, when calculating max non turbo P
> > > state. This will
> > > show now correct percentage in turbo range
> > > - To calculate busy percent, the estimate is not correct when the
> > > max non turbo
> > > is limited by tar, hence using physical max non turbo as before.
> > > - Use ACPI _PSS and _PPC in intel_ptate driver.
> > > - Avoid calculation for P state control value when cpufreq policy
> > > requests
> > > frequency limits when matched in _PSS. Sometime calculations causes
> > > reduced
> > > control value in boundary conditions.
> > > Although they are independent patches, sending as series to help
> > > applying and
> > > testing.
> > > I appreciate review and testing on multiple platforms.
> > > 
> > > v3:
> > > - Added function : convert_to_native_pstate_format to convert from
> > > perf_ctl value to pstate used ratios.
> > > - Fix bug identified by Rafael
> > > 
> > > v2:
> > > - When CONFIG_ACPI not defined, then acpi/processor.h can't be
> > > included.
> > > Also some variables will be unused when CONFIG_ACPI is not defined,
> > > so there
> > > were warnings. Fixed all these compile issues.
> > > 
> > > v1:
> > > - Change the command line option to "no_acpi"
> > > - changed kernel parameter documentation file and added "no_acpi"
> > > parameter
> > > - pr_debug prefixed with "intel_pstate" as suggested by Doug
> > > - Changed the logic to determine turbo freq in _PSS using odd/even
> > > convention,
> > > although this is the way it is defined in _PSS. But atleast two
> > > reviewers has
> > > questioned the source of this. This is defined usually in non
> > > public documents
> > > like BIOS writer guides. Now using the control field value to
> > > determine the
> > > turbo and non turbo max.
> > > - Fix the Kconfig dependency on ACPI for ACPI_PROCESSOR
> > > - multi line comment styles
> > > 
> > > v0:
> > > Base version
> > > 
> > > Srinivas Pandruvada (6):
> > >   cpufreq: intel_p_state: Fix limiting turbo sub states
> > >   cpufreq: intel_pstate: get P1 from TAR when available
> > >   cpufreq: intel-pstate: Use separate max pstate for scaling
> > >   cpufreq: intel_pstate: Use ACPI perf configuration
> > >   Documentation: kernel_parameters for Intel P state driver
> > >   cpufreq: intel_pstate: Avoid calculation for max/min
> > 
> > I'm waiting for an update of [1/6].
> > 
> > If any of [2-6/6] do not depend on it (ie. can be applied
> > separately),
> > please let me know.
> Other patches don't depend on this, but will not apply because of line
> number change. I submitted v4 by removing this patch with Kristen's
> ACK. I will submit this patch 1/6 separately.

OK, thanks!

Rafael

