From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] implement pm_ops.valid for everybody
Date: Sat, 24 Mar 2007 21:01:18 +0100
Message-ID: <200703242101.20349.rjw@sisk.pl>
References: <200703221344.l2MDi2Q9007989@olwen.urbana.css.mot.com>
	<200703232139.38721.rjw@sisk.pl>
	<20070324000147.GC14427@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070324000147.GC14427@elf.ucw.cz>
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
Cc: alexey.y.starikovskiy@intel.com, dirk.behme@de.bosch.com, linux-pm@lists.linux-foundation.org, johannes@sipsolutions.net, nico@cam.org, ben@simtec.co.uk, g.liakhovetski@gmx.de
List-Id: linux-pm@vger.kernel.org

On Saturday, 24 March 2007 01:01, Pavel Machek wrote:
> Hi!
> =

> (I do not want to get into this flamewar).

I'd rather call it a misunderstanding.

> > > That's a false choice, when you "mean" anything more than
> > > fairly broad behavioral expectations:  STR saves more power
> > > than "standby", and transitions to/from STR take more
> > > time than to/from "standby".
> > =

> > So be it.
> > =

> > Assume that the user does 'echo standby > /sys/power/state'.  I think h=
e can
> > expect that in such a case we'll freeze tasks and put devices into low-=
power
> > states and when he wakes up the system (BTW, I think the method of waki=
ng
> > up can be treated as a differentiating factor) he should be able to con=
tinue
> > from where he stopped after a little time.  Fine.
> > =

> > Now, we have to make that happen.  After we have frozen tasks, we need =
to
> > call something like device_suspend(some_argument) where the argument sh=
ould
> > tell drivers what to do.  Say we use something like PMSG_STANDBY and now
> =

> We would add another field to that struct, distingushing "mem" and
> "standby". And meaning for the drivers would be "try to save a lot of
> power, but keep the latency low" for standby, vs. "save as much power
> as possible" for mem.

Well, I think we can add more PMSG_* constants just fine.  Still, for a dri=
ver,
the meaning of PMSG_WHATEVER should be clear.

I agree that whatever is done in pm_ops->enter(some_state) has to depend on
the platform for quite obvious reasons, but the PMSG_* have some meaning
beyond the platform-specific code.

Greetings,
Rafael
