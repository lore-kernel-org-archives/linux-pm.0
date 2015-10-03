From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH 05/17] platform: x86: remove misuse of IRQF_NO_SUSPEND
 flag
Date: Sat, 3 Oct 2015 09:09:12 -0700
Message-ID: <20151003160912.GA110874@vmdeb7>
References: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
 <1442850433-5903-6-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:60555 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102AbbJCQJj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 3 Oct 2015 12:09:39 -0400
Content-Disposition: inline
In-Reply-To: <1442850433-5903-6-git-send-email-sudeep.holla@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, platform-driver-x86@vger.kernel.org

On Mon, Sep 21, 2015 at 04:47:01PM +0100, Sudeep Holla wrote:
> The IRQF_NO_SUSPEND flag is used to identify the interrupts that should
> be left enabled so as to allow them to work as expected during the
> suspend-resume cycle, but doesn't guarantee that it will wake the system
> from a suspended state, enable_irq_wake is recommended to be used for
> the wakeup.
> 
> This patch removes the use of IRQF_NO_SUSPEND flags and uses newly
> introduce PM wakeup APIs dev_pm_{set,clear}_wake_irq.
> 
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: platform-driver-x86@vger.kernel.org
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Queued to testing, thanks Sudeep.

-- 
Darren Hart
Intel Open Source Technology Center
