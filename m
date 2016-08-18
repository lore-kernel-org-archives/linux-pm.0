From: Tony Lindgren <tony@atomide.com>
Subject: Re: Power driver patches to avoid lockdep complaints
Date: Thu, 18 Aug 2016 15:51:52 -0700
Message-ID: <20160818225152.d2tvla4l3avoss2n@atomide.com>
References: <20160615211344.GA31850@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:45913 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754180AbcHSBSX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 18 Aug 2016 21:18:23 -0400
Content-Disposition: inline
In-Reply-To: <20160615211344.GA31850@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: rjw@rjwysocki.net, pavel@ucw.cz, linux@roeck-us.net, rostedt@goodmis.org, linux-pm@vger.kernel.org

Hi,

* Paul E. McKenney <paulmck@linux.vnet.ibm.com> [160615 14:16]:
> Hello!
> 
> Ingo was not comfortable taking these through -tip, which is understandable,
> given that they don't depend on each other or on anything else not already
> in mainline, and that they don't have anything to do with -tip.
> 
> So what would you guys like to do with these?
> 
> They may be pulled from 13e698e68f75 (power: Use _rcuidle for
> suspend/resume tracepoints) in my -rcu tree:
> 
> 	git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
> 

Rafael, looks like commit 13e698e68f75 is still missing from the
mainline tree. Care to merge it to your fixes so I don't have to
keep looking at that splat on daily basis?

Regards,

Tony
