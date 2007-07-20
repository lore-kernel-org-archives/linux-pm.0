From: Jeremy Maitin-Shepard <jbms@cmu.edu>
Subject: Re: Re: Hibernation considerations
Date: Fri, 20 Jul 2007 16:23:18 -0400
Message-ID: <87ir8eq0y1.fsf@jbms.ath.cx>
References: <f29402c6050f9c3ff5d83a59cea2de58%40bga.com>
	<f56664625c843ac71672d2818c4df69f@bga.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <f56664625c843ac71672d2818c4df69f@bga.com> (Milton Miller's
	message of "Fri\, 20 Jul 2007 14\:09\:00 -0500")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Milton Miller <miltonm@bga.com>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Milton Miller <miltonm@bga.com> writes:

[snip]

> There is a requirement to hibernate without dedicating a partition to save the
> data.  Two reasons given have been upgrading ram in a machine should not require
> a repartition of the hard drive, and the intel macs can only have 4 partitions
> total and people want to dual boot.

> Not having a separate partition means the userspace in the initramfs needs to
> obtain a list of blocks upon which to write the data.  My first proposal was to
> do it all from userspace of the new kernel by calling bmap on the filesystem
> mounted read only.   My later proposal is to allocate the blocks in the
> suspending kernel and pass the block list to userspace.

I see.  The later proposal is needed anyway in order to support
still-in-use swap partitions and swap files.  It is unfortunate that
special support will be needed to tell the "save image" kernel about the
storage device in order to support in-use swap partitions and files
(both swap files and regular).  It seems that the kexec approach will
need to support two different "storage methods": getting a block list
from the hibernated kernel, or having the "save image" kernel handle
itself (e.g. in order to support complicated storage methods like over
the network, FUSE, etc.).  There is the additional complication for the
"hibernated kernel tells save image kernel where to save the image"
method that the relevant block device might not even have the same
major/minor number under the save-to-disk kernel due to dynamic device
numbering, etc.  The same problem applies anyway to finding the block
device on resume (and is a problem that exists with the existing
hibernate implementations as well); in theory it can be identified by
attributes like filesystem label or UUID, or physical device path.
There doesn't seem to be an existing general solution to this problem.

Note: I have noticed that swap partitions can have a filesystem UUID,
but the e2fsprogs blkid program does not find it while the swap
partition is marked as a hibernate image.

> There is still the question of how does the restore kernel find the block list
> to restore from.  It does help the first kernel invalidating the image in the
> suspend-to-both resume-from-ram case.

Suspend2/TuxOnIce currently supports writing to regular files as well as
swap files.  To resume, it is necessary to specify the device and the
start block.  The first block must contain sufficient information to
find all of the other blocks; presumably the same technique can be used
for the kexec approach.

> PS: I'm not subscribed to the list, and only saw your reply on the archives
> ... which give me my message id as the message to reply to.   I'd appreciate
> being cc'd in the future.

The message was sent directly to you, so you should have received it.
(Your e-mail address was in the To: header).

-- 
Jeremy Maitin-Shepard
