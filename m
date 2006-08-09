From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: swsusp and suspend2 like to overheat my laptop
Date: Tue, 8 Aug 2006 22:23:22 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0608082215090.20396@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0608081612380.17442@gandalf.stny.rr.com>
	<20060808235352.GA4751@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <suspend2-devel-bounces@lists.suspend2.net>
In-Reply-To: <20060808235352.GA4751@elf.ucw.cz>
List-Unsubscribe: <http://lists.suspend2.net/mailman/listinfo/suspend2-devel>,
	<mailto:suspend2-devel-request@lists.suspend2.net?subject=unsubscribe>
List-Archive: <http://lists.suspend2.net/lurker/list/suspend2-devel.html>
List-Post: <mailto:suspend2-devel@lists.suspend2.net>
List-Help: <mailto:suspend2-devel-request@lists.suspend2.net?subject=help>
List-Subscribe: <http://lists.suspend2.net/mailman/listinfo/suspend2-devel>,
	<mailto:suspend2-devel-request@lists.suspend2.net?subject=subscribe>
Sender: suspend2-devel-bounces@lists.suspend2.net
Errors-To: suspend2-devel-bounces@lists.suspend2.net
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@osdl.org, LKML <linux-kernel@vger.kernel.org>, Suspend2-devel@lists.suspend2.net, ncunningham@linuxmail.org
List-Id: linux-pm@vger.kernel.org


On Wed, 9 Aug 2006, Pavel Machek wrote:

> Hi!
>
> > A few months ago, I installed suspend2 on my laptop.  It worked great for
> > a few days, when suddenly my laptop started to get very hot and the fan
> > costantly went off, and then I started getting these:
>
> I take it as "if I keep it for a week powered off, it will not do
> this".

Not quite.  It's more of, "if I suspend everynight instead of leaving it
running or shutting it down, it will do this" or "if I power off at night
or just leave it running, it will not do this".


>
> > ---
> > Message from syslogd@localhost at Tue Aug  8 16:08:53 2006 ...
> > localhost kernel: CPU0: Temperature above threshold
> >
> > Message from syslogd@localhost at Tue Aug  8 16:08:53 2006 ...
> > localhost kernel: CPU1: Temperature above threshold
> >
> >
> > Message from syslogd@localhost at Tue Aug  8 16:08:53 2006 ...
> > localhost kernel: CPU0: Running in modulated clock mode
> >
> > Message from syslogd@localhost at Tue Aug  8 16:08:53 2006 ...
> > localhost kernel: CPU1: Running in modulated clock mode
> > ---
>
> P4 has thermal protection, so you are actually safe.

Yeah, but still, the keyboard gets pretty hot too, and I'm actually more
worried about damaging something that is close by than damaging the CPU
itself.

>
> Nigel is right, this is acpi problem, but I guess we can help it.  Do
> you have /proc/acpi/fan? Do you have /proc/acpi/ibm/fan? Can you try
> playing with them?

hmm, I have /proc/acpi/fan/ but nothing is in it. Here's some configs of
interest:

CONFIG_ACPI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
# CONFIG_ACPI_SLEEP_PROC_SLEEP is not set
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_VIDEO=m
# CONFIG_ACPI_HOTKEY is not set
CONFIG_ACPI_FAN=m
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_THERMAL=m
# CONFIG_ACPI_ASUS is not set
CONFIG_ACPI_IBM=m
# CONFIG_ACPI_IBM_DOCK is not set
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_BLACKLIST_YEAR=2001
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_PM_TIMER=y
CONFIG_ACPI_CONTAINER=m
# CONFIG_ACPI_SBS is not set


$ lsmod |grep fan
fan                     6916  0

$ sudo modprobe ibm_acpi
$ ls /proc/acpi/ibm/
bay        bluetooth  driver     led        thermal
beep       cmos       hotkey     light      video

No fan there

and still no fan stuff in /proc/acpi/fan.


>
> And yes, this should go into bugzilla.kernel.org.

OK, will do.


Thanks,

-- Steve
