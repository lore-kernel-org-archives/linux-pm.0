From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4 1/2] Input: enable i8042-level wakeup
	control
Date: Wed, 3 Aug 2011 11:43:32 -0700
Message-ID: <20110803184332.GA17880__14733.921227935$1312397071$gmane$org@core.coreip.homeip.net>
References: <20110802154916.624619D401C@zog.reactivated.net>
	<20110803065920.GC23399@core.coreip.homeip.net>
	<CAMLZHHTTXvThE5bWfyjJu-UFJbaKAhzORKWV8ay4RZW-ZVifLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAMLZHHTTXvThE5bWfyjJu-UFJbaKAhzORKWV8ay4RZW-ZVifLg@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-pm@lists.linux-foundation.org, dilinger@queued.net, linux-input@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 03, 2011 at 09:04:56AM +0100, Daniel Drake wrote:
> On Wed, Aug 3, 2011 at 7:59 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > I am not sure that we should be marking input devices themselves as
> > wakeup capable - they are in no way physical devices. I'd stop at serio
> > level...
> =

> We need a way to make sure the device state is untouched during
> suspend/resume. Would you be happier if an input device looked at the
> device_may_wakeup() of its parent?

I think we should leave input core out of it completely, see below...

> =

> >>
> >> diff --git a/drivers/input/input.c b/drivers/input/input.c
> >> index da38d97..639aba7 100644
> >> --- a/drivers/input/input.c
> >> +++ b/drivers/input/input.c
> >> @@ -1588,6 +1588,9 @@ static int input_dev_suspend(struct device *dev)
> >> =A0{
> >> =A0 =A0 =A0 struct input_dev *input_dev =3D to_input_dev(dev);
> >>
> >> + =A0 =A0 if (device_may_wakeup(dev))
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> >> +
> >
> > On suspend should we not try to shut off leds and sound?
> =

> Thats right. The setup is that the system appears to be running as
> normal, our display also remains on during suspend (and wifi, and so
> on). Bar the laptop's power LED which goes from always-on to flashing,
> the user is unaware that the laptop has suspended.

No, I do not believe we can do what you are doing in input core. You are
changing behavior for one platform and one (or 2 drivers) that will not
be matched (at least I don't think so) by anything else out there. What
will happen if you plug a random USB keyboard into OLPC box? Will it keep
leds powered?

> =

> >> =A0 =A0 =A0 mutex_lock(&input_dev->mutex);
> >>
> >> =A0 =A0 =A0 if (input_dev->users)
> >> @@ -1602,7 +1605,8 @@ static int input_dev_resume(struct device *dev)
> >> =A0{
> >> =A0 =A0 =A0 struct input_dev *input_dev =3D to_input_dev(dev);
> >>
> >> - =A0 =A0 input_reset_device(input_dev);
> >> + =A0 =A0 if (!device_may_wakeup(dev))
> >> + =A0 =A0 =A0 =A0 =A0 =A0 input_reset_device(input_dev);
> >>
> >
> > Does the controller wakes up the system on key release or only press? My
> > concern is with cases when we suspend with a key pressed and wake up
> > with it already released.
> =

> It wakes up on key press, but our EC buffers communication, so both
> the key press and key release event would be delivered in the above
> scenario.

Just to confirm, we 3 events will be delivered in this case:

1 - old key release
2 - wakeup key press
3 - wakeup key release

?

I also wonder what will happen with non-PS2 devices...

Instead of wiring it all through input core could we contain this in
atkbd and hgpk by registering pm_notifiers and ignoring certain requests
from input/serio cores during system state transition on OLPC only?

-- =

Dmitry
