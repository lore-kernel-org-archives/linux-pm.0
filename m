From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] Behavior of PCMCIA based HCD in the event of SUSPEND
Date: Mon, 17 Apr 2006 10:15:04 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0604171007580.5391-100000@iolanthe.rowland.org>
References: <05B7784238A51247A0A9FB4B348CECAE019BA8F1@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
In-Reply-To: <05B7784238A51247A0A9FB4B348CECAE019BA8F1@PNE-HJN-MBX01.wipro.com>
Sender: linux-usb-devel-admin@lists.sourceforge.net
Errors-To: linux-usb-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
To: kaustav.majumdar@wipro.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Mon, 17 Apr 2006 kaustav.majumdar@wipro.com wrote:

> Hi all,
> 
> I have the following queries regarding the power management on a PCMCIA
> based USB host controller driver.
> 
> 1. The SUSPEND event in the PCMCIA client driver is handled in the
> following way:
> 
> In the PCMCIA layer, on a SUSPEND event, the socket layer powers off the
> card. As the USB framework behavior is not allowed to suspend if lower
> nodes are not already suspended, we assume that the correct behavior for
> the above case should be to shut down the Host Controller.
> I want to confirm whether the assumed behavior is ok or should the
> behavior be something else?

The HCD's behavior should be to suspend the host controller, with the 
understanding that factors beyond the HCD's control (such as the 
behavior of the PCMCIA client driver) may cause the host controller to be 
shut down entirely.  The HCD should not shut down the host controller 
during a suspend event.

> 2. And if the correct behavior is what we had assumed, then to implement
> that we call usb_remove_hcd from the PCMCIA client driver. Is this the
> correct way to do so? 

No.  The PCMCIA client driver should not make any assumptions about its 
clients.  All it should do is check that all the clients have been 
suspended already before allowing itself to be suspended.

> The reason for the question is it can happen that after suspending the
> card, before resume card may be manually removed. In that case, there is
> a possibility of usb_remove_hcd being called twice consecutively which
> can cause error.
> Please suggest if any better way of implementing the above.

The PCMCIA client driver should not call usb_remove_hcd at all.  Only a
USB host controller driver is allowed to call that routine.

Alan Stern



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
