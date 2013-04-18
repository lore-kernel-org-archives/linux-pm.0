From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/9] ARM: cpuidle: remove useless declaration
Date: Thu, 18 Apr 2013 15:13:59 +0100
Message-ID: <20130418141359.GT14496@n2100.arm.linux.org.uk>
References: <1364991322-20585-1-git-send-email-daniel.lezcano@linaro.org> <515C1F3B.5040008@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:34019 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965049Ab3DROPa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Apr 2013 10:15:30 -0400
Content-Disposition: inline
In-Reply-To: <515C1F3B.5040008@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@sisk.pl, deepthi@linux.vnet.ibm.com, linaro-kernel@lists.linaro.org, swarren@wwwdotorg.org, patches@linaro.org, linux-pm@vger.kernel.org, rnayak@ti.com, nsekhar@ti.com, josephl@nvidia.com, linux-tegra@vger.kernel.org, horms+renesas@verge.net.au, linux-arm-kernel@lists.infradead.org, lenb@kernel.org

On Wed, Apr 03, 2013 at 02:23:23PM +0200, Daniel Lezcano wrote:
> On 04/03/2013 02:15 PM, Daniel Lezcano wrote:
> > The noop functions code is not necessary because the header file is
> > included in files which are compiled when CONFIG_CPU_IDLE is on.
> >
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> I have been involved in the development of this file. I know Rob is no
> longer working on this neither monitoring the code.
> 
> Russell are you ok with this patch ? Rafael needs your ack to take this
> patch into its tree.

I don't know - the description doesn't make it clear.  Surely, what you
checked was that this file is _not_ included in any file which is built
when CONFIG_CPU_IDLE is disabled.  In other words, when CONFIG_CPU_IDLE
is not defined, arm_cpuidle_simple_enter() is never referenced.

If that is the case, then it's just that the patch description is the
opposite of what it should be for this patch - and then the patch and
description match and I don't see any reason to say no to it.

Then comes the issue of who takes the patch.  It looks like Rafael
would like me to.  I'm fine with that, but it will need to go into the
patch system as I'm rather busy catching up with email, and I expect
to be catching up for at least the rest of this month.
