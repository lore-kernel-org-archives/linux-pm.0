From: Tino Keitel <tino.keitel@tikei.de>
Subject: Re: Suspend hangs since 2.6.34
Date: Mon, 21 Jun 2010 23:32:24 +0200
Message-ID: <20100621213224.GA5723__42867.2457267114$1277155996$gmane$org@mac.home>
References: <20100609175356.GA17332@x61.home> <201006100142.13131.rjw@sisk.pl>
	<20100620225601.GA15589@x61.home> <201006212124.09076.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201006212124.09076.rjw@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Jun 21, 2010 at 21:24:08 +0200, Rafael J. Wysocki wrote:
> On Monday, June 21, 2010, Tino Keitel wrote:
> > Hi,
> > 
> > this nasty bug did not appear after I enabled suspend debugging first,
> > but now it did:
> > 
> > 2010-06-20_22:40:31.22927 kern.info: usbcore: deregistering interface driver dvb_usb_vp7045
> > 2010-06-20_22:40:31.24960 kern.debug: usb 1-6: __pm_runtime_resume()!
> > 2010-06-20_22:40:31.24968 kern.debug: usb 1-6: __pm_runtime_resume() returns 1!
> > 2010-06-20_22:40:31.24969 kern.debug: PM: Removing info for No Bus:dvb0.frontend0
> > 2010-06-20_22:40:31.24971 kern.debug: PM: Removing info for No Bus:dvb0.net0
> > 2010-06-20_22:40:31.24972 kern.debug: PM: Removing info for No Bus:dvb0.demux0
> > 2010-06-20_22:40:31.24973 kern.debug: PM: Removing info for No Bus:dvb0.dvr0
> > 2010-06-20_22:40:31.24974 kern.info: dvb-usb: Twinhan USB2.0 DVB-T receiver (TwinhanDTV Alpha/MagicBox II) successfully deinitialized and disconnected.
> > 2010-06-20_22:40:32.26675 kern.info: PM: Syncing filesystems ... done.
> > 2010-06-20_22:40:32.39011 kern.debug: PM: Preparing system for mem sleep
> > 
> > When I killed the suspend script which hung at the echo mem >
> > /sys/power/state line, the computer suspended. After wakeup, the kernel
> >  log lines after the line above look like this:
> > 
> > 2010-06-20_22:49:10.28745 kern.warn: Freezing user space processes ... (elapsed 0.02 seconds) done.
> > 2010-06-20_22:49:10.28748 kern.warn: Freezing remaining freezable tasks ... (elapsed 0.01 seconds) done.
> > 2010-06-20_22:49:10.28748 kern.debug: PM: Entering mem sleep
> > 2010-06-20_22:49:10.28749 kern.warn: Suspending console(s) (use no_console_suspend to debug)
> > 
> > I also attached the full kernel log since the boot.
> 
> Hmm.  It looks like a USB problem, then.

Just FYI: The dvb-usb message is generated when the driver for the
DVB-T USB receiver is unloaded. I unload it because I had issues after
resume if I did not unload it.

Regards,
Tino
