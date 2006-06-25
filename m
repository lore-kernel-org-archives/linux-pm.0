From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Sat, 24 Jun 2006 19:32:36 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606241929340.6483@g5.osdl.org>
References: <Pine.LNX.4.44L0.0606242213531.492-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0606242213531.492-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org



On Sat, 24 Jun 2006, Alan Stern wrote:
> =

> Is this an okay place to point out that after resume-from-disk, the i8042
> keyboard auto-repeat rate settings are messed up?

Does this fix it for you?

(Totally untested - I don't have PS/2 keyboards any more on the machines I =

actually use..)

> The VT console font is not restored either.

I don't think it ever has been, has it? That needs to be done by user =

space, it would be pretty wasteful to do it from the kernel..

		Linus

---
diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index fad04b6..d648242 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -39,6 +39,8 @@ static int atkbd_set =3D 2;
 module_param_named(set, atkbd_set, int, 0);
 MODULE_PARM_DESC(set, "Select keyboard code set (2 =3D default, 3 =3D PS/2=
 native)");
 =

+static int atkbd_repeatrate;
+
 #if defined(__i386__) || defined(__x86_64__) || defined(__hppa__)
 static int atkbd_reset;
 #else
@@ -477,7 +479,7 @@ static void atkbd_event_work(void *data)
 			j++;
 		dev->rep[REP_PERIOD] =3D period[i];
 		dev->rep[REP_DELAY] =3D delay[j];
-		param[0] =3D i | (j << 5);
+		param[0] =3D atkbd_repeatrate =3D i | (j << 5);
 		ps2_command(&atkbd->ps2dev, param, ATKBD_CMD_SETREP);
 	}
 =

@@ -679,7 +681,7 @@ static int atkbd_activate(struct atkbd *
  * Set autorepeat to fastest possible.
  */
 =

-	param[0] =3D 0;
+	param[0] =3D atkbd_repeatrate;
 	if (ps2_command(ps2dev, param, ATKBD_CMD_SETREP))
 		return -1;
 =
