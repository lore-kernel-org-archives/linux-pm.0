From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 22 Jun 2006 22:41:01 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0606222235210.18690-100000@netrider.rowland.org>
References: <200606221648.10799.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200606221648.10799.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Thu, 22 Jun 2006, David Brownell wrote:

> > > Fixing that involves updating pm core locking, ISTR.  I've thought th=
at
> > > the root cause of the issue is that the list of devices to be suspend=
ed
> > > is created at the wrong time ... very early and globally scoped, not
> > > on-demand and privately scoped.
> > =

> > I believe this has been fixed for quite a while. =

> =

> That's been said, but nonetheless the last few times I've tried to do
> things like handling disconnect processing anything other than very
> late (after khubd got woken up again), it was still deadlocksville.
> Yes, this is _after_ folk have said "this has been fixed...".

I haven't looked at it recently.  It shouldn't be too hard to prevent
khubd from being frozen and then provoke a disconnect during system
resume...  I'll let you know what happens.

> That applies only during system sleep state transitions.

Well yes, of course.  We were talking about system sleep, not runtime PM.

>  If you
> try to invoke selective suspend (only part of the driver model tree
> rather than the whole thing), all such ordering is ignored.  And
> for USB, selective suspend is a fundamental mechanism for reducing
> systems' runtime power usage.

Ben never suggested device creation or removal should be prevented during =

selective suspend, and you never mentioned encountering any deadlocks =

because of it.  So why do you bring it up?

Alan Stern
