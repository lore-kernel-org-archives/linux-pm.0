From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 9/10] sh: Use struct syscore_ops instead of
	sysdev class and sysdev
Date: Wed, 23 Mar 2011 06:49:23 +0900
Message-ID: <20110322214922.GA7503__41668.1247683757$1300830731$gmane$org@linux-sh.org>
References: <201103100131.58206.rjw@sisk.pl> <201103222130.46603.rjw@sisk.pl>
	<1300826390.1815.5.camel@zag> <201103222200.52131.rjw@sisk.pl>
	<1300828356.1815.15.camel@zag>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1300828356.1815.15.camel@zag>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kay Sievers <kay.sievers@suse.de>
Cc: Russell King <linux@arm.linux.org.uk>, linux-sh@vger.kernel.org, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 22, 2011 at 10:12:36PM +0100, Kay Sievers wrote:
> On Tue, 2011-03-22 at 22:00 +0100, Rafael J. Wysocki wrote:
> > On Tuesday, March 22, 2011, Kay Sievers wrote:
> > > On Tue, 2011-03-22 at 21:30 +0100, Rafael J. Wysocki wrote:
> > > > 
> > > > Perhaps there's a more straightforward way to make some files show up in
> > > > sysfs on a specific path than defininig an otherwise useless bus type and
> > > > device object?
> > > 
> > > That's absolutely not the point. Please don't get yourself into that
> > > thinking. If people want to "export stuff to userspace", they must not
> > > invent new things. We need to get rid of the silly special cases.
> > 
> > Why exactly?  Do they actually hurt anyone and if so then how?
> 
> Sure, "devices" are devices, and devices have well-defines set of
> properties, not some magic directory, people can mess around with the
> way they like.
> 
This is starting to get silly. In the case of interrupt controllers as
with clocksources the bus abstraction is completely meaningless. I could
register a type of "system" bus, but how would that be any different from
what we have from sysdevs already today? All it does is force people to
duplicate crap all over the place instead and pretend like extra busses
exist in order to fit some arbitrary definition of how the driver model
should work.

You talk about inventing special interfaces to bypass the device model,
but that's not the case here. Rolling my own interface with kobjects and
attribute groups as with /sys/power or making an arbitrary bus type for a
single class of system devices seems infinitely more hackish than the
current sysdev model.

The comment at the top of sys.c says:

 * sys.c - pseudo-bus for system 'devices' (cpus, PICs, timers, etc)

Which is precisely where I would expect interrupt controllers and timers
and CPUs to go. I'm not going to make an IRQ bus or a timer bus and
arbitrarily map some things there and some things somewhere else in the
name of some abstraction insanity. These interrupt controllers all have
consistent attributes that make the sysdev class model work well, but
there are also many other types of interrupt controllers on the same CPUs
that use a different abstraction.

Beyond that, we also have sysdev class utilization for DMA controllers,
per-CPU store queues, etc, etc. all of which would need to be converted
to something else (see for example arch/sh/kernel/cpu/sh4/sq.c -- which
in turn was modelled after the cpufreq code, which also would need to
change to something else). It's not entirely obvious how to convert these
things, or why one should even bother. I can live with the struct device
overhead even if I find it to be a meaningless abstraction in this case,
but what sort of bus/class model to shoe horn these things in to is
rather beyond me.

Indeed it seems to me that these are precisely the sorts of things that
sysdevs are intended for, which is why I elected to use them from the
onset. Simply saying "don't use sysdevs" and "pretend like you have some
sort of a magical pseudo-bus that's not a system bus" doesn't quite do it
for me.
