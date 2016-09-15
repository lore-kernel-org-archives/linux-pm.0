From: Tony Lindgren <tony@atomide.com>
Subject: Re: Power driver patches to avoid lockdep complaints
Date: Thu, 15 Sep 2016 12:52:42 -0700
Message-ID: <20160915195240.7lxrrf2s2fkgavwn@atomide.com>
References: <20160615211344.GA31850@linux.vnet.ibm.com>
 <20160823004549.b66jru7ogyfifunf@atomide.com>
 <20160823005917.GY3482@linux.vnet.ibm.com>
 <3368049.VBoKnTMGvK@vostro.rjw.lan>
 <20160823101600.GA3482@linux.vnet.ibm.com>
 <20160915194129.tq65ieriuo6a3yrf@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:42443 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754907AbcIOTwq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 15 Sep 2016 15:52:46 -0400
Content-Disposition: inline
In-Reply-To: <20160915194129.tq65ieriuo6a3yrf@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, pavel@ucw.cz, linux@roeck-us.net, rostedt@goodmis.org, linux-pm@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [160915 12:41]:
> Rafael, I'm still not seeing these applied, care to check?

Sorry looks like only one of the three fixes is missing from
current mainline:

13e698e68f75 ("power: Use _rcuidle for suspend/resume tracepoints")

So I'm still getting warning out of box with omap2plus_defconfig.

Regards,

Tony
