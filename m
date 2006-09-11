From: "David Singleton" <daviado@gmail.com>
Subject: Re: So, what's the status on the recent patches here?
Date: Mon, 11 Sep 2006 08:11:20 -0700
Message-ID: <b324b5ad0609110811p3a24e5fem88ef852a9711066b@mail.gmail.com>
References: <ADE4D9DBCFC3A345AAA95C195F62B6DD01A94E18@de01exm64.ds.mot.com>
	<1ac6c8e2a817eb0e11257b47199872f8@comcast.net>
	<b324b5ad0609021105u7fcab8c3w6d21bfca9caa93d1@mail.gmail.com>
	<200609022130.59256.rjw@sisk.pl>
	<b324b5ad0609030925p1d82385bs4da21663d47f44c3@mail.gmail.com>
	<20060903213325.GB9991@elf.ucw.cz>
	<b324b5ad0609081739q1477fa99h58827ce7deaa78a8@mail.gmail.com>
	<20060909121720.GD4277@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060909121720.GD4277@ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.osdl.org, Matthew Locke <matthew.a.locke@comcast.net>, Preece Scott-PREECE <scott.preece@motorola.com>
List-Id: linux-pm@vger.kernel.org

On 9/9/06, Pavel Machek <pavel@ucw.cz> wrote:
> On Fri 08-09-06 17:39:52, David Singleton wrote:
> > On 9/3/06, Pavel Machek <pavel@ucw.cz> wrote:
> > > > And those same steps are the same steps required to transition the
> > > > system to a new operating point, whether it's suspend or change
> > > > from 1.4GHz to 600MHz.
> > >
> > > No, processes are not frozen for simple cpu frequency change -- on
> > > non-broken cpus.
> >
> > I didn't say cpu frequency changes freeze processes.  I said a suspend
> > does a prepare to suspend step (which freezes processes) and a cpu freq=
uency
> > change does a prepare to change frequency step (where it will run the d=
river
> > notifier list to get drivers set to scale).
>
> Yep, and switching consoles is also same. It is prepare to switch, do
> a switch, notify people you switched. Shall we use same code?

No.  Since switching console is not dealing with changing the operating
state of the system.  It's just switching which device is the console.

>
> > They both do the same three steps:
> >
> > 1) prepare to transition
> >
> > 2) transition
> >
> > 3) finish transition
> >
> > That's one of my arguements as to why suspend states should be treated
> > just like frequency states.
>
> Cat and horse is a same animal. They both have 4 legs, one head and a
> tail.
>
> Anyway, as a software suspend maintainer, I do not want you to add
> non-sleeping states to /sys/power/state. I will NAK any attempt to do
> so. Please find more suitable interface.

You are right.  The power/state files for devices are for suspend
states as well.  I'll find a different interface for operating states and
leave suspend states in /sys/power/state.

David
>
>                                                         Pavel
> --
> Thanks for all the (sleeping) penguins.
>
