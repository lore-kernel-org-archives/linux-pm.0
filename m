From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Sun, 9 Jul 2006 16:28:28 -0700
Message-ID: <200607091628.29269.david-b@pacbell.net>
References: <Pine.LNX.4.64.0606221210350.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606282016220.12404@g5.osdl.org>
	<200607061527.29421.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_dEZsEIc9IyUows0"
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200607061527.29421.david-b@pacbell.net>
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
Cc: Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--Boundary-00=_dEZsEIc9IyUows0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


> > > Any thoughts as to applying your patch to the tree or not?  No objection
> > > from me if you want to.
> > 
> > I've not actually had anybody report any testing success from it ...

Here's a minor fix to Linus' PM API changes:  remove some syslog noise,
these messages appear even when they're meaningless.  Greg, please add
this to your collection.

- Dave



--Boundary-00=_dEZsEIc9IyUows0
Content-Type: text/x-diff;
  charset="us-ascii";
  name="linus-pm-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="linus-pm-fix.patch"

Fix a goof in Linus' recent PM API updates:  don't emit any messages in the
typical NOP "already suspended it" late suspend case.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: at91/drivers/base/power/suspend.c
===================================================================
--- at91.orig/drivers/base/power/suspend.c	2006-07-09 13:57:34.000000000 -0700
+++ at91/drivers/base/power/suspend.c	2006-07-09 13:57:34.000000000 -0700
@@ -102,11 +102,6 @@ static int suspend_device_late(struct de
 {
 	int error = 0;
 
-	if (dev->power.power_state.event) {
-		dev_dbg(dev, "PM: suspend_late %d-->%d\n",
-			dev->power.power_state.event, state.event);
-	}
-
 	if (dev->bus && dev->bus->suspend_late && !dev->power.power_state.event) {
 		dev_dbg(dev, "LATE %s%s\n",
 			suspend_verb(state.event),

--Boundary-00=_dEZsEIc9IyUows0
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--Boundary-00=_dEZsEIc9IyUows0--
