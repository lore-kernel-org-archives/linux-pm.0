From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 1/2] Freezer: Introduce PF_FREEZER_NOSIG
Date: Wed, 7 May 2008 14:16:47 +0200
Message-ID: <200805071416.48180.rjw__7849.37260109491$1210162803$gmane$org@sisk.pl>
References: <200805070003.56387.rjw@sisk.pl> <200805070005.20403.rjw@sisk.pl>
	<20080507093621.GF13858@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080507093621.GF13858@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@suse.cz>
Cc: Paul Menage <menage@google.com>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Cedric Le Goater <clg@fr.ibm.com>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 7 of May 2008, Pavel Machek wrote:
> Hi!

Hi,

> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > The freezer currently attempts to distinguish kernel threads from
> > user space tasks by checking if their mm pointer is unset and it
> > does not send fake signals to kernel threads.  However, there are
> > kernel threads, mostly related to networking, that behave like
> > user space tasks and may want to be sent a fake signal to be frozen.
> > 
> > Introduce the new process flag PF_FREEZER_NOSIG that will be set
> > by default for all kernel threads and make the freezer only send
> > fake signals to the tasks having PF_FREEZER_NOSIG unset.  Provide
> > the set_freezable_with_signal() function to be called by the kernel
> > threads that want to be sent a fake signal for freezing.
> > 
> > This patch should not change the freezer's observable behavior.
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> ACK.

Thanks!

> > -static int has_mm(struct task_struct *p)
> > +static inline bool should_send_signal(struct task_struct *p)
> >  {
> > -	return (p->mm && !(p->flags & PF_BORROWED_MM));
> > +	return !(current->flags & PF_FREEZER_NOSIG);
> >  }
> >
> 
> Note that we used to tell kernel threads by ->mm, and now you assume
> that anything created by ktrheadd is kernel thread, ->mm or not.
> 
> I'm not sure if those can differ (->mm = NULL somewhere? Or ->mm =
> something somewhere else?).

It's done in analogy with PF_NOFREEZE, ie. everything that has
set PF_NOFREEZE by default also has PF_FREEZER_NOSIG set by default, so I
really don't expect any problems here.

> I guess this should go to -mm for a long test...

Yes, it should.

Thanks,
Rafael
