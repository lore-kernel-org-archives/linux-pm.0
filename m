From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm 3/3] Freezer: Replace the timeout
Date: Wed, 1 Aug 2007 12:43:24 +0200
Message-ID: <200708011243.25276.rjw@sisk.pl>
References: <200707251401.48340.rjw@sisk.pl> <200708010029.43652.rjw@sisk.pl>
	<20070801083146.GX2087@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070801083146.GX2087@elf.ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Andres Salomon <dilinger@debian.org>, linux-pm@lists.linux-foundation.org, Chris Ball <cjb@laptop.org>, David Woodhouse <dwmw2@infradead.org>, Oleg Nesterov <oleg@tv-sign.ru>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 1 August 2007 10:31, Pavel Machek wrote:
> Hi!
>=20
> > Instead of using the global timeout, we can use a more fine grained m=
ethod of
> > checking if the freezing of tasks should fail.  Namely, we can measur=
e the time
> > in which no tasks have entered the refrigerator by counting the numbe=
r of calls
> > to wait_event_timeout() in try_to_freeze_tasks() that have returned 0=
 (in a
> > row).
> >=20
> > After sending freeze requests to the tasks regarded as freezable
> > try_to_freeze_tasks() goes to sleep and waits until at least one task=
 enters the
> > refrigerator. =A0If the refrigerator is not entered by any tasks befo=
re WAIT_TIME
> > expires, try_to_freeze_tasks() increases the counter of expired timeo=
uts and
> > sends freeze requests to the remaining tasks.  If the number of expir=
ed timeouts
> > becomes greater than MAX_WAITS, the freezing of tasks fails (the coun=
ter of
> > expired timeouts is reset whenever a task enters the refrigerator).
>=20
> I do not get logic behind this.
>=20
> Old logic was "we give system 20 seconds to come into quiet state".
>=20
> New logic is "if we do no progress within second, we fail"... which is
> quite a big change.

Well, I agree, and that's why I wanted to separate this part from the two
previous patches ...

> What happens on loaded ext3 filesystem, for example? Bunch of userland =
tasks
> will wait on data to be synced to disk, taking more than second, no?

IMHO this only is a question of what the value of MAX_WAITS should be.
[I took 5 because it turned to be enough in my testing, but that could be=
 10 or
more.]

The point is that in 99.(9)% of cases the 20s timeout is unnecessary, bec=
ause:
(1) most often we succeed within 1s
(2) if we are going to fail, we can say that we'll fail way before the 20=
s
    expires.
Now, the question is how we can check that we'll fail and this patch atte=
mpts
to use a simple machanism:
* measure the time in which no tasks have entered the refrigerator and if=
 this
  time is long enough, we can safely assume the "blocking" tasks to be st=
uck
  somewhere and give up.
This isn't bullet proof, but it should cover the vast majority of cases.

Anyway, eventually, I'd like the freezer to detect failures relatively ea=
rly,
so the user won't have to wait 20s each time it's going to fail.

Greetings,
Rafael


--=20
"Premature optimization is the root of all evil." - Donald Knuth
