From: Oliver Neukum <oneukum@suse.com>
Subject: Re: Should suspend plug low-level devices?
Date: Thu, 17 Mar 2016 08:50:28 +0100
Message-ID: <1458201028.4312.0.camel@suse.com>
References: <20160316150053.GG6980@mtj.duckdns.org>
	 <Pine.LNX.4.44L0.1603161127020.2250-100000@iolanthe.rowland.org>
	 <CAJZ5v0j4DGEiKzKwnw4vc2gD-6XXKt2H656Q1kGrRD==y-s5Fw@mail.gmail.com>
	 <20160316163554.GK6980@mtj.duckdns.org>
	 <CAJZ5v0i=BUSGx6ZKMS8QFeO6ybhbqekzBY+qV2Gn01yTw2DcWg@mail.gmail.com>
	 <alpine.LNX.2.00.1603170017280.3656@cbobk.fhfr.pm>
	 <CAJZ5v0i=7Sz17yr1_1fLiJq6oWRDRHOFukkzn3N=y3empshVGw@mail.gmail.com>
	 <alpine.LNX.2.00.1603170036310.3656@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57140 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754508AbcCQIBQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 17 Mar 2016 04:01:16 -0400
In-Reply-To: <alpine.LNX.2.00.1603170036310.3656@cbobk.fhfr.pm>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Tejun Heo <tj@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Jan Kara <jack@suse.cz>, Peter Chen <hzpeterchen@gmail.com>, Florian Mickler <florian@mickler.org>, Linux-pm mailing list <linux-pm@vger.kernel.org>

On Thu, 2016-03-17 at 00:42 +0100, Jiri Kosina wrote:
> I am (slowly) working towards this goal. First I am trying to make
> sure 
> that all the kernel is using the kthread freezing API in a
> well-defined 
> way (which is currently not the case at all).
> 
> Before this is done, it is more or less impossible to analyse the
> current 
> users and make any decisions on top of that.
> 
> Once some kind of analysis is possible, I am pretty sure that we'll
> be 
> able to get rid of most kthread freezing by introducing fs freezing
> during 
> suspend (and fixing a lot of currently existing bugs as a nice 
> side-effect), and perhaps eventually ditch the kthread freezer
> altogether.

But what about character devices?

	Regards
		Oliver


