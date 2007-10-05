From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] Fwd: USB suspending
Date: Fri, 5 Oct 2007 11:25:11 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0710051117560.4446-100000__23133.0525748946$1191597994$gmane$org@iolanthe.rowland.org>
References: <200710051559.43771.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200710051559.43771.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: pm list <linux-pm@lists.linux-foundation.org>, linux-usb-devel@lists.sourceforge.net, Lukas Hejtmanek <xhejtman@ics.muni.cz>
List-Id: linux-pm@vger.kernel.org

On Fri, 5 Oct 2007, Oliver Neukum wrote:

> Am Freitag 05 Oktober 2007 schrieb Rafael J. Wysocki:
> > Hi,
> > 
> > Below is a Lukas' question related to USB suspend that I'm not able to answer.
> > 
> > Please help!
> > 
> > Greetings,
> > Rafael
> > 
> > 
> > ----------  Forwarded Message  ----------
> > 
> > Subject: USB suspending
> > Date: Friday, 5 October 2007 14:54
> > From: Lukas Hejtmanek <xhejtman@ics.muni.cz>
> > To: "Rafael J. Wysocki" <rjw@sisk.pl>
> > 
> > Hello,
> > 
> > I've noticed that while suspended in RAM USB ports are powered so any device
> > connected to the port gets power. Can I turn off power of all USBs ports while
> > suspending to RAM?
> 
> If you do that all devices on these ports will be disconnected.
> If you still insist on doing so, it is done by a USB control request.

No it isn't.  In fact, I think it can't be done at all.  For example,
many USB controllers don't support PCI power management.  None of the
controllers on regular desktop and laptop machines support port-power
switching.

> But power consumption on these ports is minimal for suspended devices,
> so it is a bad idea.

Right.  Power consumption is even smaller on ports with no devices 
plugged in.

Alan Stern
