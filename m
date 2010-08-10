From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Attempted summary of suspend-blockers LKML thread,
	take three
Date: Tue, 10 Aug 2010 15:40:26 +0100
Message-ID: <20100810154026.75efa370@lxorguk.ukuu.org.uk>
References: <20100807061558.GA28087@thunk.org>
	<AANLkTi=sMVjya9CH6UoZwJCXJTDRgBhnPXmApU_RHVTi@mail.gmail.com>
	<20100808155719.GB3635@thunk.org>
	<AANLkTinM5e2HGOFavODPZNzZx4KshDSjsvKN4pLpGGgr@mail.gmail.com>
	<20100808213821.GD3635@thunk.org>
	<20100809112453.77210acc@lxorguk.ukuu.org.uk>
	<20100809181638.GI3026@linux.vnet.ibm.com>
	<20100809201822.441905f7@lxorguk.ukuu.org.uk>
	<20100810044541.GA2817@linux.vnet.ibm.com>
	<20100810093849.138e2318@lxorguk.ukuu.org.uk>
	<20100810141107.GA12873@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100810141107.GA12873@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: david@lang.hm, menage@google.com, Ted Ts'o <tytso@mit.edu>, peterz@infradead.org, Brian Swetland <swetland@google.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-kernel@vger.kernel.org, James.Bottomley@suse.de, galibert@pobox.com, florian@mickler.org, swmike@swm.pp.se, linux-pm@lists.linux-foundation.org, paulmck@linux.vnet.ibm.com, tglx@linutronix.de, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

> > Losing data is a design choice ? The application set a timer, the OS
> > shouldn't be ignoring it in that situation. It might want to delay it, it
> > might want to warn the user its hogging things it shouldnt (powertop,
> > battery usage monitors in Android etc)
> 
> So we should remove explicit system suspend from the kernel?

Explicit suspend is user triggered - in the laptop case its a bit
different. I don't btw like the fact that a laptop explicit suspend
doesn't end up as a dbus "save data" and openoffice save (or it didn't
last time I looked which is a while ago).

> There's a clear and absolute difference between system suspend and 
> entering the same hardware state from the idle loop. That difference is 
> that processes aren't scheduled until an explicit wakeup event occurs. 
> Android is entirely capable of entering the same low power state at idle 
> (it's done with a hardcoded idle loop on Qualcomm, cpuidle on omap), but 
> if you have more than 0 scheduling wakeups a second then your power draw 
> is going to be greater. 

And nothing stops you also implementing a 'forced' suspend, although you
can do that nicely by simply stopping the process group that contains the
stuff you don't want to stop suspend and dropping into suspend when you
idle.

> I agree that we should be targetting 0 wakeups per second. I don't agree 
> that it's realistic to insist that a use model that assumes imperfect 
> software is an invalid use model.

No argument.

The question is what applications should be expressing to the kernel
which is not tied to assumptions like 'suspend mode' and which is generic.

We don't have xfs stuff for example splattered all over userspace and in
lots of drivers - we have generic interfaces. That way user community A
doesn't have to care about user community B's choices, and JFFS flash fs
people don't offend big data centre people and vice versa.


Alan
