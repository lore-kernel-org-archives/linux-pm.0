From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Re: NAK new drivers without proper power
	management?
Date: Sat, 10 Feb 2007 10:34:03 +0100
Message-ID: <200702101034.04410.rjw@sisk.pl>
References: <fa.xSKPgY66Q+DPCZ1pszFFfdrJ0To@ifi.uio.no>
	<45CD24F6.8090107@shaw.ca>
	<1171076554.10170.5.camel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1171076554.10170.5.camel@nigel.suspend2.net>
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
To: nigel@nigel.suspend2.net
Cc: Robert Hancock <hancockr@shaw.ca>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Saturday, 10 February 2007 04:02, Nigel Cunningham wrote:
> Hi.
> =

> On Fri, 2007-02-09 at 19:50 -0600, Robert Hancock wrote:
> > It also kind of bothers me that if a driver has no suspend/resume =

> > functions, and you suspend and resume the system, we don't complain =

> > about it even though there's a very good chance that device is not goin=
g =

> > to function properly. How about something in dmesg like:
> > =

> > Warning: driver for device XXXX has no suspend or resume support.
> > Device may not function properly after resume.
> > =

> > so that users know who to complain to. Maybe there are some devices tha=
t =

> > truly don't need any handling for suspend, but if so I suspect the =

> > number of those is small enough that adding empty functions would be a =

> > good-enough solution.
> =

> Here's my current version of a patch to do this, if anyone wants to try
> it out. It dumps stack with the warning to make it easier to see what
> the source of the message is:

I have an alternative idea.

There is a test mode of swsusp that's triggered with
"echo test > /sys/power/disk" and "echo disk > /sys/power/state".  We can m=
ake
it set a switch that will be used to trigger the warnings in the core.

This way the warnings will only appear in the user's dmesg in the test mode
and not always.

Would that be acceptable?

Rafael
