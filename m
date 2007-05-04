From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re:
	suspend2 merge (was: Re: CFS and suspend2: hang in atomic copy))
Date: Fri, 4 May 2007 23:53:51 +0200
Message-ID: <200705042353.52409.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0705041020530.3417-100000@iolanthe.rowland.org>
	<1178312930.7408.38.camel@johannes.berg>
	<20070504211519.GA24246@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070504211519.GA24246@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Pekka Enberg <penberg@cs.helsinki.fi>, Johannes Berg <johannes@sipsolutions.net>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday, 4 May 2007 23:15, Pavel Machek wrote:
> Hi!
> 
> > > ACPI BIOS communicates with hw, too. Suppose it generates random
> > > number, stores it in memory and tells it to the keyboard conroller
> > > during bootup (more specifically during ACPI enable phase).
> > > 
> > > Now, it periodically checks if number in memory is same as the number
> > > known by keyboard controller.
> > > 
> > > If you suspend/resume without telling acpi, it will find out, because
> > > numbers will not match.
> > > 
> > > (And now, ACPI is probably not crazy enough to store random numbers --
> > > but it could -- but for example "I had AC power, now I do not, and I
> > > did not see a interrupt telling me it went away" can be counted as
> > > confusing for ACPI).
> > 
> > I don't follow.
> > 
> >  * you have AC power.
> >  * you save system state and shut down (S5)
> >  * you boot up again on battery power
> >  * you restore system state
> >  * ...
> > 
> > vs.
> > 
> >  * you have AC power
> >  * you shut down
> >  * you boot up again on battery power
> >  * ...
> > 
> > where's the difference to the ACPI bios? Oh, I see, it stores it
> > somewhere in the memory that you've stored/restored? Well, that's your
> > bug then, don't touch it.
> 
> Not sure... yes, it stores parts somewhere in memory.

These are reserved regions.  On the majority of systems we handle them
correctly.

> Plus, it may have some parts related to the communications with operating
> system (*)... I guess we need to save those, and parts related to hw
> state... where your suggestion makes sense.

If they are accessible to us, then we can, but what if they aren't (eg. the
state information is stored in the embedded controller, can only be read with
the help of some AML invocations and cannot be changed from the OS level)?

> (*) and yes, there probably are such parts. If we set backlight to
> 20%, we'll be confused if it is 100% after resume... we probably could
> handle those one-by-one...

*If* we reinitialize devices *and* ACPI from scratch after restoring the image,
we'll discard the old value (20%) and read the new value (100%) from the BIOS.
The problems occur, IMO, because we try to be smart and use the BIOS
after the resume as though we'd resumed from a real suspend (eg. s2ram).

Which is natural, if we use the same set of .resume() callbacks for both cases.

Greetings,
Rafael
