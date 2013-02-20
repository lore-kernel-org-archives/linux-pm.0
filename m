From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] freezer: configure user space process frozen along with
 kernel threads
Date: Wed, 20 Feb 2013 15:48:43 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1302201541000.1671-100000@iolanthe.rowland.org>
References: <87obfeivc3.fsf@xmission.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:35058 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S935172Ab3BTUso (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Feb 2013 15:48:44 -0500
In-Reply-To: <87obfeivc3.fsf@xmission.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Li Fei <fei.li@intel.com>, pavel@ucw.cz, rjw@sisk.pl, len.brown@intel.com, mingo@redhat.com, peterz@infradead.org, akpm@linux-foundation.org, viro@zeniv.linux.org.uk, gorcunov@openvz.org, rientjes@google.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, chuansheng.liu@intel.com, biao.wang@intel.com

On Wed, 20 Feb 2013, Eric W. Biederman wrote:

> >> Why can't the fuse filesystem freeze when there are requests pending?
> >
> > It _can_ freeze (that is, the fuse daemon can).  The problem is that
> > tasks _using_ the fuse filsystem can't if the daemon doesn't respond. 
> 
> Which is what I meant when I said that the fuse filesystem couldn't
> freeze.

Oh, okay.  But it's no different from any other filesystem in that
respect.  Processes generally can't be frozen while they are waiting
for filesystem I/O to complete.  In many cases they can't receive 
signals either (they are in an uninterruptible wait state).

> > These tasks are stuck in uninterruptible wait states deep in the
> > filesystem layer, probably holding important locks.  They can't be
> > frozen until the outstanding requests complete.
> 
> Why is it that processes that can be preempted can't be frozen?

There's a big difference between preemption and freezing: Preemption
is involuntary whereas freezing is voluntary.  It's like the difference
between preemptive and cooperative multitasking.

Processes can be frozen only by making explicit checks, and they 
mustn't be frozen while they are holding locks that would prevent other 
processes from reaching one of those checks.

> At most I would suggest that processes be frozen in reverse priority
> order.  Which unless there is a priority inversion should solve this
> problem without an additional proc file.

Do fuse daemons (and the processes they rely upon) run with elevated 
priority?

Alan Stern

