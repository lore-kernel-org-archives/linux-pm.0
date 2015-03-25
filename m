From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM / sleep: Don't unset parent's direct_complete
Date: Wed, 25 Mar 2015 14:05:57 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1503251403220.1401-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1503251346170.1401-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:45991 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754932AbbCYSF6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Mar 2015 14:05:58 -0400
In-Reply-To: <Pine.LNX.4.44L0.1503251346170.1401-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org

On Wed, 25 Mar 2015, Alan Stern wrote:

> On Wed, 25 Mar 2015, Tomeu Vizoso wrote:
> 
> > If a device isn't going to be fully-suspended because there isn't an
> > implementation of the suspend callback, there's no need to make sure
> > that its parent is going to be fully-suspended as well.
> 
> What do you mean by "fully-suspended"?
> 
> What if the parent has several children?  Maybe some of them have 
> implementations of the suspend callback and the others don't.  Will 
> your patch do the right thing then?

After thinking about it some more, I realized this won't be a problem.

But what if the device has a child that _does_ have a suspend callback?  
In that case the child will need to be resumed, so the device's parent
cannot be allowed to remain in runtime suspend when the system wakes
up.  Hence the parent's direct_complete must be cleared.

Alan Stern

