From: Tejun Heo <tj@kernel.org>
Subject: Re: Should suspend plug low-level devices?
Date: Fri, 18 Mar 2016 16:32:42 -0400
Message-ID: <20160318203242.GL20028@mtj.duckdns.org>
References: <20160316163410.GJ6980@mtj.duckdns.org>
 <Pine.LNX.4.44L0.1603171433300.2097-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:35368 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756651AbcCRUcq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Mar 2016 16:32:46 -0400
Received: by mail-qk0-f178.google.com with SMTP id o6so54239334qkc.2
        for <linux-pm@vger.kernel.org>; Fri, 18 Mar 2016 13:32:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1603171433300.2097-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Jan Kara <jack@suse.cz>, Peter Chen <hzpeterchen@gmail.com>, florian@mickler.org, jkosina@suse.cz, Linux-pm mailing list <linux-pm@vger.kernel.org>

Hello,

On Thu, Mar 17, 2016 at 02:51:36PM -0400, Alan Stern wrote:
> > Stopping kthreads in itself is fine but the problem is that we
> > currently don't know who's stopping what.  Just making each freezing
> > explicit, say, an explicit invocation of kthread_freeze_kthread(),
> > wouldn't be that difficult and would go a long way.  e.g. It would
> > immediately solve the problem arising from kthread freezing order not
> > matching device dependency hierarchy.
> 
> We're talking about workqueues in particular.  Freezing order is not 
> the issue.

Whether something is running on kthread or workqueue doesn't make any
difference.  Why would it?  It's about dependency chain, not what
something is running on.

> > * Make block layer plug bio's from upper layers.
> > 
> > * Visit each freezable workqueue or kthread users and convert them to
> >   plug explicitly.
> 
> How would this help the case in question?  If a workqueue is plugged 
> instead of frozen, won't flush_delayed_work still deadlock?

By plugging and unplugging in a well defined order rather than
"whatever comes first in workqueue or task lists".

> kthreads (including workqueues) get frozen at controlled places.  
> Presumably they are smart enough not to allow themselves to be frozen
> while any I/Os are in flight.

I don't think that's the main problem here.

Thanks.

-- 
tejun
