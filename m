From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 9/10] sh: Use struct syscore_ops instead of
	sysdev class and sysdev
Date: Tue, 22 Mar 2011 23:23:42 +0100
Message-ID: <201103222323.42627.rjw__33575.8186447949$1300832752$gmane$org@sisk.pl>
References: <201103100131.58206.rjw@sisk.pl>
	<20110322214922.GA7503@linux-sh.org> <1300831256.1815.22.camel@zag>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1300831256.1815.22.camel@zag>
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

On Tuesday, March 22, 2011, Kay Sievers wrote:
> On Wed, 2011-03-23 at 06:49 +0900, Paul Mundt wrote:
...
> > You talk about inventing special interfaces to bypass the device model,
> > but that's not the case here. Rolling my own interface with kobjects and
> > attribute groups as with /sys/power or making an arbitrary bus type for a
> > single class of system devices seems infinitely more hackish than the
> > current sysdev model.
> > 
> > The comment at the top of sys.c says:
> > 
> >  * sys.c - pseudo-bus for system 'devices' (cpus, PICs, timers, etc)
> > 
> > Which is precisely where I would expect interrupt controllers and timers
> > and CPUs to go. I'm not going to make an IRQ bus or a timer bus and
> > arbitrarily map some things there and some things somewhere else in the
> > name of some abstraction insanity. These interrupt controllers all have
> > consistent attributes that make the sysdev class model work well, but
> > there are also many other types of interrupt controllers on the same CPUs
> > that use a different abstraction.
> > 
> > Beyond that, we also have sysdev class utilization for DMA controllers,
> > per-CPU store queues, etc, etc. all of which would need to be converted
> > to something else (see for example arch/sh/kernel/cpu/sh4/sq.c -- which
> > in turn was modelled after the cpufreq code, which also would need to
> > change to something else). It's not entirely obvious how to convert these
> > things, or why one should even bother.

The reason why is, if I understand it correctly, because user space tools
generally expect /sys/devices/ to be consistent in terms of the representation
of things and /sys/devices/system/ currently violates that expectation which
leads to all sorts of problems with device discovery, hotplug etc.

Now, whether or not to convert all the things currently exported through
sysdevs to struct device objects is not too obvious to me.  I think it simply
may be better to move them into a different direcory in sysfs (presumably
creating one for this purpose).

> > I can live with the struct device overhead even if I find it to be a
> > meaningless abstraction in this case, but what sort of bus/class model to
> > shoe horn these things in to is rather beyond me.
> > 
> > Indeed it seems to me that these are precisely the sorts of things that
> > sysdevs are intended for, which is why I elected to use them from the
> > onset. Simply saying "don't use sysdevs" and "pretend like you have some
> > sort of a magical pseudo-bus that's not a system bus" doesn't quite do it
> > for me.
> 
> Nope, a device has a "name", a "subsystem" and a "devpath", has
> well-defined core-maintained properties at the device directory. It is
> not some random custom directory which people can put where they like
> it. Userspace has expectations about devices which need to be met, and
> that can only happen if these devices are "struct device".
> 
> All real devices sort into a hierarchy, possibly in different parent
> locations, and have a single point of classification which is the
> devices/ directory and contains symlinks. Only that way we can cope with
> it in userspace.
> 
> People should really stop messing around in /sys for optimization
> purposes. We have a common device model, and need to use it. Sysdevs do
> not fit into that model.
> 
> I can't tell how that fits into your use case, but please use something
> else than sysfs, if you need device information exported, but you can't
> use "struct device".

I really think you shouldn't say "sysfs" when you in fact you mean
"/sys/devices/". :-)

Now, I can easily understand arguments about representing everything under
/sys/devices/ by struct device objects, no question about that.  However,
I also think there should be a place for things like those mentioned in the
comment in sys.c, presumably outside of /sys/devices/.

Thanks,
Rafael
