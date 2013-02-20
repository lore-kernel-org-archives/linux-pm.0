From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] freezer: configure user space process frozen along with
 kernel threads
Date: Wed, 20 Feb 2013 16:58:03 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1302201652460.1671-100000@iolanthe.rowland.org>
References: <87zjyyekh8.fsf@xmission.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:35153 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751129Ab3BTV6F (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Feb 2013 16:58:05 -0500
In-Reply-To: <87zjyyekh8.fsf@xmission.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Li Fei <fei.li@intel.com>, pavel@ucw.cz, rjw@sisk.pl, len.brown@intel.com, mingo@redhat.com, peterz@infradead.org, akpm@linux-foundation.org, viro@zeniv.linux.org.uk, gorcunov@openvz.org, rientjes@google.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, chuansheng.liu@intel.com, biao.wang@intel.com

On Wed, 20 Feb 2013, Eric W. Biederman wrote:

> > Oh, okay.  But it's no different from any other filesystem in that
> > respect.  Processes generally can't be frozen while they are waiting
> > for filesystem I/O to complete.  In many cases they can't receive 
> > signals either (they are in an uninterruptible wait state).
> 
> Ick.  So the process freezer and all network filesystems has problems?
> Especially nfs?

I don't know any of the details.  On the other hand, it is not exactly 
hot, up-to-the-minute news to learn that NFS has problems...

> > There's a big difference between preemption and freezing: Preemption
> > is involuntary whereas freezing is voluntary.  It's like the difference
> > between preemptive and cooperative multitasking.
> 
> I hadn't realized freezing was voluntary.  That certainly seems like a
> pain.

More precisely, it's voluntary when processes are running in kernel 
mode.  When they're in user mode there is no problem; they get sent a 
signal and then go into the freezer when they switch to kernel mode to 
process the signal.

> >> At most I would suggest that processes be frozen in reverse priority
> >> order.  Which unless there is a priority inversion should solve this
> >> problem without an additional proc file.
> >
> > Do fuse daemons (and the processes they rely upon) run with elevated 
> > priority?
> 
> I don't know if the daemons are of an elevated scheduling priority today
> but if they aren't it is as easy to require an elevated scheduling
> priority as it is to require a magic freezer priority.  Furthermore if
> they don't run at an elevated priority there is the possibility of
> priority inversion.

This seems like a reasonable thing to try out.

Alan Stern

