From: David Brownell <david-b@pacbell.net>
Subject: Re: PM_TRACE causing FSCK
Date: Sat, 8 Jul 2006 10:45:57 -0700
Message-ID: <200607081045.57724.david-b@pacbell.net>
References: <Pine.LNX.4.64.0606221210350.5498@g5.osdl.org>
	<200607061527.29421.david-b@pacbell.net>
	<20060706223119.GA3135@kroah.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_V9+rElGoQ5cgeNp"
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060706223119.GA3135@kroah.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
Cc: Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--Boundary-00=_V9+rElGoQ5cgeNp
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 06 July 2006 3:31 pm, Greg KH wrote:
> On Thu, Jul 06, 2006 at 03:27:28PM -0700, David Brownell wrote:
> > The only other new behaviors of note are that the console changes now
> > prevent diagnostics during suspend (sigh), and that something (maybe
> > the PM_TRACE stuff?) is causing a 60 GB ext3 filesystem to fsck on
> > every reboot, claiming it's been 10+ years since it was last checked.
> 
> Yeah, the PM_TRACE stuff caused this for me too, and was driving me
> crazy until I figured out what was killing my clock chip...

The attached patch makes things better, by using real-but-unused
bytes in NVRAM instead of clobbering the clock chip.  Two issues
with the patch:

 - the "#if this is Linus's machine" thing can be improved on;

 - it's not clear if the three bytes used are available on many
   machines other than the one I tested this with.

Maybe the best way to do this is to give the PM_TRACE thing some
Kconfig options, where one would be to clobber the RTC and another
would clobber some configurable NVRAM bytes.

- Dave

 

--Boundary-00=_V9+rElGoQ5cgeNp
Content-Type: text/x-diff;
  charset="us-ascii";
  name="trace.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="trace.patch"

This modifies the new suspend/resume tracing so that it
doesn't clobber the RTC and thereby force FSCK all the time.
It does that by using some NVRAM locations that work on on
system I have.

This means it won't work on Linus' Mac Mini, which clears
the NVRAM as it boots ... at least without a #define.


