From: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpuidle: Fix last_residency division
Date: Thu, 30 Jun 2016 20:06:18 +0530
Message-ID: <57752E62.5030909@linux.vnet.ibm.com>
References: <1467296844-2055-1-git-send-email-shreyas@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19110 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752141AbcF3Ogd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jun 2016 10:36:33 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u5UEYaL9128304
	for <linux-pm@vger.kernel.org>; Thu, 30 Jun 2016 10:36:32 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	by mx0b-001b2d01.pphosted.com with ESMTP id 23v09909qd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 30 Jun 2016 10:36:32 -0400
Received: from localhost
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <shreyas@linux.vnet.ibm.com>;
	Fri, 1 Jul 2016 00:36:29 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id AC3F32CE8046
	for <linux-pm@vger.kernel.org>; Fri,  1 Jul 2016 00:36:25 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u5UEaMJw63570126
	for <linux-pm@vger.kernel.org>; Fri, 1 Jul 2016 00:36:25 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u5UEaLs7006869
	for <linux-pm@vger.kernel.org>; Fri, 1 Jul 2016 00:36:22 +1000
In-Reply-To: <1467296844-2055-1-git-send-email-shreyas@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, anton@samba.org, mpe@ellerman.id.au, bsingharora@gmail.com, David.Laight@ACULAB.COM, arnd@arndb.de, nicolas.pitre@linaro.org

Please ignore this mail. I have resent this post using the correct
version number. Sorry for the noise.


On 06/30/2016 07:57 PM, Shreyas B. Prabhu wrote:
> Snooze is a poll idle state in powernv and pseries platforms. Snooze
> has a timeout so that if a cpu stays in snooze for more than target
> residency of the next available idle state, then it would exit thereby
> giving chance to the cpuidle governor to re-evaluate and
> promote the cpu to a deeper idle state. Therefore whenever snooze exits
> due to this timeout, its last_residency will be target_residency of next
> deeper state.
> 
> commit e93e59ce5b85 ("cpuidle: Replace ktime_get() with local_clock()")
> changed the math around last_residency calculation. Specifically, while
> converting last_residency value from nanoseconds to microseconds it does
> right shift by 10. Due to this, in snooze timeout exit scenarios
> last_residency calculated is roughly 2.3% less than target_residency of
> next available state. This pattern is picked up get_typical_interval()
> in the menu governor and therefore expected_interval in menu_select() is
> frequently less than the target_residency of any state but snooze.
> 
> Due to this we are entering snooze at a higher rate, thereby affecting
> the single thread performance.
> 
> Fix this by using a better approximation for division by 1000.
> 
> Reported-by: Anton Blanchard <anton@samba.org>
> Bisected-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> Suggested-by David Laight <david.laight@aculab.com>
> Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
> ---
> Changes in v4
> =============
>  - Increasing the threshold upto which approximation can be used.
>  - Removed explicit cast. Instead added a comment saying why cast
>    is safe.
> 
> Changes in v3
> =============
>  - Using approximation suggested by David
> 
> Changes in v2
> =============
>  - Fixing it in the cpuidle core code instead of driver code.
> 

