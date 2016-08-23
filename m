From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Power driver patches to avoid lockdep complaints
Date: Tue, 23 Aug 2016 03:52:12 +0200
Message-ID: <3368049.VBoKnTMGvK@vostro.rjw.lan>
References: <20160615211344.GA31850@linux.vnet.ibm.com> <20160823004549.b66jru7ogyfifunf@atomide.com> <20160823005917.GY3482@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:46994 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1753423AbcHWBqg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Aug 2016 21:46:36 -0400
In-Reply-To: <20160823005917.GY3482@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: paulmck@linux.vnet.ibm.com
Cc: Tony Lindgren <tony@atomide.com>, pavel@ucw.cz, linux@roeck-us.net, rostedt@goodmis.org, linux-pm@vger.kernel.org

On Monday, August 22, 2016 05:59:17 PM Paul E. McKenney wrote:
> On Mon, Aug 22, 2016 at 05:45:49PM -0700, Tony Lindgren wrote:
> > * Rafael J. Wysocki <rjw@rjwysocki.net> [160822 10:30]:
> > > On Saturday, August 20, 2016 07:28:37 AM Tony Lindgren wrote:
> > > > * Rafael J. Wysocki <rjw@rjwysocki.net> [160819 18:35]:
> > > > > On Thursday, August 18, 2016 03:51:52 PM Tony Lindgren wrote:
> > > > > > Hi,
> > > > > > 
> > > > > > * Paul E. McKenney <paulmck@linux.vnet.ibm.com> [160615 14:16]:
> > > > > > > Hello!
> > > > > > > 
> > > > > > > Ingo was not comfortable taking these through -tip, which is understandable,
> > > > > > > given that they don't depend on each other or on anything else not already
> > > > > > > in mainline, and that they don't have anything to do with -tip.
> > > > > > > 
> > > > > > > So what would you guys like to do with these?
> > > > > > > 
> > > > > > > They may be pulled from 13e698e68f75 (power: Use _rcuidle for
> > > > > > > suspend/resume tracepoints) in my -rcu tree:
> > > > > > > 
> > > > > > > 	git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
> > > > > > > 
> > > > > > 
> > > > > > Rafael, looks like commit 13e698e68f75 is still missing from the
> > > > > > mainline tree. Care to merge it to your fixes so I don't have to
> > > > > > keep looking at that splat on daily basis?
> > > > > 
> > > > > I could pull it if I knew where to pull it from.  The above gives me
> > > > > "Already up-to-date."
> > > > 
> > > > Here are the ones still missing:
> > > > 
> > > > $ git log --pretty=oneline v4.7-rc2..13e698e68f75
> > > > 13e698e68f75708c45241a2dad23cd6b65181056 power: Use _rcuidle for suspend/resume tracepoints
> > > > 320e2a2d081b6c519f80fca9377b8fb90db7bb9c power: Add _rcuidle suffix to allow rpm_resume() to be called from idle
> > > > b72aadb1d082d3935cbffd60e979238252045971 power: Add _rcuidle suffix to allow rpm_idle() use from idle
> > > > 
> > > > So maybe just git merge 13e698e68f75 if you have the linux-rcu.git
> > > > fetched and the above look OK to you?
> > > 
> > > If I do
> > > 
> > > $ git fetch git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
> > > 
> > > and then
> > > 
> > > $ git show 13e698e68f75
> > > 
> > > then it tells me
> > > 
> > > fatal: ambiguous argument '13e698e68f75': unknown revision or path not in the working tree.
> > > 
> > > Do I need to fetch it in any special way or something?
> > 
> > Well I usuall add things to my .git/config like:
> > 
> > [remote "rcu"]
> > 	url = git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
> > 	fetch = refs/heads/*:refs/remotes/rcu/*
> > 
> > And then do git fetch --no-tags on what I need. There's probably
> > some easy way to do that temporarily too :)
> > 
> > But now doing git fetch --no-tags rcu here with produces this
> > for me:
> > ...
> >  ! [rejected]        rcu/dev    -> rcu/rcu/dev  (non-fast-forward)
> >  ! [rejected]        rcu/next   -> rcu/rcu/next  (non-fast-forward)
> > 
> > So maybe that branch got trashed and the commit is there no more.
> 
> The trick is that rcu/dev and rcu/next simply mark my current development
> branch and the stuff I want Stephen Rothwell to pull into -next,
> respectively.
> 
> > Paul, do you have 13e698e68f75 still somewhere or want me to push
> > out a branch with that?
> 
> The permanent branch name for those changes is power.2016.06.15a,
> so those should be pullable from anywhere.
> 
> Or please do feel free to push from your tree if that works better.
> However they get where they need to go, I am good!  ;-)

I guess I'll just apply the patches you've sent directly then.

Thanks,
Rafael

