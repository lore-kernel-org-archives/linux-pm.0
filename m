From: Pavel Machek <pavel@ucw.cz>
Subject: suspend-to-both (less ugly version)
Date: Wed, 15 Mar 2006 10:06:27 +0100
Message-ID: <20060315090627.GA2201@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============11785865792444294=="
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Suspend-devel list <suspend-devel@lists.sourceforge.net>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============11785865792444294==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

Here's less ugly version of suspend-to-both patch. Code needs to
become optional on some command-line option, and then it may even be
ready for merge suspend.sf.net.

Ahha, and will have something to do with that chroot-safety-net.

Any testers?
								Pavel

Index: Makefile
===================================================================
RCS file: /cvsroot/suspend/suspend/Makefile,v
retrieving revision 1.21
diff -u -u -r1.21 Makefile
--- Makefile	12 Mar 2006 16:17:19 -0000	1.21
+++ Makefile	15 Mar 2006 09:04:17 -0000
@@ -69,8 +69,8 @@
 vt.o:	vt.c vt.h
 	gcc -Wall -c vt.c
 
-suspend:	md5.o encrypt.o config.o suspend.c swsusp.h config.h encrypt.h md5.h
-	gcc -Wall $(CC_FLAGS) md5.o encrypt.o config.o suspend.c -o suspend $(LD_FLAGS)
+suspend:	md5.o encrypt.o config.o suspend.c swsusp.h config.h encrypt.h md5.h s2ram.c dmidecode.c whitelist.c radeontool.c $(S2RAMOBJ)
+	gcc -g -O2 -DCONFIG_BOTH -Wall $(CC_FLAGS) md5.o encrypt.o config.o suspend.c s2ram.c -o suspend $(S2RAMOBJ) $(LD_FLAGS) -lpci 
 
 resume:	md5.o encrypt.o config.o resume.c swsusp.h config.h encrypt.h md5.h
 	gcc -Wall $(CC_FLAGS) md5.o encrypt.o config.o resume.c -static -o resume $(LD_FLAGS)
Index: s2ram.c
===================================================================
RCS file: /cvsroot/suspend/suspend/s2ram.c,v
retrieving revision 1.29
diff -u -u -r1.29 s2ram.c
--- s2ram.c	7 Mar 2006 23:54:21 -0000	1.29
+++ s2ram.c	15 Mar 2006 09:04:23 -0000
@@ -237,6 +239,7 @@
 	exit(1);
 }
 
+#ifndef CONFIG_BOTH
 int main(int argc, char *argv[])
 {
 	int i;
@@ -299,3 +302,4 @@
 	s2ram_resume();
 	return i;
 }
+#endif
Index: suspend.c
===================================================================
RCS file: /cvsroot/suspend/suspend/suspend.c,v
retrieving revision 1.22
diff -u -u -r1.22 suspend.c
--- suspend.c	12 Mar 2006 16:17:19 -0000	1.22
+++ suspend.c	15 Mar 2006 09:04:41 -0000
@@ -53,6 +53,7 @@
 #define encrypt 0
 #define key_name NULL
 #endif
+static int s2ram = 1;
 
 static struct config_par parameters[PARAM_NO] = {
 	{
@@ -518,6 +519,46 @@
 						ioctl(fd, VT_WAITACTIVE, vt); \
 						ioctl(fd, KDSKBMODE, ioc2);
 
+
+static int reset_signature(int fd)
+{
+	int ret, error = 0;
+
+	error = lseek(fd, 0, SEEK_SET);
+
+	if (!error) {
+		memset(&swsusp_header, 0, sizeof(swsusp_header));
+		ret = read(fd, &swsusp_header, PAGE_SIZE);
+		if (ret == PAGE_SIZE) {
+			if (memcmp(SWSUSP_SIG, swsusp_header.sig, 10)) {
+				/* Impossible? We wrote signature and it is not there?! */
+				error = -EINVAL;
+			}
+		} else {
+			error = ret < 0 ? ret : -EIO;
+		}
+	}
+
+	if (!error) {
+		/* Reset swap signature now */
+		memcpy(swsusp_header.sig, swsusp_header.orig_sig, 10);
+		error = lseek(fd, 0, SEEK_SET);
+	}
+	if (!error) {
+		ret = write(fd, &swsusp_header, PAGE_SIZE);
+		error = (ret != PAGE_SIZE)
+	}
+	fsync(fd);
+	if (error) {
+		printf("reset_signature: Error %d resetting the image.\n"
+		       "There should be valid image on disk. Powerdown and do normal resume.\n"
+		       "Continuing with this booted system will lead to data corruption.\n", 
+		       error);
+		while(1);
+	}
+	return error;
+}
+
 int suspend_system(int snapshot_fd, int resume_fd, int vt_fd, int vt_no)
 {
 	loff_t avail_swap;
@@ -552,7 +593,16 @@
 				break;
 			error = write_image(snapshot_fd, resume_fd);
 			if (!error) {
-				power_off();
+				if (!s2ram)
+					power_off();
+				else {
+					/* ioctl(snapshot_fd, SNAPSHOT_ENTER_ACPI_STATE, 3); */
+					s2ram_do();
+					s2ram_resume();
+					error = EDOM;
+					reset_signature(resume_fd);
+					break;
+				}
 			} else {
 				free_swap_pages(snapshot_fd);
 				free_snapshot(snapshot_fd);
@@ -569,7 +619,6 @@
 
 Unfreeze:
 	unfreeze(snapshot_fd);
-
 	return error;
 }
 
@@ -779,7 +828,6 @@
 	if (stat(resume_dev_name, &stat_buf)) {
 		fprintf(stderr, "suspend: Could not stat the resume device file\n");
 		return ENODEV;
-	} else {
 	}
 	if (!S_ISBLK(stat_buf.st_mode)) {
 		fprintf(stderr, "suspend: Invalid resume device\n");
@@ -797,6 +845,10 @@
 		ret = ENODEV;
 		goto Close_resume_fd;
 	}
+
+	if (s2ram)
+		s2ram_prepare();
+
 	if (!S_ISCHR(stat_buf.st_mode)) {
 		fprintf(stderr, "suspend: Invalid snapshot device\n");
 		ret = EINVAL;
@@ -823,6 +875,7 @@
 		goto Close_snapshot_fd;
 	}
 
+#if 0
 	sprintf(chroot_path, "/proc/%d", getpid());
 	if (chroot(chroot_path)) {
 		fprintf(stderr, "suspend: Could not chroot to %s\n", chroot_path);
@@ -830,6 +883,7 @@
 		goto Restore_console;
 	}
 	chdir("/");
+#endif
 
 	orig_loglevel = get_kernel_console_loglevel();
 	set_kernel_console_loglevel(suspend_loglevel);

-- 
119:        CryptoStream cs = new CryptoStream( ms, ct, CryptoStreamMode.Write );

--===============11785865792444294==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============11785865792444294==--
