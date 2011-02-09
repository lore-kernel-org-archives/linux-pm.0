From: Brendan Cully <brendan@cs.ubc.ca>
Subject: Re: [PATCH 0/2] Fix hangup after creating checkpoint on
 Xen.
Date: Wed, 9 Feb 2011 15:16:59 -0800
Message-ID: <20110209231659.GB249__43216.5905055173$1297355539$gmane$org@zanzibar.kublai.com>
References: <Pine.LNX.4.44L0.1102081143470.2100-100000@iolanthe.rowland.org>
	<1297186554.9388.248.camel@zakaz.uk.xensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1297186554.9388.248.camel@zakaz.uk.xensource.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ian Campbell <ijc@hellion.org.uk>
Cc: xen-devel@lists.xensource.com, LKML <linux-kernel@vger.kernel.org>, linux-pm@lists.linux-foundation.org, "SUZUKI,
	Kazuhiro" <kaz@jp.fujitsu.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 08 February 2011 at 17:35, Ian Campbell wrote:
> On Tue, 2011-02-08 at 11:46 -0500, Alan Stern wrote:
> > On Tue, 8 Feb 2011, Ian Campbell wrote:
> > 
> > > The problem is that currently we have:
> > > 
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
> > > 
> > > However the suspend hypercall can return a value indicating that the
> > > suspend didn't actually happen (e.g. was cancelled). This is used e.g.
> > > when checkpointing guests, because in that case you want the original
> > > guest to continue. When the suspend didn't happen the drivers need to
> > > recover differently from if it did.
> > 
> > That is odd, and it is quite different from the intended design of the 
> > PM core.  Drivers are supposed to put their devices into a known 
> > suspended state; then afterwards they put the devices back into an 
> > operational state.  What happens while the devices are in the suspended 
> > state isn't supposed to matter -- the system transition can fail, but 
> > devices get treated exactly the same way as if it succeeded.
> > 
> > Why do your drivers need to recover differently based on the success of 
> > the hypercall?
> 
> checkpointing isn't really my area but AIUI you don't want to do a full
> device teardown and reconnect like you would with a proper suspend
> because of the time that takes which prevents you from doing continuous
> rolling checkpoints at granularity which people want to implement
> various disaster recovery schemes.
> 
> Hopefully one of the Xen checkpointing folks will chime in and explain
> why this is not possible to achieve at the individual driver level (or,
> even better, with a patch which does it that way ;-)).

As Ian says, Xen has suspend_cancel because while the normal full
suspend/resume path works, it is much slower, and the work done during
resume is redundant. I don't remember the numbers offhand, but when we
added suspend_cancel I think we could do full suspend/resume in under
100us, which was maybe a couple of orders of magnitude faster than
full resume (largely due to slow xenstore handshaking on resume,
IIRC). It made a big difference for our Remus HA project, which was
checkpointing tens of times per second.

I'd like to keep the fast resume option, and expect that it can be
contained entirely in Xen-specific code. I'll try to get someone to
look into it here.

I think fast resume is somewhat orthogonal to the problem of hanging
on resume, which just sounds like a xen-specific bug in the slow
path.
