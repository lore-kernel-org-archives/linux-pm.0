From: Daniel Gollub <dgollub@suse.de>
Subject: RTPM allowing trailing newline in state_store()
Date: Wed, 28 Sep 2005 18:12:16 +0200
Message-ID: <20050928181216.4fe42a8a@yang-old.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----------=_1127923904-13385-327"
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
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

This is a multi-part message in MIME format...

------------=_1127923904-13385-327
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp.osdl.org id j8SGBd4s017859

hi,

is there a special way reserved for writing on power/state in the device
directories?
a simple echo {0,1,2,3} doesn't work, because of the trailing newline.
only with echo -n it works.
i was very confused about that... i needed two days to figure this out
:)
maybe it's a good idea to allow an value with \n=A0 .. because other stat=
e
files like /sys/power/state also allows trailing newlines.

can you please give me a hint, if there is another special way to set a
single device in suspend. or is there a reason for ignoring trailing
newline?

thanks,
daniel

simple patch for allowing trailing newlines in state_strore in sysfs.c :

--- linux/drivers/base/power/sysfs.c.orig=A0=A0=A0=A0=A0=A0 2005-09-20
17:07:42.000000000 +0200
+++ linux/drivers/base/power/sysfs.c=A0=A0=A0 2005-09-20 17:09:42.0000000=
00
+0200
@@ -36,7 +36,7 @@ static ssize_t state_store(struct device
=A0=A0=A0=A0=A0=A0=A0 int error =3D 0;
=A0
=A0=A0=A0=A0=A0=A0=A0 state =3D simple_strtoul(buf, &rest, 10);
-=A0=A0=A0=A0=A0=A0 if (*rest)
+=A0=A0=A0=A0=A0=A0 if (*rest && *rest !=3D '\n')
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;
=A0=A0=A0=A0=A0=A0=A0 if (state)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 error =3D dpm_runtime_suspe=
nd(dev, state);

_______________________________________________
linux-pm mailing list
linux-pm@lists.osdl.org
https://lists.osdl.org/mailman/listinfo/linux-pm

------------=_1127923904-13385-327
Content-Type: text/plain; name="SpamAssassinReport.txt"
Content-Disposition: inline; filename="SpamAssassinReport.txt"
MIME-Version: 1.0
X-Mailer: MIME-tools 5.411 (Entity 5.404)
Content-Transfer-Encoding: 7bit

Spam detection software, running on the system "fire-1.osdl.org", has
identified this incoming email as possible spam.  The original message
has been attached to this so you can view it (if it isn't spam) or block
similar future email.  If you have any questions, see
the administrator of that system for details.

Content preview:  hi, is there a special way reserved for writing on
  power/state in the device directories? a simple echo {0,1,2,3} doesn't
  work, because of the trailing newline. only with echo -n it works. i
  was very confused about that... i needed two days to figure this out :)
  maybe it's a good idea to allow an value with \n .. because other state
  files like /sys/power/state also allows trailing newlines. [...] 

Content analysis details:   (6.0 points, 5.0 required)

 pts rule name              description
---- ---------------------- --------------------------------------------------
 2.0 OSDL_HIGH_ASCII_6      BODY: 6 high-ASCII characters in a row
 2.0 OSDL_HIGH_ASCII_7      BODY: 7 high-ASCII characters in a row
 2.0 OSDL_HIGH_ASCII_15     BODY: 15 or more high-ASCII characters in a row



------------=_1127923904-13385-327--
