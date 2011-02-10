From: Ian Campbell <ijc@hellion.org.uk>
Subject: Re: [Xen-devel] Re: [PATCH 0/2] Fix hangup after
 creating checkpoint on Xen.
Date: Thu, 10 Feb 2011 11:40:05 +0000
Message-ID: <1297338005.20491.163.camel__45846.6908232824$1297338083$gmane$org@zakaz.uk.xensource.com>
References: <Pine.LNX.4.44L0.1102091837050.18843-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1102091837050.18843-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, LKML <linux-kernel@vger.kernel.org>, Brendan Cully <brendan@cs.ubc.ca>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "SUZUKI,
	Kazuhiro" <kaz@jp.fujitsu.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 2011-02-09 at 23:42 +0000, Alan Stern wrote:
> In fact there already is a "fast suspend & resume" path in the PM core.  
> It's the freeze/thaw procedure used when starting to hibernate.  The
> documentation specifically says that drivers' freeze methods are
> supposed to quiesce their devices but not change power levels.  In
> addition, the thaw method is invoked as part of recovery from a failed
> hibernation attempt, so it already has the "cancel" semantics that xen 
> seems to want.

Sounds like that would work and I would much prefer to simply make
correct use of the core functionality.

So PMSG_FREEZE is balanced by either PMSG_RECOVER or PMSG_THAW depending
on whether the suspend was cancelled or not? So the sequence of events
is something like:
	dpm_suspend_start(PMSG_FREEZE);
         
		dpm_suspend_noirq(PMSG_FREEZE);
                         
			sysdev_suspend(PMSG_QUIESCE);
			cancelled = suspend_hypercall()
			sysdev_resume();
                 
		dpm_resume_noirq(cancelled ? PMSG_RECOVER : PMSG_THAW);
         
	dpm_resume_end(cancelled ? PMSG_RECOVER : PMSG_THAW);
?

(For comparison we currently have:
> > >         dpm_suspend_start(PMSG_SUSPEND);
> > >         
> > >                 dpm_suspend_noirq(PMSG_SUSPEND);
> > >                         
> > >                         sysdev_suspend(PMSG_SUSPEND);
> > >                         /* suspend hypercall */
> > >                         sysdev_resume();
> > >                 
> > >                 dpm_resume_noirq(PMSG_RESUME);
> > >         
> > >         dpm_resume_end(PMSG_RESUME);
)

Ian.
-- 
Ian Campbell
Current Noise: Neil Young - Angry World

If only one could get that wonderful feeling of accomplishment without
having to accomplish anything.
