From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC 09/15] PM / Hibernate: user,
	implement user_ops writer
Date: Tue, 30 Mar 2010 00:09:18 +0200
Message-ID: <201003300009.18315.rjw@sisk.pl>
References: <1269361063-3341-1-git-send-email-jslaby@suse.cz>
	<201003262304.32118.rjw@sisk.pl> <4BB0C840.7030802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4BB0C840.7030802@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, Nigel Cunningham <ncunningham@crca.org.au>
List-Id: linux-pm@vger.kernel.org

On Monday 29 March 2010, Jiri Slaby wrote:
> On 03/26/2010 11:04 PM, Rafael J. Wysocki wrote:
> > I have some other comments to this patch, but I'd like to understand what
> > really happens here, since the changelog is not too verbose.
> > 
> > Please explain the design here.
> 
> Yeah, my bad.
> 
> What I want to achieve is to revert the behaviour of current
> implementation to the one used in toi. Now, it is that when writing a
> page to the swap, the hibernation does snapshot_read_page(page) with
> swap_write_page(page) in a loop. This is OK until one needs to do
> anything with the page.
> 
> When compression or encryption (or both) are needed to be done, this
> scenario does not work well because page returned by snapshot_read_page,
> after going through the crypto layers, is no longer PAGE_SIZE big.

Actually, s2disk has the same problem, because it only receives entire pages
from the kernel and it needs to compress/encrypt them before writing to the
storage (which also is written in blocks that are page size-aligned).  Still,
s2disk uses snapshot_[read\write]_next() through the functions in user.c, so
I don't think we need to reorder things in there.

> Probably the easiest solution is to revert it as noted above: a page is
> taken from snapshot (with patches I have here the snapshot layer is only
> told to "store next page" without returning a page to the caller), fed
> through crypto layers as needed and finally given to chunk writer which
> assembles PAGE_SIZE blocks from the chunks. Then whole pages of
> compressed/encrypted data are given to user or in-kernel block io by
> hibernate_io_ops->write_page. In-kernel .write_page simply calls
> swap_write_page (which in turn hib_bio_write_page while storing swap
> sector entries).

That's fine if I understand correctly.

> User .write_page, with buf as a parameter, does the following:
> * to_do_buf = buf
> * set WORK bit
> * wake_up .read (below)
> * wait_for WORK bit clear
> 
> Writer in this case is a user process performing fops->read. .read does
> the following:
> * wait_for WORK bit
> * copy_to_user to_do_buf
> * clear WORK bit
> * wake_up .write_page
> 
> I need the barrier to ensure the "to_do_buf = buf" assignment is not
> reordered with the "set WORK bit" in .write_page. Otherwise .read will
> see WORK bit set, but have to_do_buf not updated. I certainly can lock
> the two operation together, but (a) I see no point in doing so; (b) it
> makes the code worse (I need to unlock and relock in wait_event and
> unlock on all fail paths).
> 
> The very similar happens for fops->write, ergo hibernate_io_ops->read_page.

You can't open /dev/snapshot for reading and writing at the same time, because
that wouldn't make any sense.

/dev/snapshot represents a hibernation image which is presented to user space
as a "file", because the user space is then able to use "regular" read() and
write() on it.  However, the situation during hibernation is much different
than during resume.  Namely, during hibernation the image is there in memory
and it can't be modified.  It can only be read and written to the storage.  So,
at this stage it only makes sense to open /dev/snapshot for reading.

Now, during resume the image is not present in memory at all.  In fact, we
don't even use any contiguous region to store the pages read from the on-disk
image.  Instead, the pages are put directly into their destination page frames,
if they are free.  Otherwise, they are put into free page frames and then
copied back to the target ones right before returning control to the image
kernel.  So during resume there's nothing that could be read from /dev/snapshot
and you can only open it for writing.

The idea is that snapshot_read_next() will only be used during hibernation
for reading all of the image pages as contiguous stream of data (the real image
is not contiguous in general), because that's what the user space needs.  Then,
the observation goes that the swap.c functions can use the same mechanism,
although that is not really necessary in principle.

Analogously, snapshot_write_next() is only useful during resume for writing
all of the image pages as a contiguous stream of data, because that's needed
by the user space and _can_ be used by the in-kernel code as well.

[Note that snapshot_[read|write]_next() belong to the memory management
part of the hibernation subsystem and that's exactly why they are in
snapshot.c.]

Now, compression can happen in two places: while the image is created
or after it has been created (current behavior).  In the latter case, the image
pages need not be compressed in place, they may be compressed after being
returned by snapshot_read_next(), in a temporary buffer (that's now s2disk
does that).  So you can arrange things like this:

create image
repeat:
- snapshot_read_next() -> buffer
- if buffer is full, compress it (possibly encrypt it) and write the result to
  the storage

This way you'd just avoid all of the complications and I fail to see any
drawbacks.

Now, an attractive thing would be to compress data while creating the image
and that may be done in the following way:

have a buffer ready
repeat:
- copy image pages to the buffer (instead of copying them directly into the
  image storage space)
- if buffer is full, compress it and copy the result to the image storage
  space, page by page.

Thanks,
Rafael
