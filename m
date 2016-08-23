From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Power driver patches to avoid lockdep complaints
Date: Tue, 23 Aug 2016 03:16:00 -0700
Message-ID: <20160823101600.GA3482@linux.vnet.ibm.com>
References: <20160615211344.GA31850@linux.vnet.ibm.com>
 <20160823004549.b66jru7ogyfifunf@atomide.com>
 <20160823005917.GY3482@linux.vnet.ibm.com>
 <3368049.VBoKnTMGvK@vostro.rjw.lan>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52999 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753656AbcHWKP6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Aug 2016 06:15:58 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u7NADqsm129132
        for <linux-pm@vger.kernel.org>; Tue, 23 Aug 2016 06:15:50 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0b-001b2d01.pphosted.com with ESMTP id 24ybqvtj3f-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Tue, 23 Aug 2016 06:15:50 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 23 Aug 2016 04:15:49 -0600
Content-Disposition: inline
In-Reply-To: <3368049.VBoKnTMGvK@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Tony Lindgren <tony@atomide.com>, pavel@ucw.cz, linux@roeck-us.net, rostedt@goodmis.org, linux-pm@vger.kernel.org

On Tue, Aug 23, 2016 at 03:52:12AM +0200, Rafael J. Wysocki wrote:
> On Monday, August 22, 2016 05:59:17 PM Paul E. McKenney wrote:
> > On Mon, Aug 22, 2016 at 05:45:49PM -0700, Tony Lindgren wrote:
> > > * Rafael J. Wysocki <rjw@rjwysocki.net> [160822 10:30]:
> > > > On Saturday, August 20, 2016 07:28:37 AM Tony Lindgren wrote:
> > > > > * Rafael J. Wysocki <rjw@rjwysocki.net> [160819 18:35]:
> > > > > > On Thursday, August 18, 2016 03:51:52 PM Tony Lindgren wrote:
> > > > > > > Hi,
> > > > > > > 
> > > > > > > * Paul E. McKenney <paulmck@linux.vnet.ibm.com> [160615 14:16]:
> > > > > > > > Hello!
> > > > > > > > 
> > > > > > > > Ingo was not comfortable taking these through -tip, which is understandable,
> > > > > > > > given that they don't depend on each other or on anything else not already
> > > > > > > > in mainline, and that they don't have anything to do with -tip.
> > > > > > > > 
> > > > > > > > So what would you guys like to do with these?
> > > > > > > > 
> > > > > > > > They may be pulled from 13e698e68f75 (power: Use _rcuidle for
> > > > > > > > suspend/resume tracepoints) in my -rcu tree:
> > > > > > > > 
> > > > > > > > 	git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
> > > > > > > > 
> > > > > > > 
> > > > > > > Rafael, looks like commit 13e698e68f75 is still missing from the
> > > > > > > mainline tree. Care to merge it to your fixes so I don't have to
> > > > > > > keep looking at that splat on daily basis?
> > > > > > 
> > > > > > I could pull it if I knew where to pull it from.  The above gives me
> > > > > > "Already up-to-date."
> > > > > 
> > > > > Here are the ones still missing:
> > > > > 
> > > > > $ git log --pretty=oneline v4.7-rc2..13e698e68f75
> > > > > 13e698e68f75708c45241a2dad23cd6b65181056 power: Use _rcuidle for suspend/resume tracepoints
> > > > > 320e2a2d081b6c519f80fca9377b8fb90db7bb9c power: Add _rcuidle suffix to allow rpm_resume() to be called from idle
> > > > > b72aadb1d082d3935cbffd60e979238252045971 power: Add _rcuidle suffix to allow rpm_idle() use from idle
> > > > > 
> > > > > So maybe just git merge 13e698e68f75 if you have the linux-rcu.git
> > > > > fetched and the above look OK to you?
> > > > 
> > > > If I do
> > > > 
> > > > $ git fetch git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
> > > > 
> > > > and then
> > > > 
> > > > $ git show 13e698e68f75
> > > > 
> > > > then it tells me
> > > > 
> > > > fatal: ambiguous argument '13e698e68f75': unknown revision or path not in the working tree.
> > > > 
> > > > Do I need to fetch it in any special way or something?
> > > 
> > > Well I usuall add things to my .git/config like:
> > > 
> > > [remote "rcu"]
> > > 	url = git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
> > > 	fetch = refs/heads/*:refs/remotes/rcu/*
> > > 
> > > And then do git fetch --no-tags on what I need. There's probably
> > > some easy way to do that temporarily too :)
> > > 
> > > But now doing git fetch --no-tags rcu here with produces this
> > > for me:
> > > ...
> > >  ! [rejected]        rcu/dev    -> rcu/rcu/dev  (non-fast-forward)
> > >  ! [rejected]        rcu/next   -> rcu/rcu/next  (non-fast-forward)
> > > 
> > > So maybe that branch got trashed and the commit is there no more.
> > 
> > The trick is that rcu/dev and rcu/next simply mark my current development
> > branch and the stuff I want Stephen Rothwell to pull into -next,
> > respectively.
> > 
> > > Paul, do you have 13e698e68f75 still somewhere or want me to push
> > > out a branch with that?
> > 
> > The permanent branch name for those changes is power.2016.06.15a,
> > so those should be pullable from anywhere.
> > 
> > Or please do feel free to push from your tree if that works better.
> > However they get where they need to go, I am good!  ;-)
> 
> I guess I'll just apply the patches you've sent directly then.

Works for me!

							Thanx, Paul

