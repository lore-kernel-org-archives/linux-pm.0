From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Power driver patches to avoid lockdep complaints
Date: Sat, 20 Aug 2016 03:40 +0200
Message-ID: <1883021.VkIzpAuQoG@vostro.rjw.lan>
References: <20160615211344.GA31850@linux.vnet.ibm.com> <20160818225152.d2tvla4l3avoss2n@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:65399 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1755137AbcHTBeZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Aug 2016 21:34:25 -0400
In-Reply-To: <20160818225152.d2tvla4l3avoss2n@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, pavel@ucw.cz, linux@roeck-us.net, rostedt@goodmis.org, linux-pm@vger.kernel.org

On Thursday, August 18, 2016 03:51:52 PM Tony Lindgren wrote:
> Hi,
> 
> * Paul E. McKenney <paulmck@linux.vnet.ibm.com> [160615 14:16]:
> > Hello!
> > 
> > Ingo was not comfortable taking these through -tip, which is understandable,
> > given that they don't depend on each other or on anything else not already
> > in mainline, and that they don't have anything to do with -tip.
> > 
> > So what would you guys like to do with these?
> > 
> > They may be pulled from 13e698e68f75 (power: Use _rcuidle for
> > suspend/resume tracepoints) in my -rcu tree:
> > 
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
> > 
> 
> Rafael, looks like commit 13e698e68f75 is still missing from the
> mainline tree. Care to merge it to your fixes so I don't have to
> keep looking at that splat on daily basis?

I could pull it if I knew where to pull it from.  The above gives me
"Already up-to-date."

Thanks,
Rafael

