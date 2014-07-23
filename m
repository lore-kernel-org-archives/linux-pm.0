From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [GIT PULL] ARM: mvebu: SoC changes for v3.17 (round 3)
Date: Wed, 23 Jul 2014 19:41:30 -0400
Message-ID: <20140723234130.GM23220@titan.lakedaemon.net>
References: <20140722205706.GA23220@titan.lakedaemon.net>
 <201407232231.41787.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:40900 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757992AbaGWXlr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 23 Jul 2014 19:41:47 -0400
Content-Disposition: inline
In-Reply-To: <201407232231.41787.arnd@arndb.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>, Kevin Hilman <khilman@linaro.org>, arm@kernel.org, Andrew Lunn <andrew@lunn.ch>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

On Wed, Jul 23, 2014 at 10:31:41PM +0200, Arnd Bergmann wrote:
> On Tuesday 22 July 2014, Jason Cooper wrote:
> > All,
> > 
> > Here's the cpufreq changes I mentioned over the weekend.  It's been in
> > -next for a while.  Once I get the new version of cpuidle from ThomasP,
> > I'll push that as quickly as possible.
> 
> Just for my information, is this coordinated with the cpufreq maintainers?
> I remember being asked to ensure all cpufreq/cpuidle stuff has an Ack
> from them, even stuff that doesn't touch drivers/cpufreq at all.

Good to know.

> The contents look good to me. I can merge them if there are no objections
> from Viresh, feel free to send the next batch already without waiting
> for me to pull.

We've been coordinating with Viresh.  He has an unsettled issue on his
side he hopes to have resolved soon.  Worst case scenario, he doesn't
get the change in for v3.17, we'll have to do a minor DT fix on top of
-rc1.

> > As usual (do I need to type this each time any more? :) ), this is an
> > incremental pull request from tags/mvebu-soc-3.17-2 up to
> > tags/mvebu-soc-3.17-3 on the mvebu/soc branch.
> 
> It certainly helps me to have this information, but you can write it
> more briefly, e.g. "based on tags/mvebu-soc-3.17-2".

Ahhhh....  Much more succinct.  Thank you.  On a side note, I wonder
what it would take to get 'git request-pull' smart enough to add that
information when handed a tag?

> > The following changes since commit ba364fc752daeded072a5ef31e43b84cb1f9e5fd:
> > 
> >   ARM: Kirkwood: Remove mach-kirkwood (2014-07-13 22:13:39 +0000)

eg:

  ARM: Kirkwood: Remove mach-kirkwood (tags/mvebu-soc-3.17-2)

> > 
> > are available in the git repository at:
> > 
> >   git://git.infradead.org/linux-mvebu.git tags/mvebu-soc-3.17-3
> > 
> > for you to fetch changes up to ba3ec5780bba27819bbc4f669e6c77418a00f14b:
> > 
> >   Merge branch 'mvebu/soc-cpufreq' into mvebu/soc (2014-07-22 20:46:48 +0000)
> > 
> > ----------------------------------------------------------------

Is the date of the base commit useful in any way in the pull request?

thx,

Jason.
