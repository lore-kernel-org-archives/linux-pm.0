From: Matt Helsley <matthltc@linux.vnet.ibm.com>
Subject: Re: [PATCH 07/10] futex: use freezable blocking call
Date: Thu, 2 May 2013 12:52:33 -0700
Message-ID: <20130502195233.GC24627@us.ibm.com>
References: <1367271946-7239-1-git-send-email-ccross@android.com>
 <1367271946-7239-8-git-send-email-ccross@android.com>
 <517EF9AB.8080508@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e7.ny.us.ibm.com ([32.97.182.137]:37032 "EHLO e7.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760289Ab3ECW6O (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 3 May 2013 18:58:14 -0400
Received: from /spool/local
	by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <matthltc@linux.vnet.ibm.com>;
	Fri, 3 May 2013 18:58:13 -0400
Content-Disposition: inline
In-Reply-To: <517EF9AB.8080508@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Darren Hart <dvhart@linux.intel.com>
Cc: Colin Cross <ccross@android.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, arve@android.com, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>, Matthew Helsley <matthltc@us.ibm.com>

On Mon, Apr 29, 2013 at 03:52:27PM -0700, Darren Hart wrote:
> Colin,
> 
> I don't know anything about when or when not to use freezable*, and I
> suspect that may be true for others as well. A more complete
> description of why it's acceptable here in the commit log might help
> expedite acceptance.
> 
> 
> Matt,
> 
> I have a vague memory of discussing something similar to this with you.
> Do you see any potential problems here?

Re: vague memories: We discussed futexes in the context of the old
checkpoint/restart patch series (<= 2.6.32).

This change looks correct to me.

> --
> Darren
> 
> On 04/29/2013 02:45 PM, Colin Cross wrote:
> > Avoid waking up every thread sleeping in a futex_wait call during
> > suspend and resume by calling a freezable blocking call.

(in addition to suspend/resume: freeze/thaw via the cgroup freezer.
I'm going to call it freeze/thaw since that should cover both cases..)

Here's my shot at explaining what I *think* the commit is supposed fix:

I imagine that before this patch on a highly-contended futex there
could be a thundering herd during freeze/thaw -- the wakeups are
*likely* to be painful because lots of tasks could be woken from the
schedule() call by the freezer only to find that the futex state hasn't
changed.

With this change the freezer won't wake these tasks up because the
FREEZER_SKIP flag is set while in the schedule() call and thus the
thundering herd won't be triggered by the freezer.

Cheers,
	-Matt Helsley

