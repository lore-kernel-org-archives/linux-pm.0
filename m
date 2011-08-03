From: Daniel Drake <dsd@laptop.org>
Subject: Re: [PATCH v4 1/2] Input: enable i8042-level wakeup
	control
Date: Wed, 3 Aug 2011 09:04:56 +0100
Message-ID: <CAMLZHHTTXvThE5bWfyjJu-UFJbaKAhzORKWV8ay4RZW-ZVifLg__32450.2890151509$1312358766$gmane$org@mail.gmail.com>
References: <20110802154916.624619D401C@zog.reactivated.net>
	<20110803065920.GC23399@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110803065920.GC23399@core.coreip.homeip.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, dilinger@queued.net, linux-input@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 3, 2011 at 7:59 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> I am not sure that we should be marking input devices themselves as
> wakeup capable - they are in no way physical devices. I'd stop at serio
> level...

We need a way to make sure the device state is untouched during
suspend/resume. Would you be happier if an input device looked at the
device_may_wakeup() of its parent?

>>
>> diff --git a/drivers/input/input.c b/drivers/input/input.c
>> index da38d97..639aba7 100644
>> --- a/drivers/input/input.c
>> +++ b/drivers/input/input.c
>> @@ -1588,6 +1588,9 @@ static int input_dev_suspend(struct device *dev)
>> =A0{
>> =A0 =A0 =A0 struct input_dev *input_dev =3D to_input_dev(dev);
>>
>> + =A0 =A0 if (device_may_wakeup(dev))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
>
> On suspend should we not try to shut off leds and sound?

Thats right. The setup is that the system appears to be running as
normal, our display also remains on during suspend (and wifi, and so
on). Bar the laptop's power LED which goes from always-on to flashing,
the user is unaware that the laptop has suspended.

>> =A0 =A0 =A0 mutex_lock(&input_dev->mutex);
>>
>> =A0 =A0 =A0 if (input_dev->users)
>> @@ -1602,7 +1605,8 @@ static int input_dev_resume(struct device *dev)
>> =A0{
>> =A0 =A0 =A0 struct input_dev *input_dev =3D to_input_dev(dev);
>>
>> - =A0 =A0 input_reset_device(input_dev);
>> + =A0 =A0 if (!device_may_wakeup(dev))
>> + =A0 =A0 =A0 =A0 =A0 =A0 input_reset_device(input_dev);
>>
>
> Does the controller wakes up the system on key release or only press? My
> concern is with cases when we suspend with a key pressed and wake up
> with it already released.

It wakes up on key press, but our EC buffers communication, so both
the key press and key release event would be delivered in the above
scenario.

>> @@ -87,6 +87,7 @@ MODULE_PARM_DESC(debug, "Turn i8042 debugging mode on =
and off");
>> =A0#endif
>>
>> =A0static bool i8042_bypass_aux_irq_test;
>> +static bool i8042_enable_wakeup;
>>
>> =A0#include "i8042.h"
>>
>> @@ -1082,10 +1083,17 @@ static void i8042_dritek_enable(void)
>> =A0 * before suspending.
>> =A0 */
>>
>> -static int i8042_controller_resume(bool force_reset)
>> +static int i8042_controller_resume(bool force_reset, bool soft_resume)
>> =A0{
>> =A0 =A0 =A0 int error;
>>
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* If device is selected as a wakeup source, it was not powe=
red down
>> + =A0 =A0 =A0* or reset during suspend, so we have very little to do.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (soft_resume)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto soft;
>
> Maybe instead of adding a parameter simply not call the function and
> move i8042_interrupt as well?

OK

>> =A0static int i8042_pm_resume(struct device *dev)
>> =A0{
>> =A0 =A0 =A0 /*
>> =A0 =A0 =A0 =A0* On resume from S2R we always try to reset the controller
>> =A0 =A0 =A0 =A0* to bring it in a sane state. (In case of S2D we expect
>> =A0 =A0 =A0 =A0* BIOS to reset the controller for us.)
>> + =A0 =A0 =A0* This function call will also handle any pending keypress =
event
>> + =A0 =A0 =A0* (perhaps the system wakeup reason)
>> + =A0 =A0 =A0*/
>> + =A0 =A0 int r =3D i8042_controller_resume(true, device_may_wakeup(dev)=
);
>> +
>> + =A0 =A0 /* If the device was left running during suspend, enable IRQs =
again
>> + =A0 =A0 =A0* now. Must be done last to avoid races with interrupt proc=
essing
>> + =A0 =A0 =A0* inside i8042_controller_resume.
>> =A0 =A0 =A0 =A0*/
>
> Hmm, we have proper locking so I am not sure how true this statement is.

What happens is that the event used to wake up the system is not
delivered as an interrupt (consistent with the fact that the resume
handler already calls i8042_interrupt() manually). However, there is a
race window. If the system was woken up with a key press, and then the
key was released during early resume, the key press event will not be
presented as an interrupt, but the key release event will. That
interrupt can arrive before i8042_controller_resume() reaches
i8042_interrupt(), which would result in those 2 events being
processed in the wrong order. I'll make this clearer in the comment.

Thanks for the fast review comments!
Daniel
