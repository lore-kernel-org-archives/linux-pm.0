From: Alan Stern <stern@rowland.harvard.edu>
Subject: Should suspend plug low-level devices?
Date: Wed, 16 Mar 2016 11:37:35 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1603161127020.2250-100000@iolanthe.rowland.org>
References: <20160316150053.GG6980@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:51176 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S964917AbcCPPhh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Mar 2016 11:37:37 -0400
In-Reply-To: <20160316150053.GG6980@mtj.duckdns.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Peter Chen <hzpeterchen@gmail.com>, florian@mickler.org, jkosina@suse.cz, Linux-pm mailing list <linux-pm@vger.kernel.org>

[Removed linux-usb and usb-storage from CC: and added linux-pm; changed 
$SUBJECT]

On Wed, 16 Mar 2016, Tejun Heo wrote:

> Hello, Jan, Alan.
> 
> On Tue, Mar 15, 2016 at 10:25:43AM +0100, Jan Kara wrote:
> > > The kernel does suspend device drivers; that is, it invokes their
> > > suspend callbacks.  But it doesn't "freeze" them in any sense.  Once a 
> > > driver has been suspended, it assumes it won't receive any I/O requests 
> > > until it has been resumed.  Therefore the kernel first has to prevent 
> > > all the upper layers from generating such requests and/or sending them 
> > > to the low-level drivers.
> > 
> > OK, so Tejun and you should talk together because you both seem to want
> > something else... If I understand it right, Tejun wants suspended devices
> > to just queue requests that have been submitted after these devices were
> > suspended and complete them once they are resumed...
> 
> Yeah, I suppose that's why we have the code base we do now.  I don't
> think freezing kernel threads is the right mechanism to plug IO
> devices during suspend.  It's way too error-prone and causes a
> dependency nightmare as it acts essentially as a system-wide lock.
> 
> More complex drivers already plug themselves which are necessary no
> matter what as upper layers or some kthreads aren't the only sources
> of commands to devices.  We can plug at block layer for IOs coming
> down from higher layers.  We can even provide a mechanism to plug
> certain kthreads if necessary but they should be contained in the
> driver - e.g. the suspend callback specifically blocking certain
> specific kthreads - instead of the vague "the system is generally
> stopped now and it seems to work most of the time" that we're doing
> now.

Doing what you suggest would require a tremendous effort.  There are
lots and lots of drivers that have no provisions for plugging; they
would all need to be modified.  Changing the higher layers instead (to
prevent them from generating I/O requests during suspend) seems much
easier.

The original design of the PM subsystem was intended to make life
easier for drivers by minimizing the amount of work needed to support
suspend/resume.  Maybe the decision to do it that way was wrong, but
it's kind of late to change the design now.

I foresee other kinds of problems, too.  Suppose after a suspend 
starts, some higher layer code creates an I/O request with a short 
timeout.  If the device weren't suspended the request would succeed -- 
should it time out and fail now that the system is going to sleep?  
That would make system sleep transitions non-transparent.

Alan Stern

