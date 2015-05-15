From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/1] suspend: delete sys_sync()
Date: Fri, 15 May 2015 02:34:48 +0200
Message-ID: <3798672.EXej90jOp1@vostro.rjw.lan>
References: <b1587e8b2c664632ecd0d9ad1a3e56733da76490.1431068823.git.len.brown@intel.com> <20150514092251.6d0625af@notabene.brown> <20150514235426.GF4316@dastard>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150514235426.GF4316@dastard>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: NeilBrown <neilb@suse.de>, Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Friday, May 15, 2015 09:54:26 AM Dave Chinner wrote:
> ng back On Thu, May 14, 2015 at 09:22:51AM +1000, NeilBrown wrote:
> > On Mon, 11 May 2015 11:44:28 +1000 Dave Chinner <david@fromorbit.com> wrote:
> > 
> > > On Fri, May 08, 2015 at 03:08:43AM -0400, Len Brown wrote:
> > > > From: Len Brown <len.brown@intel.com>
> > > > 
> > > > Remove sys_sync() from the kernel's suspend flow.
> > > > 
> > > > sys_sync() is extremely expensive in some configurations,
> > > > and so the kernel should not force users to pay this cost
> > > > on every suspend.
> > > 
> > > Since when? Please explain what your use case is that makes this
> > > so prohibitively expensive it needs to be removed.
> > > 
> > > > 
> > > > The user-space utilities s2ram and s2disk choose to invoke sync() today.
> > > > A user can invoke suspend directly via /sys/power/state to skip that cost.
> > > 
> > > So, you want to have s2disk write all the dirty pages in memory to
> > > the suspend image, rather than to the filesystem?
> > > 
> > > Either way you have to write that dirty data to disk, but if you
> > > write it to the suspend image, it then has to be loaded again on
> > > resume, and then written again to the filesystem the system has
> > > resumed. This doesn't seem very efficient to me....
> > > 
> > > And, quite frankly, machines fail to resume from suspne dall the
> > > time. e.g. run out of batteries when they are under s2ram
> > > conditions, or s2disk fails because a kernel upgrade was done before
> > > the s2disk and so can't be resumed. With your change, users lose all
> > > the data that was buffered in memory before suspend, whereas right
> > > now it is written to disk and so nothing is lost if the resume from
> > > suspend fails for whatever reason.
> > > 
> > > IOWs, I can see several good reasons why the sys_sync() needs to
> > > remain in the suspend code. User data safety and filesystem
> > > integrity is far, far more important than a couple of seconds
> > > improvement in suspend speed....
> > 
> > To be honest, this sounds like superstition and fear, not science and fact.
> > 
> > "filesystem integrity" is not an issue for the fast majority of filesystems
> > which use journalling to ensure continued integrity even after a crash.  I
> > think even XFS does that :-)
> 
> It has nothing to do with journalling, and everything to do with
> bring filesystems to an *idle state* before suspend runs.  We have a
> long history of bug reports with XFS that go: suspend, resume, XFS
> almost immediately detects corruption, shuts down.
> 
> The problem is that "sync" doesn't make the filesystem idle - XFs
> has *lots* of background work going on, and if we aren't *real
> careful* the filesystem is still doing work while the hardware gets
> powerd down and the suspend image is being taken. the result is on
> resume that the on-disk filesystem state does not match the memory
> image pulled back from resume, and we get shutdowns.
> 
> sys_sync() does not guarantee a filesystem is idle - it guarantees
> the data in memory is recoverable, butit doesn't stop the filesystem
> from doing things like writing back metadata or running background
> cleaup tasks. If those aren't stopped properly, then we get into
> the state where in-memory and on-disk state get out of whack. And
> s2ram can have these problems too, because if there is IO in flight
> when the hardware is powered down, that IO is lost....
> 
> Every time some piece of generic infrastructure changes behaviour
> w.r.t. suspend/resume, we get a new set of problems being reported
> by users. It's extremely hard to test for these problems and it
> might take months of occasional corruption reports from a user to
> isolate it to being a suspend/resume problem.  It's a game of
> whack-a-mole, because quite often they come down to the fact that
> something changed and nobody in the XFS world knew they had to now
> set an different initialisation flag on some structure or workqueue
> to make it work the way it needed to work.
> 
> Go back an look at the history of sys_sync() in suspend discussions
> over the past 10 years.  You'll find me saying exactly the same
> thing again and again about sys_sync(): it does not guarantee the
> filesystem is in an idle or coherent, unchanging state, and nothing
> in the suspend code tells the filesystem to enter an idle or frozen
> state. We actually have mechanisms for doing this - we use it in the
> storage layers to idle the filesystem while we do things like *take
> a snapshot*.
> 
> What is the mechanism suspend to disk uses? It *takes a snapshot* of
> system state, written to disk. It's supposed to be consistent, and
> the only way you can guarantee the state of an active, mounted
> filesystem has consistent in-memory state and on-disk state and
> that it won't get changed is to *freeze the filesystem*.
> 
> Removing the sync is only going to make this problem worse because
> the delta between on-disk and in-memory state is going to be much,
> much larger. There is also likely to be significant filesystem
> activity occurring when the filesystem has all it's background
> threads and work queues abruptly frozen with no warning or
> co-ordination, which makes it impossible for anyone to test
> suspend/resume reliably.
> 
> Sorry for the long rant, but I've been saying the same thing for 10
> years, which is abotu as long as I've been dealing with filesystem
> corruptions that have resulted from suspend/resume.

Well, the change proposed by Len is *only* about suspend-to-RAM and
similar.  It is *not* about suspend-to-disk, so pretty please let's
not confuse things.

So what problems may arise specifically in the suspend-to-RAM case if
we remove the unconditional sys_sync() from its code path?

Cheers,
Rafael
