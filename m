From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH] powercap/rapl: add support for cpu model 0x3f
Date: Tue, 2 Sep 2014 10:41:51 -0700
Message-ID: <20140902104151.720c2ece@ultegra>
References: <20140814142608.5A9A38004B@prod-mail-relay07.akamai.com>
	<2447035.ZSkeOUhJMy@vostro.rjw.lan>
	<5405D4D9.7050103@akamai.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:49523 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754190AbaIBRpR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 2 Sep 2014 13:45:17 -0400
In-Reply-To: <5405D4D9.7050103@akamai.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jason Baron <jbaron@akamai.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "durgadoss.r@intel.com" <durgadoss.r@intel.com>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>

On Tue, 02 Sep 2014 10:31:53 -0400
Jason Baron <jbaron@akamai.com> wrote:

> Hi Rafael,
> 
> I think Jacob is ok with it:
> 
> https://lkml.org/lkml/2014/8/13/702
> 
> but he didn't give it a formal ack.
> 
Acked-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

> Thanks,
> 
> -Jason
> 
> On 09/01/2014 07:49 PM, Rafael J. Wysocki wrote:
> > On Thursday, August 14, 2014 02:26:08 PM Jason Baron wrote:
> >> I've confirmed that monitoring the package power usage as well as
> >> setting power limits appear to be working as expected. Supports
> >> the package and dram domains.
> >>
> >> Tested aginst cpu:
> >>
> >> Intel(R) Xeon(R) CPU E5-2650 v3 @ 2.30GHz
> >>
> >> Signed-off-by: Jason Baron <jbaron@akamai.com>
> > 
> > Has this been ACKed by Jacob?
> > 
> >> ---
> >>  drivers/powercap/intel_rapl.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/powercap/intel_rapl.c
> >> b/drivers/powercap/intel_rapl.c index b1cda6f..a362dcc 100644
> >> --- a/drivers/powercap/intel_rapl.c
> >> +++ b/drivers/powercap/intel_rapl.c
> >> @@ -953,6 +953,7 @@ static const struct x86_cpu_id rapl_ids[] = {
> >>  	{ X86_VENDOR_INTEL, 6, 0x3a},/* Ivy Bridge */
> >>  	{ X86_VENDOR_INTEL, 6, 0x3c},/* Haswell */
> >>  	{ X86_VENDOR_INTEL, 6, 0x3d},/* Broadwell */
> >> +	{ X86_VENDOR_INTEL, 6, 0x3f},/* Haswell */
> >>  	{ X86_VENDOR_INTEL, 6, 0x45},/* Haswell ULT */
> >>  	/* TODO: Add more CPU IDs after testing */
> >>  	{}
> >>
> > 
> 

[Jacob Pan]
