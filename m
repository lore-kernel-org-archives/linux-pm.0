From: Tony Lindgren <tony@atomide.com>
Subject: Re: Power driver patches to avoid lockdep complaints
Date: Sat, 20 Aug 2016 07:28:37 -0700
Message-ID: <20160820142837.dqh3kmem4o3ca54t@atomide.com>
References: <20160615211344.GA31850@linux.vnet.ibm.com>
 <20160818225152.d2tvla4l3avoss2n@atomide.com>
 <1883021.VkIzpAuQoG@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:45980 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752710AbcHTO2l (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 20 Aug 2016 10:28:41 -0400
Content-Disposition: inline
In-Reply-To: <1883021.VkIzpAuQoG@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, pavel@ucw.cz, linux@roeck-us.net, rostedt@goodmis.org, linux-pm@vger.kernel.org

* Rafael J. Wysocki <rjw@rjwysocki.net> [160819 18:35]:
> On Thursday, August 18, 2016 03:51:52 PM Tony Lindgren wrote:
> > Hi,
> > 
> > * Paul E. McKenney <paulmck@linux.vnet.ibm.com> [160615 14:16]:
> > > Hello!
> > > 
> > > Ingo was not comfortable taking these through -tip, which is understandable,
> > > given that they don't depend on each other or on anything else not already
> > > in mainline, and that they don't have anything to do with -tip.
> > > 
> > > So what would you guys like to do with these?
> > > 
> > > They may be pulled from 13e698e68f75 (power: Use _rcuidle for
> > > suspend/resume tracepoints) in my -rcu tree:
> > > 
> > > 	git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
> > > 
> > 
> > Rafael, looks like commit 13e698e68f75 is still missing from the
> > mainline tree. Care to merge it to your fixes so I don't have to
> > keep looking at that splat on daily basis?
> 
> I could pull it if I knew where to pull it from.  The above gives me
> "Already up-to-date."

Here are the ones still missing:

$ git log --pretty=oneline v4.7-rc2..13e698e68f75
13e698e68f75708c45241a2dad23cd6b65181056 power: Use _rcuidle for suspend/resume tracepoints
320e2a2d081b6c519f80fca9377b8fb90db7bb9c power: Add _rcuidle suffix to allow rpm_resume() to be called from idle
b72aadb1d082d3935cbffd60e979238252045971 power: Add _rcuidle suffix to allow rpm_idle() use from idle

So maybe just git merge 13e698e68f75 if you have the linux-rcu.git
fetched and the above look OK to you?

Regards,

Tony
