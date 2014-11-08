From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH V3 3/6] sched: idle: Get the next timer event and pass
 it the cpuidle framework
Date: Sat, 08 Nov 2014 16:14:27 +0530
Message-ID: <545DF40B.9000803@linux.vnet.ibm.com>
References: <1415370687-18688-1-git-send-email-daniel.lezcano@linaro.org> <1415370687-18688-4-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e39.co.us.ibm.com ([32.97.110.160]:56850 "EHLO
	e39.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753519AbaKHKoh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 8 Nov 2014 05:44:37 -0500
Received: from /spool/local
	by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <preeti@linux.vnet.ibm.com>;
	Sat, 8 Nov 2014 03:44:36 -0700
In-Reply-To: <1415370687-18688-4-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, rjw@rjwysocki.net
Cc: nicolas.pitre@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org, linaro-kernel@lists.linaro.org, patches@linaro.org, lenb@kernel.org

On 11/07/2014 08:01 PM, Daniel Lezcano wrote:
> Following the logic of the previous patch, retrieve from the idle task the
> expected timer sleep duration and pass it to the cpuidle framework.
> 
> Take the opportunity to remove the unused headers in the menu.c file.
> 
> This patch does not change the current behavior.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Acked-by: Nicolas Pitre <nico@linaro.org>
> Reviewed-by: Len Brown <len.brown@intel.com>
> ---

This patch looks good to me as well.

Reviewed-by: Preeti U. Murthy

