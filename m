From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-pm] Remote wake up not working
Date: Tue, 13 Jun 2006 10:17:58 -0700
Message-ID: <200606131018.00575.david-b@pacbell.net>
References: <380D9721A8E2114485644D71E87C6AB201FD8476@PNE-HJN-MBX01.wipro.com>
	<20060610132832.GB4547@ucw.cz> <1150215167.6305.6.camel@johannes>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1150215167.6305.6.camel@johannes>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-usb-devel-bounces@lists.sourceforge.net
Errors-To: linux-usb-devel-bounces@lists.sourceforge.net
To: linux-usb-devel@lists.sourceforge.net
Cc: Johannes Berg <johannes@sipsolutions.net>, rasmit.ranjan@wipro.com, linux-pm@lists.osdl.org, Linux Kernel list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Tuesday 13 June 2006 9:12 am, Johannes Berg wrote:
> On Sat, 2006-06-10 at 13:28 +0000, Pavel Machek wrote:
> 
> > I do not think we support remote wakeup these days. Code may be there,
> > but as noone ever uses it... perhaps it needs some fixing.
> 
> Works fine with bluetooth on my powerbook, but then again, I can't turn
> it *off* which is rather annoying, but I think caused by the missing
> suspend/resume handlers in hci_usb :/

USB remote wakeup basically works today (given CONFIG_USB_SUSPEND),
and has worked for quite a few kernel releases now, given

  (a) Working platform support.  So for example ACPI will not-infrequently
      do the wrong thing on resume, or the video driver misbehaves, and
      so on.  All too few systems work correctly with either (a1) "standby"
      or (a2) "mem" when you write them to /sys/power/state, and the issues
      have only rarely been related to USB.  (I got some mail over the last
      few days about one that boiled down to interrupt controller bugs.)

  (b) Support in the USB drivers for suspend/resume.  I've seen other
      reports lately about hci_usb is missing usb suspend/resume calls,
      leading to misbehavior.  (I think someone checked in an odd patch
      a while ago which change the failure mode for those missing calls
      to something that was still broken, just not as obviously.)  And
      then there are the ALSA drivers, and quite a few others...

That's not to say that it's perfect -- the clock framework is still missing
a hook to help embedded USB hosts behave right, and the /proc/acpi/wakeup
state isn't even vaguely integrated with the driver model wakeup stuff -- but
there are no known blocking issues there inside the USB stack or the main
host controller drivers.

- Dave



_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
