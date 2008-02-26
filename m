From: David Brownell <david-b@pacbell.net>
Subject: Re: Fundamental flaw in system suspend,
	exposed by freezer removal
Date: Mon, 25 Feb 2008 23:13:23 -0800
Message-ID: <200802252313.23399.david-b__31042.6101707437$1204010195$gmane$org@pacbell.net>
References: <Pine.LNX.4.44L0.0802251439030.5536-100000@iolanthe.rowland.org>
	<200802252325.09439.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200802252325.09439.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.linux-foundation.org, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

This "flaw" isn't a new thing, of course.  I remember pointing out the rath=
er
annoying proclivity of the PM framework to deadlock when suspend() tried to
remove USB devices ... back around 2.6.10 or so.  Things have shuffled arou=
nd
a bit, and gotten better in some cases, but not fundamentally changed.

It may be more accurate to say that now we understand some constraints on
device tree management policies ... ones we had previously assumed should
not be issues.  (But AFAICT, without actually considering the question.
Now we know the right question to ask!)


On Monday 25 February 2008, Rafael J. Wysocki wrote:
> IMO the device driver should assure that no new children will be register=
ed
> concurrently with the ->suspend() method (IOW, ->suspend() should wait for
> all such registrations to complete and should prevent any new ones from
> being started) and it should make it impossible to register any new child=
ren
> after ->suspend() has run. =A0It's the driver's problem how to achieve th=
at.

There's also the case where it's framework code that handles the additions
rather than the parent device.  That would be typical for many bridge, hub,
or adapter type drivers ... you may be thinking mostly about drivers acting
as "leaf" nodes in the device tree, at least in terms of real hardware node=
s.

Yes, "require that policy from such framework code too".  Just trying to be
sure the description doesn't have gaping holes in the middle.  :)

I can think of a bunch of serial busses where framework code has that sort
of responsiblity.  USB, SPI, I2C ... "legacy" I2C drivers would all need
to be taught not to create/remove children during those intervals, lacking
"new style" conversion (which makes them work more like normal drivers).

- Dave
