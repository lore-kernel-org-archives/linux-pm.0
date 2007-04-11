From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] pm_ops: add irq enable/disable hooks
Date: Wed, 11 Apr 2007 21:22:13 +1000
Message-ID: <1176290533.8061.100.camel@localhost.localdomain>
References: <1175810054.3489.34.camel@johannes.berg>
	<200704060217.50560.rjw@sisk.pl>
	<1175849322.3489.64.camel@johannes.berg>
	<200704061141.31677.rjw@sisk.pl>
	<1175852652.3489.67.camel@johannes.berg>
	<20070406191903.GD2583@elf.ucw.cz>
	<1175896767.8459.6.camel@johannes.berg>
	<20070410113623.GF8239@elf.ucw.cz>
	<1176205508.8459.89.camel@johannes.berg>
	<20070410120028.GI8239@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070410120028.GI8239@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@suse.cz>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 2007-04-10 at 14:00 +0200, Pavel Machek wrote:
> Hi!
> =

> > > Hmm, and can't you simply create sysdev for decrementer and special
> > > platform handling? sysdevs should be suspended last...
> > =

> > In theory, yes.
> > =

> > In practise, however, it seems to be impossible to get a sysdev into the
> > queue that is suspended before any other sysdevs are suspended (i.e.
> > right after interrupts are disabled)
> > =

> > And then there are the platform functions. In theory, they could be done
> > with a regular struct device, but in practice they need to be the very
> > last thing before interrupts are disabled, and that again is impossible
> > to achieve.
> =

> Is it feasible to improve sysdev handling to allow this?

It would be an absolutely ugly hack imho...

The trick to get the decrementer right is to really do it at the same
time as we turn irqs off... hence the idea to make the whole "turning
irqs off" platform specific to get the platform a chance to perform
whatever trickery is necessary after normal driver suspend and around
IRQ disabling.

(In the decrementer case, it looks approx like:
  1- set decrementer to max value
  2- switch irqs off
  3- set decrementer to max value (again)
 )

Along with that, we have all sort of platform specific hackery we need
to perform just before disabling IRQs on suspend and just after
re-enabling them on resume. That's really the simplest/easiest way to do
it.

In fact, I'm pretty sure ACPI would love to use such a hook into as
well, in order to run all that motherboard stuff that needs to be able
to sleep, take semaphores, etc... before IRQs are off but after all
devices have suspended.

sysdev's are just a pain in the neck if you ask me... Most of the
problems I've seen with cpufreq are due to the fact that it's a sysdev.
They were a bad idea in the first place and keep being abused :-)

Ben.
