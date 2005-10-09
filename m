From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC 3/3] Runtime PM support for named power states
Date: Sun, 9 Oct 2005 11:08:47 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0510091044060.27612-100000@netrider.rowland.org>
References: <20051008170017.GC10865@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============25150573489451999=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20051008170017.GC10865@openzaurus.ucw.cz>
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
Cc: David Brownell <david-b@pacbell.net>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============25150573489451999==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Sat, 8 Oct 2005, Pavel Machek wrote:

> > People have already pretty much agreed that ->resume needs to take a 
> > pm_message_t argument, and that will mean changing a lot of drivers.  We 
> > ought to settle on a decision about the rest of this too, so we won't have 
> > to go through and change them all yet again.
> 
> I think they need to go in one-after-one, anyway... Adding parameter
> to resume() should definitely be separate patch, because it needs to
> change all drivers *at once*.  Removing power_state usage can be
> done incrementally...

I suppose it could be done like that.  It would mean keeping the
power_state member in the structure until all the drivers are updated,
even though the core wouldn't use it any more.

There's a few other things I wanted to ask.  What do you think of the way
my patch used the new suspend_name member?  The idea was to allow users to
simply write a generic

	echo "suspend" >/sys/device/.../power/state

and have the driver do the appropriate thing, no matter what the actual
power states were.  A driver could even change the value of suspend_name
dynamically.  For instance, a PCI driver could initially make "suspend" an
alias for "D1", but when the device was put in D1 it could make "suspend"
an alias for "D2", and so on.  That's one way to implement multiple levels
of power saving.

Another question: Initially most drivers won't set up an array of named
states.  We could have the core treat such devices as though they were
using a generic two-entry array: "on" and "suspend".  That would provide
by default essentially the same functionality we have now, and it would
allow many drivers to use the new runtime PM scheme with (almost) no
changes.  Do you see anything wrong with that?

Third question: Is there a usable PCI core routine for choosing power
states?  If not, should a PCI ->suspend method usually use the
lowest-power available state?  I have a feeling this should involve ACPI,
but it looks like the code hasn't been written yet.

Alan Stern


--===============25150573489451999==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============25150573489451999==--
