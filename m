From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re:
	=?iso-8859-1?q?=5BPATCH_2/2=5D_Fix_console_handling_du?=
	=?iso-8859-1?q?ring=09suspend/resume?=
Date: Sat, 24 Jun 2006 19:06:25 +0200
Message-ID: <200606241906.25125.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<Pine.LNX.4.64.0606232155160.6483@g5.osdl.org>
	<1151130644.10141.70.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1151130644.10141.70.camel@localhost.localdomain>
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
Cc: David Brownell <david-b@pacbell.net>, Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Saturday 24 June 2006 08:30, Benjamin Herrenschmidt wrote:
> On Fri, 2006-06-23 at 22:18 -0700, Linus Torvalds wrote:
[-- snip --]
> Well, console switch is generic way of dealing with X and other things
> that may use directfb etc... as long as they are sane enough to honor
> the console switch requests. So yes, in that sense, it's not a special
> case. Now, where the console switch however doesn't quite "fit" in the
> model at this point is that I don't think there is any relationship
> currently between the VT subsystem and the driver model. Thus there is
> no struct device/driver to attach a suspend_prepare and a resume_finish
> hook. I'm not sure where we would hook one... If you have fbdev's, we
> could have something on fbcon itself, though even how to do that isn't
> obvious in the details.
> =

> Any idea there ?

In ususpend we switch the console from the userland using some ioctls,
so we don't need pm_prepare/resume_console() (or any other in-kernel
mechanism) for that.

Greetings,
Rafael
