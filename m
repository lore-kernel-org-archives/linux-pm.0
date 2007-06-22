From: David Brownell <david-b@pacbell.net>
Subject: Re: Re: [2.6.22-rc1-mm1] vaio laptop (SZ72B) immediately
	resumes after STR
Date: Fri, 22 Jun 2007 03:02:10 -0700
Message-ID: <200706220302.11081.david-b__16222.4006410272$1182506581$gmane$org@pacbell.net>
References: <200706191326.10320.rjw@sisk.pl>
	<Pine.LNX.4.44L0.0706191019090.3674-100000@iolanthe.rowland.org>
	<20070620144532.GA3761@inferi.kami.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070620144532.GA3761@inferi.kami.home>
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
To: Mattia Dongili <malattia@linux.it>, Alan Stern <stern@rowland.harvard.edu>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, akpm@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wednesday 20 June 2007, Mattia Dongili wrote:

> http://www.linux.it/~malattia/logs/dmesg-suspend-ehci-debug-log

which includes

> [18014387.734703] psmouse serio1: resuming
> [18014388.257990] usb_endpoint usbdev5.1_ep00: PM: resume from 0, parent usb5 still 2
> [18014388.257994] usb_endpoint usbdev5.1_ep81: PM: resume from 0, parent 5-0:1.0 still 2
> [18014388.258004] usb_endpoint usbdev5.2_ep00: PM: resume from 0, parent 5-4 still 2
> [18014388.258007] usb_endpoint usbdev5.4_ep00: PM: resume from 0, parent 5-6 still 2
> [18014388.258011] usb_endpoint usbdev5.4_ep81: PM: resume from 0, parent 5-6:1.0 still 2
> [18014388.258014] usb_endpoint usbdev5.4_ep86: PM: resume from 0, parent 5-6:1.0 still 2
> [18014388.258019] sony-laptop sony-laptop: resuming 
> [18014388.258022] platform bluetooth: resuming
> [18014388.258034] usb_endpoint usbdev5.2_ep02: PM: resume from 0, parent 5-4:1.0 still 2
> [18014388.258037] usb_endpoint usbdev5.2_ep82: PM: resume from 0, parent 5-4:1.0 still 2
> [18014388.310276] Restarting tasks ... <7>usb usb5: usb resume
> [18014388.310514] usb usb5: finish resume
> [18014388.310524] ehci_hcd 0000:00:1d.7: resume root hub
> [18014388.312058] done.
> [18014388.437263] hub 5-0:1.0: hub_resume
> [18014388.437314] hub 5-0:1.0: state 7 ports 8 chg 0000 evt 0000

That looks pretty darn goofy.  Resumes out of order:  endpoints for child
devices, then the downstream root hub, then finally the PCI dev.  Which
is completely the reverse of the correct direction.

Or am I missing something?
