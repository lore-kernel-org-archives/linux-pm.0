From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: powernv: Define per_cpu chip pointer to
 optimize hot-path
Date: Mon, 21 Mar 2016 12:52:55 +0530
Message-ID: <20160321072255.GB1803@vireshk-i7>
References: <1458274308.6622.79.camel@neuling.org>
 <1458313100-27676-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34635 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602AbcCUHW7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Mar 2016 03:22:59 -0400
Received: by mail-pf0-f179.google.com with SMTP id x3so254778744pfb.1
        for <linux-pm@vger.kernel.org>; Mon, 21 Mar 2016 00:22:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1458313100-27676-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, ego@linux.vnet.ibm.com, linux-pm@vger.kernel.org, rjw@rjwysocki.net, pc@us.ibm.com, shreyas@linux.vnet.ibm.com, anton@samba.org, mikey@neuling.org

On 18-03-16, 20:28, Shilpasri G Bhat wrote:
> From: Michael Neuling <mikey@neuling.org>
> 
> "cpufreq: powernv: Remove cpu_to_chip_id() from hot-path" introduced

If the patch is already committed, you should provide its commit id as well.

> 'core_to_chip_map' array to cache the chip-id of all cores. Replace
> this with per_cpu variable that stores the pointer to the chip-array.
> This removes the linear lookup and provides a neater and simpler
> solution.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Tested-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>

You are sending this patch and you have updated it as well.. So, you should have
had your signed-off here.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
