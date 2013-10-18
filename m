From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH V2 Resend 29/34] cpufreq: sa11x0: Convert to light
	weight ->target_index() routine
Date: Fri, 18 Oct 2013 16:46:44 +0100
Message-ID: <20131018154644.GC25034@n2100.arm.linux.org.uk>
References: <cover.1382104514.git.viresh.kumar@linaro.org> <fb85256f34e1a61c6c2c37c3e6fa8b1398bad683.1382104515.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:41402 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756113Ab3JRPq4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Oct 2013 11:46:56 -0400
Content-Disposition: inline
In-Reply-To: <fb85256f34e1a61c6c2c37c3e6fa8b1398bad683.1382104515.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Oct 18, 2013 at 07:29:52PM +0530, Viresh Kumar wrote:
> This patch converts existing .target() to newly defined light weight
> .target_index() routine for this driver.
> 
> CPUFreq core will call cpufreq_frequency_table_target() before calling this
> routine and will pass index to it.
> 
> Some existing routines are no more required and so are removed now.
> 
> Cc: Russell King <linux@arm.linux.org.uk>

I think I acked this patch.  Please ensure that my ack appears on all
that I did ack, thanks.
