From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH-next v2 0/2] cpufreq: powernv: Fixes for Global pstate
 management
Date: Mon, 9 May 2016 21:02:04 +0530
Message-ID: <20160509153204.GA21661@vireshk-i7>
References: <1462288776-26721-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34183 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026AbcEIPcJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 9 May 2016 11:32:09 -0400
Received: by mail-pa0-f44.google.com with SMTP id r5so75633772pag.1
        for <linux-pm@vger.kernel.org>; Mon, 09 May 2016 08:32:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1462288776-26721-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

On 03-05-16, 20:49, Akshay Adiga wrote:
> Fixes are based on patch https://patchwork.ozlabs.org/patch/612058/ which
> is in Rafael's linux-next.
> 
> - Patch [1] fixes WARN_ON in powernv_target_index()
> - Patch [2] Deleting any pending timer to saves an unnecessary irq call
>  in powernv_target_index()
> 
> Akshay Adiga (2):
>   cpufreq: powernv: Move smp_call_function_any() out of irq safe block
>   cpufreq: powernv: del_timer_sync when global and local pstate are
>     equal

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
