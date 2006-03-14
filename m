From: Pavel Machek <pavel@suse.cz>
Subject: Re: Re: standby to disk transition
Date: Tue, 14 Mar 2006 22:59:19 +0100
Message-ID: <20060314215919.GP1782@elf.ucw.cz>
References: <E1FIctI-0000jE-00@porton.narod.ru>
	<200603140036.17051.rjw@sisk.pl> <20060314203350.GG1782@elf.ucw.cz>
	<200603142213.03000.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============059372436224574887=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200603142213.03000.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <nigel@suspend2.net>, linux-pm@osdl.org, linux-pm@lists.osdl.org, "Victor Porton, , , " <porton@ex-code.com>
List-Id: linux-pm@vger.kernel.org

--===============059372436224574887==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

Just a preview of what I'm working on: suspend-to-both
implementation. Be *very* careful with it.


===================================================================
RCS file: /cvsroot/suspend/suspend/Makefile,v
retrieving revision 1.21
diff -u -u -r1.21 Makefile
--- Makefile	12 Mar 2006 16:17:19 -0000	1.21
+++ Makefile	14 Mar 2006 21:55:40 -0000
@@ -1,5 +1,5 @@
 #CONFIG_COMPRESS=yes
-#CONFIG_ENCRYPT=yes
+CONFIG_ENCRYPT=yes
 
 CC_FLAGS=-I/usr/local/include
 LD_FLAGS=-L/usr/local/lib
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
+++ s2ram.c	14 Mar 2006 21:55:44 -0000
@@ -162,9 +162,11 @@
 		vbe_buffer = __save_state(&size);
 	}
 	if (flags & RADEON_OFF) {
+#if 0
 		map_radeon_cntl_mem();
 		printf("Calling radeon_cmd_light");
 		radeon_cmd_light("off");
+#endif
 	}
 }
 
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
+++ suspend.c	14 Mar 2006 21:55:58 -0000
@@ -53,6 +53,7 @@
 #define encrypt 0
 #define key_name NULL
 #endif
+static int s2ram = 1;
 
 static struct config_par parameters[PARAM_NO] = {
 	{
@@ -518,6 +519,50 @@
 						ioctl(fd, VT_WAITACTIVE, vt); \
 						ioctl(fd, KDSKBMODE, ioc2);
 
+
+static int reset_signature(int fd)
+{
+	static struct swap_map_handle handle;
+	int ret, error = 0;
+	struct swsusp_info *header;
+	char c;
+
+	ret = lseek(fd, 0, SEEK_SET);
+	if (!ret)
+		return -errno;
+	memset(&swsusp_header, 0, sizeof(swsusp_header));
+	ret = read(fd, &swsusp_header, PAGE_SIZE);
+	if (ret == PAGE_SIZE) {
+		if (memcmp(SWSUSP_SIG, swsusp_header.sig, 10))
+			/* Impossible? We wrote signature and it is not there?! */
+			return -EINVAL;
+	} else {
+		error = ret < 0 ? ret : -EIO;
+	}
+
+	if (!error || !ret) {
+		/* Reset swap signature now */
+		memcpy(swsusp_header.sig, swsusp_header.orig_sig, 10);
+		ret = lseek(fd, 0, SEEK_SET);
+		if (!ret)
+			ret = write(fd, &swsusp_header, PAGE_SIZE);
+		if (ret < (int)PAGE_SIZE) {
+			fprintf(stderr, "resume: Could not restore the partition header\n");
+			error = ret < 0 ? -errno : -EIO;
+		}
+	}
+	fsync(fd);
+	close(fd);
+	if (!error) {
+		printf("reset_signature: Signature reset ok\n");
+	} else {
+		printf("reset_signature: Error %d resetting the image. Something went very wrong please reboot machine manually, destroy saved image, and force fsck.\n"
+			"\n", error);
+		while(1);
+	}
+	return error;
+}
+
 int suspend_system(int snapshot_fd, int resume_fd, int vt_fd, int vt_no)
 {
 	loff_t avail_swap;
@@ -552,7 +597,15 @@
 				break;
 			error = write_image(snapshot_fd, resume_fd);
 			if (!error) {
-				power_off();
+				if (!s2ram)
+					power_off();
+				else {
+					s2ram_do();
+					s2ram_resume();
+					error = EDOM;
+					reset_signature(snapshot_fd);
+					break;
+				}
 			} else {
 				free_swap_pages(snapshot_fd);
 				free_snapshot(snapshot_fd);
@@ -569,6 +622,7 @@
 
 Unfreeze:
 	unfreeze(snapshot_fd);
+	/* FIXME: We have to kill the signature here */
 
 	return error;
 }
@@ -779,7 +833,6 @@
 	if (stat(resume_dev_name, &stat_buf)) {
 		fprintf(stderr, "suspend: Could not stat the resume device file\n");
 		return ENODEV;
-	} else {
 	}
 	if (!S_ISBLK(stat_buf.st_mode)) {
 		fprintf(stderr, "suspend: Invalid resume device\n");
@@ -797,6 +850,10 @@
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
@@ -823,6 +880,7 @@
 		goto Close_snapshot_fd;
 	}
 
+#if 0
 	sprintf(chroot_path, "/proc/%d", getpid());
 	if (chroot(chroot_path)) {
 		fprintf(stderr, "suspend: Could not chroot to %s\n", chroot_path);
@@ -830,6 +888,7 @@
 		goto Restore_console;
 	}
 	chdir("/");
+#endif
 
 	orig_loglevel = get_kernel_console_loglevel();
 	set_kernel_console_loglevel(suspend_loglevel);

-- 
53:        Decrypt( adPRIV, 0, adPRIV.Length, UserKey, MD5.Hash );

--===============059372436224574887==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============059372436224574887==--
