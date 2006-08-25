From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: So, what's the status on the recent patches here?
Date: Fri, 25 Aug 2006 16:34:27 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0608251627460.3307-100000@netrider.rowland.org>
References: <EA12F909C0431D458B9D18A176BEE4A5074D04EE@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <EA12F909C0431D458B9D18A176BEE4A5074D04EE@dlee02.ent.ti.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Fri, 25 Aug 2006, Woodruff, Richard wrote:

> There are two sides to this in the case for the embedded processor I'm
> using.
> =

> -A- you have to put the USB bus into suspend mode.
> 	- This will lower the throughput of the device on the other end.

?  Wouldn't suspending the entire bus completely stop the throughput of =

any attached device?

> The frequency of entering this state should not interfere with my active
> use case.
> =

> -B- After I've put down the USB device, I now can program the internal
> SOC bus wrapper for the USB to allow idling of the interconnect.  I also
> need to associate the USB remote wake interrupt with a wake up interrupt
> to restart my interconnect.  All devices on that interconnect must be in
> the same state for the big savings to happen.
> =

> Certainly for this embedded system, not coordinating the device states
> means I can't get the big power savings.

Part of this programming has to be done in the architecture-specific
driver for the interconnect.  There already is code being developed to
suspend USB buses when they aren't in use (although determining _when_
they aren't in use has not yet been implemented).  However this code stops
at the level of the USB controller.  Further development is being stymied
by lack of information about how to detect the controller's wake-up events
on regular desktop systems; it's possible someone might implement this
first on an embedded platform.

But this doesn't require any over-reaching global coordination.  All it =

needs is for each driver to know when it's not being used.

Alan Stern
