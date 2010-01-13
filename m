From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Suspend-devel] Serious bug in s2disk may cause
	filesystem corruption when suspending to swap file
Date: Wed, 13 Jan 2010 22:24:35 +0100
Message-ID: <201001132224.35173.rjw__3589.56640488959$1263417935$gmane$org@sisk.pl>
References: <4B4D1DBA.6020402@cs.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4B4D1DBA.6020402@cs.tu-berlin.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: suspend-devel@lists.sourceforge.net
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wednesday 13 January 2010, Jakob Lell wrote:
> Hi,

Hi,

> I've just located a very serious bug in s2disk which may cause 
> filesystem corruption when suspending to a swap file. The problem is 
> that the programs s2disk and resume seek to positions in resume_fd 
> (which is a file handle for the underlying filesystem device) using a 32 
> bit value. However, a 32 bit value is not sufficient for filesystems 
> bigger than 4 Gb. This bug can only be triggered when at least some 
> parts of the swap file are not within the first 4 Gb of the filesystem.
> 
> The most problematic point in the code is the function get_swap_page:
> >
> > static inline unsigned long get_swap_page(int dev)
> > {
> >         int error;
> >         loff_t offset;
> >
> >         error = ioctl(dev, SNAPSHOT_GET_SWAP_PAGE, &offset);
> >         if (!error)
> >                 return offset;
> >         return 0;
> > }
>
> The return value (unsigned long) is 32 bit while loff_t is 64 bit.

The most recent version of the suspend package, located at:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-utils.git

has all of these problems fixed.

Thanks,
Rafael


> This 
> means that the correct position of the page is calculated but then 
> truncated to 32 bits before being used for writing the image. The result 
> of this is that data at incorrect positions somewhere in the first 4 Gb 
> of the filesystem is overwritten. For me this has caused a huge 
> filesystem corruption last Sunday (luckily I had a backup). After 
> restoring the system and creating a new swap file, s2disk didn't work 
> any more for no obvious reason. The system just showed the desktop again 
> directly after saving the image (by the way: s2disk should be a little 
> more verbose and always tell the reason why it is aborting). So I added 
> some printf debugging to suspend.c and figured out that this happened 
> because mark_swap didn't find a swap signature. After some more 
> debugging I've found out that mark_swap calculates the position of the 
> swap header in the underlying filesystem in an unsigned int variable. 
> The same problem also exists in restore_signature(). In resume.c, the 
> functions open_resume_dev() and read_image() are affected as well. I've 
> attached a patch which resolves this problem. For my system, s2disk 
> works fine with this patch. However, I didn't test it on a 64 bit system.*
> 
> I am sending this mail to two mailing lists (suspend-devel and 
> linux-pm). Maxim Levitsky has reported an ext4 filesystem corruption 
> related to s2disk on linux-pm about three months ago. I think that this 
> problem has probably been caused by the same bug.
> 
> Please test the attached patch and publish an updated version. Since 
> this bug can cause filesystem corruption and data loss, you might also 
> inform the maintainers at some linux distributions so that that a fix to 
> this issue can be delivered to end users as soon as possible.
> 
> Regards
> Jakob Lell
> *
> 
