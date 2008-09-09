From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC 3/5] pci wakeup handler
Date: Tue, 9 Sep 2008 09:18:17 -0700
Message-ID: <200809090918.18343.david-b__25765.4738067233$1220980931$gmane$org@pacbell.net>
References: <20080908091926.785882370@sli10-desk.sh.intel.com>
	<200809081956.42663.david-b@pacbell.net>
	<200809091309.01433.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200809091309.01433.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 09 September 2008, Rafael J. Wysocki wrote:
> > =

> > Another rather important case is bridges. =A0I observe that with ACPI
> > the way PME# is handled for add-in cards _seems_ to be that the bridge
> > for that PCI bus segment gets a GPE (presumably matching the PME#
> > signal for that bus segment, and maybe for its subsidiaries). =A0That
> > suggests the bridge will need to scan its children to find out which
> > one(s) issued PME#. =A0You didn't include such code here, where that
> > notification will be received...
> =

> AFAICS, the 'original' PCI PME# (as opposed to the PCI Express native PME)
> signal is supposed to be routed _around_ bridges and (presumably) the ent=
ire
> PME# network would share one GPE in that case.

To the extent that board designers are expected to follow
such rules, but have the power not to do so, we know that
relying on such expectations would be ... unwise.  ;)

Isn't the notion of a GPE pretty much an x86-ism?
For non-x86 systems I'd just think "IRQ".  And for
x86, I regularly wonder if maybe chaining through
genirq wouldn't make SCI interrupts, including GPEs,
become a lot more robust.  :(

I suspect folk maintaining non-ACPI platforms with PCI
wiill have to help sort out this particular issue.  I
suspect their board designs will provide at least one
PME# indication.  ISTR multiple PME# domains were OK,
at least in the "one per root bridge" sense, but I've
not looked at the relevant spec recently.


> Then, we'd actually have to =

> check all of the PCI devices to see which of them caused the event to hap=
pen.

That emphasizes my point:  that patch #3 needs to include code
to handle bridges, scanning wakeup-eligible devices until it
finds the relevant one(s).

Of course there should be a few ways to speed that scanning:

 - First, bridges shouldn't need to scan devices for which PME#
   was not enabled.  Make pci_enable_wake() record that state
   for use in scanning ... look at that handful of devices first.
   (And possibly the rest later, in case of errors.)

 - Second, ACPI-specific, is to recognize that the mainboard
   devices all seem to be associated with private GPEs so they
   can get direct wake event notifications.  So when the PCI
   device getting this notification/probe isn't a bridge, it
   won't need to scan other devices.

EVERY system I have here seems to have PCI devices, including
ones in add-in slots, which will require that scanning ...
because they don't show up in the ACPI tables (second case).

- Dave