Index: linux/drivers/base/power/trace.c
===================================================================
--- linux.orig/drivers/base/power/trace.c	2006-07-05 20:02:43.000000000 -0700
+++ linux/drivers/base/power/trace.c	2006-07-08 09:59:46.000000000 -0700
@@ -15,6 +15,25 @@
 #include "power.h"
 
 /*
+ * PC systems include a battery-backed chip with an RTC and some SRAM
+ * that's partially used by BIOS.  Read "cmos.txt" in Ralf Brown's
+ * "RBIL" for information about how it's used; the short summary is
+ * that modern hardware has many bytes of NVRAM but there's no clear
+ * story for what Linux could use (without adding to BIOS confusion).
+ * Plus on Mac Mini, POST clears that NVRAM, so those bytes aren't
+ * really available ... but the RTC itself can be used as SRAM...
+ *
+ * This leaves us two degrees of trouble:  normal PCs will likely
+ * have some bytes available for use, iff you can find some that
+ * the BIOS isn't using.  And then there's MacMini.
+ */
+
+static unsigned int dev_hash_value;
+
+
+#ifdef	APPLE_X86
+
+/*
  * Horrid, horrid, horrid.
  *
  * It turns out that the _only_ piece of hardware that actually
@@ -73,8 +92,6 @@
 
 #define DEVSEED (7919)
 
-static unsigned int dev_hash_value;
-
 static int set_magic_time(unsigned int user, unsigned int file, unsigned int device)
 {
 	unsigned int n = user + USERHASH*(file + FILEHASH*device);
@@ -125,6 +142,75 @@
 	return val;
 }
 
+#else	/* !APPLE_X86 */
+
+/* We really don't want to clobber the clock, since among other
+ * things that means we'll spend lots of time in FSCK on boot.
+ *
+ * Instead, use some bits in the upper 64 bytes of NVRAM address
+ * space which don't seem to be used (on at least my platform!).
+ *
+ * NOTE that some platforms conveniently provide 32-bit registers
+ * working this way, so sticking to one word is a Good Thing.
+ */
+
+#define USERHASH (16)
+#define FILEHASH (997)
+
+#define DEVHASH (1009)
+#define DEVSEED (7919)
+
+
+/*
+ * IMPORTANT:  these byte offsets are BIOS-SPECIFIC!!
+ *
+ * BE SURE YOUR BIOS IS NOT USING THESE NVRAM LOCATIONS!!
+ * AND THAT YOU HAVE NVRAM AT THESE LOCATIONS!!
+ *
+ * Potentially available on one system: 0x38-3f, 0x58-5f, 0x68-78.
+ * These were all zeroes in a /dev/nvram dump (don't forget to
+ * add 14 zero bytes at the beginning, since that hides addreses
+ * used by the RTC).
+ */
+
+#define	NVRAM_BYTE_0	0x5c
+#define	NVRAM_BYTE_1	0x5d
+#define	NVRAM_BYTE_2	0x5e
+
+static int set_magic_time(unsigned int user, unsigned int file, unsigned int device)
+{
+	unsigned int	n = user + USERHASH*(file + FILEHASH*device);
+	unsigned long	flags;
+
+	spin_lock_irqsave(&rtc_lock, flags);
+	CMOS_WRITE(n, NVRAM_BYTE_0);
+	n >>= 8;
+	CMOS_WRITE(n, NVRAM_BYTE_1);
+	n >>= 8;
+	CMOS_WRITE(n, NVRAM_BYTE_2);
+	spin_unlock_irqrestore(&rtc_lock, flags);
+
+	return n ? -1 : 0;
+}
+static unsigned int read_magic_time(void)
+{
+	unsigned long	flags;
+	unsigned	value;
+
+	spin_lock_irqsave(&rtc_lock, flags);
+	value = CMOS_READ(NVRAM_BYTE_2);
+	value <<= 8;
+	value |= CMOS_READ(NVRAM_BYTE_1);
+	value <<= 8;
+	value |= CMOS_READ(NVRAM_BYTE_0);
+	spin_unlock_irqrestore(&rtc_lock, flags);
+
+	printk("  pm trace value: %06x\n", value);
+	return value;
+}
+
+#endif	/* !APPLE_X86 */
+
 /*
  * This is just the sdbm hash function with a user-supplied
  * seed and final size parameter.
@@ -164,7 +250,8 @@
 }
 
 extern char __tracedata_start, __tracedata_end;
-static int show_file_hash(unsigned int value)
+
+static int __init show_file_hash(unsigned int value)
 {
 	int match;
 	char *tracedata;
@@ -182,7 +269,7 @@
 	return match;
 }
 
-static int show_dev_hash(unsigned int value)
+static int __init show_dev_hash(unsigned int value)
 {
 	int match = 0;
 	struct list_head * entry = dpm_active.prev;
@@ -199,15 +286,15 @@
 	return match;
 }
 
-static unsigned int hash_value_early_read;
+static unsigned int __initdata hash_value_early_read;
 
-static int early_resume_init(void)
+static int __init early_resume_init(void)
 {
 	hash_value_early_read = read_magic_time();
 	return 0;
 }
 
-static int late_resume_init(void)
+static int __init late_resume_init(void)
 {
 	unsigned int val = hash_value_early_read;
 	unsigned int user, file, dev;
@@ -220,7 +307,8 @@
 
 	printk("  Magic number: %d:%d:%d\n", user, file, dev);
 	show_file_hash(file);
-	show_dev_hash(dev);
+	if (!show_dev_hash(dev))
+		printk("  no matching dev\n");
 	return 0;
 }
 

--Boundary-00=_V9+rElGoQ5cgeNp
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--Boundary-00=_V9+rElGoQ5cgeNp--
