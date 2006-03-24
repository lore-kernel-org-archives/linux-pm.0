From: Stefan Rompf <stefan@loplof.de>
Subject: [PATCH] suspend.c: make sure stdin,
	stdout and stderr are open
Date: Fri, 24 Mar 2006 20:13:48 +0100
Message-ID: <200603242013.48811.stefan@loplof.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_sTEJE8XMr+yz5tq"
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
To: linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

--Boundary-00=_sTEJE8XMr+yz5tq
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

recently I patched my 2.6.16 kernel to use uswsusp. Nice work, but when I 
installed /usr/local/sbin/suspend into the Suse 9.3 powermanagement scripts, 
I've stumbled over a bad interaction: powersaved closes all filedescriptors 
before calling scripts. suspend then opens snapshot and swap device, 
allocating file descriptors 0 and 1, but printfs() afterwards. Luckily, I did 
not lose any data.

For robustness, suspend must make sure that these fds are open. Simple patch 
to achieve this is attached. It loses the descriptors, but I don't think 
that's an issue for the short running program.

Stefan

--Boundary-00=_sTEJE8XMr+yz5tq
Content-Type: text/x-diff;
  charset="us-ascii";
  name="suspend.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="suspend.diff"

Index: suspend.c
===================================================================
RCS file: /cvsroot/suspend/suspend/suspend.c,v
retrieving revision 1.33
diff -u -p -r1.33 suspend.c
--- suspend.c	21 Mar 2006 20:44:31 -0000	1.33
+++ suspend.c	24 Mar 2006 18:55:52 -0000
@@ -831,6 +830,10 @@ int main(int argc, char *argv[])
 	dev_t resume_dev;
 	int orig_loglevel, ret = 0;
 
+	/* Easy way to make sure that stdin, stdout and stderr are open
+	   so that later printfs wont go to our suspend partition */
+	while((unsigned)open("/dev/null", O_RDWR)<2);
+
 	if (get_config("suspend", argc, argv, PARAM_NO, parameters, resume_dev_name))
 		return EINVAL;
 	if (compute_checksum != 'y' && compute_checksum != 'Y')

--Boundary-00=_sTEJE8XMr+yz5tq
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--Boundary-00=_sTEJE8XMr+yz5tq--
