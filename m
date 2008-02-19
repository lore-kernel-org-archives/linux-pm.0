From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: arch/x86/kernel/acpi/sleep_32.c not compiled ?
Date: Wed, 20 Feb 2008 00:41:46 +0100
Message-ID: <200802200041.47851.rjw__19970.0438337915$1203464727$gmane$org@sisk.pl>
References: <20080219165940.6e9348f6@crazy> <200802192202.53510.rjw@sisk.pl>
	<20080219222623.GA28786@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080219222623.GA28786@elf.ucw.cz>
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
Cc: Thomas Petazzoni <thomas.petazzoni@enix.org>, linux-kernel@vger.kernel.org, mingo@redhat.com, hpa@zytor.com, tglx@linutronix.de, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 19 of February 2008, Pavel Machek wrote:
> On Tue 2008-02-19 22:02:52, Rafael J. Wysocki wrote:
> > On Tuesday, 19 of February 2008, Thomas Petazzoni wrote:
> > > Hi,
> > 
> > Hi,
> > 
> > > Maybe I'm missing something completely obvious, but I don't see where
> > > the arch/x86/kernel/acpi/sleep_32.c file gets compiled. The Makefile in
> > > that directory compiles sleep.o, but doesn't compile sleep_$(BITS).o:
> > > 
> > > obj-$(CONFIG_ACPI)              += boot.o
> > > obj-$(CONFIG_ACPI_SLEEP)        += sleep.o wakeup_$(BITS).o
> > > 
> > > ifneq ($(CONFIG_ACPI_PROCESSOR),)
> > > obj-y                           += cstate.o processor.o
> > > endif
> > 
> > No, the file is not build now.
> > 
> > Pavel, is this file really necessary?
> 
> sleep_32.c is obsolete. It tried to do s2ram whitelist in kernel, with
> just one entry ;-). Remove it. If Mirek Spousta (probably last
> remaining owner of whitelisted toshiba, he got it from me ;-)
> complains, I'll give him better machine or something.

Well, then perhaps we also should remove the S1 quirk for the same box from
drivers/acpi/sleep/main.c ?

Alternatively, put them both into the same file and simplify things (in which
case I'd vote for drivers/acpi/sleep/main.c)?

Rafael
