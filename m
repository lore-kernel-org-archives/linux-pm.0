From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Two problems with system sleep
Date: Tue, 16 Feb 2010 22:22:31 +0100
Message-ID: <201002162222.31075.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1002161118360.1281-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1002161118360.1281-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, Alan <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Tuesday 16 February 2010, Alan Stern wrote:
> On Sun, 14 Feb 2010, Rafael J. Wysocki wrote:
> 
> > On Sunday 14 February 2010, Alan Stern wrote:
> > > On Sat, 13 Feb 2010, Rafael J. Wysocki wrote:
> > > 
> > > > > The bigger problem is that with a normal sleep ("echo none >pm_test"),
> > > > > the system doesn't wake up.  Pressing a key or a mouse button does
> > > > > nothing.  Pressing the power button causes the machine to start up
> > > > > again, but the screen remains blank and there's no response to network
> > > > > pings.
> > > > > 
> > > > > This was with more or less standard 2.6.33-rc6 (Greg KH's patch set was 
> > > > > applied but none of your PM patches).  The motherboard is an Intel 
> > > > > ICH5 with a 32-bit CPU.  Any ideas on ways to approach this?
> > > > 
> > > > That depends on the graphics adapter.  Is it Intel or AMD?
> > > 
> > > $ lspci -s 2.0
> > > 00:02.0 VGA compatible controller: Intel Corporation 82865G Integrated Graphics Controller (rev 02)
> > 
> > Well, that is supposed to work.  Do you have KMS turned on?
> 
> It's hard to tell.  CONFIG_DRM and CONFIG_DRM_HELPER were both set to M
> and the i915 driver was loaded, which pulled both of them in as well.  
> But lsmod showed that i915's usage count was 0 and there were no kernel
> messages about the framebuffer device; the only relevant messages were:
> 
> [   41.814441] [drm] Initialized drm 1.1.0 20060810
> [   41.869690] pci 0000:00:02.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
> [   41.869705] pci 0000:00:02.0: setting latency timer to 64
> [   41.883076] [drm] Initialized i915 1.6.0 20080730 for 0000:00:02.0 on minor 0
> 
> Also, the console remained in the BIOS's original 80x25 video mode.  
> Since I wasn't running X11 during the test, KMS shouldn't have made any
> difference, right?
> 
> > > Do you need any more information than that?
> > 
> > Is the problem reproducible with init=/bin/bash vga=0?
> 
> Yes.  I tried booting with no initramfs and with "init=/bin/bash
> vga=0".  Just as before the suspended machine didn't do anything when I
> pressed keys on the keyboard, and pressing the power button caused it
> to come back up totally unresponsive with the screen blank and the
> CapsLock and ScrollLock lights blinking.

Hmm.  What about X86_CHECK_BIOS_CORRUPTION and friends?

Perhaps the BIOS steps onto the early wakeup code.

Rafael
