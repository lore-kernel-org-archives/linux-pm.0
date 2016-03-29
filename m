From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/3] cpufreq: dt: Create platform device from generic code
Date: Tue, 29 Mar 2016 15:22:59 +0200
Message-ID: <4279257.XRWOdgISPj@wuerfel>
References: <cover.1458801338.git.viresh.kumar@linaro.org> <4531000.a0G78BGFu1@wuerfel> <20160325044124.GN22062@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:54160 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751584AbcC2NX2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Mar 2016 09:23:28 -0400
In-Reply-To: <20160325044124.GN22062@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, Rafael Wysocki <rjw@rjwysocki.net>, arnd.bergmann@linaro.org, kgene.kim@samsung.com, heiko@sntech.de, xf@rock-chips.com, mmcclint@codeaurora.org, linux-pm@vger.kernel.org

On Friday 25 March 2016 10:11:24 Viresh Kumar wrote:
> On 24-03-16, 15:16, Arnd Bergmann wrote:
> > Hmm, can you give an example where this is needed?
> 
> I don't remember them, but I am quite sure that I have seen people
> asking for that support again and again.
> 
> > I assume you are
> > thinking of some clock controller or regulator that gets initialized
> > after the cpufreq driver, right?
> 
> Yeah.
> 
> > Are there any that are in loadable modules, rather than just later
> > in the init sequence for built-in drivers?
> 
> Maybe both, don't remember. Sorry.
> 
> Over that, independent of what the users are doing today, I think its
> important to support defer probing for anyone that wants to use it.

Ok.

> > I think we do care about compatibility there, but there are clearly
> > other ways to handle the special case for opp-v1 if we want to.
> 
> Okay, and what are those ? There is only one platform which has used
> the pdata, mvebu.

The platform already calls dev_pm_opp_add(), so it directly interacts
with the cpufreq infrastructure. One way to do it would be to add
another function call to set the independent_clocks flag in a static
variable owned by that. Another way would be to have a separate
function call for doing dev_pm_opp_add() with independent clocks.
As far as I can tell, the two (dev_pm_opp_add and independent_clocks)
are already tightly coupled interfaces, so it makes sense to
combine them.

	Arnd
