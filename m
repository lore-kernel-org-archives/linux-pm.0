From: Nigel Cunningham <ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>
Subject: Re: CPU local things [was Re: Nested suspends; messages
	vs. states]
Date: Fri, 25 Mar 2005 07:59:29 +1100
Message-ID: <1111697969.3430.26.camel@desktop.cunningham.myip.net.au>
References: <1111548664.16201.63.camel@gaston>
	<Pine.LNX.4.50.0503231008340.17099-100000@monsoon.he.net>
	<20050323210204.GE30704@elf.ucw.cz>
	<1111613750.14853.117.camel@desktop.cunningham.myip.net.au>
	<20050323215416.GK30704@elf.ucw.cz>
	<Pine.LNX.4.50.0503231838570.15119-100000@monsoon.he.net>
	<1111634182.3430.1.camel@desktop.cunningham.myip.net.au>
	<Pine.LNX.4.50.0503240017460.15119-100000@monsoon.he.net>
	<20050324100153.GE1354@elf.ucw.cz>
	<Pine.LNX.4.50.0503240749030.24692-100000@monsoon.he.net>
	<20050324171406.GE16469@otto>
Reply-To: ncunningham-3EexvZdKGZRWk0Htik3J/w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============35413094114661448=="
In-Reply-To: <20050324171406.GE16469@otto>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Nathan Lynch <ntl-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Cc: Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============35413094114661448==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Nathan.

On Fri, 2005-03-25 at 04:14, Nathan Lynch wrote:
> > > > Become more componentized. We need a better way to represent optional
> > > > features of any device, but in particular CPUs. We should never be calling
> > > > it directly; we should be looping over the feature drivers bound to a 'CPU
> > > > Driver' and suspending them.
> > >
> > > Actually, no.
> > >
> > > mtrr's are cpu local. That means they need to be handled by CPU
> > > hotplug framework. I guess we should just drop them from "normal"
> > > device trees, and create something per-CPU.
> > 
> > Sorry, it was late and that explanation sucked.
> > 
> > - Every CPU has a set of optional features that it supports.
> > 
> > - MTRRs are an optional feature that a CPU may support.
> > 
> > - When the MTRR driver is loaded, a data structure should be allocated for
> >   each CPU and added to a list.
> > 
> > - The list that the per-CPU MTRR data structure is added to could be part
> >   of a 'CPU driver'.
> > 
> > - We should be looping over the set of optional features that a CPU
> >   supports to suspend/resume them, rather than calling them directly.
> 
> Don't sysdev_suspend and sysdev_resume do this already?

I guess you missed part of the context of this discussion. MTRR sysdev
suspend and resume work fine for one CPU, but there's a potential SMP
deadlock. For Suspend2, MTRR sysdev support was removed a number of
months ago, and tied in to CPU state saving and restoring. This
addressed the deadlock, correctly, I believe.

Hope this helps.

Nigel

> > > Perhaps plain old notification list is enough for this one.
> > 
> > It's possible, but notification lists present some problems. Like the fact
> > they use a hard-coded set of events in a global header file. They are good
> > only for a certain set of events.
> > 
> > It's damn simple to create a struct type for CPU features and a method
> > contained in each one for cpu offline/online. I would suggest adding a
> > list_head to struct cpu (include/linux/cpu.h) called 'features', then
> > having things like MTRR add themselves to that list.
> 
> Why is the existing sysdev auxiliary driver support not sufficient?
> Last time I checked, cpufreq uses it for this kind of purpose.
> 
> 
> Nathan
> 
> ______________________________________________________________________
> _______________________________________________
> linux-pm mailing list
> linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
> http://lists.osdl.org/mailman/listinfo/linux-pm
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://suspend2.net


--===============35413094114661448==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============35413094114661448==--
