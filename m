From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: Runtime PM and device locking
Date: Thu, 11 Aug 2005 10:52:34 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0508111044060.5854-100000@iolanthe.rowland.org>
References: <20050811143233.GC2691@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============21046562742893382=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050811143233.GC2691@elf.ucw.cz>
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
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Preece Scott-PREECE <scott.preece@motorola.com>
List-Id: linux-pm@vger.kernel.org

--===============21046562742893382==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Thu, 11 Aug 2005, Pavel Machek wrote:

> Hi!
> 
> > As I understood it, the "parents" are simply things the device has
> > dependencies on. Since the dependencies are different, there is at least
> > potentially a benefit in being able to dismiss those dependencies
> 
> Power-consumption benefit?

Programming simplicity benefit.

> > serially (that is, as the dependency on each device goes away, tell that
> > parental device that its parental role has been satisfied and that the
> > child is no longer depending on it as a parent).
> 
> This would lead to something pretty complex. Anyway, you can have
> that, just introduce multiple states to the device. "Mouse is
> idle". "Mouse is idle and no longer need clock". "Mouse is really idle
> and no longer needs anything".
> 
> But I believe thats way too complex for most devices.

Exactly.  Straight-line code is much simpler than multiple intermediate 
states.


> > > Consider a device that has many power parents (P1 - Pn).  A typical 
> > > power-state change for this device might have to go like this:
> > > 
> > > 	Do something to the device.
> > > 
> > > 	Notify P1.
> > > 
> > > 	Do some more to the device.
> > > 
> > > 	Notify P2.
> > > 
> > > 	Do some more to the device.
> > > 
> > > 	...
> > > 
> > > 	Notify Pn.
> > > 
> > > 	Do the last thing to the device.
> > 
> > Ouch, thats really ugly. Is it really neccessary to do something to the
> > device just after notifying parent?

Sometimes it is.  For a resume transition, you need to tell the device
itself to wake up _after_ telling all the parents to resupply the
necessary power resources.

> > I thought it would be more like
> > 
> > mouse
> > 	"oh, I'm idle".
> > 	power myself down. 
> > 	tell all my parents that they can power down my cord.

For a mouse, this is indeed how a suspend would work.  My example above
was for a much more complex device; a mouse is a degenerate case where n
= 1 and the last step isn't needed for suspend (and the first step isn't
needed for resume).

> > If something is neccessary to be done after changing parent state, I'd
> > do it during call from parent.

But that call is to the parent's driver.  It can't be expected to modify 
settings on the child device.  To finish the mouse example, the resume 
code would look like this:

mouse
	"oh, something has happened".
	tell all my parents that they must power up my card.
	power myself up.

Hopefully this is all clear now.

Alan Stern


--===============21046562742893382==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============21046562742893382==--
