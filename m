From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Linux 2.6.21-rc6
Date: Sun, 15 Apr 2007 17:52:59 +0200
Message-ID: <200704151753.00584.rjw@sisk.pl>
References: <Pine.LNX.4.64.0704051944230.6730@woody.linux-foundation.org>
	<200704151316.26136.rjw@sisk.pl>
	<200704151019.37074.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704151019.37074.dtor@insightbb.com>
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
To: Dmitry Torokhov <dtor@insightbb.com>, Tobias Diedrich <ranma+kernel@tdiedrich.de>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>
List-Id: linux-pm@vger.kernel.org

On Sunday, 15 April 2007 16:19, Dmitry Torokhov wrote:
> On Sunday 15 April 2007 07:16, Rafael J. Wysocki wrote:
> > On Sunday, 15 April 2007 10:02, Tobias Diedrich wrote:
> > =

> > > > With CONFIG_PM_DEBUG=3Dy and CONFIG_DISABLE_CONSOLE_SUSPEND=3Dy I s=
ee
> > > > that the second suspend hangs at "i8042 i8042: EARLY resume".
> > > > This is kinda interesting because I'm normally using a USB keyboard
> > > > and sure enough, if I hook up a normal keyboard and disable USB
> > > > legacy support in the BIOS, then suspend to disk works multiple
> > > > times. I'd still rather like to use my USB keyboard though. ;)
> > =

> > Well, I think that when you're using the USB keyboard and the USB legacy
> > support, the i8042 driver thinks it has a keyboard to handle and tries =
to
> > handle it during the suspend, which fails.  I don't know why it fails d=
uring
> > the second suspend, though.
> > =

> > Dmitry, could you please have a look?
> > =

> =

> This is wierd as i8042 does not use suspend_late/resume_early hooks and
> so it is impossible for it to hang there. None of input drivers use these
> hooks. Could it be that some other driver _after_ i8042 hangs?

Yes.

Tobias, can you please post the dmesg output from after a successful
suspend/resume cycle with CONFIG_PM_DEBUG=3Dy in the 'platform' mode?

> > > And I can now confirm that unpatched 2.6.21-rc6 works fine as long
> > > as USB legacy support is disabled (however without legacy support I
> > > can't use the USB keyboard to control grub).
> > =

> > I think using the 'shutdown' mode of suspend would be better.  There's =
a little
> > point in using 'platform' on desktop systems anyway.
> > =

> > Frankly, I don't know what to do about it.  If we move platform_finish(=
) after
> > device_resume(), some systems may be broken and I think there are more =
such
> > systems than there are systems that set USB legacy support in the BIOS =
and
> > have no PS/2 keyboards attached.
> =

> I would say that every box that does not use PS/2 keyboard does this.

Quite some people I know use USB keyboards with notebooks, but in these cas=
es
the PS/2 keyboard is still attached (except for notebooks in which the buil=
t-in
keyboard is a USB one, that is).

> IOW every box with USB keyboard has legacy emulation turned on so quite
> few of them...

I have such a machine nearby, so I'll see if I can reproduce the problem.

Greetings,
Rafael
