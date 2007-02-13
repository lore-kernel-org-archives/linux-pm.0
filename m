From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: question on freeze and aio
Date: Tue, 13 Feb 2007 16:53:15 +0100
Message-ID: <200702131653.15744.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0702091700450.4557-100000@iolanthe.rowland.org>
	<200702092309.11530.rjw@sisk.pl>
	<20070213101859.GD12996@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20070213101859.GD12996@elf.ucw.cz>
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
To: Pavel Machek <pavel@suse.cz>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, 13 February 2007 11:18, Pavel Machek wrote:
> Hi!
> =

> > > > > can there be running aio requests if all tasks are frozen?
> > > > =

> > > > Since tasks are frozen, no new aio requests would be submitted. We =
do a
> > > > sync to ssek to complete existing requests; I haven't looked to see
> > > > whether that would need extending to flush aio as well, but don't t=
hink
> > > > that would be the case. Given everyone else's silence, so far, you =
might
> > > > be better to ask the author(s) of the aio code.
> > > =

> > > I believe Nigel is basically correct.  However sync will only flush a=
io =

> > > for block devices.  Other types of aio will remain active.
> > > =

> > > aio callbacks are interrupt-driven and execute in a workqueue (see
> > > fs/aio.c), and as far as I can tell that workqueue doesn't freeze.  =

> > > Unless some general facility freezes all workqueues...
> > =

> > No, workqueues are not frozen unless they are explicitly declared as
> > freezeable.  Which currently is only done by XFS, AFAIKS.
> =

> Ok, then we have a bug in swsusp. Can someone locate _which_ workqueue
> is used for aio... and make it freezeable?

Hm, so AIO is not needed for saving the image regardless of the system
configuration?

Rafael
