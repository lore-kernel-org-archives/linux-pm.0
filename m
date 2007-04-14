From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v4] pm_ops: add system quiesce/activate hooks
Date: Sat, 14 Apr 2007 11:14:55 +0200
Message-ID: <200704141114.56545.rjw@sisk.pl>
References: <1175810054.3489.34.camel@johannes.berg>
	<20070413223922.GS28264@elf.ucw.cz>
	<1176506383.5764.129.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1176506383.5764.129.camel@localhost.localdomain>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-pm@lists.linux-foundation.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Saturday, 14 April 2007 01:19, Benjamin Herrenschmidt wrote:
> Ok, PowerPC Decrementer 101
> =

> The processor contains a special register, the decrementer, which
> keeps ... decrementing. It can be set to any arbitrary value at any time
> and will decrement in sync with the processor timebase.
> =

> There are some subtle differences between implementations regarding what
> happens when reaching 0, but the basic idea is that you get an interrupt
> (depending on the processor, that interrupt is somewhat a level
> interrupt asserted when the decrementer is negative or it can be a kind
> of edge interrupt queued up when the dec transitions from 0 to -1).
> =

> This decrementer is used as the main timer. Thus it needs to be
> operating normally at all time until interrupts are off or the scheduler
> will stop working properly, kernel timers will not fire, etc...
> =

> (and saying that platforms devices should use mdelay instead is just
> gross, I won't even go there. Interrupts are still on -> the core kernel
> should operate normally and that includes the main timer source).
> =

> Now what happens when we put the processors (well, most desktop
> processors, at least the one that concern us in that discussion) to
> sleep is that they get out of sleep when an interrupt occur, for
> example ... a decrementer interrupt. This is not good for STR for
> various reasons related to the way STR works in hardware (the
> northbridge snoops that the CPU is going to sleep and starts putting
> things down, ultimately shutting the CPU off, it can't really cope if
> the CPU wakes up right away and start doing things). Unfortunately, for
> other reasons, the procedure of putting the CPU to sleep involves
> turning interrupts on. For all external interrupts, that isn't a problem
> as we have previously shut them all down on the main PIC, but it is with
> the DEC.
> =

> The "trick" is that once interrupts are off, we want the DEC to be set
> to such a high value that it won't tick anytime soon (that is actually
> several seconds, enough in practice). But if we do that after IRQs have
> been turned off (from a sysdev), we have the risk that it might have
> ticked between turning IRQs off and our sysdev, and thus a DEC
> interrupts is already "queued up" (especially on CPUs where it acts as
> an edge interrupt) and will screw up our attempt to put the CPU to sleep
> later on.
> =

> The procedure we use is to set it to 0x7fffffff with IRQs on, then turn
> IRQs off, then set it back to 0x7fffffff in case it kicked in just
> before and the timer interrupt set it back to a short value. As you can
> imagine, thoseh have to be done close together as part of the main irq
> disabling procedure, after platform devices have run (that is we can
> consider the scheduler as "off") and before sysdev's etc...
> =

> Now, in addition to that, we have some weird motherboard stuff we need
> to turn off/on, which has to be done after drivers (because it renders
> various busses inaccessible in some cases, and might cause DMA snooping
> to stop working, I'm not 100% sure, but I know for sure it has to be
> done late) but can't be done as a sysdev because we need some
> infrastructure like the i2c stuff (and others) that requires semaphores
> and timers. It's based on something remotely akin to AML in that we have
> to execute "scripts" provided by the firmware and the code to do so need
> to run in an environment where scheduler & timers are operating.
> =

> That later thing could be dealt with using a platform device if we could
> guarantee that platform device is put to sleep last of all devices in
> the tree and woken up first. Right now, we have no such guarantee and no
> mecanism for it, and I don't see a solution showing up for 2.6.22
> =

> In the long run, we might be able to break up that phase to have each
> individual device that has such functions associated have ways to call
> into them after the device has been put to sleep, but that involves more
> complication, probably hook in the generic PCI code etc... and more
> ordering issues vs. some motherboard foo so it's definitely not on the
> short term radar.
> =

> For all those reasons, I do think that the proper, clean and incremental
> approach to get our stuff working is to have that pair of hooks allowing
> us to "replace" the local_irq_disable/enable calls...
> =

> Now it does not need to be pm_ops. I'm fine with arch_pm_irq_quiesce()
> kind of thing (or find a better name if you can, maybe
> arch_pm_after_devices_suspend() arch_pm_before_device_wakeup() ?) and
> have the default implementation of these just do
> local_irq_disable/enable.

I like this idea.

Greetings,
Rafael
