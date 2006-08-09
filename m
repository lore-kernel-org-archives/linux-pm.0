From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Subject: Re: swsusp and suspend2 like to overheat my laptop
Date: Wed, 9 Aug 2006 15:42:11 +0200
Message-ID: <20060809134211.GA6286@rhlx01.fht-esslingen.de>
References: <Pine.LNX.4.58.0608081612380.17442@gandalf.stny.rr.com>
	<Pine.LNX.4.58.0608090732100.2500@gandalf.stny.rr.com>
	<20060809115843.GB3747@elf.ucw.cz> <200608091415.51226.rjw@sisk.pl>
	<Pine.LNX.4.58.0608090913480.3560@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <suspend2-devel-bounces@lists.suspend2.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0608090913480.3560@gandalf.stny.rr.com>
List-Unsubscribe: <http://lists.suspend2.net/mailman/listinfo/suspend2-devel>,
	<mailto:suspend2-devel-request@lists.suspend2.net?subject=unsubscribe>
List-Archive: <http://lists.suspend2.net/lurker/list/suspend2-devel.html>
List-Post: <mailto:suspend2-devel@lists.suspend2.net>
List-Help: <mailto:suspend2-devel-request@lists.suspend2.net?subject=help>
List-Subscribe: <http://lists.suspend2.net/mailman/listinfo/suspend2-devel>,
	<mailto:suspend2-devel-request@lists.suspend2.net?subject=subscribe>
Sender: suspend2-devel-bounces@lists.suspend2.net
Errors-To: suspend2-devel-bounces@lists.suspend2.net
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-pm@osdl.org, Suspend2-devel@lists.suspend2.net, LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>, ncunningham@linuxmail.org
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 09, 2006 at 09:16:30AM -0400, Steven Rostedt wrote:
> 
> On Wed, 9 Aug 2006, Rafael J. Wysocki wrote:
> 
> >
> > If it's a P4, we rather don't, because the ACPI tables should be above the
> > last pfn in the normal zone.  Still, Steven please send your dmesg after a
> > fresh boot.
> >
> 
> Attached is a gzipped version of my dmesg.

This one is fatal:

| ACPI: Found ECDT
| ACPI: Could not use ECDT

And you also have

| ACPI: Processor [CPU0] (supports 4 throttling states)
| ACPI: Processor [CPU1] (supports 4 throttling states)

(IOW, no C2/C3 states listed here)

The buggy ECDT table (see http://www.poupinou.org/acpi/ibm_ecdt.html)
is said to cause ACPI init to fail:
http://t2100cdt.kippona.net/tlinux/archive/linux.toshiba-dme.co.jp/ML/tlinux-users/4300/4396.html
as such it's not too astonishing that you don't have C2/C3 states, *always*
(pre-suspend and post-suspend).

However the machine should still do normal HLT idle loop which should
manage to keep it reasonably cool, right?

Given this ECDT table issue it's very possible that this is the reason for
Linux ACPI layer misbehaviour after resume.

Google "ACPI ECDT" might help, too.

In any case, you could do some kernel logging around pm_idle* in
drivers/acpi/processor_idle.c since I suspect that this is what changes
after resume to cause the idling to fail.

Andreas Mohr
