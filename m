From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [PATCH 1/1] suspend: delete sys_sync()
Date: Fri, 15 May 2015 13:13:42 +0800
Message-ID: <CACVXFVO+4zy=7E6p+hN8nXZpKQV5q2c20XWVBxqPPBR8Vi_udg@mail.gmail.com>
References: <b1587e8b2c664632ecd0d9ad1a3e56733da76490.1431068823.git.len.brown@intel.com>
	<20150514092251.6d0625af@notabene.brown>
	<20150514235426.GF4316@dastard>
	<3798672.EXej90jOp1@vostro.rjw.lan>
	<CACVXFVMEwOSeP8FM89E4XZPUhDsP6bfeCGmJDK1i5kKs-3MCDg@mail.gmail.com>
	<CAJZ5v0gvDCwXWc5aAU7dGDsC=8ZbGBhQHgPkP92W=+Z7-v_2wA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:33817 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744AbbEOFNn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 15 May 2015 01:13:43 -0400
In-Reply-To: <CAJZ5v0gvDCwXWc5aAU7dGDsC=8ZbGBhQHgPkP92W=+Z7-v_2wA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Dave Chinner <david@fromorbit.com>, NeilBrown <neilb@suse.de>, Len Brown <lenb@kernel.org>, Linux PM List <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>

On Fri, May 15, 2015 at 8:59 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Fri, May 15, 2015 at 2:40 AM, Ming Lei <tom.leiming@gmail.com> wrote:
>> On Fri, May 15, 2015 at 8:34 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>> On Friday, May 15, 2015 09:54:26 AM Dave Chinner wrote:
>>>> ng back On Thu, May 14, 2015 at 09:22:51AM +1000, NeilBrown wrote:
>>>> > On Mon, 11 May 2015 11:44:28 +1000 Dave Chinner <david@fromorbit.com> wrote:
>>>> >
>>>> > > On Fri, May 08, 2015 at 03:08:43AM -0400, Len Brown wrote:
>>>> > > > From: Len Brown <len.brown@intel.com>
>>>> > > >
>>>> > > > Remove sys_sync() from the kernel's suspend flow.
>>>> > > >
>>>> > > > sys_sync() is extremely expensive in some configurations,
>>>> > > > and so the kernel should not force users to pay this cost
>>>> > > > on every suspend.
>>>> > >
>>>> > > Since when? Please explain what your use case is that makes this
>>>> > > so prohibitively expensive it needs to be removed.
>>>> > >
>>>> > > >
>>>> > > > The user-space utilities s2ram and s2disk choose to invoke sync() today.
>>>> > > > A user can invoke suspend directly via /sys/power/state to skip that cost.
>>>> > >
>>>> > > So, you want to have s2disk write all the dirty pages in memory to
>>>> > > the suspend image, rather than to the filesystem?
>>>> > >
>>>> > > Either way you have to write that dirty data to disk, but if you
>>>> > > write it to the suspend image, it then has to be loaded again on
>>>> > > resume, and then written again to the filesystem the system has
>>>> > > resumed. This doesn't seem very efficient to me....
>>>> > >
>>>> > > And, quite frankly, machines fail to resume from suspne dall the
>>>> > > time. e.g. run out of batteries when they are under s2ram
>>>> > > conditions, or s2disk fails because a kernel upgrade was done before
>>>> > > the s2disk and so can't be resumed. With your change, users lose all
>>>> > > the data that was buffered in memory before suspend, whereas right
>>>> > > now it is written to disk and so nothing is lost if the resume from
>>>> > > suspend fails for whatever reason.
>>>> > >
>>>> > > IOWs, I can see several good reasons why the sys_sync() needs to
>>>> > > remain in the suspend code. User data safety and filesystem
>>>> > > integrity is far, far more important than a couple of seconds
>>>> > > improvement in suspend speed....
>>>> >
>>>> > To be honest, this sounds like superstition and fear, not science and fact.
>>>> >
>>>> > "filesystem integrity" is not an issue for the fast majority of filesystems
>>>> > which use journalling to ensure continued integrity even after a crash.  I
>>>> > think even XFS does that :-)
>>>>
>>>> It has nothing to do with journalling, and everything to do with
>>>> bring filesystems to an *idle state* before suspend runs.  We have a
>>>> long history of bug reports with XFS that go: suspend, resume, XFS
>>>> almost immediately detects corruption, shuts down.
>>>>
>>>> The problem is that "sync" doesn't make the filesystem idle - XFs
>>>> has *lots* of background work going on, and if we aren't *real
>>>> careful* the filesystem is still doing work while the hardware gets
>>>> powerd down and the suspend image is being taken. the result is on
>>>> resume that the on-disk filesystem state does not match the memory
>>>> image pulled back from resume, and we get shutdowns.
>>>>
>>>> sys_sync() does not guarantee a filesystem is idle - it guarantees
>>>> the data in memory is recoverable, butit doesn't stop the filesystem
>>>> from doing things like writing back metadata or running background
>>>> cleaup tasks. If those aren't stopped properly, then we get into
>>>> the state where in-memory and on-disk state get out of whack. And
>>>> s2ram can have these problems too, because if there is IO in flight
>>>> when the hardware is powered down, that IO is lost....
>>>>
>>>> Every time some piece of generic infrastructure changes behaviour
>>>> w.r.t. suspend/resume, we get a new set of problems being reported
>>>> by users. It's extremely hard to test for these problems and it
>>>> might take months of occasional corruption reports from a user to
>>>> isolate it to being a suspend/resume problem.  It's a game of
>>>> whack-a-mole, because quite often they come down to the fact that
>>>> something changed and nobody in the XFS world knew they had to now
>>>> set an different initialisation flag on some structure or workqueue
>>>> to make it work the way it needed to work.
>>>>
>>>> Go back an look at the history of sys_sync() in suspend discussions
>>>> over the past 10 years.  You'll find me saying exactly the same
>>>> thing again and again about sys_sync(): it does not guarantee the
>>>> filesystem is in an idle or coherent, unchanging state, and nothing
>>>> in the suspend code tells the filesystem to enter an idle or frozen
>>>> state. We actually have mechanisms for doing this - we use it in the
>>>> storage layers to idle the filesystem while we do things like *take
>>>> a snapshot*.
>>>>
>>>> What is the mechanism suspend to disk uses? It *takes a snapshot* of
>>>> system state, written to disk. It's supposed to be consistent, and
>>>> the only way you can guarantee the state of an active, mounted
>>>> filesystem has consistent in-memory state and on-disk state and
>>>> that it won't get changed is to *freeze the filesystem*.
>>>>
>>>> Removing the sync is only going to make this problem worse because
>>>> the delta between on-disk and in-memory state is going to be much,
>>>> much larger. There is also likely to be significant filesystem
>>>> activity occurring when the filesystem has all it's background
>>>> threads and work queues abruptly frozen with no warning or
>>>> co-ordination, which makes it impossible for anyone to test
>>>> suspend/resume reliably.
>>>>
>>>> Sorry for the long rant, but I've been saying the same thing for 10
>>>> years, which is abotu as long as I've been dealing with filesystem
>>>> corruptions that have resulted from suspend/resume.
>>>
>>> Well, the change proposed by Len is *only* about suspend-to-RAM and
>>> similar.  It is *not* about suspend-to-disk, so pretty please let's
>>> not confuse things.
>>>
>>> So what problems may arise specifically in the suspend-to-RAM case if
>>> we remove the unconditional sys_sync() from its code path?
>>
>> Data loss may be caused for hotplug storage(like USB), or all storage
>> when power is exhausted during suspend.
>
> Which also may very well happen at run time, right?

