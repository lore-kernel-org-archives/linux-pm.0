From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Should suspend plug low-level devices?
Date: Thu, 17 Mar 2016 14:55:47 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1603171453540.2097-100000@iolanthe.rowland.org>
References: <alpine.LNX.2.00.1603170036310.3656@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:53628 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S934189AbcCQSzs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Mar 2016 14:55:48 -0400
In-Reply-To: <alpine.LNX.2.00.1603170036310.3656@cbobk.fhfr.pm>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>, Peter Chen <hzpeterchen@gmail.com>, Florian Mickler <florian@mickler.org>, Linux-pm mailing list <linux-pm@vger.kernel.org>

On Thu, 17 Mar 2016, Jiri Kosina wrote:

> On Thu, 17 Mar 2016, Rafael J. Wysocki wrote:
> 
> > >> Well, is there any point where they come together?  Say somebody
> > >> communicates with user space over mmaped address range and writes to
> > >> that go to hardware.  What do we do then?
> > >
> > > There are no more writes happening to that region after userspace has been
> > > frozen. And we're definitely not getting rid of userspace freezing.
> > >
> > > Or have I missed the point of your question?
> > 
> > I thought Tejun was talking about getting rid of userspace freezing.
> > Sorry if that was not the case.
> 
> Oh, I definitely belive that the current "holy grail" is to get rid of 
> ktrehad / kernel code freezing. Userspace is a completely different story, 
> I agree.

Why get rid of kernel code freezing?  It is the perfect solution for 
some problems.

> > As I've already said for multiple times, I think that the freezing 
> > should really be limited to user space as a rule.  And in particular, if 
> > freezing of any kernel threads or workqueues etc causes problems to 
> > happen, the code using those freezable things is simply buggy and needs 
> > to be fixed.  Most likely by getting rid of the freezing from it.
> 
> I am (slowly) working towards this goal. First I am trying to make sure 
> that all the kernel is using the kthread freezing API in a well-defined 
> way (which is currently not the case at all).
> 
> Before this is done, it is more or less impossible to analyse the current 
> users and make any decisions on top of that.
> 
> Once some kind of analysis is possible, I am pretty sure that we'll be 
> able to get rid of most kthread freezing by introducing fs freezing during 
> suspend (and fixing a lot of currently existing bugs as a nice 
> side-effect), and perhaps eventually ditch the kthread freezer altogether.

While fs freezing would undoubtedly be a good thing, I don't think it 
will allow you to eliminate kthread (or more specifically, workqueue) 
freezing.

Alan Stern

