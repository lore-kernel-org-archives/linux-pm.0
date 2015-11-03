From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/3] PM, vfs: use filesystem freezing instead of kthread freezer
Date: Tue, 03 Nov 2015 05:06:01 +0100
Message-ID: <2254911.sCQ2smOA47@vostro.rjw.lan>
References: <Pine.LNX.4.44L0.1510301637310.1659-100000@iolanthe.rowland.org> <2258525.D9qdTJBeTN@vostro.rjw.lan> <20151103001053.GL10656@dastard>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56136 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751275AbbKCDgz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 Nov 2015 22:36:55 -0500
In-Reply-To: <20151103001053.GL10656@dastard>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Jiri Kosina <jikos@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org

On Tuesday, November 03, 2015 11:10:53 AM Dave Chinner wrote:
> On Mon, Nov 02, 2015 at 03:43:07AM +0100, Rafael J. Wysocki wrote:
> > I guess it may also helps to address the case when a device is removed from a
> > suspended system, written to on another system in the meantime and inserted
> > back into the (still suspended) original system which then is resumed.  Today
> > this is an almost guaranteed data corruption scenario, but if the filesystem in
> > question is properly frozen during suspend, the driver should be able to detect
> > superblock changes during unfreeze.
> 
> Never going to work. There is no guarantee that a write to a
> filesystem by a third party device is going to change the superblock
> (or any metadata in the rest of the filesystem) in any detectable
> way.  Hence freezing filesystems will not prevent Bad Things
> Happening if you do this while your system is suspended.

OK, thanks for the clarification.

Cheers,
Rafael

