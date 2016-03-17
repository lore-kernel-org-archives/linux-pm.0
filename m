From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Should suspend plug low-level devices?
Date: Thu, 17 Mar 2016 14:58:31 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1603171455541.2097-100000@iolanthe.rowland.org>
References: <20160317000501.GM21104@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:53654 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932975AbcCQS6c (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Mar 2016 14:58:32 -0400
In-Reply-To: <20160317000501.GM21104@mtj.duckdns.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Jiri Kosina <jikos@kernel.org>, Jan Kara <jack@suse.cz>, Peter Chen <hzpeterchen@gmail.com>, Florian Mickler <florian@mickler.org>, Linux-pm mailing list <linux-pm@vger.kernel.org>

On Wed, 16 Mar 2016, Tejun Heo wrote:

> Hello, Rafael, Jiri.
> 
> On Thu, Mar 17, 2016 at 12:24:57AM +0100, Rafael J. Wysocki wrote:
> > > There are no more writes happening to that region after userspace has been
> > > frozen. And we're definitely not getting rid of userspace freezing.
> > >
> > > Or have I missed the point of your question?
> > 
> > I thought Tejun was talking about getting rid of userspace freezing.
> > Sorry if that was not the case.
> 
> Oh, kthreads, definitely.  Userland freezing doesn't cause any
> dependency issues in the kernel and I don't see any reason for
> changing userland part.

Actually, it does cause dependency issues.  The prototype example is
fuse, when one process can't be frozen because it is waiting in the
kernel for file I/O to complete, but the I/O involves a fuse filesystem
and the userspace driver is already frozen.

Alan Stern

