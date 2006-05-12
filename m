From: Pavel Machek <pavel@ucw.cz>
Subject: [PATCH/rfc] schedule /sys/device/.../power for removal
Date: Fri, 12 May 2006 12:05:44 +0200
Message-ID: <20060512100544.GA29010@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============23185175988500983=="
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
To: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============23185175988500983==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

It is very ugly, and we really should use names instead.

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index 421bcff..dfcfc47 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -6,6 +6,16 @@ be removed from this file.
 
 ---------------------------
 
+What:	/sys/device/.../power
+When:	July 2007
+Files:	
+Why:	Because it takes integers, and different userland applications
+	expect different numbers to mean different things.
+	(Pcmcia expect 2 for off, some other code expects 3 for off).
+Who:	Pavel Machek <pavel@suse.cz>
+
+---------------------------
+
 What:	devfs
 When:	July 2005
 Files:	fs/devfs/*, include/linux/devfs_fs*.h and assorted devfs

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

--===============23185175988500983==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============23185175988500983==--
