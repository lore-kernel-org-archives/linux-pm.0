From: Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH 0/3] PM, vfs: use filesystem freezing instead of kthread
 freezer
Date: Mon, 02 Nov 2015 12:00:31 +0100
Message-ID: <1446462031.25345.15.camel@suse.com>
References: <Pine.LNX.4.44L0.1510301637310.1659-100000@iolanthe.rowland.org>
	 <6015070.Gclh0s3EvS@vostro.rjw.lan>
	 <alpine.LNX.2.00.1510310844360.17538@pobox.suse.cz>
	 <2258525.D9qdTJBeTN@vostro.rjw.lan>
	 <alpine.LNX.2.00.1511021137310.22567@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41857 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751834AbbKBLCN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 2 Nov 2015 06:02:13 -0500
In-Reply-To: <alpine.LNX.2.00.1511021137310.22567@pobox.suse.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alan Stern <stern@rowland.harvard.edu>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org

On Mon, 2015-11-02 at 11:45 +0100, Jiri Kosina wrote:
> > For example, if user space does a "read" or "write" on a character
> device
> > which is runtime-suspended at that point, the driver may want to
> resume the
> > device temporarily, carry out the operation and suspend it again,
> but that
> > generally won't work for the system suspend case.
> 
> But why would this even be relevant in this discussion, given that at
> the 
> point we are talking about, the whole userspace has been frozen
> already?

It really doesn't matter whether the thread in question is a kernel
thread or user space. Device detection is even worse.
Kernel threads that do either of these things must stop at
defined points. You can use the freezer or go to another mechanism.
I just doubt they'd act much different in the end.

	Regards
		Oliver


