From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: question on freeze and aio
Date: Thu, 15 Feb 2007 00:40:41 +0100
Message-ID: <200702150040.42370.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0702131557400.2741-100000@iolanthe.rowland.org>
	<200702142228.46543.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200702142228.46543.rjw@sisk.pl>
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
Cc: Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 14 February 2007 22:28, Rafael J. Wysocki wrote:
> On Tuesday, 13 February 2007 22:01, Alan Stern wrote:
> > On Tue, 13 Feb 2007, Pavel Machek wrote:
> > =

> > > > No, workqueues are not frozen unless they are explicitly declared as
> > > > freezeable.  Which currently is only done by XFS, AFAIKS.
> > > =

> > > Ok, then we have a bug in swsusp. Can someone locate _which_ workqueue
> > > is used for aio... and make it freezeable?
> > =

> > Here is an untested patch.  Does anybody have a way to test it?
> =

> I'll give it a run on my test system.

Unfortunately, it seems to break the suspend.

The system doesn't suspend, but enters an endless loop right after the free=
zing
of consoles.

I'll have to debug it a bit more on a machine with a serial console, but not
today.

Well, it looks like there's something we didn't know about. :-)

Greetings,
Rafael
