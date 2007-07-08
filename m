From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm] Freezer: Handle uninterruptible
	tasks
Date: Sun, 8 Jul 2007 15:55:51 +0200
Message-ID: <200707081555.53094.rjw__44304.4645166539$1183902566$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0707061039380.3737-100000@iolanthe.rowland.org>
	<200707080108.17371.rjw@sisk.pl> <20070708120933.GA3866@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070708120933.GA3866@ucw.cz>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Miklos Szeredi <miklos@szeredi.hu>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Sunday, 8 July 2007 14:09, Pavel Machek wrote:
> Hi!
> 
> > > And then you will face the problem of a user task doing I/O during 
> > > hibernate after the atomic snapshot has been made.
> > 
> > I don't think that this is possible in normal conditions.  It would be possible
> > if, for example, the task were waiting for an unavailable resource and that
> > resource became available after the hibernation image had been created.
> > In that case, however, to do any damage, the task would have to cause some
> > filesystem-related data to be flushed in the same syscall (ie. before returning
> > to user space).
> 
> I agree that it is relatively unlikely to trigger (if you avoid
> freezing the tasks that were uninterruptible for long), but it will
> trigger in error cases etc.

Yes, it will.

> > Such situations may be prevented by a mechanizm detecting if any uniterruptible
> > and freezing task has been woken up after creating the image and aborting the
> > hibernation in that cases.  For this purpose, we only need to add an
> > appropriate condition to try_to_wake_up() and make it start to trigger after,
> > for example, enabling the nonboot CPUs.
> 
> I don't know how to do that mechanism... but if we knew where to trap
> filesystem writes, we could simply freeze at that point, and at that
> point only, no?

>From the image/filesystems integrity standpoint, yes, that should be
sufficient.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
