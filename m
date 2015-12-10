From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 1/3] cpufreq: intel_pstate: configurable algorithm to
 get target pstate
Date: Wed, 09 Dec 2015 16:19:43 -0800
Message-ID: <1449706783.3240.235.camel@spandruv-desk3.jf.intel.com>
References: <1449247235-29389-1-git-send-email-philippe.longepe@linux.intel.com>
	 <1449247235-29389-4-git-send-email-philippe.longepe@linux.intel.com>
	 <1449250542.3240.91.camel@spandruv-desk3.jf.intel.com>
	 <2117140.H2dcq623lF@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:46317 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754657AbbLJAUs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 9 Dec 2015 19:20:48 -0500
In-Reply-To: <2117140.H2dcq623lF@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Philippe Longepe <philippe.longepe@linux.intel.com>, linux-pm@vger.kernel.org, Philippe Longepe <philippe.longepe@intel.com>

On Thu, 2015-12-10 at 01:45 +0100, Rafael J. Wysocki wrote:
> On Friday, December 04, 2015 09:35:42 AM Srinivas Pandruvada wrote:
> > On Fri, 2015-12-04 at 17:40 +0100, Philippe Longepe wrote:
> > > From: Philippe Longepe <philippe.longepe@intel.com>
> > > 
> > Rafael meant signed-off not --author"". But it is fine for me.
> 
> OK
> 
> I'm assuming that it's OK to add your Acked-by: to the patches in this series.
Yes. 

We will have follow up patches in a different patchset as Thomas is
suggesting to select by ACPI and policy/command line.

Thanks,
Srinivas
> 
> Please let me know if that's not the case.
> 
> Thanks,
> Rafael
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


