From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: Ottawa
Date: Sun, 13 Mar 2005 20:28:49 -0800
Message-ID: <200503132028.49339.david-b@pacbell.net>
References: <F7DC2337C7631D4386A2DF6E8FB22B3002F2271A@hdsmsx401.amr.corp.intel.com>
	<1110587382.5752.144.camel@gaston>
	<1110589712.12485.262.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============92453661517275032=="
In-Reply-To: <1110589712.12485.262.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Cc: Adam Belay <abelay-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============92453661517275032==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 11 March 2005 5:08 pm, Adam Belay wrote:
> 
> Under the topic of dynamic power management, there are a few logical
> divisions of interest:
> 
> 1.) Low-level - providing the bus support and facilities for higher
> level power management (ex. the current work I'm doing with the PCI bus
> driver).  Also support for power domains might fall under this category.
> 
> 2.) Driver state and driver relationships - logical vs. physical, driver
> API, threading power management to transition multiple devices at once,
> etc

Clock management.  ARM (and other) SOC based boards commonly have
schemes to gate clocks off when the peripheral in question is unused,
thereby saving power.  <asm-arm/hardware/clock.h> has an API used to
explicitly represent the clock tree.

So a common mode of operation with such systems will be to keep
the peripheral unclocked (saving power) until it's needed.  I don't
actually see any reason to routinely plan policy options there,
that'd just be pointless extra work.  clk_use() when the device
is active, clk_unuse() otherwise.  And in some cases "suspended"
will mean "unused" for at least some clocks.

That's sort of a "low level" category ... except that it pops up to
higher level concerns.  For example, clocks may be shared (which can
make the "low level" vs "driver state and relationships" distinctions
look nonexistent), and they may interact with system power transitions. 

Plus there are interactions with external devices.  For example, some
SOCs can enter various deep sleep states when USB is either suspended
(by the host) or disconnected ... but not all.  (And some could do it
given external transceiver support...)  So there may be a choice between
entering a deeper sleep, or discarding active device state...


> 3.) Power Management Policy - determining which behavior to take for
> various classes of devices, how to determine idleness etc., and how to
> control/monitor those devices.

The primary mechanism I've heard discussed is having devices monitor
when they haven't been used recently, and using that to enter some
suspend level.  The "not even active" clock gating approach isn't
quite the same.

 
> 4.) Userspace - how to notify of power changes, how to allow the user to
> control power management.
> 
> Anything else?

Oh, and wakeup event sources.  ACPI has a very indirect approach,
which seems to underlay some assumptions on this list.  There's a
similar thing going on with PCI.  So for example when folk start
to assume that a "wakeup" event is for some reason distinct from
the device's normal IRQ, I must cringe ... anyone assuming that
device or system suspend involves turning off IRQs is erecting
roadblocks against most embedded hardware.

- Dave


--===============92453661517275032==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============92453661517275032==--
