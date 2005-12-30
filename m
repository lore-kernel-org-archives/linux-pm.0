From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: Hotplug events during sleep transition
Date: Fri, 30 Dec 2005 14:21:47 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0512301412220.32015-100000@netrider.rowland.org>
References: <Pine.LNX.4.50.0512301031490.2506-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============25891306241258816=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.50.0512301031490.2506-100000@monsoon.he.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============25891306241258816==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Fri, 30 Dec 2005, Patrick Mochel wrote:

> > > Would it be possible to simply mark the device as 'removed' and ignore it
> > > until we resumed, and then clean it up (hotplug events and everything)?
> >
> > Internally that's what the USB core does do.  When we know that a device
> > has gone away during a sleep transition (generally because the USB host
> > controller has lost power while it was suspended), the device structure is
> > marked with USB_STATE_NOTATTACHED.  All future I/O operations to it will
> > fail, future resume requests will return 0 without actually doing
> > anything, and future suspend requests will fail.  When the khubd thread is
> > eventually unfrozen, it goes through the device unregistration procedure.
> 
> Ah, perfect. So, it actually scans the USB device lists on resume? I
> thought it relied on a notification via an interrupt?

Khubd does not exactly scan device lists on resume.  What happens is that
we set a bit in the device's parent hub's private data structure,
indicating that there was a connect-change on the device's port, and we
put the data structure on a list of hubs needing attention.  Khubd
continually scans this hub-event list whenever it isn't asleep, so it sees
that the device has been disconnected as soon as it gets unfrozen.

In normal operation khubd operates not so much by interrupts as by polling
hubs.  (The polling is set up once and then handled automatically by the
USB host controller hardware.)  However for managing root hubs we do use
either timer-driven polling or interrupt-driven notifications -- some host
controller drivers use one, some use the other.

Alan Stern


--===============25891306241258816==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============25891306241258816==--
