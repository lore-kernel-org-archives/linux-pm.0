From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: swsusp and suspend2 like to overheat my laptop
Date: Wed, 9 Aug 2006 08:35:47 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0608090831440.3177@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0608081612380.17442@gandalf.stny.rr.com>
	<20060808235352.GA4751@elf.ucw.cz>
	<Pine.LNX.4.58.0608082215090.20396@gandalf.stny.rr.com>
	<20060809073958.GK4886@elf.ucw.cz>
	<Pine.LNX.4.58.0608090732100.2500@gandalf.stny.rr.com>
	<Pine.LNX.4.58.0608090751340.2500@gandalf.stny.rr.com>
	<20060809120844.GD3747@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <suspend2-devel-bounces@lists.suspend2.net>
In-Reply-To: <20060809120844.GD3747@elf.ucw.cz>
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

>
> Okay, run top to see what goes on, and look for
> /proc/acpi/processor/*/* -- you are interested in C states before and
> after suspend.
> 									Pavel

I don't quite understand.  What am I looking for in top?

Here's the before and after:

before:

$ grep C /proc/acpi/processor/*/*
/proc/acpi/processor/CPU0/power:active state:            C1
/proc/acpi/processor/CPU0/power:max_cstate:              C8
/proc/acpi/processor/CPU0/power:   *C1:                  type[C1]
promotion[--] demotion[--] latency[000] usage[00000000] duration[00000000000000000000]
/proc/acpi/processor/CPU1/power:active state:            C1
/proc/acpi/processor/CPU1/power:max_cstate:              C8
/proc/acpi/processor/CPU1/power:   *C1:                  type[C1]
promotion[--] demotion[--] latency[000] usage[00000000] duration[00000000000000000000]


after:

grep C /proc/acpi/processor/*/*
/proc/acpi/processor/CPU0/power:active state:            C1
/proc/acpi/processor/CPU0/power:max_cstate:              C8
/proc/acpi/processor/CPU0/power:   *C1:                  type[C1]
promotion[--] demotion[--] latency[000] usage[00000000] duration[00000000000000000000]
/proc/acpi/processor/CPU1/power:active
state:            C1
/proc/acpi/processor/CPU1/power:max_cstate:              C8
/proc/acpi/processor/CPU1/power:   *C1:                  type[C1]
promotion[--] demotion[--] latency[000] usage[00000000] duration[00000000000000000000]

-- Steve
