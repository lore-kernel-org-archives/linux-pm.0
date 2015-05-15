From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/1] suspend: delete sys_sync()
Date: Fri, 15 May 2015 10:19:22 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1505151012460.1295-100000@iolanthe.rowland.org>
References: <20150514235426.GF4316@dastard>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150514235426.GF4316@dastard>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: NeilBrown <neilb@suse.de>, Len Brown <lenb@kernel.org>, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Fri, 15 May 2015, Dave Chinner wrote:

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

Are you suggesting that filesystems should register a "freeze the
filesystem" routine, and the PM core should call this routine during 
hibernation (aka suspend-to-disk)?  With a corresponding "unfreeze" 
hook for resume, of course.

That seems like a good idea to me.  It would also present a logical
place to add some simple checks for changes to the on-disk image caused
by the user moving the storage device to another system, modifying the
contents, and then moving it back all while the current system was 
hibernating (or suspended).

Alan Stern
