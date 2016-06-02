From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] Revert "cpufreq: intel_pstate: Enable PPC enforcement for servers"
Date: Fri, 03 Jun 2016 00:00:31 +0200
Message-ID: <2942391.Y8jFCPZgiC@vostro.rjw.lan>
References: <1464828117-6534-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:65147 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932826AbcFBV4j (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jun 2016 17:56:39 -0400
In-Reply-To: <1464828117-6534-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-pm@vger.kernel.org

On Wednesday, June 01, 2016 05:41:57 PM Srinivas Pandruvada wrote:
> This change reverts
> 'commit 2b3ec7650584 ("cpufreq: intel_pstate: Enable PPC enforcement for
> servers")'
> 
> Intel P State uses max P-State as the max turbo P-State. This max P-State
> can be limited by ACPI _PSS table entry 0. After
> 'commit 9522a2ff9cde ("cpufreq: intel_pstate: Enforce _PPC limits")''
> the _PSS table entry[0] will be used to cap max performance for
> enterprise and performance server by default.
> 
> Even though this is correct processing, but when the performance results
> are compared with the version before the above commit, then obviously the
> results will be worse, if the _PSS table entry 0 is not the max turbo
> P-State.
> 
> So to minimize impact on performance, this revert will disable the default
> enforcement of ACPI _PSS and ACPI _PPC. So this feature can only only be
> explicitly activated by kernel command line
> intel_pstate=support_acpi_ppc
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Thanks for the revert, but I'm wondering if we can explore one more option.

Namely, if _PSS doesn't contain the turbo state, but we know the turbo range is
there from the CPU, we can still use it and interpret _PPC for the max state as
a permission to go into the turbo range.

What do you think?

Thanks,
Rafael

