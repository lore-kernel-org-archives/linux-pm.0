From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v6 4/5] cpufreq: powernv: Replace pr_info with trace
 print for throttle event
Date: Mon, 25 Jan 2016 11:28:09 +0530
Message-ID: <20160125055809.GC3183@vireshk>
References: <1453447145-17722-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1453447145-17722-5-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33621 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbcAYF6M (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Jan 2016 00:58:12 -0500
Received: by mail-pf0-f171.google.com with SMTP id e65so76815704pfe.0
        for <linux-pm@vger.kernel.org>; Sun, 24 Jan 2016 21:58:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1453447145-17722-5-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, pc@us.ibm.com, anton@samba.org, ego@linux.vnet.ibm.com, shreyas@linux.vnet.ibm.com

On 22-01-16, 12:49, Shilpasri G Bhat wrote:
> Currently we use printk message to notify the throttle event. But this
> can flood the console if the cpu is throttled frequently. So replace the
> printk with the tracepoint to notify the throttle event. And also events
> like throttle below nominal frequency and OCC_RESET are reduced to
> pr_warn/pr_warn_once as pointed by MFG to not mark them as critical
> messages. This patch adds 'throt_reason' to struct chip to store the
> throttle reason.
> 
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
> No changes from v5.

You have done too many things in a single patch, its always better to
keep a patch for a special problem. Don't try to solve everything in
the same patch.

Though, I am NOT strongly saying that you respin this patch now.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
