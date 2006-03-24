From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] suspend.c: make sure stdin,
	stdout and stderr are open
Date: Fri, 24 Mar 2006 23:55:12 +0100
Message-ID: <200603242355.48702.rjw@sisk.pl>
References: <200603242013.48811.stefan@loplof.de>
	<200603242136.56180.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3939524348452943=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200603242136.56180.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Stefan Rompf <stefan@loplof.de>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============3939524348452943==
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 24 March 2006 21:36, Rafael J. Wysocki wrote:
> On Friday 24 March 2006 20:13, Stefan Rompf wrote:
> > recently I patched my 2.6.16 kernel to use uswsusp. Nice work, but when I 
> > installed /usr/local/sbin/suspend into the Suse 9.3 powermanagement scripts, 
> > I've stumbled over a bad interaction: powersaved closes all filedescriptors 
> > before calling scripts. suspend then opens snapshot and swap device, 
> > allocating file descriptors 0 and 1, but printfs() afterwards. Luckily, I did 
> > not lose any data.

Fortunately it drops the 0, 1 and 2 descriptors afterwards in prepare_console(). :-)

Still this is a bug and has to be fixed.

I've redone your patch a bit, could you please test it?

Rafael

---
 suspend.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletion(-)

Index: suspend/suspend.c
===================================================================
--- suspend.orig/suspend.c
+++ suspend/suspend.c
@@ -856,7 +856,7 @@ int main(int argc, char *argv[])
 	struct stat stat_buf;
 	int resume_fd, snapshot_fd, vt_fd, orig_vc = -1, suspend_vc = -1;
 	dev_t resume_dev;
-	int orig_loglevel, ret = 0;
+	int orig_loglevel, ret;
 
 	if (get_config("suspend", argc, argv, PARAM_NO, parameters, resume_dev_name))
 		return EINVAL;
@@ -875,6 +875,18 @@ int main(int argc, char *argv[])
 	if (s2ram != 'y' && s2ram != 'Y')
 		s2ram = 0;
 
+	/* Make sure the 0, 1, 2 descriptors are open before opening the
+	 * snapshot and resume devices
+	 */
+	do {
+		ret = open("/dev/null", O_RDWR);
+		if (ret < 0) {
+			fprintf(stderr, "suspend: Could not open /dev/null\n");
+			return errno;
+		}
+	} while (ret <= 2);
+	close(ret);
+
 	setvbuf(stdout, NULL, _IONBF, 0);
 	setvbuf(stderr, NULL, _IONBF, 0);
 
@@ -898,6 +910,7 @@ int main(int argc, char *argv[])
 	}
 	resume_dev = stat_buf.st_rdev;
 
+	ret = 0;
 	if (stat(snapshot_dev_name, &stat_buf)) {
 		fprintf(stderr, "suspend: Could not stat the snapshot device file\n");
 		ret = ENODEV;

--===============3939524348452943==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============3939524348452943==--
