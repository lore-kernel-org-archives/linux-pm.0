From: Alan Stern <stern@rowland.harvard.edu>
Subject: RE: [linux-pm] Behavior of PCMCIA based HCD in the event of SUSPEND
Date: Tue, 18 Apr 2006 09:45:50 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0604180940070.4972-100000@iolanthe.rowland.org>
References: <05B7784238A51247A0A9FB4B348CECAE019BAAF3@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
In-Reply-To: <05B7784238A51247A0A9FB4B348CECAE019BAAF3@PNE-HJN-MBX01.wipro.com>
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

On Tue, 18 Apr 2006 kaustav.majumdar@wipro.com wrote:

> > The HCD's behavior should be to suspend the host controller, with the
> > understanding that factors beyond the HCD's control (such as the
> > behavior of the PCMCIA client driver) may cause the host controller to
> be
> > shut down entirely.  The HCD should not shut down the host controller
> > during a suspend event.
> 
> As per my understanding, the Host Controller can be suspended only if
> all the child devices are already suspended. If they are not then
> suspension of HC will fail.

That's right.

> Also the PCMCIA subsystem's behavior is to power off the socket
> irrespective of whether the PCMCIA client driver has successfully
> handled the SUSPEND event or not.

I don't know how the PCMCIA subsystem works.  If it behaves the way you 
described then it is broken and should be fixed.

> So if the child devices of HC are not suspended and PCMCIA subsystem
> will get a SUSPEND event (may be initiated by some user space tool
> through /sys) then there is a possibility of HC being in operational
> state (from driver perspective) but the PC Card itself not powered - a
> chaos I think.

I doubt it will cause chaos, although it might.  More likely the driver 
will just decide that the host controller has died.

> > No.  The PCMCIA client driver should not make any assumptions about
> its
> > clients.  All it should do is check that all the clients have been
> > suspended already before allowing itself to be suspended.
> 
> First of all, is there any way to check the state of all the clients
> from inside the PCMCIA client driver? Please suggest.

Since I don't know anything about how the PCMCIA subsystem or the client 
drivers work, I can't suggest anything specific.  The general approach is 
to go through the list of child devices and for each one, check the 
power state (it's embedded in the struct device).

> Secondly, what should we do in the PCMCIA client driver if the check
> fails? Here point to be noted is, as already mentioned, the PCMCIA
> socket will be powered off.

The client driver should fail the suspend call and the PCMCIA socket 
should remain powered on.

> > The PCMCIA client driver should not call usb_remove_hcd at all.  Only
> a
> > USB host controller driver is allowed to call that routine.
> 
> Actually we are not calling usb_remove_hcd directly. We are implementing
> the HCD module and there we have a function which is exported. From
> PCMCIA client driver we call this function, which in turn calls
> usb_remove_hcd.
> I am not sure whether this will be ok or not.

I suppose it might work, but it adds a bunch of extra code for no good 
reason.  You would be much better off directing your efforts toward fixing 
the PCMCIA socket driver.

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
