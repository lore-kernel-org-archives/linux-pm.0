From: "Chen, Yu C" <yu.c.chen@intel.com>
Subject: RE: [PATCH] intel_pstate: prevent max_perf_pct < min_perf_pct
Date: Mon, 7 Sep 2015 09:00:39 +0000
Message-ID: <36DF59CE26D8EE47B0655C516E9CE6401CB04B52@SHSMSX101.ccr.corp.intel.com>
References: <55E97973.1020301@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:28181 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751018AbbIGJBY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Sep 2015 05:01:24 -0400
In-Reply-To: <55E97973.1020301@jp.fujitsu.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Seiichi Ikarashi <s.ikarashi@jp.fujitsu.com>, "kristen@linux.intel.com" <kristen@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>

Hi, Seiichi

> -----Original Message-----
> From: linux-pm-owner@vger.kernel.org [mailto:linux-pm-
> owner@vger.kernel.org] On Behalf Of Seiichi Ikarashi
> Sent: Friday, September 04, 2015 6:59 PM
> To: kristen@linux.intel.com; Wysocki, Rafael J
> Cc: linux-pm@vger.kernel.org
> Subject: [PATCH] intel_pstate: prevent max_perf_pct < min_perf_pct
> 
> Add some value check to prevent a reversal, max_perf_pct < min_perf_pct.
> 
> Signed-off-by: Seiichi Ikarashi <s.ikarashi@jp.fujitsu.com>
> 
I guess a similar patch has been sent at:
https://patchwork.kernel.org/patch/6995461/


Best Regards,
Yu
