From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [RFC] cpufreq: send notifications for intermediate (stable) frequencies
Date: Thu, 15 May 2014 13:17:52 -0600
Message-ID: <537512E0.7000102@wwwdotorg.org>
References: <25738681139c04272b6d2ebeff244c6d36c893f7.1400133090.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:35368 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753988AbaEOTR4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 15 May 2014 15:17:56 -0400
In-Reply-To: <25738681139c04272b6d2ebeff244c6d36c893f7.1400133090.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, rjw@rjwysocki.net
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, arvind.chauhan@arm.com, swarren@nvidia.com, nicolas.pitre@linaro.org, dianders@chromium.org, linux@arm.linux.org.uk

On 05/14/2014 11:56 PM, Viresh Kumar wrote:
> Douglas Anderson, recently pointed out an interesting problem due to which his
> udelay() was expiring earlier than it should:
> https://lkml.org/lkml/2014/5/13/766
> 
> While transitioning between frequencies few platforms may temporarily switch to
> a stable frequency, waiting for the main PLL to stabilize.
> 
> For example: When we transition between very low frequencies on exynos, like
> between 200MHz and 300MHz, we may temporarily switch to a PLL running at 800MHz.
> No CPUFREQ notification is sent for that. That means there's a period of time
> when we're running at 800MHz but loops_per_jiffy is calibrated at between 200MHz
> and 300MHz. And so udelay behaves badly.
> 
> To get this fixed in a generic way, lets introduce another callback safe_freq()
> for the cpufreq drivers.
> 
> safe_freq() should return a stable intermediate frequency a platform might want
> to switch to, before jumping to the frequency corresponding to 'index'. Core
> will send the 'PRE' notification for this 'stable' frequency and 'POST' for the
> 'target' frequency. Though if ->target_index() fails, it will handle POST for
> 'stable' frequency only.
> 
> Drivers must send 'POST' notification for 'stable' freq and 'PRE' for 'target'
> freq. If they can't switch to target frequency, they don't need to send any
> notification.

This seems rather complex. Can't either the driver or the cpufreq core
be responsible for all of the notifications? Otherwise, the logic gets
rather complex, and spread between the core and the driver.

Perhaps the core should make separate calls into the driver to switch to
the temporary frequency and the final frequency, so it can manage all
the notifications. Probably best to use a separate function pointer for
the temporary change so the driver can easily know what it's doing.
