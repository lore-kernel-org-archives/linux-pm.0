From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC][PATCH] thunderbolt: icm: Ignore mailbox errors in icm_suspend()
Date: Wed, 26 Jul 2017 19:05:01 +0200
Message-ID: <4165239.xHgWvuTePe@aspire.rjw.lan>
References: <4063610.TqANq0McE8@aspire.rjw.lan> <2817723.OEn9Hxcbhj@aspire.rjw.lan> <20170726131259.GM2369@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170726131259.GM2369@lahna.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Andreas Noever <andreas.noever@gmail.com>, Michael Jamet <michael.jamet@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, July 26, 2017 04:12:59 PM Mika Westerberg wrote:
> On Wed, Jul 26, 2017 at 02:48:54PM +0200, Rafael J. Wysocki wrote:
> > On Wednesday, July 26, 2017 11:32:44 AM Mika Westerberg wrote:
> > > On Tue, Jul 25, 2017 at 06:10:57PM +0200, Rafael J. Wysocki wrote:
> > > > On Tuesday, July 25, 2017 01:00:12 PM Mika Westerberg wrote:
> > > > > On Tue, Jul 25, 2017 at 01:31:00AM +0200, Rafael J. Wysocki wrote:
> > > > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > > 
> > > > > > On one of my test machines nhi_mailbox_cmd() called from icm_suspend()
> > > > > > times out and returnes an error which then is propagated to the
> > > > > > caller and causes the entire system suspend to be aborted which isn't
> > > > > > very useful.
> > > > > > 
> > > > > > Instead of aborting system suspend, print the error into the log
> > > > > > and continue.
> > > > > 
> > > > > I agree, it should not prevent suspend but I wonder why it fails in the
> > > > > first place? Can you check what is the return value?
> > > > 
> > > > As per the above, the error is a timeout, ie. -ETIMEDOUT.
> > > 
> > > Ah, right I somehow missed that.
> > > 
> > > Does it have Falcon Ridge controller or Alpine Ridge?
> > 
> > I'll check later today, but i guess you'll know (see below).
> 
> No need to check, it is Alpine Ridge (since it is Dell 9360).
> 
> > > Just to make sure, can you increase the timeout in nhi_mailbox_cmd()
> > > to 1000ms or so. It should not take that long though but better to check.
> > 
> > Well, I can do that, but I don't think it will help.
> > 
> > It just looks like the chip is not responding at all at that point.
> 
> I see.
> 
> Then I think we should apply your patch now and we can investigate this
> further offline and hopefully find the root cause for the problem.
> 
> For this patch:
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

OK

I guess I can apply it, then, or if anyone else in the CC wants to do that,
please let me know.

> 
> > > Which system this is BTW?
> > 
> > It's the Dell 9360. :-)
> > 
> > Sometimes after a reboot or a power cycle it starts in a state in which the
> > TBT controller and a USB one (which seem to be somehow connected)
> > appear to be dead or at least really flaky.  Basically, the box needs to be
> > power-cycled again to get rid of this condition and then everything works.
> 
> The xHCI controller is part of the Thunderbolt controller so whenever
> you have normal USB-C device connected there, you should also see the
> Alpine Ridge hierarchy in lspci output but the Thunderbolt host
> controller is not there.

I don't have any USB-C devices, though, so I can't really test it this way ATM.

It's jjust never used now. :-)

Thanks,
Rafael
