From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: RFC -- updated Documentation/power/devices.txt
Date: Sun, 23 Jul 2006 09:03:17 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0607230843160.31932-100000@netrider.rowland.org>
References: <200607231250.33839.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200607231250.33839.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Sun, 23 Jul 2006, Rafael J. Wysocki wrote:

> On Sunday 23 July 2006 05:59, Alan Stern wrote:
> > On Sat, 22 Jul 2006, David Brownell wrote:
> ]--snip--[
> > Some simple questions may help start the ball rolling.  During a system
> > resume, should all devices be powered on full,
> =

> IMHO that would be wasteful.
> =

> > or should they be restored to the state they were in before the suspend?
> > Or should there be a third possibility -- maybe some devices always on,
> > others the way they were?
> =

> I think the devices that were on before the suspend should stay on, becau=
se
> that's what the user will expect to happen.  For the same reason the devi=
ces
> that had been switched off explicitly ("by the user") before the suspend
> should stay off.  For the others, the rule of thumb may be "off".

To put it another way: Devices that were ON get restored to ON, and
devices that were OFF (either because the user turned them off explicitly
or because the driver decided to do its own runtime power management) =

get restored to OFF.  In other words, devices get restored to the state =

they were in before suspend.

I don't see anything wrong with that.  It does raise some more questions.

	Who should be responsible for remembering the device's state
	from before the system suspend: the PM core or the driver?
	(Note that the driver has a better idea of what that state
	actually was.)

	Upon resuming from a system suspend, is it better to tell the
	driver to "go directly to the saved state" or to turn the
	device back fully ON and then change to the saved state (if it =

	wasn't fully ON before the system suspend)?

Alan Stern
