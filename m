From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] pm_ops: add irq enable/disable hooks
Date: Wed, 11 Apr 2007 10:07:44 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0704111006060.3305-100000@iolanthe.rowland.org>
References: <1176290533.8061.100.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1176290533.8061.100.camel@localhost.localdomain>
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
Cc: linux-pm <linux-pm@lists.osdl.org>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Wed, 11 Apr 2007, Benjamin Herrenschmidt wrote:

> > Is it feasible to improve sysdev handling to allow this?
> =

> It would be an absolutely ugly hack imho...
> =

> The trick to get the decrementer right is to really do it at the same
> time as we turn irqs off... hence the idea to make the whole "turning
> irqs off" platform specific to get the platform a chance to perform
> whatever trickery is necessary after normal driver suspend and around
> IRQ disabling.
> =

> (In the decrementer case, it looks approx like:
>   1- set decrementer to max value
>   2- switch irqs off
>   3- set decrementer to max value (again)
>  )
> =

> Along with that, we have all sort of platform specific hackery we need
> to perform just before disabling IRQs on suspend and just after
> re-enabling them on resume. That's really the simplest/easiest way to do
> it.
> =

> In fact, I'm pretty sure ACPI would love to use such a hook into as
> well, in order to run all that motherboard stuff that needs to be able
> to sleep, take semaphores, etc... before IRQs are off but after all
> devices have suspended.
> =

> sysdev's are just a pain in the neck if you ask me... Most of the
> problems I've seen with cpufreq are due to the fact that it's a sysdev.
> They were a bad idea in the first place and keep being abused :-)

Have you guys considered using a notifier chain for this?  The platform =

code could register itself on the chain at boot time.  When suspending you =

send out notifications just before and just after disabling interrupts, =

and inversely on resume.

Alan Stern
