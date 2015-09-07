From: Seiichi Ikarashi <s.ikarashi@jp.fujitsu.com>
Subject: Re: [PATCH] intel_pstate: prevent max_perf_pct < min_perf_pct
Date: Tue, 8 Sep 2015 08:18:46 +0900
Message-ID: <55EE1B56.3010205@jp.fujitsu.com>
References: <55E97973.1020301@jp.fujitsu.com>
 <36DF59CE26D8EE47B0655C516E9CE6401CB04B52@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mgwym04.jp.fujitsu.com ([211.128.242.43]:30194 "EHLO
	mgwym04.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197AbbIGXUn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Sep 2015 19:20:43 -0400
Received: from g01jpfmpwyt03.exch.g01.fujitsu.local (g01jpfmpwyt03.exch.g01.fujitsu.local [10.128.193.57])
	by yt-mxq.gw.nic.fujitsu.com (Postfix) with ESMTP id DFF75AC0190
	for <linux-pm@vger.kernel.org>; Tue,  8 Sep 2015 08:20:39 +0900 (JST)
In-Reply-To: <36DF59CE26D8EE47B0655C516E9CE6401CB04B52@SHSMSX101.ccr.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: "kristen@linux.intel.com" <kristen@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>

Hi, Yu

On 2015-09-07 18:00, Chen, Yu C wrote:
> Hi, Seiichi
> 
>> -----Original Message-----
>> From: linux-pm-owner@vger.kernel.org [mailto:linux-pm-
>> owner@vger.kernel.org] On Behalf Of Seiichi Ikarashi
>> Sent: Friday, September 04, 2015 6:59 PM
>> To: kristen@linux.intel.com; Wysocki, Rafael J
>> Cc: linux-pm@vger.kernel.org
>> Subject: [PATCH] intel_pstate: prevent max_perf_pct < min_perf_pct
>>
>> Add some value check to prevent a reversal, max_perf_pct < min_perf_pct.
>>
>> Signed-off-by: Seiichi Ikarashi <s.ikarashi@jp.fujitsu.com>
>>
> I guess a similar patch has been sent at:
> https://patchwork.kernel.org/patch/6995461/

Yes, your patch looks better than mine from the point of view
of covering intel_pstate_set_policy().

Still I have a question.
Does your patch allow the following condition?

  limits.max_policy_pct > limits.min_perf_pct > limits.max_perf_pct > limits.min_policy_pct

Regards,
Ikarashi

