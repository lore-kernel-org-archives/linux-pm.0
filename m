From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] implement pm_ops.valid for everybody
Date: Sat, 24 Mar 2007 01:01:47 +0100
Message-ID: <20070324000147.GC14427@elf.ucw.cz>
References: <200703221344.l2MDi2Q9007989@olwen.urbana.css.mot.com>
	<200703231443.19536.rjw@sisk.pl>
	<200703231057.16539.david-b@pacbell.net>
	<200703232139.38721.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200703232139.38721.rjw@sisk.pl>
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
Cc: alexey.y.starikovskiy@intel.com, dirk.behme@de.bosch.com, linux-pm@lists.linux-foundation.org, johannes@sipsolutions.net, nico@cam.org, ben@simtec.co.uk, g.liakhovetski@gmx.de
List-Id: linux-pm@vger.kernel.org

Hi!

(I do not want to get into this flamewar).

> > That's a false choice, when you "mean" anything more than
> > fairly broad behavioral expectations:  STR saves more power
> > than "standby", and transitions to/from STR take more
> > time than to/from "standby".
> =

> So be it.
> =

> Assume that the user does 'echo standby > /sys/power/state'.  I think he =
can
> expect that in such a case we'll freeze tasks and put devices into low-po=
wer
> states and when he wakes up the system (BTW, I think the method of waking
> up can be treated as a differentiating factor) he should be able to conti=
nue
> from where he stopped after a little time.  Fine.
> =

> Now, we have to make that happen.  After we have frozen tasks, we need to
> call something like device_suspend(some_argument) where the argument shou=
ld
> tell drivers what to do.  Say we use something like PMSG_STANDBY and now

We would add another field to that struct, distingushing "mem" and
"standby". And meaning for the drivers would be "try to save a lot of
power, but keep the latency low" for standby, vs. "save as much power
as possible" for mem.
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
