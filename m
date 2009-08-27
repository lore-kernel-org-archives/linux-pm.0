From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: PME# for add-on cards
Date: Thu, 27 Aug 2009 21:41:03 +0200
Message-ID: <200908272141.03343.rjw__27721.417861949$1251402076$gmane$org@sisk.pl>
References: <200908240112.39424.rjw@sisk.pl>
	<20090825234203.GB14047@khazad-dum.debian.net>
	<20090827091307.1fe8af2b@jbarnes-g45>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090827091307.1fe8af2b@jbarnes-g45>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 27 August 2009, Jesse Barnes wrote:
> On Tue, 25 Aug 2009 20:42:03 -0300
> Henrique de Moraes Holschuh <hmh@hmh.eng.br> wrote:
> 
> > On Mon, 24 Aug 2009, Jesse Barnes wrote:
> > > On Mon, 24 Aug 2009 20:39:07 +0200
> > > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > > > On Monday 24 August 2009, Matthew Garrett wrote:
> > > > > On Mon, Aug 24, 2009 at 01:12:39AM +0200, Rafael J. Wysocki
> > > > > wrote:
> > > > > > After some debugging it turned out that PCI0 is the PCI host
> > > > > > bridge (no-bus:pci0000:00), so apparently echoing PCI0
> > > > > > to /proc/acpi/wakeup causes a wake-up GPE to be set up for the
> > > > > > host bridge which triggers wake-up once eth0 signals PME#.
> > > > > 
> > > > > Mm. That sounds entirely plausible. If it were a built-in card
> > > > > then the DSDT would provide that GPE, but as an add-in...
> > > > > 
> > > > > > First, I wonder if that's the case in general (anybody
> > > > > > knows?). Second, if that is the case, would it be a good idea
> > > > > > to set up the host bridge wake-up GPE by default?
> > > > > 
> > > > > I'd expect this to be the case in general, yes. Systems that
> > > > > work without this probably have the BIOS enable it themselves on
> > > > > suspend. I suspect we'll have to set it to make sure.
> > > > 
> > > > OK, Matthew, Alan, thanks for your opinions.
> > > > 
> > > > I'll try to implement this, then.
> > > 
> > > I think that's the best approach.  The only risk that I can see
> > > immediately is that we'll expose ourselves to add-in cards with
> > > flakey PME# signals.  We can worry about that when/if we see it
> > > though.
> > 
> > I have seen it, an old atheros-based wifi card packaged by 3COM.  My
> > Intel D875PBZ motherboard could not turn off (it would turn back on
> > due to #PME) with that crap installed.  Probably the BIOS didn't
> > defend itself enough against PME on power _off_.  I didn't even need
> > to have ANY driver at all for that card for it to be a hassle.
> > 
> > I have sinced given that card away to someone who runs it under
> > Windows in a different motherboard (that probably masks #PME on
> > shutdown :p).
> > 
> > May I humbly suggest a command-line switch to let the user disable
> > the new behaviour (or even selectively disable/enable it per host
> > bridge) since day one?  The default can be enabled, let's priorize
> > good hardware and firmware over buggy crap!  but let's make it easy
> > to work around any issues it could cause right from the beginning,
> > because they _will_ happen.
> 
> Hopefully we can do even better than that with per-device quirks (i.e.
> only disable PME on a bridge if a child device is buggy).
> 
> Rafael?

First off, this is about enabling the host bridge's GPE to wake up the
system rather than PME and I'm not yet sure we can generally do that for all
host bridges (investigation in progress).

The particular system I was talking about in the first message in this thread
had a specific entry for the host bridge in /proc/acpi/wakeup while the other
systems I looked at didn't appear to have anything like this.

At the moment I think it should be safe to set wakeup.state.enabled for the
host bridge provided that it has wakeup.flags.valid set (otherwise it wouldn't
work anyway).  The systems where this is known unsafe should be regarded as
buggy and handled through quirks IMO.

Thanks,
Rafael
