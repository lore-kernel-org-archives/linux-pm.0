From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/9] ARM: cpuidle: remove useless declaration
Date: Thu, 18 Apr 2013 16:42:36 +0100
Message-ID: <20130418154236.GY14496@n2100.arm.linux.org.uk>
References: <1364991322-20585-1-git-send-email-daniel.lezcano@linaro.org> <515C1F3B.5040008@linaro.org> <20130418141359.GT14496@n2100.arm.linux.org.uk> <517003CF.5090106@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:34188 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967558Ab3DRPof (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Apr 2013 11:44:35 -0400
Content-Disposition: inline
In-Reply-To: <517003CF.5090106@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: deepthi@linux.vnet.ibm.com, linaro-kernel@lists.linaro.org, swarren@wwwdotorg.org, linux-pm@vger.kernel.org, patches@linaro.org, nsekhar@ti.com, rjw@sisk.pl, rnayak@ti.com, josephl@nvidia.com, linux-tegra@vger.kernel.org, horms+renesas@verge.net.au, linux-arm-kernel@lists.infradead.org, lenb@kernel.org

On Thu, Apr 18, 2013 at 04:31:43PM +0200, Daniel Lezcano wrote:
> On 04/18/2013 04:13 PM, Russell King - ARM Linux wrote:
> > On Wed, Apr 03, 2013 at 02:23:23PM +0200, Daniel Lezcano wrote:
> >> On 04/03/2013 02:15 PM, Daniel Lezcano wrote:
> >>> The noop functions code is not necessary because the header file is
> >>> included in files which are compiled when CONFIG_CPU_IDLE is on.
> >>>
> >>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >>
> >> I have been involved in the development of this file. I know Rob is no
> >> longer working on this neither monitoring the code.
> >>
> >> Russell are you ok with this patch ? Rafael needs your ack to take this
> >> patch into its tree.
> > 
> > I don't know - the description doesn't make it clear.  Surely, what you
> > checked was that this file is _not_ included in any file which is built
> > when CONFIG_CPU_IDLE is disabled.  In other words, when CONFIG_CPU_IDLE
> > is not defined, arm_cpuidle_simple_enter() is never referenced.
> > 
> > If that is the case, then it's just that the patch description is the
> > opposite of what it should be for this patch - and then the patch and
> > description match and I don't see any reason to say no to it.
> > 
> > Then comes the issue of who takes the patch.  It looks like Rafael
> > would like me to.
> 
> Actually Rafael was willing to take the patch if you ack it.

Well, I want to see a proper description on the patch which describes
what it _is_ doing before I ack it.  The existing description is just
plain confusing.
