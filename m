From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: Re: [PATCH-next v2 0/2] cpufreq: powernv: Fixes for Global pstate
 management
Date: Mon, 9 May 2016 18:08:34 +0530
Message-ID: <573084CA.6020708@linux.vnet.ibm.com>
References: <1462288776-26721-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e23smtp04.au.ibm.com ([202.81.31.146]:56874 "EHLO
	e23smtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764AbcEIMji (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 9 May 2016 08:39:38 -0400
Received: from localhost
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <akshay.adiga@linux.vnet.ibm.com>;
	Mon, 9 May 2016 22:39:35 +1000
In-Reply-To: <1462288776-26721-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

On 05/03/2016 08:49 PM, Akshay Adiga wrote:

> Fixes are based on patch https://patchwork.ozlabs.org/patch/612058/ which
> is in Rafael's linux-next.
>
> - Patch [1] fixes WARN_ON in powernv_target_index()
> - Patch [2] Deleting any pending timer to saves an unnecessary irq call
>   in powernv_target_index()
>
> Akshay Adiga (2):
>    cpufreq: powernv: Move smp_call_function_any() out of irq safe block
>    cpufreq: powernv: del_timer_sync when global and local pstate are
>      equal
>
>   drivers/cpufreq/powernv-cpufreq.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
>
Does this look good ? Anything i should do ?


Regards
Akshay Adiga

