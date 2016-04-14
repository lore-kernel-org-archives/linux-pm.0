From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] cpufreq: powernv: Ramp-down global pstate slower than
 local-pstate
Date: Thu, 14 Apr 2016 21:24:36 +0530
Message-ID: <570FBD3C.2050505@linux.vnet.ibm.com>
References: <1460484386-28389-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <1460484386-28389-3-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <570F2D65.3090502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e23smtp05.au.ibm.com ([202.81.31.147]:56457 "EHLO
	e23smtp05.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932243AbcDNPze (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 14 Apr 2016 11:55:34 -0400
Received: from localhost
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <akshay.adiga@linux.vnet.ibm.com>;
	Fri, 15 Apr 2016 01:55:31 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id C729B3578053
	for <linux-pm@vger.kernel.org>; Fri, 15 Apr 2016 01:55:28 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u3EFtKxN6881642
	for <linux-pm@vger.kernel.org>; Fri, 15 Apr 2016 01:55:28 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u3EFstj4012059
	for <linux-pm@vger.kernel.org>; Fri, 15 Apr 2016 01:54:56 +1000
In-Reply-To: <570F2D65.3090502@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Balbir Singh <bsingharora@gmail.com>, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: ego@linux.vnet.ibm.com

Hi Balbir,

On 04/14/2016 11:10 AM, Balbir Singh wrote:

> On 13/04/16 04:06, Akshay Adiga wrote:
>> This patch brings down global pstate at a slower rate than the local
>> pstate. As the frequency transition latency from pmin to pmax is
>> observed to be in few millisecond granurality. It takes a performance
>> penalty during sudden frequency rampup. Hence by holding global pstates
>> higher than local pstate makes the subsequent rampups faster.
> What domains does local and global refer to?

The *global pstate* is a Chip-level entity as such, so the global entity
(Voltage)  is managed across several cores. But with a DCM (Dual Chip Modules),
its more of a socket-level entity and hence Voltage is managed across both chips.

The *local pstate* is a Core-level entity, so the local entity (frequency) is
managed across threads.

I will include this in the commit message. Thanks.

>
>> +/*
>> + * Quadratic equation which gives the percentage rampdown for time elapsed in
>> + * milliseconds. time can be between 0 and MAX_RAMP_DOWN_TIME ( milliseconds )
>> + * This equation approximates to y = -4e-6 x^2
> Thanks for documenting this, but I think it will also be good to explain why we
> use y = -4 e-6*x^2 as opposed to any other magic numbers.

Well it empirically worked out best this way.

On an idle system we want the Global Pstate to ramp-down from max value to min over
a span of ~5 secs. Also we want initially ramp-down slowly and ramp-down rapidly later
on, hence the equation.

I will try to make this in the comment more informative.

Regards

Akshay Adiga

