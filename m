From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 03/10] freezer: add new freezable helpers using
 freezer_do_not_count()
Date: Fri, 3 May 2013 09:54:48 -0700
Message-ID: <20130503165448.GA22709@mtj.dyndns.org>
References: <20130503040934.GA16968@mtj.dyndns.org>
 <Pine.LNX.4.44L0.1305031017030.1513-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:43417 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759592Ab3ECQyz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 May 2013 12:54:55 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1305031017030.1513-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Colin Cross <ccross@android.com>, Linux PM list <linux-pm@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>, Oleg Nesterov <oleg@redhat.com>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Jeff Layton <jlayton@redhat.com>, Mandeep Baines <msb@chromium.org>

On Fri, May 03, 2013 at 10:18:17AM -0400, Alan Stern wrote:
> Don't forget about freezable kernel threads.  They never cross the 
> kernel/user boundary.

Doesn't really matter for this purpose.  They first of all can't be
moved into !root cgroups and thus can't be cgroup-frozen and even if
they could they can't be killed or ptraced, so they just don't play
the same game.

Thanks.

-- 
tejun
