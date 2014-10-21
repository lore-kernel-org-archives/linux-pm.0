From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 01/47] kernel: Add support for poweroff handler call
 chain
Date: Tue, 21 Oct 2014 09:11:04 -0700
Message-ID: <20141021161104.GB3453@roeck-us.net>
References: <1413864783-3271-1-git-send-email-linux@roeck-us.net>
 <41603148.RJg26vx0Wv@vostro.rjw.lan>
 <54465CD5.5070002@roeck-us.net>
 <2369971.tIcht5GPeB@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2369971.tIcht5GPeB@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Alexander Graf <agraf@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Heiko Stuebner <heiko@sntech.de>, Lee Jones <lee.jones@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Philippe =?iso-8859-1?Q?R=E9tornaz?= <philippe.retornaz@gmail.com>, Romain Perier <romain.perier@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Oct 21, 2014 at 04:15:11PM +0200, Rafael J. Wysocki wrote:
> On Tuesday, October 21, 2014 06:17:09 AM Guenter Roeck wrote:
> > On 10/21/2014 05:26 AM, Rafael J. Wysocki wrote:
> > > On Monday, October 20, 2014 09:12:17 PM Guenter Roeck wrote:
> > >> Various drivers implement architecture and/or device specific means to
> > >> remove power from the system.  For the most part, those drivers set the
> > >> global variable pm_power_off to point to a function within the driver.
> > >>
> > >> This mechanism has a number of drawbacks.  Typically only one scheme
> > >> to remove power is supported (at least if pm_power_off is used).
> > >> At least in theory there can be multiple means remove power, some of
> > >> which may be less desirable. For example, some mechanisms may only
> > >> power off the CPU or the CPU card, while another may power off the
> > >> entire system.  Others may really just execute a restart sequence
> > >> or drop into the ROM monitor. Using pm_power_off can also be racy
> > >> if the function pointer is set from a driver built as module, as the
> > >> driver may be in the process of being unloaded when pm_power_off is
> > >> called. If there are multiple poweroff handlers in the system, removing
> > >> a module with such a handler may inadvertently reset the pointer to
> > >> pm_power_off to NULL, leaving the system with no means to remove power.
> > >>
> > >> Introduce a system poweroff handler call chain to solve the described
> > >> problems.  This call chain is expected to be executed from the
> > >> architecture specific machine_power_off() function.  Drivers providing
> > >> system poweroff functionality are expected to register with this call chain.
> > >> By using the priority field in the notifier block, callers can control
> > >> poweroff handler execution sequence and thus ensure that the poweroff
> > >> handler with the optimal capabilities to remove power for a given system
> > >> is called first.
> > >
> > > Well, I must admit to having second thoughts regarding this particular
> > > mechanism.  Namely, notifiers don't seem to be the best way of expressing
> > > what's needed from the design standpoint.
> > >
> > > It looks like we need a list of power off methods and a way to select one
> > > of them, so it seems that using a plist would be a natural choice here?
> > >
> > Isn't a notifier call chain nothing but a list of methods, with its priority
> > the means to select which one to use (first) ?
> 
> Traditionally, the idea behind notifier call chains has been to call all of the
> supplied methods (meaning whoever supplied them wants to be notified of events)
> where the higher-priority ones are called first.
> 
> In this particular case, though, we call them until one succeeds to power
> off the system it seems.
> 
> > The only difference I can see is that you would only select one of them,
> > meaning the one with the highest priority, and not try the others.
> 
> Yes, this was my thought.
> 
> But if you want a fallback mechanism, then I agree that using notifiers makes
> sense, although it is not exactly about notifications this time.
> 
It is the same machanism we are using for the newly introduced restart handler,
with the same logic. Notifiers come handy, because the infrastructure is already
there, but I consider that to be more of an implementation detail. It is useful
in many cases, though, since the notifier_block can be part of a local data
structure which can be referenced from the callback using container_of.

If I don't use notifiers, and the callback function doesn't get a reference to
its control block, I don't get that reference, and another means to pass context
data into the notifier function would be necessary - either a static variable,
as widely used so far, or another parameter. While the current code of course
permits the use of a static variable, I very much like that it is possible to
avoid that by using notifiers.

> I would probably use something along the lines of syscore_ops, but with added
> execution priority.

But wouldn't that mean to, for all practical purposes, re-implement a notifier
call chain in syscore just for the purpose of naming it differently ?

>From a practical side, it would also be a bit awkward since syscore_ops are
typically not installed from the same file as the poweroff handler. So I would
either have to rearrange code significantly, or install two sysore_ops handlers
for the same architecture / platform. Hope it would be ok to do the latter; if
the first approach is asked for, I'd rather only implement the core code and not
do the full conversion, as it would add more risk than I think it adds value.

Guenter
