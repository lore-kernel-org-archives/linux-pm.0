From: Tejun Heo <tj@kernel.org>
Subject: Re: Should suspend plug low-level devices?
Date: Wed, 16 Mar 2016 17:05:01 -0700
Message-ID: <20160317000501.GM21104@mtj.duckdns.org>
References: <20160316150053.GG6980@mtj.duckdns.org>
 <Pine.LNX.4.44L0.1603161127020.2250-100000@iolanthe.rowland.org>
 <CAJZ5v0j4DGEiKzKwnw4vc2gD-6XXKt2H656Q1kGrRD==y-s5Fw@mail.gmail.com>
 <20160316163554.GK6980@mtj.duckdns.org>
 <CAJZ5v0i=BUSGx6ZKMS8QFeO6ybhbqekzBY+qV2Gn01yTw2DcWg@mail.gmail.com>
 <alpine.LNX.2.00.1603170017280.3656@cbobk.fhfr.pm>
 <CAJZ5v0i=7Sz17yr1_1fLiJq6oWRDRHOFukkzn3N=y3empshVGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:34249 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967159AbcCQAFE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Mar 2016 20:05:04 -0400
Received: by mail-io0-f178.google.com with SMTP id m184so79620760iof.1
        for <linux-pm@vger.kernel.org>; Wed, 16 Mar 2016 17:05:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i=7Sz17yr1_1fLiJq6oWRDRHOFukkzn3N=y3empshVGw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Jan Kara <jack@suse.cz>, Peter Chen <hzpeterchen@gmail.com>, Florian Mickler <florian@mickler.org>, Linux-pm mailing list <linux-pm@vger.kernel.org>

Hello, Rafael, Jiri.

On Thu, Mar 17, 2016 at 12:24:57AM +0100, Rafael J. Wysocki wrote:
> > There are no more writes happening to that region after userspace has been
> > frozen. And we're definitely not getting rid of userspace freezing.
> >
> > Or have I missed the point of your question?
> 
> I thought Tejun was talking about getting rid of userspace freezing.
> Sorry if that was not the case.

Oh, kthreads, definitely.  Userland freezing doesn't cause any
dependency issues in the kernel and I don't see any reason for
changing userland part.

> As I've already said for multiple times, I think that the freezing
> should really be limited to user space as a rule.  And in particular,
> if freezing of any kernel threads or workqueues etc causes problems to
> happen, the code using those freezable things is simply buggy and
> needs to be fixed.  Most likely by getting rid of the freezing from
> it.

We're in full agreement.

Thanks.

-- 
tejun
