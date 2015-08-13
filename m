From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: 3.18: lockdep problems in cpufreq
Date: Thu, 13 Aug 2015 09:17:44 +0100
Message-ID: <20150813081744.GN7557@n2100.arm.linux.org.uk>
References: <20141214213655.GA11285@n2100.arm.linux.org.uk>
 <2574268.XBqpdL2VLI@vostro.rjw.lan>
 <20150811170357.GA24529@n2100.arm.linux.org.uk>
 <5160300.5D2Dvly8u9@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:56301 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751654AbbHMISB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2015 04:18:01 -0400
Content-Disposition: inline
In-Reply-To: <5160300.5D2Dvly8u9@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Eduardo Valentin <edubezval@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, Yadwinder Singh Brar <yadi.brar@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Thu, Aug 13, 2015 at 03:20:35AM +0200, Rafael J. Wysocki wrote:
> On Tuesday, August 11, 2015 06:03:57 PM Russell King - ARM Linux wrote:
> > On Tue, May 19, 2015 at 12:05:55AM +0200, Rafael J. Wysocki wrote:
> > > On Monday, May 18, 2015 07:56:45 PM Russell King - ARM Linux wrote:
> > > > On Tue, Dec 16, 2014 at 09:11:53AM +0530, Viresh Kumar wrote:
> > > > > On 16 December 2014 at 04:39, Russell King - ARM Linux
> > > > > <linux@arm.linux.org.uk> wrote:
> > > > > > Well, here's a patch which I'm running on top of 3.18 at the moment,
> > > > > > which is basically what I described in my email, and I'm running with it
> > > > > > and it is without any lockdep complaint.
> > > > > 
> > > > > We need two separate patches now, one for 3.18 and other one for 3.19-rc.
> > > > > 3.19 has see lots of changes in this particular file and so we need to
> > > > > change few things here.
> > > > 
> > > > What happened with this?  I'm still carrying the patch.
> > > 
> > > This should go in through the thermal tree.  Eduardo?
> > 
> > Having waited a long time for any kind of response from Eduardo, I've
> > given up.  My conclusion is that Eduardo isn't interested in this.
> > 
> > I've re-checked, and the AB-BA deadlock is still there in the latest
> > code.  So, I've taken it upon myself to throw this into my for-next
> > branch to force the issue - not something I _want_ to do, but I'm doing
> > this out of frustration.  It's clear to me that "playing nice" by email
> > does _not_ work with some people.
> > 
> > I'm rather hoping that Stephen reports a merge conflict with linux-next
> > this evening to highlight this situation.  I've added additional commentry
> > to the commit message on the patch giving the reason why I've done this,
> > and the relevant message IDs showing the past history.
> > 
> > I've not decided whether I'm going to ask Linus to take this patch
> > directly or not, that rather depends whether there's any co-operation
> > from Eduardo on this.  I'd rather Eduardo took the patch.
> > 
> > The patch I have has had to be updated again for changes to the driver,
> > but I really don't see the point of re-posting it just for it to be
> > ignored yet again.
> > 
> > I'm really disappointed by this dysfunctional state of affairs, and
> > that what should be an urgent fix for an observable problem is still
> > not merged some nine months after it was first identified.
> 
> I guess it might help if you sent the updated patch in a new thread.

That I doubt.  Eduardo has not bothered to reply at _any_ time.  I
have to question whether there is anyone even reading that email
address, or whether it's a redirect to /dev/null.  All the evidence I
have right now is that this Eduardo is a ficticous character.

I would have at least expected some complaints when I said "I've put
it in linux-next" but... absolutely nothing.

So... my only conclusion is that you're all pulling my leg that there
_is_ this "Eduardo" maintainer who's supposed to be taking patches for
this stuff.

As I've said, I'm not bothering with this anymore, it's just far too
much effort to play these stupid games.  The deadlock can stay for all
I care.

Sorry.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
