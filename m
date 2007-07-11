From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH -mm 0/7] Freezer update (updated)
Date: Thu, 12 Jul 2007 00:06:49 +0200
Message-ID: <200707120006.50095.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Oleg Nesterov <oleg@tv-sign.ru>, Pavel Machek <pavel@ucw.cz>, Miklos Szeredi <miklos@szeredi.hu>
List-Id: linux-pm@vger.kernel.org

Hi,

This is the second "release" of my latest freezer update.  I have updated=
 the
patches to take your comments into account (thanks a lot for them) and
changed their ordering.

The patches in these series update the freezer to eliminate some existing
shortcomings, so I'm still considering them as 2.6.23 material.

The patches do the following:
* update the freezer documentation to describe, previously omitted, impor=
tant
  reason for freezing tasks (ie. memory shrinking)
* remove sys_sync() from the freezer and make the suspend/hibernation cod=
e
=A0 invoke it explicitly
* prevent new tasks from inheriting TIF_FREEZE set from the parents
* introduce freezer-firendly wrappers around wait_event_interruptible()
  and wait_event_interruptible_timeout()
* prevent the freezer from sending signals to kernel threads
* increase the verbosity of the freezer slightly
* make the freezer use the freezing timeout more efficiently
The details are in the changelogs.

Comments welcome.

Greetings,
Rafael

--=20
"Premature optimization is the root of all evil." - Donald Knuth
