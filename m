From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH v7 5/6] cpufreq: powernv: Replace pr_info with trace
 print for throttle event
Date: Thu, 28 Jan 2016 13:48:35 +0530
Message-ID: <20160128081835.GC13654@in.ibm.com>
References: <1453965941-7363-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1453965941-7363-6-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:55117 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932479AbcA1ISr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jan 2016 03:18:47 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
	Thu, 28 Jan 2016 01:18:47 -0700
Content-Disposition: inline
In-Reply-To: <1453965941-7363-6-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, pc@us.ibm.com, anton@samba.org, ego@linux.vnet.ibm.com, shreyas@linux.vnet.ibm.com, bsingharora@gmail.com, mpe@ellerman.id.au

On Thu, Jan 28, 2016 at 12:55:40PM +0530, Shilpasri G Bhat wrote:
> Currently we use printk message to notify the throttle event. But this
> can flood the console if the cpu is throttled frequently. So replace the
> printk with the tracepoint to notify the throttle event. And also events
> like throttle below nominal frequency and OCC_RESET are reduced to
> pr_warn/pr_warn_once as pointed by MFG to not mark them as critical
> messages. This patch adds 'throttle_reason' to struct chip to store the
> throttle reason.
> 
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>

Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

--
Thanks and Regards
gautham.

