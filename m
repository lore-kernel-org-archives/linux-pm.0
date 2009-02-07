From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 02/13] PM: Add early suspend api.
Date: Sat, 7 Feb 2009 15:34:55 -0800
Message-ID: <d6200be20902071534j711d7c36x49180b6af9739c0b@mail.gmail.com>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<1233802226-23386-2-git-send-email-arve@android.com>
	<1233802226-23386-3-git-send-email-arve@android.com>
	<200902072153.30076.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902072153.30076.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ncunningham@crca.org.au, u.luckas@road.de, swetland@google.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sat, Feb 7, 2009 at 12:53 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> +The early-suspend api allows drivers to get notified when user-space wr=
ites to
>> +/sys/power/request_state to indicate that the user visible sleep state =
should
>> +change. A level controls what order the handlers are called in. Suspend
>> +handlers are called in low to high level order, resume handlers are cal=
led in
>> +the opposite order.
>
> I don't really understand this description, sorry.
>
> In particular, what values can be written to /sys/power/request_state, wh=
at
> their meaning is and what's supposed to happen if someone writes one of t=
hese
> values to this file?

Is it clearer if I change it to:

The early-suspend api allows drivers to get notified when user-space writes=
 a
sleep state, e.g. "mem", or "on" to /sys/power/request_state to indicate th=
at
the user visible sleep state should change. ...

>
>> +
>> +Four levels are defined:
>> +EARLY_SUSPEND_LEVEL_BLANK_SCREEN:
>> +  On suspend the screen should be turned off but the framebuffer must s=
till be
>> +  accessible. On resume the screen can be turned back on.
>
> What exactly is the meaning of "suspend" here?

early-suspend.

>> +EARLY_SUSPEND_LEVEL_STOP_DRAWING:
>> +  On suspend this level notifies user-space that it should stop accessi=
ng the
>> +  framebuffer and it waits for it to complete. On resume it notifies us=
er-space
>> +  that it should resume screen access.
>> +  Two methods are provided, console switch or a sysfs interface.
>
> How exactly is the notification supposed to happen?

Console switch or a blocking sysfs read.

>> +EARLY_SUSPEND_LEVEL_DISABLE_FB:
>> +  Turn off the framebuffer on suspend and back on on resume.
>> +
>> +EARLY_SUSPEND_LEVEL_STOP_INPUT:
>> +  On suspend turn off input devices that are not capable of wakeup or w=
here
>> +  wakeup is disabled. On resume turn the same devices back on.
>
> This always happens during suspend-resume.  How is this different from the
> usual suspend-resume behaviour?

It happens when user-space changes the state, before wakelocks are released.

>> +struct early_suspend {
>> +#ifdef CONFIG_HAS_EARLYSUSPEND
>> +     struct list_head link;
>> +     int level;
>> +     void (*suspend)(struct early_suspend *h);
>> +     void (*resume)(struct early_suspend *h);
>> +#endif
>> +};
>
> Does this mean addional suspend-resume callbacks for device drivers?

Yes.

> If so, how are they different from the "standard" suspend-resume callback=
s?

They are called at a different time.

> Also, what about bus types that carry out some suspend-resume operations
> for their devices, like PCI?  Your early callbacks don't seem to take the
> bus type part into account.

No, the driver will have to take care of this. It has to do the same
work as it would do if it got and ioctl command to enter a low power
state.

> My understanding of the 'early suspend' idea is that it is a mechanism al=
lowing
> us to place some devices selectively into low power states before the act=
ual
> suspend happens.  However, this is exactly the same as runtime power
> management on demand, with an interface allowing user space to put device=
s into
> low power states.

The main point is to have a single entrypoint from user-space. We do
not have a list of devices to suspend in user-space.

> Now, in my opinion, runtime power management should be implemented on the
> bus type level, since bus types differ from each other by power management
> requirements, mechanisms that can be used and hardware interfaces.
>
> I have some prototype patches for PCI runtime PM in the works.  I didn't
> intend to post them just yet, since I'm considering them as work in progr=
ess.
> Still, I can do that if you think it would be useful.

We don't have a PCI bus, but a generic mechanism to put individual
devices to sleep, from within the kernel or from user-space, would be
useful.

-- =

Arve Hj=F8nnev=E5g
