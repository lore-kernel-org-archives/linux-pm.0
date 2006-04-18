From: <kaustav.majumdar@wipro.com>
Subject: RE: [linux-pm] Behavior of PCMCIA based HCD in the event of SUSPEND
Date: Tue, 18 Apr 2006 09:50:18 +0530
Message-ID: <05B7784238A51247A0A9FB4B348CECAE019BAAF3@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
Content-class: urn:content-classes:message
Sender: linux-usb-devel-admin@lists.sourceforge.net
Errors-To: linux-usb-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
To: stern@rowland.harvard.edu
Cc: linux-usb-devel@lists.sourceforge.net, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org


-----Original Message-----
From: Alan Stern [mailto:stern@rowland.harvard.edu]=20
Sent: Monday, April 17, 2006 7:45 PM
To: Kaustav Majumdar (WT01 - Semiconductors & Consumer Electronics)
Cc: linux-usb-devel@lists.sourceforge.net; linux-pm@lists.osdl.org
Subject: Re: [linux-pm] Behavior of PCMCIA based HCD in the event of
SUSPEND

On Mon, 17 Apr 2006 kaustav.majumdar@wipro.com wrote:

>> Hi all,
>>=20
>> I have the following queries regarding the power management on a
PCMCIA
>> based USB host controller driver.
>>=20
>> 1. The SUSPEND event in the PCMCIA client driver is handled in the
>> following way:
>>=20
>> In the PCMCIA layer, on a SUSPEND event, the socket layer powers off
the
>> card. As the USB framework behavior is not allowed to suspend if
lower
>> nodes are not already suspended, we assume that the correct behavior
for
>> the above case should be to shut down the Host Controller.
>> I want to confirm whether the assumed behavior is ok or should the
>> behavior be something else?

> The HCD's behavior should be to suspend the host controller, with the=20
> understanding that factors beyond the HCD's control (such as the=20
> behavior of the PCMCIA client driver) may cause the host controller to
be=20
> shut down entirely.  The HCD should not shut down the host controller=20
> during a suspend event.

As per my understanding, the Host Controller can be suspended only if
all the child devices are already suspended. If they are not then
suspension of HC will fail.=20
Also the PCMCIA subsystem's behavior is to power off the socket
irrespective of whether the PCMCIA client driver has successfully
handled the SUSPEND event or not.
So if the child devices of HC are not suspended and PCMCIA subsystem
will get a SUSPEND event (may be initiated by some user space tool
through /sys) then there is a possibility of HC being in operational
state (from driver perspective) but the PC Card itself not powered - a
chaos I think.


>> 2. And if the correct behavior is what we had assumed, then to
implement
>> that we call usb_remove_hcd from the PCMCIA client driver. Is this
the
>> correct way to do so?=20

> No.  The PCMCIA client driver should not make any assumptions about
its=20
> clients.  All it should do is check that all the clients have been=20
> suspended already before allowing itself to be suspended.

First of all, is there any way to check the state of all the clients
from inside the PCMCIA client driver? Please suggest.
Secondly, what should we do in the PCMCIA client driver if the check
fails? Here point to be noted is, as already mentioned, the PCMCIA
socket will be powered off.

>> The reason for the question is it can happen that after suspending
the
>> card, before resume card may be manually removed. In that case, there
is
>> a possibility of usb_remove_hcd being called twice consecutively
which
>> can cause error.
>> Please suggest if any better way of implementing the above.

> The PCMCIA client driver should not call usb_remove_hcd at all.  Only
a
> USB host controller driver is allowed to call that routine.

Actually we are not calling usb_remove_hcd directly. We are implementing
the HCD module and there we have a function which is exported. From
PCMCIA client driver we call this function, which in turn calls
usb_remove_hcd.
I am not sure whether this will be ok or not.

Thank you,
With regards,
Kaustav=20

> Alan Stern



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
