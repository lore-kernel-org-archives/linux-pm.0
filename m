From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Re: lockdep report in hibernate code
Date: Sun, 28 Oct 2007 11:38:36 +0100
Message-ID: <1193567916.3966.14.camel@johannes.berg>
References: <Pine.LNX.4.44L0.0710271827210.2418-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1568027953209861149=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0710271827210.2418-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org


--===============1568027953209861149==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-1ExZ2GYplLMoSaj5FTiN"


--=-1ExZ2GYplLMoSaj5FTiN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> The "nested" part of the name is a little misleading.  The function
> helps the lockdep core distinguish between locks belonging to the same
> class.  Normally this is be done so that you can nest the locks in the
> proper order, but that shouldn't stop you from using it here.

Oh good point. I'll test the patch below during the week (my powerbook
doesn't have lockdep and I don't have another machine here right now)
but I'm fairly confident it'll fix the issue. I'll submit it after
testing.

johannes

--- linux-2.6.orig/kernel/power/disk.c	2007-10-28 11:34:32.669337294 +0100
+++ linux-2.6/kernel/power/disk.c	2007-10-28 11:37:29.849294324 +0100
@@ -456,7 +456,17 @@ static int software_resume(void)
 	int error;
 	unsigned int flags;
=20
-	mutex_lock(&pm_mutex);
+	/*
+	 * name_to_dev_t() below takes a sysfs buffer mutex when sysfs
+	 * is configured into the kernel. Since the regular hibernate
+	 * trigger path is via sysfs which takes a buffer mutex before
+	 * calling hibernate functions (which take pm_mutex) this can
+	 * cause lockdep to complain about a possible ABBA deadlock
+	 * which cannot happen since we're in the boot code here and
+	 * sysfs can't be invoked yet. Therefore, we use a subclass
+	 * here to avoid lockdep complaining.
+	 */
+	mutex_lock_nested(&pm_mutex, 1);
 	if (!swsusp_resume_device) {
 		if (!strlen(resume_file)) {
 			mutex_unlock(&pm_mutex);


--=-1ExZ2GYplLMoSaj5FTiN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARyRmq6Vg1VMiehFYAQL6xw/9FrI4AgRnpSoL2ML37kpnJJ5G94SmvZKx
QdfxR15c2Q633rtEo7yp0mCh9A9PF6y+tvD55KrEICajiVQmNsuZJhZ8fw4bDnQ/
Kt/ahdxgp9MNiM55kSiiRFhn+/sAqvjAxuFzHJq2LNkrO1Iu3P9QD51ymWtehk0y
seq8MNF5EVaQtW1DGc80wdFWaJZZ3Wi2rpFCjBwd4hsqVWY4Y27kcE6UZX4qy9rJ
rdrsKqW1pQT13W8FZjC+qSFC+mSeZhc/KawJzERg5lhp4S1Ku2dZrEQjibdg4l/8
1XR2dk/MFN7p8t9xXff18IWth5oZVchYCQblaeOf1x2OFHmIr7zLVkp6mqAulh49
C7u0+nL3KKlDW+Brl9IN5a1R8xm96NwRBkcMMXV/hbGxlqE/sbb8VmBXsyvQlSrC
fcFnzcXW1suBojQrweKe2SYHPN9yoZipaHVmZzJZItM5mWe5o7G+LTtrMQSx+f2V
0gxYsqZqXaL//b3jiTIM1W6gKvHGHIoMN4bTE42N+rZ8YZ6nr0tKuhXNzNby4317
7TZtinf+s78MoqIeWZ03sYAlLNoEBC6/mNivTr4nWfzEhFn2UHaUmg2OZm9KabeC
zWemaF9vW/p5yxFVOtXG3AUZqL0v3fbk7tRu08qYt0VAzwP6rAcXJ4hvsbFMfSgH
lFlbU1yB5wA=
=dIcx
-----END PGP SIGNATURE-----

--=-1ExZ2GYplLMoSaj5FTiN--


--===============1568027953209861149==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1568027953209861149==--
