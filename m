From: Pavel Machek <pavel@suse.cz>
Subject: Re: swsusp: Not enough free pages
Date: Mon, 30 May 2005 17:01:57 +0200
Message-ID: <20050530150157.GC2207@elf.ucw.cz>
References: <3ACA40606221794F80A5670F0AF15F84041AC1A8@pdsmsx403>
	<42935C72.9030506@suse.de>
	<20050525012040.GA6145@linux.sh.intel.com>
	<20050530091419.GA7922@linux.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============91154022603250606=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050530091419.GA7922@linux.sh.intel.com>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Stefan Seyfried <seife@suse.de>, ACPI devel <acpi-devel@lists.sourceforge.net>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============91154022603250606==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > >    > I got this error when I'm hacking suspend-to-disk on my IA64 box
> > >    with 1G
> > >    > memory.
> > >    > (Pagesize 64K,MemTotal:  1002112 kB ,MemFree:  395008 kB)
> > >    > Do you plan to improve it by compressing pages ?
> > >    >
> > >    > swsusp: Need to copy 9878 pages
> > >    > suspend: (pages needed: 9878 + 512 free: 6486)
> > >    > swsusp: Not enough free pages: Have 6486
> > >    I have not seen one of those for a long time (on i386). Does this
> > >    happen
> > >    every time? 
> > 
> > So far, yes. I just tried 2 times.
> 
> always. (I check that swap dev is on)
> 
> Sometimes, my ia32 laptop free 0 pages too.
> I think we should always free some pages 
> from various caches. 

Try this hack... it is basically mm problem I don't know how to fix,
but this seems to help.
								Pavel

Index: kernel/power/disk.c
===================================================================
--- 805a02ec2bcff3671d7b1e701bd1981ad2fa196c/kernel/power/disk.c  (mode:100644)
+++ ecd8559cc08319bb16a42aac06cf7d664157643a/kernel/power/disk.c  (mode:100644)
@@ -88,23 +92,25 @@
 
 static void free_some_memory(void)
 {
-	unsigned int i = 0;
-	unsigned int tmp;
-	unsigned long pages = 0;
-	char *p = "-\\|/";
-
-	printk("Freeing memory...  ");
-	while ((tmp = shrink_all_memory(10000))) {
-		pages += tmp;
-		printk("\b%c", p[i]);
-		i++;
-		if (i > 3)
-			i = 0;
+	int i;
+	for (i=0; i<5; i++) {
+		int i = 0, tmp;
+		long pages = 0;
+		char *p = "-\\|/";
+
+		printk("Freeing memory...  ");
+		while ((tmp = shrink_all_memory(10000))) {
+			pages += tmp;
+			printk("\b%c", p[i]);
+			i++;
+			if (i > 3)
+				i = 0;
+		}
+		printk("\bdone (%li pages freed)\n", pages);
+		msleep_interruptible(200);
 	}
-	printk("\bdone (%li pages freed)\n", pages);
 }
 
-
 static inline void platform_finish(void)
 {
 	if (pm_disk_mode == PM_DISK_PLATFORM) {

--===============91154022603250606==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============91154022603250606==--
