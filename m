From: Patrick Mochel <mochel-og82NyAXoxR0I81aPRRTmR2eb7JE58TQ@public.gmane.org>
Subject: Re: CPU local things [was Re: Nested suspends; messages
	vs. states]
Date: Thu, 24 Mar 2005 07:59:21 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0503240749030.24692-100000@monsoon.he.net>
References: <1111540913.16224.43.camel@gaston>
	<Pine.LNX.4.50.0503221724550.16154-100000@monsoon.he.net>
	<1111548664.16201.63.camel@gaston>
	<Pine.LNX.4.50.0503231008340.17099-100000@monsoon.he.net>
	<20050323210204.GE30704@elf.ucw.cz>
	<1111613750.14853.117.camel@desktop.cunningham.myip.net.au>
	<20050323215416.GK30704@elf.ucw.cz>
	<Pine.LNX.4.50.0503231838570.15119-100000@monsoon.he.net>
	<1111634182.3430.1.camel@desktop.cunningham.myip.net.au>
	<Pine.LNX.4.50.0503240017460.15119-100000@monsoon.he.net>
	<20050324100153.GE1354@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============70270712172754957=="
In-Reply-To: <20050324100153.GE1354-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Nigel Cunningham <ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>, Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============70270712172754957==
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Thu, 24 Mar 2005, Pavel Machek wrote:

> Hi!
>
> > > Just for clarity's sake, what are you thinking should happen to MTRR
> > > support?
> >
> > Become more componentized. We need a better way to represent optional
> > features of any device, but in particular CPUs. We should never be calling
> > it directly; we should be looping over the feature drivers bound to a 'CPU
> > Driver' and suspending them.
>
> Actually, no.
>
> mtrr's are cpu local. That means they need to be handled by CPU
> hotplug framework. I guess we should just drop them from "normal"
> device trees, and create something per-CPU.

Sorry, it was late and that explanation sucked.

- Every CPU has a set of optional features that it supports.

- MTRRs are an optional feature that a CPU may support.

- When the MTRR driver is loaded, a data structure should be allocated for
  each CPU and added to a list.

- The list that the per-CPU MTRR data structure is added to could be part
  of a 'CPU driver'.

- We should be looping over the set of optional features that a CPU
  supports to suspend/resume them, rather than calling them directly.

Agree?

I agree that the CPU hotplug framework should help, since the save/restore
of MTRRs is needed for that feature as well.

I don't think they could/should go into normal device tree. They are part
of the special class of 'system' devices that don't support the notion of
a traditional driver and have to be handled at special times (when
interrupts are disabled) during the suspend/resume process.

I do think that the current model of system + platform devices kinda
stinks, but I do not think that merging them into the normal device tree
is the right solution.

> Perhaps plain old notification list is enough for this one.

It's possible, but notification lists present some problems. Like the fact
they use a hard-coded set of events in a global header file. They are good
only for a certain set of events.

It's damn simple to create a struct type for CPU features and a method
contained in each one for cpu offline/online. I would suggest adding a
list_head to struct cpu (include/linux/cpu.h) called 'features', then
having things like MTRR add themselves to that list.

But, that's just my $0.02 (which is greatly devalued these days :)


	Pat

--===============70270712172754957==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============70270712172754957==--
