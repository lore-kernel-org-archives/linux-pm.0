From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v7 5/6] cpufreq: powernv: Replace pr_info with trace
 print for throttle event
Date: Thu, 28 Jan 2016 13:59:29 +0530
Message-ID: <20160128082929.GJ3935@vireshk>
References: <1453965941-7363-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1453965941-7363-6-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34454 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934972AbcA1I3c (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jan 2016 03:29:32 -0500
Received: by mail-pa0-f54.google.com with SMTP id uo6so20028380pac.1
        for <linux-pm@vger.kernel.org>; Thu, 28 Jan 2016 00:29:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1453965941-7363-6-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, pc@us.ibm.com, anton@samba.org, ego@linux.vnet.ibm.com, shreyas@linux.vnet.ibm.com, bsingharora@gmail.com, mpe@ellerman.id.au

On 28-01-16, 12:55, Shilpasri G Bhat wrote:
> Currently we use printk message to notify the throttle event. But this
> can flood the console if the cpu is throttled frequently. So replace the
> printk with the tracepoint to notify the throttle event. And also events
> like throttle below nominal frequency and OCC_RESET are reduced to
> pr_warn/pr_warn_once as pointed by MFG to not mark them as critical
> messages. This patch adds 'throttle_reason' to struct chip to store the
> throttle reason.
> 
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> ---
> Changes from v6:
> - Rename struct chip member 'throt_reason' to 'throttle_reason'

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
