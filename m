From: Jakob Lell <jakob@cs.tu-berlin.de>
Subject: Serious bug in s2disk may cause filesystem corruption
 when suspending to swap file
Date: Wed, 13 Jan 2010 02:11:22 +0100
Message-ID: <4B4D1DBA.6020402__43060.3902008899$1263345144$gmane$org@cs.tu-berlin.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050904030206010407030001"
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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

This is a multi-part message in MIME format.
--------------050904030206010407030001
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I've just located a very serious bug in s2disk which may cause 
filesystem corruption when suspending to a swap file. The problem is 
that the programs s2disk and resume seek to positions in resume_fd 
(which is a file handle for the underlying filesystem device) using a 32 
bit value. However, a 32 bit value is not sufficient for filesystems 
bigger than 4 Gb. This bug can only be triggered when at least some 
parts of the swap file are not within the first 4 Gb of the filesystem.

The most problematic point in the code is the function get_swap_page:
>
> static inline unsigned long get_swap_page(int dev)
> {
>         int error;
>         loff_t offset;
>
>         error = ioctl(dev, SNAPSHOT_GET_SWAP_PAGE, &offset);
>         if (!error)
>                 return offset;
>         return 0;
> }

The return value (unsigned long) is 32 bit while loff_t is 64 bit. This 
means that the correct position of the page is calculated but then 
truncated to 32 bits before being used for writing the image. The result 
of this is that data at incorrect positions somewhere in the first 4 Gb 
of the filesystem is overwritten. For me this has caused a huge 
filesystem corruption last Sunday (luckily I had a backup). After 
restoring the system and creating a new swap file, s2disk didn't work 
any more for no obvious reason. The system just showed the desktop again 
directly after saving the image (by the way: s2disk should be a little 
more verbose and always tell the reason why it is aborting). So I added 
some printf debugging to suspend.c and figured out that this happened 
because mark_swap didn't find a swap signature. After some more 
debugging I've found out that mark_swap calculates the position of the 
swap header in the underlying filesystem in an unsigned int variable. 
The same problem also exists in restore_signature(). In resume.c, the 
functions open_resume_dev() and read_image() are affected as well. I've 
attached a patch which resolves this problem. For my system, s2disk 
works fine with this patch. However, I didn't test it on a 64 bit system.*

I am sending this mail to two mailing lists (suspend-devel and 
linux-pm). Maxim Levitsky has reported an ext4 filesystem corruption 
related to s2disk on linux-pm about three months ago. I think that this 
problem has probably been caused by the same bug.

Please test the attached patch and publish an updated version. Since 
this bug can cause filesystem corruption and data loss, you might also 
inform the maintainers at some linux distributions so that that a fix to 
this issue can be delivered to end users as soon as possible.

Regards
Jakob Lell
*

--------------050904030206010407030001
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff -r -u uswsusp-0.8/resume.c uswsusp-0.8.fixed/resume.c
--- uswsusp-0.8/resume.c	2007-12-31 19:50:12.000000000 +0100
+++ uswsusp-0.8.fixed/resume.c	2010-01-13 01:05:42.000000000 +0100
@@ -550,7 +550,7 @@
 			    struct swsusp_header *swsusp_header)
 {
 	unsigned int size = sizeof(struct swsusp_header);
-	unsigned int shift = (resume_offset + 1) * page_size - size;
+	off_t shift = ((off_t)resume_offset + 1) * page_size - size;
 	int fd, ret;
 
 	fd = open(resume_dev_name, O_RDWR);
@@ -585,7 +585,7 @@
 	char *buffer = (char *)mem_pool + page_size;
 	unsigned int nr_pages = 0;
 	unsigned int size = sizeof(struct swsusp_header);
-	unsigned int shift = (resume_offset + 1) * page_size - size;
+	off_t shift = ((off_t)resume_offset + 1) * page_size - size;
 	char c;
 
 	error = read_area(fd, header, swsusp_header->image, page_size);
diff -r -u uswsusp-0.8/suspend.c uswsusp-0.8.fixed/suspend.c
--- uswsusp-0.8/suspend.c	2007-12-31 19:50:12.000000000 +0100
+++ uswsusp-0.8.fixed/suspend.c	2010-01-13 01:05:42.000000000 +0100
@@ -208,7 +208,7 @@
 	return 0;
 }
 
-static inline unsigned long get_swap_page(int dev)
+static inline off_t get_swap_page(int dev)
 {
 	int error;
 	loff_t offset;
@@ -587,7 +587,7 @@
 {
 	int error = 0;
 	unsigned int size = sizeof(struct swsusp_header);
-	unsigned int shift = (resume_offset + 1) * page_size - size;
+	off_t shift = ((off_t)resume_offset + 1) * page_size - size;
 
 	if (lseek(fd, shift, SEEK_SET) != shift)
 		return -EIO;
@@ -757,7 +757,7 @@
 {
 	int ret, error = 0;
 	unsigned int size = sizeof(struct swsusp_header);
-	unsigned int shift = (resume_offset + 1) * page_size - size;
+	off_t shift = ((off_t)resume_offset + 1) * page_size - size;
 
 	if (lseek(fd, shift, SEEK_SET) != shift)
 		return -EIO;

--------------050904030206010407030001
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------050904030206010407030001--
