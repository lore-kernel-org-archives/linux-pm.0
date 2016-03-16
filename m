From: Tejun Heo <tj@kernel.org>
Subject: Re: Should suspend plug low-level devices?
Date: Wed, 16 Mar 2016 09:34:10 -0700
Message-ID: <20160316163410.GJ6980@mtj.duckdns.org>
References: <20160316150053.GG6980@mtj.duckdns.org>
 <Pine.LNX.4.44L0.1603161127020.2250-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35785 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752236AbcCPQe0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Mar 2016 12:34:26 -0400
Received: by mail-pf0-f169.google.com with SMTP id n5so81306683pfn.2
        for <linux-pm@vger.kernel.org>; Wed, 16 Mar 2016 09:34:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1603161127020.2250-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Jan Kara <jack@suse.cz>, Peter Chen <hzpeterchen@gmail.com>, florian@mickler.org, jkosina@suse.cz, Linux-pm mailing list <linux-pm@vger.kernel.org>

Hello, Alan.

On Wed, Mar 16, 2016 at 11:37:35AM -0400, Alan Stern wrote:
> Doing what you suggest would require a tremendous effort.  There are

I don't know.  Is it?

> lots and lots of drivers that have no provisions for plugging; they
> would all need to be modified.  Changing the higher layers instead (to
> prevent them from generating I/O requests during suspend) seems much
> easier.

Big lock and "much easier" usually don't go together.  I get why we
started out this way - there wasn't anything working and we didn't
quite understand what the actual requirements were and wanted
something more or less working with manageable amount of effort, but I
think we're past the point where we need to address the issue
properly.  The more complex drivers are already doing most of what's
necessary and even for drivers which depend on the freezer the changes
don't need to be too difficult.

Stopping kthreads in itself is fine but the problem is that we
currently don't know who's stopping what.  Just making each freezing
explicit, say, an explicit invocation of kthread_freeze_kthread(),
wouldn't be that difficult and would go a long way.  e.g. It would
immediately solve the problem arising from kthread freezing order not
matching device dependency hierarchy.

> The original design of the PM subsystem was intended to make life
> easier for drivers by minimizing the amount of work needed to support
> suspend/resume.  Maybe the decision to do it that way was wrong, but
> it's kind of late to change the design now.

Hmmm... but that's how most subsystems evolve.  We start out with
something coarse and not quite optimal or even correct and then as we
learn more, the code and design evolve.  I frankly don't think
shifting to driver-side plugging would be *that* difficult.  It's
gonna be quite a bit of work, for sure, but things can be gradual.
For example,

* Make block layer plug bio's from upper layers.

* Visit each freezable workqueue or kthread users and convert them to
  plug explicitly.

> I foresee other kinds of problems, too.  Suppose after a suspend 
> starts, some higher layer code creates an I/O request with a short 
> timeout.  If the device weren't suspended the request would succeed -- 
> should it time out and fail now that the system is going to sleep?  
> That would make system sleep transitions non-transparent.

I can't see how freezing or not freezing would make any difference
there.  What if a kthread gets frozen with with IOs in flight?  The
timeouts would still trigger whether the issuer is frozen or not.  IO
timeouts are mostly implemented in block layer and block layer just
needs to handle it sensibly.

Thanks.

-- 
tejun
