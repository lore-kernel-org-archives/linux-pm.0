From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [RFC 09/15] PM / Hibernate: user,
	implement user_ops writer
Date: Tue, 30 Mar 2010 10:59:28 +0200
Message-ID: <4BB1BD70.90105@gmail.com>
References: <1269361063-3341-1-git-send-email-jslaby@suse.cz>
	<201003262304.32118.rjw@sisk.pl> <4BB0C840.7030802@gmail.com>
	<201003300009.18315.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201003300009.18315.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, Nigel Cunningham <ncunningham@crca.org.au>
List-Id: linux-pm@vger.kernel.org

On 03/30/2010 12:09 AM, Rafael J. Wysocki wrote:
> On Monday 29 March 2010, Jiri Slaby wrote:
>> Probably the easiest solution is to revert it as noted above: a page is
>> taken from snapshot (with patches I have here the snapshot layer is only
>> told to "store next page" without returning a page to the caller), fed
>> through crypto layers as needed and finally given to chunk writer which
>> assembles PAGE_SIZE blocks from the chunks. Then whole pages of
>> compressed/encrypted data are given to user or in-kernel block io by
>> hibernate_io_ops->write_page. In-kernel .write_page simply calls
>> swap_write_page (which in turn hib_bio_write_page while storing swap
>> sector entries).
> 
> That's fine if I understand correctly.

(It is in fact the same what s2disk does, except it works on a single
page and the block io chaining is up to the block layer.)

>> The very similar happens for fops->write, ergo hibernate_io_ops->read_page.
> 
> You can't open /dev/snapshot for reading and writing at the same time, because
> that wouldn't make any sense.

Err, I didn't mean to write that. fops->read and
hibernate_io_ops->write_page are both involved solely in image writing
and are consumer and producer respectively. Vice versa for image reading.

> Now, during resume the image is not present in memory at all.  In fact, we

<snipped> -- we both understand the code the same.

> Now, compression can happen in two places: while the image is created
> or after it has been created (current behavior).  In the latter case, the image
> pages need not be compressed in place, they may be compressed after being
> returned by snapshot_read_next(), in a temporary buffer (that's now s2disk
> does that).  So you can arrange things like this:
> 
> create image
> repeat:
> - snapshot_read_next() -> buffer
> - if buffer is full, compress it (possibly encrypt it) and write the result to
>   the storage
> 
> This way you'd just avoid all of the complications and I fail to see any
> drawbacks.

Yes, this was the intention. Except I wanted snapshot_read_next to be
something like snapshot_write_next_page which would call
hibernate_io_ops->write_page(buf, len) somewhere in the deep.
hibernate_io_ops is an alias for the first module which accepts the page
and feeds it further. E.g. for hibernate_io_ops being compress_ops it
may be a chain like compress_ops->write_page => encrypt_ops->write_page
=> swap_ops->write_page.

But if you want to preserve snapshot_read_next, then it would look like
repeat:
  snapshot_read_next() -> buffer, len = PAGE_SIZE
  compress_ops->write_page(buffer, len) =>
    encrypt_ops->write_page(buffer, len) =>
    swap_ops->write_page(buffer, len)

instead of
repeat:
  snapshot_write_next_page()
In this case its work is to fetch a next page and call appropriate
.write_page.

> Now, an attractive thing would be to compress data while creating the image
> and that may be done in the following way:

I wouldn't go for this. We should balance I/O and CPU and this can be
done only when writing the image, if I can say. OTOH I must admit I have
no numbers.

thanks,
-- 
js
