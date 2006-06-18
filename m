From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Sun, 18 Jun 2006 10:09:04 -0700
Message-ID: <200606181009.05203.david-b@pacbell.net>
References: <20060614103404.GC28536@elf.ucw.cz>
	<Pine.LNX.4.64.0606161114110.5498@g5.osdl.org>
	<20060616212811.GA2213@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060616212811.GA2213@elf.ucw.cz>
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
Cc: Linus Torvalds <torvalds@osdl.org>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Friday 16 June 2006 2:28 pm, Pavel Machek wrote:
> =

> > > It's not so different from what Linus has been sketching, except
> > > for the actual turn-off-DMA step.  (Needed because you want to get
> > > an atomic snapshot.)  In terms of $SUBJECT the gain is that you
> > > actually get a debuggable suspend sequence.
> > =

> > Actually, if the _only_ thing STD wants to do, why not just have a
> > =

> > 	->freeze(dev)
> > 	->unfreeze(dev)
> > =

> > call-in?
> =

> Unfortunately, it is not the _only_ thing STD needs to do. unfreeze()
> must be able to reinitialize/resume the device during resume.

Not really ... because resuming drivers get resume() calls, and
were first told to suspend().

Another difference between just quiescing a driver and suspending
it is that when you suspend, the device will potentially need to be
enabled as a wakeup event source ... which is never true with just
quiescing the device.  Of course, this is again a difference that
most drivers will ignore.  ("Wakeup event?  What's that?")

- Dave
