From: Daniel Drake <dsd@laptop.org>
Subject: Re: [PATCH v2] Input: enable i8042-level wakeup control
Date: Mon, 11 Jul 2011 14:22:22 +0100
Message-ID: <CAGq3pz5D=qDyfodEB2ikNsP0V94nTKNJ8-jyrb7=irH571bUPA__36433.6932813332$1310390661$gmane$org@mail.gmail.com>
References: <20110709211321.5FE139D401C@zog.reactivated.net>
	<201107102300.14064.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201107102300.14064.rjw@sisk.pl>
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
Cc: dilinger@queued.net, dtor@mail.ru, linux-pm@lists.linux-foundation.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Rafael, many thanks for looking at this.

2011/7/10 Rafael J. Wysocki <rjw@sisk.pl>:
>> @@ -1602,6 +1611,15 @@ static int input_dev_resume(struct device *dev)
>> =A0{
>> =A0 =A0 =A0 struct input_dev *input_dev =3D to_input_dev(dev);
>>
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* If this device is a child of serio, which is a child of i=
8042, and
>> + =A0 =A0 =A0* i8042 wakeup is enabled (i.e. this input device was not s=
uspended),
>> + =A0 =A0 =A0* do nothing.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (dev->parent && dev->parent->parent
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && device_may_wakeup(dev->pare=
nt->parent))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
>
> You check exactly the same condition in two places with very similar comm=
ents.
> I'd put it into a bool function and add a kerneldoc description to it ins=
tead.

OK, I agree. I was hoping that you'd be able to point out a better way
of doing this though - I think you'd agree that this code is not very
nice. But maybe explaining it better and hiding it away in its own
function is the best approach we have.

It is a strange case, because the device hierarchy is as follows:

i8042 -> serio -> input

Yet the kernel sees the i8042 and input devices as somewhat
independent devices on different busses, so each one has its own
independent suspend/resume implementation called from the PM layer.
And in this particular case, I need to make the i8042 controller
communicate the fact that its grandchild input device should not be
suspended or reset.

> The fact that you need provide several empty definitions of
> i8042_platform_suspend() is a bit worrisome. =A0Have you considered using=
 a
> different approach?

This seems quite the norm in i8042-land - those .h files already
include a number of empty functions that were presumably added just
because a small selection of the other supported arches needed to do
something. Nevertheless I'd be happy to convert these drivers to a new
"struct i8042_platform_ops" type system if that helps with the merge
of this patch.

Thanks,
Daniel
