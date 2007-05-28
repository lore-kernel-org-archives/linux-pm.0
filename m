From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm 3/3] PM: Disable _request_firmware
	before hibernation/suspend
Date: Mon, 28 May 2007 13:28:07 +0200
Message-ID: <200705281328.08979.rjw@sisk.pl>
References: <200705272229.21263.rjw@sisk.pl> <200705280943.54312.rjw@sisk.pl>
	<20070528111554.GF18807@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070528111554.GF18807@elf.ucw.cz>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Kay Sievers <kay.sievers@vrfy.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday, 28 May 2007 13:15, Pavel Machek wrote:
> Hi!
> 
> > > > > What exactly is the problem we see here? The timeout of the firmware loader?
> > > > > What goes wrong with frozen userspace, usually there is only a netlink
> > > > > message sent from the kernel, which should be received and handled
> > > > > just fine when userspace is running again.
> > > > 
> > > > Driver calls request_firmware in the resume method. The userspace helper 
> > > > can't be run because it's been frozen, so the firmware never gets loaded 
> > > > and the call times out. The driver then fails to resume. While all this 
> > > > is happening, the rest of the kernel is blocking on that resume method. 
> > > > The firmware can be loaded once userspace has been started again, but by 
> > > > that time the driver has given up.
> > > 
> > > Seems, that's just the broken synchronous firmware loading interface
> > > with the useless timeout handling. The nowait version of the same loader
> > > doesn't time out, and should not have that problem. The sync version
> > > should be removed from the kernel, it just causes all sorts of problems
> > > since it exists.
> > > 
> > > Userspace should handle the async request just fine when it comes back
> > > running, regardless of the time it was submitted.
> > 
> > Okay, so the solution is to convert the drivers to use
> > request_firmware_nowait() instead of request_firmware() in their .resume()
> > routines.
> 
> You'll just get deadlock at different level (and more rare).
> 
> Imagine disk with its firmware on NFS and NFS with its firmware on
> disk.

Yeah, I've just given the very same example in another message. :-)

I believe the only _solution_ would be to load the firmware into memory
before the suspend and use the in-RAM copy to upload it into the device
in .resume().

A PM_PRE_FREEZE notifier could be used for that just fine, BTW.

Greetings,
Rafael