I believe common people can understand the difference between
suspend(often done by docking laptop) and runtime wrt laptop usage

Yes, it may happen runtime for hotplug storage, but people know it is
their own fault and won't complain anyone. But if they find data loss is
caused during suspend and may figure out it is one regression by this
change, they may complain someone, :-)

Actually one common practice about my laptop usage for me is to always
use suspend, and seldom power down, then follows to plug all USB
thumb/HDD. from the laptop and put laptop in my backpack
,then go somewhere, and the change migh make trouble for me.

Also for power exhausting case, it is different with runtime
because distribution often detects low battery and puts system to
suspend when low battery happens. Then the deletion makes
a difference and cause trouble after power is exhausted.

Finally I guess it might affect some network based storage like iSCSI,
CIFS and NFS too, and hope guys in these fields can review the change.

>
>> Is there obvious advantage to remove sys_sync() in the case?
>
> Yes, there is.  It is not necessary to sync() every time you suspend
> if you do that very often.
>
> And it is done in such a place that everything needs to wait for it to complete.

I mean Len said sys_sync() has been added to s2ram/s2disk utilities
already in some distribution, that means people think it is required in the
suspend path, so the kernel side sys_sync() shouldn't be expensive
like Dave explained because there are little dirty pages after userspace
have done the sys_sync().


Thanks,
Ming
