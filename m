From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Behavior of PCMCIA based HCD in
	the event of SUSPEND
Date: Mon, 17 Apr 2006 22:47:25 -0700
Message-ID: <200604172247.25664.david-b@pacbell.net>
References: <05B7784238A51247A0A9FB4B348CECAE019BA8F1@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============13970434151692235=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <05B7784238A51247A0A9FB4B348CECAE019BA8F1@PNE-HJN-MBX01.wipro.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-usb-devel@lists.sourceforge.net
Cc: linux-pm@lists.osdl.org, kaustav.majumdar@wipro.com
List-Id: linux-pm@vger.kernel.org

--===============13970434151692235==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday 16 April 2006 11:30 pm, kaustav.majumdar@wipro.com wrote:
> Hi all,
> 
> I have the following queries regarding the power management on a PCMCIA
> based USB host controller driver.

You mean PCMCIA as in the 16-bit ISA-ish bus?

Or PCMCIA as in the "PC Card" form factor with Cardbus/PCI options?

Right now we have working examples of both of those.  ("sl811_cs" for
PCMCIA/CF, and at least OHCI and EHCI for CardBus/PCI.)  I wouldn't say
either work perfectly -- lack of constant testing being a predictable
source of trouble -- but they have differences which matter.

Look at any of those drivers for code models.  They all used to work
correctly in these cases, maybe they still do.  ;)


> 1. The SUSPEND event in the PCMCIA client driver is handled in the
> following way:
> 
> In the PCMCIA layer, on a SUSPEND event, the socket layer powers off the
> card. As the USB framework behavior is not allowed to suspend if lower
> nodes are not already suspended, we assume that the correct behavior for
> the above case should be to shut down the Host Controller.
> I want to confirm whether the assumed behavior is ok or should the
> behavior be something else?

Shutting down the host controller at suspend() is what I'd like to see
happen, but it kept deadlocking in the PM infrastructure, which has been
designed with odd assumptions like "devices can't go away now".


What the existing drivers do is rely on the rest of Linux (usbcore and
the PM framework) to have cleanly shut down all child devices before
anyone asks the HCD to suspend ... and then HCDs will shut down politely.
(If that's not happening, something outside the HCD is broken.)

If power to a host controller gets lost during suspend, implicitly
disconnecting all the USB devices, that must be noticed in its HCD's
resume() method, at which point it marks the child devices as dead and
reinitializes itself.

And if the power is dropped _before_ the resume method gets called,
no big deal.  Ignore that fact until later; you can just handle it
later when the PM and USB frameworks are ready to handle it too.


Of course, another option is that on resume() the HCD notices that the
hardware has been unplugged, which is a somewhat different situation
that arguably reflects a bug in the bus glue used by that adapter ...
that is, the HCD should have gotten a remove() call not resume().  But
I've certainly seen Cardbus/PCI use that bogus call sequence, so the
HCDs have code to also mark the USB controller itself as dead.  That
way, until the bus glue eventually calls remove(), all is fine.



> 2. And if the correct behavior is what we had assumed, then to implement
> that we call usb_remove_hcd from the PCMCIA client driver. Is this the
> correct way to do so? 
> The reason for the question is it can happen that after suspending the
> card, before resume card may be manually removed. In that case, there is
> a possibility of usb_remove_hcd being called twice consecutively which
> can cause error.

Keep things simple, and rely on your bus glue (PCMCIA or Cardbus) to
handle disconnections; just handle suspend() and resume() sanely, while
also detecting the "card removed" cases as normal non-error operations.

- Dave


--===============13970434151692235==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============13970434151692235==--
