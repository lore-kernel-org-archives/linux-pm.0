From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 02/13] PM: Add early suspend api.
Date: Mon, 9 Feb 2009 00:59:47 +0100
Message-ID: <200902090059.48563.rjw@sisk.pl>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<200902072153.30076.rjw@sisk.pl>
	<d6200be20902071534j711d7c36x49180b6af9739c0b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <d6200be20902071534j711d7c36x49180b6af9739c0b@mail.gmail.com>
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
To: Arve =?iso-8859-1?q?Hj=F8nnev=E5g?= <arve@android.com>
Cc: ncunningham@crca.org.au, u.luckas@road.de, swetland@google.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sunday 08 February 2009, Arve Hj=F8nnev=E5g wrote:
> On Sat, Feb 7, 2009 at 12:53 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >> +The early-suspend api allows drivers to get notified when user-space =
writes to
> >> +/sys/power/request_state to indicate that the user visible sleep stat=
e should
> >> +change. A level controls what order the handlers are called in. Suspe=
nd
> >> +handlers are called in low to high level order, resume handlers are c=
alled in
> >> +the opposite order.
> >
> > I don't really understand this description, sorry.
> >
> > In particular, what values can be written to /sys/power/request_state, =
what
> > their meaning is and what's supposed to happen if someone writes one of=
 these
> > values to this file?
> =

> Is it clearer if I change it to:
> =

> The early-suspend api allows drivers to get notified when user-space writ=
es a
> sleep state, e.g. "mem", or "on" to /sys/power/request_state to indicate =
that
> the user visible sleep state should change. ...

So, how is it different from the "normal" suspend?  Do you want that to hap=
pen
before tasks are frozen?

> >
> >> +
> >> +Four levels are defined:
> >> +EARLY_SUSPEND_LEVEL_BLANK_SCREEN:
> >> +  On suspend the screen should be turned off but the framebuffer must=
 still be
> >> +  accessible. On resume the screen can be turned back on.
> >
> > What exactly is the meaning of "suspend" here?
> =

> early-suspend.

OK

How exactly are these levels going to be used?

> >> +EARLY_SUSPEND_LEVEL_STOP_DRAWING:
> >> +  On suspend this level notifies user-space that it should stop acces=
sing the
> >> +  framebuffer and it waits for it to complete. On resume it notifies =
user-space
> >> +  that it should resume screen access.
> >> +  Two methods are provided, console switch or a sysfs interface.
> >
> > How exactly is the notification supposed to happen?
> =

> Console switch or a blocking sysfs read.

Let's choose the console switch for example.  What would you like to happen
during early suspend on the EARLY_SUSPEND_LEVEL_STOP_DRAWING level?

> >> +EARLY_SUSPEND_LEVEL_DISABLE_FB:
> >> +  Turn off the framebuffer on suspend and back on on resume.
> >> +
> >> +EARLY_SUSPEND_LEVEL_STOP_INPUT:
> >> +  On suspend turn off input devices that are not capable of wakeup or=
 where
> >> +  wakeup is disabled. On resume turn the same devices back on.
> >
> > This always happens during suspend-resume.  How is this different from =
the
> > usual suspend-resume behaviour?
> =

> It happens when user-space changes the state, before wakelocks are releas=
ed.

Can you give an example, please?

> >> +struct early_suspend {
> >> +#ifdef CONFIG_HAS_EARLYSUSPEND
> >> +     struct list_head link;
> >> +     int level;
> >> +     void (*suspend)(struct early_suspend *h);
> >> +     void (*resume)(struct early_suspend *h);
> >> +#endif
> >> +};
> >
> > Does this mean addional suspend-resume callbacks for device drivers?
> =

> Yes.
> =

> > If so, how are they different from the "standard" suspend-resume callba=
cks?
> =

> They are called at a different time.

My question was about the functionality.  Are they supposed to be
_functionally_ different from the "standard" callbacks?

> > Also, what about bus types that carry out some suspend-resume operations
> > for their devices, like PCI?  Your early callbacks don't seem to take t=
he
> > bus type part into account.
> =

> No, the driver will have to take care of this. It has to do the same
> work as it would do if it got and ioctl command to enter a low power
> state.

Many drivers have no such ioctls.  Moreover, during "normal" suspend the
drivers' ->suspend() callbacks are not called directly by the PM core, but =
they
are called via the appropriate bus type driver's ->suspend() callback, so t=
he
bus type driver may perform additional operations before or after calling t=
he
driver's callback.  The PCI bus type driver actually does it.

> > My understanding of the 'early suspend' idea is that it is a mechanism =
allowing
> > us to place some devices selectively into low power states before the a=
ctual
> > suspend happens.  However, this is exactly the same as runtime power
> > management on demand, with an interface allowing user space to put devi=
ces into
> > low power states.
> =

> The main point is to have a single entrypoint from user-space. We do
> not have a list of devices to suspend in user-space.

We don't need such a list.  The devices may be suspended automatically by t=
he
kernel after a period of (device) inactivity, for example.

> > Now, in my opinion, runtime power management should be implemented on t=
he
> > bus type level, since bus types differ from each other by power managem=
ent
> > requirements, mechanisms that can be used and hardware interfaces.
> >
> > I have some prototype patches for PCI runtime PM in the works.  I didn't
> > intend to post them just yet, since I'm considering them as work in pro=
gress.
> > Still, I can do that if you think it would be useful.
> =

> We don't have a PCI bus, but a generic mechanism to put individual
> devices to sleep, from within the kernel or from user-space, would be
> useful.

The mechanism may not be 100% generic, because for different buses and
platforms there are different _hardware_ mechanisms for putting devices into
low power/full power states.  For example, PCI devices can generally be in
one of 4 different power states, while there are only 2 power states availa=
ble
to USB devices.  Also, on PCI you can put an entire BUS segment into a low
power state, etc.

Thanks,
Rafael
