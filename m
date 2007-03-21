From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.21-rc4-mm1: freezing of processes broken
Date: Wed, 21 Mar 2007 13:08:32 +0100
Message-ID: <200703211308.33295.rjw@sisk.pl>
References: <20070319205623.299d0378.akpm@linux-foundation.org>
	<200703210149.33240.rjw@sisk.pl>
	<m1lkhre6f5.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <m1lkhre6f5.fsf@ebiederm.dsl.xmission.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Sukadev Bhattiprolu <sukadev@us.ibm.com>, Jiri Slaby <jirislaby@gmail.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, Nigel Cunningham <ncunningham@linuxmail.org>, Oleg Nesterov <oleg@tv-sign.ru>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 21 March 2007 02:23, Eric W. Biederman wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> =

> > On Tuesday, 20 March 2007 22:06, Rafael J. Wysocki wrote:
> >> On Tuesday, 20 March 2007 21:58, Jiri Slaby wrote:
> >> > Rafael J. Wysocki napsal(a):
> >> > > Actually, the problem is 100% reproducible on my system too and I =
doubt
> > it's
> >> > > caused by the recent freezer patches.
> >> > =

> >> > I don't know what exactly do you mean by recent, but 2.6.21-rc3-mm2 =
works
> >> > for me.
> >> =

> >> Thanks for the confirmation.
> >> =

> >> The patches I was talking about had already been in 2.6.21-rc3-mm2, so=
 the
> >> reason of this failure must be different.
> >
> > Bisection shows that the freezing of processes has been broken by one o=
f the
> > patches:
> >
> > remove-the-likelypid-check-in-copy_process.patch
> =

> Grr.  Oleg's review of remove-the-likelypid-check-in-copy-process
> showed it to be questionable (and it was just an optimization)
> so we can get rid of that one easily. =

> =

> Although all it did that was really questionable was add
> the idle process to the global process list and bump a process
> count when we forked the idle process.  Not dramatically dangerous
> things.

I think this patch is the culprit, though, as it seems that the freezer tri=
es
to freeze the idle process and fails.  Yesterday I didn't have the time to
figure out the exact reason, I'll try to look at it later today.

> > use-task_pgrp-task_session-in-copy_process.patch
> =

> As I recall that patch was pretty trivial, and shouldn't have
> anything to do with the freezer.   The process freezer doesn't care
> about pids does it?

No, it doesn't, at least not directly.  I'll try to run the kernel with this
change and without remove-the-likelypid-check-in-copy_process.patch .

Greetings,
Rafael
