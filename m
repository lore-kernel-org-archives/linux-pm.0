From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Should suspend plug low-level devices?
Date: Thu, 17 Mar 2016 14:53:42 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1603171452140.2097-100000@iolanthe.rowland.org>
References: <CAJZ5v0i=7Sz17yr1_1fLiJq6oWRDRHOFukkzn3N=y3empshVGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:53614 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932948AbcCQSxo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Mar 2016 14:53:44 -0400
In-Reply-To: <CAJZ5v0i=7Sz17yr1_1fLiJq6oWRDRHOFukkzn3N=y3empshVGw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>, Peter Chen <hzpeterchen@gmail.com>, Florian Mickler <florian@mickler.org>, Linux-pm mailing list <linux-pm@vger.kernel.org>

On Thu, 17 Mar 2016, Rafael J. Wysocki wrote:

> I thought Tejun was talking about getting rid of userspace freezing.
> Sorry if that was not the case.
> 
> As I've already said for multiple times, I think that the freezing
> should really be limited to user space as a rule.  And in particular,
> if freezing of any kernel threads or workqueues etc causes problems to
> happen, the code using those freezable things is simply buggy and
> needs to be fixed.  Most likely by getting rid of the freezing from
> it.

I agree, except that I think the most likely solution is to delay the 
operations that require a freezable thing until after the system is 
resumed.

Alan Stern

