From: Oliver Neukum <oneukum@suse.com>
Subject: Re: Should suspend plug low-level devices?
Date: Thu, 17 Mar 2016 09:20:35 +0100
Message-ID: <1458202835.4312.3.camel@suse.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59061 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755499AbcCQIX1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 17 Mar 2016 04:23:27 -0400
In-Reply-To: <alpine.LNX.2.00.1603170901560.3656@cbobk.fhfr.pm>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Peter Chen <hzpeterchen@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Tejun Heo <tj@kernel.org>, Florian Mickler <florian@mickler.org>, Alan Stern <stern@rowland.harvard.edu>, Jan Kara <jack@suse.cz>, Linux-pm mailing list <linux-pm@vger.kernel.org>

On Thu, 2016-03-17 at 09:02 +0100, Jiri Kosina wrote:
> On Thu, 17 Mar 2016, Oliver Neukum wrote:
> 
> > But what about character devices?
> 
> What makes the special in this context?

Actually nothing, but they don't dpend on file systems.
So I see a basic problem, how does a device driver
know which kernel threads cause IO? Are you assuming
that only those a driver starts itself are important?

	Regards
		Oliver



