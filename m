From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH -mm 3/3] Freezer: Replace the timeout
Date: Wed, 1 Aug 2007 10:31:46 +0200
Message-ID: <20070801083146.GX2087@elf.ucw.cz>
References: <200707251401.48340.rjw@sisk.pl> <20070731100254.GC3462@elf.ucw.cz>
	<200708010025.27018.rjw@sisk.pl> <200708010029.43652.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200708010029.43652.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Andres Salomon <dilinger@debian.org>, linux-pm@lists.linux-foundation.org, Chris Ball <cjb@laptop.org>, David Woodhouse <dwmw2@infradead.org>, Oleg Nesterov <oleg@tv-sign.ru>
List-Id: linux-pm@vger.kernel.org

Hi!

> Instead of using the global timeout, we can use a more fine grained met=
hod of
> checking if the freezing of tasks should fail.  Namely, we can measure =
the time
> in which no tasks have entered the refrigerator by counting the number =
of calls
> to wait_event_timeout() in try_to_freeze_tasks() that have returned 0 (=
in a
> row).
>=20
> After sending freeze requests to the tasks regarded as freezable
> try_to_freeze_tasks() goes to sleep and waits until at least one task e=
nters the
> refrigerator. =A0If the refrigerator is not entered by any tasks before=
 WAIT_TIME
> expires, try_to_freeze_tasks() increases the counter of expired timeout=
s and
> sends freeze requests to the remaining tasks.  If the number of expired=
 timeouts
> becomes greater than MAX_WAITS, the freezing of tasks fails (the counte=
r of
> expired timeouts is reset whenever a task enters the refrigerator).

I do not get logic behind this.

Old logic was "we give system 20 seconds to come into quiet state".

New logic is "if we do no progress within second, we fail"... which is
quite a big change. What happens on loaded ext3 filesystem, for
example? Bunch of userland tasks will wait on data to be synced to
disk, taking more than second, no?

								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html
