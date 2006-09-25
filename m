From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: suspending to disk on FC6 not working
Date: Mon, 25 Sep 2006 22:15:19 +0200
Message-ID: <200609252215.19257.rjw@sisk.pl>
References: <1159138520.19021.11.camel@soncomputer>
	<200609252043.23219.rjw@sisk.pl>
	<1159212870.2520.5.camel@soncomputer>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1159212870.2520.5.camel@soncomputer>
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
To: Louis Garcia <louisg00@bellsouth.net>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Monday, 25 September 2006 21:34, Louis Garcia wrote:
> On Mon, 2006-09-25 at 20:43 +0200, Rafael J. Wysocki wrote:
> > On Monday, 25 September 2006 19:10, Louis Garcia wrote:
> > > On Mon, 2006-09-25 at 09:16 +0200, Rafael J. Wysocki wrote:
> > > > On Monday, 25 September 2006 00:55, Louis Garcia wrote:
> > > > > When I first installed FC6 test 2 suspend to disk worked on my bo=
x which
> > > > > is a Dell dimension 8200 (P4). During the kernel-2.6.17-xxx updat=
es this
> > > > > has stopped working. Now kernel-2.6.18 has come out and I'm havin=
g the
> > > > > same problems. I have tried to get this resolved on there mailing=
 list
> > > > > but it's not high on there things todo. I would like to debug sus=
pend to
> > > > > see what is happening. What is the proper way to do this? Has thi=
s been
> > > > > discussed before? Is there a separate mailing-list for suspend?
> > > > =

> > > > Generally you're not giving enough information to trace the problem.
> > > > =

> > > > First, what doesn't work, the suspend to disk or the resume?
> > > > =

> > > > Rafael
> > > > =

> > > > =

> > > =

> > > Suspend to disk does not work. When trying to suspend, from gnome, it
> > > goes normally. The power button blinks and then restarts. I'm back to
> > > the screensaver lock screen but the mouse and keyboard are dead.
> > =

> > Can you please try booting the kernel with init=3D/bin/bash, mount /pro=
c,
> > mount /sys, do "/sbin/swapon -a" and "echo disk > /sys/power/state"?
> > =

> > Rafael
> > =

> > =

> After the echo command the box turned off. The power button was not
> blinking. I restarted it and went into grub,

Did you append init=3D/bin/bash to the kernel command line after it had gone
into GRUB?

> linux booted into bash.

Had it been displaying a progress meter before the bash came up?

> When suspend was working the power button flashed and when I pressed it
> the box booted right into linux and the screensaver lock screen
> bypassing grub altogether.

That's because if you suspend "normally", some scripts run before the suspe=
nd
that change your GRUB configuration and use the "platform" suspend method.
However, the problem seems to be on much lower level and to debug it we need
to bypass these things.

Greetings,
Rafael


-- =

You never change things by fighting the existing reality.
		R. Buckminster Fuller
