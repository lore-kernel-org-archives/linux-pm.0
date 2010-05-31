From: Neil Brown <neilb@suse.de>
Subject: Re: [PATCH 1/8] PM: Opportunistic suspend support.
Date: Mon, 31 May 2010 15:56:25 +1000
Message-ID: <20100531155625.65fd094d__31192.589729517$1275285483$gmane$org@notabene.brown>
References: <Pine.LNX.4.44L0.1005251647530.1634-100000@iolanthe.rowland.org>
	<AANLkTimVhC3X68uN3krrkkAAAK4a4D5yTK1V8i_x_Vfy@mail.gmail.com>
	<20100530180846.408e50be@notabene.brown>
	<201005302152.14166.rjw@sisk.pl>
	<20100531090329.786fce79@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100531090329.786fce79@notabene.brown>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Arve =?UTF-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>, Alan Stern <stern@rowland.harvard.edu>
Cc: Wu Fengguang <fengguang.wu@intel.com>, Andi Kleen <ak@linux.intel.com>, markgross@thegnar.org, Len Brown <len.brown@intel.com>, linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@suse.de>, Kernel development list <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, James Bottomley <James.Bottomley@suse.de>, Tejun Heo <tj@kernel.org>, tytso@mit.edu, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 31 May 2010 09:03:29 +1000
Neil Brown <neilb@suse.de> wrote:

> > Well, please have a look at the Alan Stern's proposal here:
> > http://lkml.org/lkml/2010/5/29/77
> >
> 
> Thanks for the reference.
> Some of the details are different, but the idea seems almost exactly the same
> as mine.
> The apparent dependence on signals makes me feel a little uncomfortable
> (interfaces that depend on using signals seem to be easy to use wrongly), but
> I don't think that is a serious flaw.
> 
> Maybe the biggest difference is philosophical.  Alan's proposal appears to be
> adding a new feature.  Mine presents as trying to fix an existing feature so
> that it can be used reliably.
> It is easier to argue against a feature than against a bug-fix (??).

Addendum...

The use of signals by Alan here got me thinking.. and combining it which what 
Alan Cox and Thomas Gleixner (and others?) have been saying about detecting
idleness led me down an interesting path that I thought I would share.

An absolutely minimal change to allow a user-space initiated auto-suspend to
be race-free would be achieved by placing an interruptible wait between
       pm_notifier_call_chain(PM_SUSPEND_PREPARE);
and 
       suspend_freeze_processes();

which waits for all kernel threads to have passed through an 'idle' state.

Then any wake event that happened after the PM_SUSPEND_PREPARE would
presumably either abort the suspend later, or would cause an immediate
wake-up.
Any event that happened before the PM_SUSPEND_PREPARE would have been fully
processed by any kernel thread and so would be queued for user-space (or have
been discarded).

If we then require any process that handles wakeup events to use the
equivalent of fcntl(F_SETOWN) to direct a SIGIO (or other signal) at the
process which requests the suspend, then wakeup events won't be lost.
They will either send a signal to the suspend-daemon in time to abort the
suspend, or will be late enough to either abort the suspend in-kernel, or
trigger an immediate wakeup.

Yes: this would require quite a large change of the android code, and the
F_SETOWN usage is fairly ugly, but balanced against it actually working and
it being minimal, that might be OK.

The hardest part would be waiting for all kernel-threads to pass through idle
(or all threads to pass through idle or user-space).  We'd need help to make
that work, but at least it would be a fairly localised change.

Maybe it is something to keep in mind when other possibilities have proven
intractable.

NeilBrown
