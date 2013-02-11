From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 06/16] ARM idle: delete pm_idle
Date: Mon, 11 Feb 2013 16:11:25 +0000
Message-ID: <20130211161125.GM17833@n2100.arm.linux.org.uk>
References: <2b219d07e0f287c2c713f5465fc8646158fa986e.1360475150.git.len.brown@intel.com> <9838a4aeee256adeaef90efe56df2c9988206982.1360475150.git.len.brown@intel.com> <20130211160229.GB5676@MacBook-Pro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:40309 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757840Ab3BKQL4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 Feb 2013 11:11:56 -0500
Content-Disposition: inline
In-Reply-To: <20130211160229.GB5676@MacBook-Pro.local>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Len Brown <lenb@kernel.org>, Len Brown <len.brown@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Mon, Feb 11, 2013 at 04:02:30PM +0000, Catalin Marinas wrote:
> On Sun, Feb 10, 2013 at 05:58:13AM +0000, Len Brown wrote:
> > pm_idle() on ARM was a synonym for default_idle(),
> > so simply invoke default_idle() directly.
> 
> The clean-up looks fine as we already have an arm_pm_idle but longer
> term I was thinking about having a common declaration similar to
> pm_power_off that code under drivers/power/(reset/) can override (and
> such driver may be shared by multiple architectures). OTOH, if you get
> rid of the generic linux/pm.h declaration architectures can use a common
> pm_idle name and type (though I think having it in the common header
> would be better). For ARM this would mean s/arm_pm_idle/pm_idle/ on top
> if your patch.

pm_idle() was that common declaration - but it had the side effect that
it was defined to be called with interrupts disabled, but return with
interrupts enabled.

arm_pm_idle() "fixed" that weirdness such that it's now expected to
return with IRQs in the same state that it was called.

pm_power_off() is a cross-arch hook already.
