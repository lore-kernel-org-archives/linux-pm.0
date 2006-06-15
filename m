From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 15 Jun 2006 23:27:24 +0200
Message-ID: <20060615212724.GB2255@elf.ucw.cz>
References: <20060615083921.GB9423@elf.ucw.cz>
	<Pine.LNX.4.44L0.0606151047410.6879-100000@iolanthe.rowland.org>
	<20060615161446.GA23859@elf.ucw.cz>
	<Pine.LNX.4.64.0606150922200.5498@g5.osdl.org>
	<20060615182419.GA1711@elf.ucw.cz>
	<Pine.LNX.4.64.0606151219540.5498@g5.osdl.org>
	<20060615200333.GB1849@elf.ucw.cz>
	<Pine.LNX.4.64.0606151325520.5498@g5.osdl.org>
	<20060615204317.GC1849@elf.ucw.cz>
	<Pine.LNX.4.64.0606151356480.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606151356480.5498@g5.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, Nigel Cunningham <ncunningham@linuxmail.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > > > Why? We are saving state to memory, we should not need any other
> > > > devices to do that.
> > > =

> > > Hell no, we're not.
> > =

> > ?
> =

> We're clearly saving state to _user_ space etc in some cases. That's not =

> "memory", that is "pageable data and processes that can - and do - depend =

> on other devices in ways that the kernel is not necessarily even aware =

> of".
> =

> Just as the most obvious example, it's entirely possible that when you as=
k =

> the graphics system to save its state, it might actually tell clients =

> across a network that their window got occluded or something.

That's okay, kernel tells X to switch consoles. When X gives console
control back to kernel, kernel owns the graphics hardware, and we are
okay.

> The same is true of various virtual devices that the kernel may not even =

> know about. Network devices done as tunnels in user space etc. They may =

> _look_ like system devices at the root of the device tree to the kernel, =

> but that's just because the kernel has not a f*cking clue about what they =

> are actually connected to.

I admit we have problems with various virtual devices...

> So we're _not_ just saving data to memory. We're allocating memory (which =

> means that we want to access every single device that may do write-back), =

> and we're calling out to user space (which means that we _really_ don't =

> know what a device may need).

That memory should be either allocated statically, or allocated during
boot up or something. Usually, device just adds few bytes to
per-device structures.. this problem is real but not too bad.

> > For fbcon, etc, no, we do not any other devices, so it actually works
> > okay.
> =

> Yeah, Linux suspend is generally felt to "work ok".
> =

> Not.

Yeah, we have few drivers to fix :-). Yes, we could add one more pass
before freezing (in s2disk) and before suspending (s2ram). Would it
magically solve all the suspend problems? No I don't think so.

[Your separate pass may save some memory at runtime, you are right,
but it will not fix the buggy drivers.]

> > > In fact, done right, if you know the machine powers off, the final su=
spend =

> > > should literally not be needed. "Remove power globally" is actually a=
 very =

> > > good suspend/shutdown mechanism that doesn't even need any driver sup=
port ;)
> > =

> > Actually, that's bad idea; some machines are unable to power down with
> > devices still running.
> =

> Can you read my sentence again? "If you know the machine powers off"?
> =

> Trust me, if you remove power from the devices, that machine _will_ power =

> down. It's that simple. It's not "maybe", or "if" or "unable to". It's =

> basic physics.

Except that powerdown is done with ACPI, and that means ... guess
what... BIOS call. And that BIOS fails if you leave APIC enabled, or
something like that. So yes, if you could cut off power with devices
enabled, it is okay to do that. But you can't, because BIOSen are
broken.

									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
