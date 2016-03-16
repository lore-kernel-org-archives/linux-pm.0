From: Jiri Kosina <jikos@kernel.org>
Subject: Re: Should suspend plug low-level devices?
Date: Thu, 17 Mar 2016 00:18:30 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1603170017280.3656@cbobk.fhfr.pm>
References: <20160316150053.GG6980@mtj.duckdns.org> <Pine.LNX.4.44L0.1603161127020.2250-100000@iolanthe.rowland.org> <CAJZ5v0j4DGEiKzKwnw4vc2gD-6XXKt2H656Q1kGrRD==y-s5Fw@mail.gmail.com> <20160316163554.GK6980@mtj.duckdns.org>
 <CAJZ5v0i=BUSGx6ZKMS8QFeO6ybhbqekzBY+qV2Gn01yTw2DcWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40046 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752454AbcCPXSc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 16 Mar 2016 19:18:32 -0400
In-Reply-To: <CAJZ5v0i=BUSGx6ZKMS8QFeO6ybhbqekzBY+qV2Gn01yTw2DcWg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Jan Kara <jack@suse.cz>, Peter Chen <hzpeterchen@gmail.com>, florian@mickler.org, Linux-pm mailing list <linux-pm@vger.kernel.org>

On Wed, 16 Mar 2016, Rafael J. Wysocki wrote:

> > That's what we're doing now.  What I'm suggesting is that we should be
> > plugging the point where they come together instead of the sources of
> > which there can be many.  Freezing does block a lot of those sources
> > but not all.
> 
> Well, is there any point where they come together?  Say somebody
> communicates with user space over mmaped address range and writes to
> that go to hardware.  What do we do then?

There are no more writes happening to that region after userspace has been 
frozen. And we're definitely not getting rid of userspace freezing.

Or have I missed the point of your question?

Thanks,

-- 
Jiri Kosina
SUSE Labs

