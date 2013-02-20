From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] freezer: configure user space process frozen along with
 kernel threads
Date: Wed, 20 Feb 2013 23:39:01 +0100
Message-ID: <20130220223901.GD23856@xo-6d-61-c0.localdomain>
References: <1361326525.9753.1.camel@fli24-HP-Compaq-8100-Elite-CMT-PC>
 <878v6jjdoq.fsf@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:57120 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716Ab3BTWjM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Feb 2013 17:39:12 -0500
Content-Disposition: inline
In-Reply-To: <878v6jjdoq.fsf@xmission.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Li Fei <fei.li@intel.com>, rjw@sisk.pl, len.brown@intel.com, mingo@redhat.com, peterz@infradead.org, akpm@linux-foundation.org, viro@zeniv.linux.org.uk, gorcunov@openvz.org, rientjes@google.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, chuansheng.liu@intel.com, biao.wang@intel.com

On Wed 2013-02-20 05:51:49, Eric W. Biederman wrote:
> Li Fei <fei.li@intel.com> writes:
> 
> > There is well known issue that freezing will fail in case that fuse
> > daemon is frozen firstly with some requests not handled, as the fuse
> > usage task is waiting for the response from fuse daemon and can't be
> > frozen. To solve the issue as above, make fuse daemon frozen after
> > all user space processes frozen and during the kernel threads frozen
> > phase.
> >
> > After discussion, at present it's generally agreed that:
> > 1) It's only the fuse daemon itself know definitely that it needs
> > and can be frozen together with kernel threads;
> > 2) It's helpful to expose interface that user space processes can
> > use to configure user space processes to be frozen together with
> > kernel threads.
> > More information can be found on https://lkml.org/lkml/2013/2/18/174.
> >
> > To support the requirement above, attribute /proc/<PID>/freeze_late
> > is added, writing 1 to it will make the process to be frozen together
> > with kernel threads, and writing 0 to it will make the process to be
> > frozen together with user space processes.
> 
> There are no permission checks on this interface at all which
> potentially could make freeze late loose all meaning.  Certainly
> operating without permission checks needs some justification.
> 
> Then I have the question how does this scale.  Which processes are ok to
> have the freeze late bit set?
> 
> But even more than that fuse is setup to allow unprivileged mounts and
> mostly untrusted processes to act as filesystems, whith a nice kernel
> wrapper.  Now we are going to trust those filesystems with the ability
> to stop the kernel from freezing?
> 
> That seems inherently wrong.

Well, agreed...

It would be cool to treat fuse as a kind of IPC, and have rule that all
processes waiting for fuse need to be in S state (or at least freezeable/killable).

Unfortunately fuse does support mmap, and the way VFS is done, putting
tasks waiting for fuse in S state is not easy.

We could use help in that area...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
