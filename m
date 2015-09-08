From: "Chen, Yu C" <yu.c.chen@intel.com>
Subject: RE: [PATCH] intel_pstate: prevent max_perf_pct < min_perf_pct
Date: Tue, 8 Sep 2015 07:27:51 +0000
Message-ID: <36DF59CE26D8EE47B0655C516E9CE6401D4A70BF@SHSMSX101.ccr.corp.intel.com>
References: <55E97973.1020301@jp.fujitsu.com>
 <36DF59CE26D8EE47B0655C516E9CE6401CB04B52@SHSMSX101.ccr.corp.intel.com>
 <55EE1B56.3010205@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:43843 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751803AbbIHH3n convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2015 03:29:43 -0400
In-Reply-To: <55EE1B56.3010205@jp.fujitsu.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Seiichi Ikarashi <s.ikarashi@jp.fujitsu.com>
Cc: "kristen@linux.intel.com" <kristen@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>

Hi, Seiichi

> -----Original Message-----
> From: Seiichi Ikarashi [mailto:s.ikarashi@jp.fujitsu.com]
> Sent: Tuesday, September 08, 2015 7:19 AM
> To: Chen, Yu C
> Cc: kristen@linux.intel.com; Wysocki, Rafael J; linux-pm@vger.kernel.org;
> Zhang, Rui
> Subject: Re: [PATCH] intel_pstate: prevent max_perf_pct < min_perf_pct
> 
> Hi, Yu
> 
> On 2015-09-07 18:00, Chen, Yu C wrote:
> > Hi, Seiichi
> >
> >> -----Original Message-----
> >> From: linux-pm-owner@vger.kernel.org [mailto:linux-pm-
> >> owner@vger.kernel.org] On Behalf Of Seiichi Ikarashi
> >> Sent: Friday, September 04, 2015 6:59 PM
> >> To: kristen@linux.intel.com; Wysocki, Rafael J
> >> Cc: linux-pm@vger.kernel.org
> >> Subject: [PATCH] intel_pstate: prevent max_perf_pct < min_perf_pct
> >>
> >> Add some value check to prevent a reversal, max_perf_pct <
> min_perf_pct.
> >>
> >> Signed-off-by: Seiichi Ikarashi <s.ikarashi@jp.fujitsu.com>
> >>
> > I guess a similar patch has been sent at:
> > https://patchwork.kernel.org/patch/6995461/
> 
> Yes, your patch looks better than mine from the point of view of covering
> intel_pstate_set_policy().
> 
> Still I have a question.
> Does your patch allow the following condition?
> 
>   limits.max_policy_pct > limits.min_perf_pct > limits.max_perf_pct >
> limits.min_policy_pct
> 

Thanks!  Seems my previous patch does not guarantee
 max_perf_pct >= min_perf_pct,  I think following logic would be better:
Step0:  normalize the user input to [min_policy, max_policy]
Step1: make sure max_perf_pct>= min_perf_pct

BTW,why I add step0 here is because we should not rely on user input, and
different policy might have different (min,max), for example,
max_policy_pct=40,min_policy_pct=30, and user input of 
echo 50 > min_sysfs_pct would make the final min_perf_pct to
50, it's not in legal policy scope, so...

Best Regards,
Yu

