From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/1] suspend: delete sys_sync()
Date: Thu, 09 Jul 2015 00:03:05 +0200
Message-ID: <1850836.6zSgANe26P@vostro.rjw.lan>
References: <4290667.ZqInAykFGS@vostro.rjw.lan> <1522789.fQO6RUUx40@vostro.rjw.lan> <1436341873.5636.5.camel@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57937 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755602AbbGHVgh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jul 2015 17:36:37 -0400
In-Reply-To: <1436341873.5636.5.camel@suse.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Oliver Neukum <oneukum@suse.com>
Cc: Dave Chinner <david@fromorbit.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>, Len Brown <lenb@kernel.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Alan Stern <stern@rowland.harvard.edu>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

On Wednesday, July 08, 2015 09:51:13 AM Oliver Neukum wrote:
> On Wed, 2015-07-08 at 00:11 +0200, Rafael J. Wysocki wrote:
> > On Tuesday, July 07, 2015 04:38:26 PM Oliver Neukum wrote:
> >  
> > > That is a tough nut. But that's not a reason to make it worse.
> > > I'd say there's no reason not to use a secondary interface to
> > > suspend without syncing or to extend or introduce such an interface
> > > if the API is deficient.
> > 
> > Well, the point here is that the sync we have doesn't prevent all potentially
> > possible bad things from happening.  It's a partial measure at best in that
> > respect.
> 
> Well, removed hardware doesn't work. That is a very basic limitation.
> But can we guarantee that any returned syscall actually wrote to disk?
> Yes, but it must be done in kernel space. So doing a sync has a true
> benefit.
> I don't see why you would want to generally remove it. What is wrong
> with an interface allowing a selection there to those who don't care
> about additional guarantees?

Nothing and I'm not discussing that (I've said that already at least once in
this thread).

What I'm questioning is the "why" of calling sys_sync() from the kernel.

If we had a good answer to why we do that to start with, the whole discussion
wouldn't be necessary.

So the answer I'm getting from this thread so far is something like "It is a
safety measure to prevent users from losing data if they pull removable storage
out of the system while suspended".

Your point about the returned syscall guaranees is a good one, but still.

Thanks,
Rafael

