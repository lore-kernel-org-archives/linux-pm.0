From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Sat, 24 Jun 2006 22:20:14 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0606242217470.1024-100000@netrider.rowland.org>
References: <200606232039.16262.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200606232039.16262.david-b@pacbell.net>
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

On Fri, 23 Jun 2006, David Brownell wrote:

> > > That's been said, but nonetheless the last few times I've tried to do
> > > things like handling disconnect processing anything other than very
> > > late (after khubd got woken up again), it was still deadlocksville.
> > > Yes, this is _after_ folk have said "this has been fixed...".
> > =

> > Okay, I have tried it.
> =

> Hmm, when I tried that, I did it on suspend() paths not resume, and
> the deadlocks were in PM core code.  I didn't see that SCSI bug.
> Maybe it really is fixed now.

Unregistering child devices during suspend() also works okay.  No =

deadlock.

Mind you, trying to unregister a device from within its _own_ suspend =

method is guaranteed to deadlock.  But that should already be obvious.

Alan Stern
