From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] freezer: configure user space process frozen along with kernel threads
Date: Wed, 20 Feb 2013 12:28:12 -0800
Message-ID: <87obfeivc3.fsf@xmission.com>
References: <Pine.LNX.4.44L0.1302201021210.1671-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from out03.mta.xmission.com ([166.70.13.233]:42329 "EHLO
	out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934793Ab3BTU2l (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Feb 2013 15:28:41 -0500
In-Reply-To: <Pine.LNX.4.44L0.1302201021210.1671-100000@iolanthe.rowland.org>
	(Alan Stern's message of "Wed, 20 Feb 2013 10:24:12 -0500 (EST)")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Li Fei <fei.li@intel.com>, pavel@ucw.cz, rjw@sisk.pl, len.brown@intel.com, mingo@redhat.com, peterz@infradead.org, akpm@linux-foundation.org, viro@zeniv.linux.org.uk, gorcunov@openvz.org, rientjes@google.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, chuansheng.liu@intel.com, biao.wang@intel.com

Alan Stern <stern@rowland.harvard.edu> writes:

> On Wed, 20 Feb 2013, Eric W. Biederman wrote:
>
>> Why can't the fuse filesystem freeze when there are requests pending?
>
> It _can_ freeze (that is, the fuse daemon can).  The problem is that
> tasks _using_ the fuse filsystem can't if the daemon doesn't respond. 

Which is what I meant when I said that the fuse filesystem couldn't
freeze.
 
> These tasks are stuck in uninterruptible wait states deep in the
> filesystem layer, probably holding important locks.  They can't be
> frozen until the outstanding requests complete.

Why is it that processes that can be preempted can't be frozen?

At most I would suggest that processes be frozen in reverse priority
order.  Which unless there is a priority inversion should solve this
problem without an additional proc file.

Adding a userspace interface that doesn't come close to doing the right
thing automatically and that is brittle and will likely fail in ways
even stranger and harder to track ways than fuse is failing today seems
like totally the wrong direction to go.  Not adding any permission
checks to the proc files just compounds the problem.

Eric
