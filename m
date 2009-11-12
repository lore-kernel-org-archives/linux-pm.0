From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Memory consumption difference between in-kernel and
	userspace hibernation
Date: Thu, 12 Nov 2009 21:52:02 +0100
Message-ID: <200911122152.02671.rjw@sisk.pl>
References: <20091112210155.0f9bbe5d@surf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20091112210155.0f9bbe5d@surf>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thursday 12 November 2009, Thomas Petazzoni wrote:
> Hi,
> 
> Let me first introduce my question, and then give details about the
> context.
> 
> Question: is there any difference in terms of memory requirements for
> the in-kernel hibernation (echo disk > /sys/power/state) and the
> userspace hibernation interface (through /dev/snapshot) ? With exactly
> the same userspace workload and applications running, the in-kernel
> hibernation works, but the hibernating using the userspace hibernation
> interface fails because not enough memory can be freed.
> 
> Now, the context.
> 
> I'm implementing hibernation on an embedded device, which has no swap
> since the only storage available is NAND flash.
> 
> I started by using the in-kernel hibernation mechanism, which saved the
> resume image directly into an MTD partition, declared as a swap just
> before starting the hibernation process (swapon /dev/mtdblockX; echo
> disk > /sys/power/state). This worked like a charm.
> 
> But writing the resume image directly to the MTD partition is not
> satisfying since it doesn't handle bad erase blocks and wear leveling.
> Therefore, I wanted to save the resume image into a file, inside a
> JFFS2 or YAFFS2 filesystem.

The userspace interface doesn't really allow you to write to a file.  You can
write into the area the file occupies on the partition, but you can't use the
filesystem code for the actual writing.  At least you shouldn't do that.

> For this, I used the /dev/snapshot
> userspace interface to swsusp. With a light workload, it works
> perfectly (both suspend and resume). But with a similar workload than
> the one tested with the in-kernel hibernation, things fail at the
> SNAPSHOT_ATOMIC_SNAPSHOT ioctl() step, which returns ENOMEM.
> 
> To get some details about the issue, I've added a few printk()s in
> swsusp_shrink_memory(). Here is the patch:
> 
> ==================================================================
> --- foo.orig/kernel/power/swsusp.c
> +++ foo/kernel/power/swsusp.c
> @@ -226,15 +226,20 @@
>                 highmem_size = count_highmem_pages();
>                 size = count_data_pages() + PAGES_FOR_IO;
>                 tmp = size;
> +               printk("size=%d\n", size);
>                 size += highmem_size;
>                 for_each_zone (zone)
>                         if (populated_zone(zone)) {
>                                 if (is_highmem(zone)) {
>                                         highmem_size -= zone->free_pages;
>                                 } else {
> +                                       printk("1 tmp=%d\n", tmp);
>                                         tmp -= zone->free_pages;
> +                                       printk("2 tmp=%d\n", tmp);
>                                         tmp += zone->lowmem_reserve[ZONE_NORMAL];
> +                                       printk("3 tmp=%d\n", tmp);
>                                         tmp += snapshot_additional_pages(zone);
> +                                       printk("4 tmp=%d\n", tmp);
>                                 }
>                         }
>  
> @@ -243,9 +248,12 @@
>  
>                 tmp += highmem_size;
>                 if (tmp > 0) {
> +                       printk("trying to free %d pages\n", tmp);
>                         tmp = __shrink_memory(tmp);
> -                       if (!tmp)
> +                       if (!tmp) {
> +                               printk("\bfailed, ENOMEM\n");
>                                 return -ENOMEM;
> +                       }
>                         pages += tmp;
>                 } else if (size > image_size / PAGE_SIZE) {
>                         tmp = __shrink_memory(size - (image_size / PAGE_SIZE));
> ==================================================================
> 
> I get the following output:
> 
> ==================================================================
> Stopping tasks ... done.
> Shrinking memory...  size=6967
> 1 tmp=6967
> 2 tmp=6639
> 3 tmp=6639
> 4 tmp=6643
> trying to free 6643 pages
> -size=4036
> 1 tmp=4036
> 2 tmp=777
> 3 tmp=777
> 4 tmp=781
> trying to free 781 pages
> failed, ENOMEM
> Restarting tasks ... done.
> ==================================================================

swsusp_shrink_memory() is used by both the in-kernel code and the userspace
code more-or-less in the same way, so it looks strange.  How much memory is
there in the system?
 
> Note 1: I've already reduced PAGES_FOR_IO from 1024 to 128.
> 
> Note 2: As usual in the embedded space, I'm stuck with an old 2.6.25
>         kernel.
> 
> Any idea on why it works with the in-kernel solution and not the
> userspace one ?

s2disk allocates a few buffers for itself, but I'm not sure if that matters
at all.

Which version of s2disk do you use, do you have encryption enabled in s2disk?

Rafael
