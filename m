From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm] Freezer: Handle uninterruptible
	tasks
Date: Sat, 7 Jul 2007 22:44:45 +0200
Message-ID: <200707072244.46645.rjw__13004.6722632416$1183840715$gmane$org@sisk.pl>
References: <200707061012.48998.rjw@sisk.pl>
	<200707071913.43482.nigel@nigel.suspend2.net>
	<20070707113118.GA2789@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070707113118.GA2789@elf.ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Miklos Szeredi <miklos@szeredi.hu>, nigel@suspend2.net, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Saturday, 7 July 2007 13:31, Pavel Machek wrote:
> Hi!
> 
> > > I don't think we can do that. I suspect rename looks like:
> > > 
> > > 	write directory entry in source
> > > A)	(uninterruptible wait for write)
> > > 	write directory entry in destination
> > > 	(uninterruptible wait for write)
> > > 	write something else
> > > 
> > > If we freeze some task in place "A)", we'll write to the disk when the
> > > directory write is finished :-(.
> > 
> > Renaming is a single syscall, so won't the process get frozen when the syscall 
> > finishes? 
> 
> It would be frozen when syscall finishes. But if we freeze it at A)
> point, we have a problem.

With this patch, we don't freeze it. :-)

We do something like "send a freeze request to this task, but don't care if it
doesn't freeze".

Now, IMHO, the correctness here is the question of for how long a task can be
in TASK_UNINTERRUPTIBLE it it's not stuck (eg. the resource needed is gone
indefinitely, like in NFS) and I think that's not very long.

For example, if the tasks sleeps on a mutex, then it waits for another task to
release the mutex (interrupt handlers don't use mutexes) and I don't know of
any realistic scenario in which it can last in that state throughout
freeze_processes().

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
