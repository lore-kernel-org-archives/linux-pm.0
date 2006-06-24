From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Sat, 24 Jun 2006 12:19:52 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0606241214390.19990-100000@netrider.rowland.org>
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

> > > > I believe this has been fixed for quite a while. =

> > > =

> > > That's been said, but nonetheless the last few times I've tried to do
> > > things like handling disconnect processing anything other than very
> > > late (after khubd got woken up again), it was still deadlocksville.
> > > Yes, this is _after_ folk have said "this has been fixed...".
> > =

> > Okay, I have tried it.
> =

> Hmm, when I tried that, I did it on suspend() paths not resume, and
> the deadlocks were in PM core code.  I didn't see that SCSI bug.

The SCSI bug is new, probably introduced while adding support for SCSI =

suspend.  The state model didn't allow for a transition from suspended to =

disconnecting.

> Maybe it really is fixed now.

I'll have to try calling usb_disconnect during suspend, to make sure that =

works as well...


> > The devices actually get removed twice: once during the "resume so we c=
an
> > write out the memory image" phase and then once again during the actual =

> > final resume.
> =

> ... albeit still strange.

Not so strange, since the system's state has been cloned -- complete with =

the "device should be removed for testing during the upcoming resume" =

stuff.

Alan Stern
