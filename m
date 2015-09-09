From: Seiichi Ikarashi <s.ikarashi@jp.fujitsu.com>
Subject: Re: [PATCH] intel_pstate: prevent max_perf_pct < min_perf_pct
Date: Wed, 9 Sep 2015 13:27:17 +0900
Message-ID: <55EFB525.3010705@jp.fujitsu.com>
References: <55E97973.1020301@jp.fujitsu.com>
 <36DF59CE26D8EE47B0655C516E9CE6401CB04B52@SHSMSX101.ccr.corp.intel.com>
 <55EE1B56.3010205@jp.fujitsu.com>
 <36DF59CE26D8EE47B0655C516E9CE6401D4A70BF@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mgwkm03.jp.fujitsu.com ([202.219.69.170]:12345 "EHLO
	mgwkm03.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714AbbIIEaE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Sep 2015 00:30:04 -0400
Received: from g01jpfmpwkw03.exch.g01.fujitsu.local (g01jpfmpwkw03.exch.g01.fujitsu.local [10.0.193.57])
	by kw-mxq.gw.nic.fujitsu.com (Postfix) with ESMTP id 9810DAC013C
	for <linux-pm@vger.kernel.org>; Wed,  9 Sep 2015 13:30:00 +0900 (JST)
In-Reply-To: <36DF59CE26D8EE47B0655C516E9CE6401D4A70BF@SHSMSX101.ccr.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: "kristen@linux.intel.com" <kristen@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>

Hi, Yu

On 2015-09-08 16:27, Chen, Yu C wrote:
> Hi, Seiichi
> 
>>> I guess a similar patch has been sent at:
>>> https://patchwork.kernel.org/patch/6995461/
>>
>> Yes, your patch looks better than mine from the point of view of covering
>> intel_pstate_set_policy().
>>
>> Still I have a question.
>> Does your patch allow the following condition?
>>
>>   limits.max_policy_pct > limits.min_perf_pct > limits.max_perf_pct >
>> limits.min_policy_pct
>>
> 
> Thanks!  Seems my previous patch does not guarantee
>  max_perf_pct >= min_perf_pct,  I think following logic would be better:
> Step0:  normalize the user input to [min_policy, max_policy]
> Step1: make sure max_perf_pct>= min_perf_pct
> 
> BTW,why I add step0 here is because we should not rely on user input, and
> different policy might have different (min,max), for example,
> max_policy_pct=40,min_policy_pct=30, and user input of 
> echo 50 > min_sysfs_pct would make the final min_perf_pct to
> 50, it's not in legal policy scope, so...

Those two steps will make sense.
I will review your upcoming v2 patch.

Regards,
Seiichi

