From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH] swsusp: documentation update
Date: Sun, 5 Feb 2006 12:16:55 +0100
Message-ID: <20060205111655.GF1790@elf.ucw.cz>
References: <200602050903.48678.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============90339229164611412=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200602050903.48678.rjw@sisk.pl>
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
Cc: Linux PM <linux-pm@osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============90339229164611412==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Ne 05-02-06 09:03:48, Rafael J. Wysocki wrote:
> Hi,
> 
> This patch updates the swsusp documentation to reflect the recent change
> that prevented the kernel from setting to console loglevel to 10
> unconditionally during suspend.  It also removes one obsolete
> paragraph.

I'd say that kernel messages are common knowledge and do not deserve
to be *that* visible.

What about this? If you agree, I'll push it to akpm.

diff --git a/Documentation/power/swsusp.txt b/Documentation/power/swsusp.txt
index b28b7f0..96bbe61 100644
--- a/Documentation/power/swsusp.txt
+++ b/Documentation/power/swsusp.txt
@@ -27,19 +27,18 @@ echo shutdown > /sys/power/disk; echo di
 
 echo platform > /sys/power/disk; echo disk > /sys/power/state
 
+. If you have SATA disks, you'll need recent kernels with SATA suspend
+support. For suspend and resume to work, make sure your disk drivers
+are built into kernel -- not modules. [There's way to make
+suspend/resume with modular disk drivers, see FAQ, but you probably
+should not do that.]
+
 If you want to limit the suspend image size to N bytes, do
 
 echo N > /sys/power/image_size
 
 before suspend (it is limited to 500 MB by default).
 
-Encrypted suspend image:
-------------------------
-If you want to store your suspend image encrypted with a temporary
-key to prevent data gathering after resume you must compile
-crypto and the aes algorithm into the kernel - modules won't work
-as they cannot be loaded at resume time.
-
 
 Article about goals and implementation of Software Suspend for Linux
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -333,4 +332,19 @@ init=/bin/bash, then swapon and starting
 usually does the trick. Then it is good idea to try with latest
 vanilla kernel.
 
+Q: How can distributions ship a swsusp-supporting kernel with modular
+disk drivers (especially SATA)?
+
+A: Well, it can be done, load the drivers, then do echo into
+/sys/power/disk/resume file from initrd. Be sure not to mount
+anything, not even read-only mount, or you are going to lose your
+data.
+
+Q: How do I make suspend more verbose?
+
+A: If you want to see any non-error kernel messages on the virtual
+terminal the kernel switches to during suspend, you have to set the
+kernel console loglevel to at least 4 (KERN_WARNING), for example by
+doing
 
+	echo 4 > /proc/sys/kernel/printk



-- 
Thanks, Sharp!

--===============90339229164611412==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============90339229164611412==--
