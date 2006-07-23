From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: RFC -- updated Documentation/power/devices.txt
Date: Sun, 23 Jul 2006 12:50:33 +0200
Message-ID: <200607231250.33839.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0607222334510.10239-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0607222334510.10239-100000@netrider.rowland.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
Cc: David Brownell <david-b@pacbell.net>
List-Id: linux-pm@vger.kernel.org

On Sunday 23 July 2006 05:59, Alan Stern wrote:
> On Sat, 22 Jul 2006, David Brownell wrote:
]--snip--[
> Some simple questions may help start the ball rolling.  During a system
> resume, should all devices be powered on full,

IMHO that would be wasteful.

> or should they be restored to the state they were in before the suspend?
> Or should there be a third possibility -- maybe some devices always on,
> others the way they were?

I think the devices that were on before the suspend should stay on, because
that's what the user will expect to happen.  For the same reason the devices
that had been switched off explicitly ("by the user") before the suspend
should stay off.  For the others, the rule of thumb may be "off".

> And who decides?  The driver?

I don't think the driver should decide.  It just may have too little
information to make a proper decision.

Greetings,
Rafael
