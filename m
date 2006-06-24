From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Fri, 23 Jun 2006 20:39:15 -0700
Message-ID: <200606232039.16262.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0606231425440.6478-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0606231425440.6478-100000@iolanthe.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Friday 23 June 2006 11:32 am, Alan Stern wrote:
> On Thu, 22 Jun 2006, David Brownell wrote:
> =

> > On Thursday 22 June 2006 1:31 pm, Alan Stern wrote:

> > > I believe this has been fixed for quite a while. =

> > =

> > That's been said, but nonetheless the last few times I've tried to do
> > things like handling disconnect processing anything other than very
> > late (after khubd got woken up again), it was still deadlocksville.
> > Yes, this is _after_ folk have said "this has been fixed...".
> =

> Okay, I have tried it.

Hmm, when I tried that, I did it on suspend() paths not resume, and
the deadlocks were in PM core code.  I didn't see that SCSI bug.
Maybe it really is fixed now.


> ...  =

> The devices actually get removed twice: once during the "resume so we can
> write out the memory image" phase and then once again during the actual =

> final resume.

... albeit still strange.

- Dave
