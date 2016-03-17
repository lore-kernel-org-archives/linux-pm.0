From: Oliver Neukum <oneukum@suse.com>
Subject: Re: Should suspend plug low-level devices?
Date: Thu, 17 Mar 2016 10:12:09 +0100
Message-ID: <1458205929.4312.11.camel@suse.com>
References: <20160316150053.GG6980@mtj.duckdns.org>
	   <Pine.LNX.4.44L0.1603161127020.2250-100000@iolanthe.rowland.org>
	   <CAJZ5v0j4DGEiKzKwnw4vc2gD-6XXKt2H656Q1kGrRD==y-s5Fw@mail.gmail.com>
	   <20160316163554.GK6980@mtj.duckdns.org>
	   <CAJZ5v0i=BUSGx6ZKMS8QFeO6ybhbqekzBY+qV2Gn01yTw2DcWg@mail.gmail.com>
	   <alpine.LNX.2.00.1603170017280.3656@cbobk.fhfr.pm>
	   <CAJZ5v0i=7Sz17yr1_1fLiJq6oWRDRHOFukkzn3N=y3empshVGw@mail.gmail.com>
	   <alpine.LNX.2.00.1603170036310.3656@cbobk.fhfr.pm>
	  <1458201028.4312.0.camel@suse.com>
	  <alpine.LNX.2.00.1603170901560.3656@cbobk.fhfr.pm>
	 <1458202835.4312.3.camel@suse.com>
	 <alpine.LNX.2.00.1603170931090.3656@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:34180 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932199AbcCQJPA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 17 Mar 2016 05:15:00 -0400
In-Reply-To: <alpine.LNX.2.00.1603170931090.3656@cbobk.fhfr.pm>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Peter Chen <hzpeterchen@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Tejun Heo <tj@kernel.org>, Florian Mickler <florian@mickler.org>, Alan Stern <stern@rowland.harvard.edu>, Jan Kara <jack@suse.cz>, Linux-pm mailing list <linux-pm@vger.kernel.org>

On Thu, 2016-03-17 at 09:35 +0100, Jiri Kosina wrote:
> On Thu, 17 Mar 2016, Oliver Neukum wrote:
> 
> > > What makes the special in this context?
> > 
> > Actually nothing, but they don't dpend on file systems. 
> 
> Sure. And userspace is frozen, so nothing new is happening with them from 
> the process side.

Well, to the same extent as to block devices.

> > So I see a basic problem, how does a device driver know which kernel 
> > threads cause IO? Are you assuming that only those a driver starts 
> > itself are important?
> 
> Every driver should know what the kthreads it is spawning are doing, and 
> whether they should be handled in a special way during suspend (in most 
> cases, they don't, I believe).
> 
> Most kthreads don't generate any IO by themselves; usually they are 
> actualy I/O helpers, which are threads you in fact want to be running 
> during suspend.

Yes, but you are making the assumption that only the kthreads a driver
started are causing IO to it. That is a tall one.

- logging
- network
- device discovery on busses
- detection of media
- knfsd

All these things cause IO and I probably forgot some.
Defined semantics for the threads a driver starts are a good idea,
but it leaves out the really hard cases.

	Regards
		Oliver



