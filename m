From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: 3.18: lockdep problems in cpufreq
Date: Thu, 13 Aug 2015 03:20:35 +0200
Message-ID: <5160300.5D2Dvly8u9@vostro.rjw.lan>
References: <20141214213655.GA11285@n2100.arm.linux.org.uk> <2574268.XBqpdL2VLI@vostro.rjw.lan> <20150811170357.GA24529@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:41320 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751182AbbHMAxT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Aug 2015 20:53:19 -0400
In-Reply-To: <20150811170357.GA24529@n2100.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Eduardo Valentin <edubezval@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, Yadwinder Singh Brar <yadi.brar@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Tuesday, August 11, 2015 06:03:57 PM Russell King - ARM Linux wrote:
> On Tue, May 19, 2015 at 12:05:55AM +0200, Rafael J. Wysocki wrote:
> > On Monday, May 18, 2015 07:56:45 PM Russell King - ARM Linux wrote:
> > > On Tue, Dec 16, 2014 at 09:11:53AM +0530, Viresh Kumar wrote:
> > > > On 16 December 2014 at 04:39, Russell King - ARM Linux
> > > > <linux@arm.linux.org.uk> wrote:
> > > > > Well, here's a patch which I'm running on top of 3.18 at the moment,
> > > > > which is basically what I described in my email, and I'm running with it
> > > > > and it is without any lockdep complaint.
> > > > 
> > > > We need two separate patches now, one for 3.18 and other one for 3.19-rc.
> > > > 3.19 has see lots of changes in this particular file and so we need to
> > > > change few things here.
> > > 
> > > What happened with this?  I'm still carrying the patch.
> > 
> > This should go in through the thermal tree.  Eduardo?
> 
> Having waited a long time for any kind of response from Eduardo, I've
> given up.  My conclusion is that Eduardo isn't interested in this.
> 
> I've re-checked, and the AB-BA deadlock is still there in the latest
> code.  So, I've taken it upon myself to throw this into my for-next
> branch to force the issue - not something I _want_ to do, but I'm doing
> this out of frustration.  It's clear to me that "playing nice" by email
> does _not_ work with some people.
> 
> I'm rather hoping that Stephen reports a merge conflict with linux-next
> this evening to highlight this situation.  I've added additional commentry
> to the commit message on the patch giving the reason why I've done this,
> and the relevant message IDs showing the past history.
> 
> I've not decided whether I'm going to ask Linus to take this patch
> directly or not, that rather depends whether there's any co-operation
> from Eduardo on this.  I'd rather Eduardo took the patch.
> 
> The patch I have has had to be updated again for changes to the driver,
> but I really don't see the point of re-posting it just for it to be
> ignored yet again.
> 
> I'm really disappointed by this dysfunctional state of affairs, and
> that what should be an urgent fix for an observable problem is still
> not merged some nine months after it was first identified.

I guess it might help if you sent the updated patch in a new thread.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
