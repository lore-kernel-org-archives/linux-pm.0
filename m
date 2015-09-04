From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 7/7] ARM: smp: Add runtime PM support for CPU hotplug
Date: Fri, 4 Sep 2015 10:17:35 +0100
Message-ID: <20150904091735.GC21084@n2100.arm.linux.org.uk>
References: <1441310314-8857-1-git-send-email-lina.iyer@linaro.org>
 <1441310314-8857-8-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:49644 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752286AbbIDJRu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 4 Sep 2015 05:17:50 -0400
Content-Disposition: inline
In-Reply-To: <1441310314-8857-8-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: ulf.hansson@linaro.org, khilman@linaro.org, linux-pm@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, k.kozlowski@samsung.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, sboyd@codeaurora.org, rjw@rjwysocki.net, msivasub@codeaurora.org, geert@linux-m68k.org, agross@codeaurora.org, linux-arm-kernel@lists.infradead.org

On Thu, Sep 03, 2015 at 01:58:34PM -0600, Lina Iyer wrote:
> @@ -401,6 +412,11 @@ asmlinkage void secondary_start_kernel(void)
>  	local_irq_enable();
>  	local_fiq_enable();
>  
> +	/* We are running, enable runtime PM for the CPU. */
> +	cpu_dev = get_cpu_device(cpu);
> +	if (cpu_dev)
> +		pm_runtime_get_sync(cpu_dev);
> +

Please no.  This is fragile.

pm_runtime_get_sync() can sleep, and this path is used when the system
is fully up and running.  Locks may be held, which cause this to sleep.
However, we're calling it from a context where we can't sleep - which
is the general rule for any part of system initialisation where we
have not entered the idle thread yet (the idle thread is what we run
when sleeping.)

NAK on this.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
