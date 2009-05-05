From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Mon, 4 May 2009 20:48:09 -0700
Message-ID: <d6200be20905042048h4582e155sb2640e741a67eab6@mail.gmail.com>
References: <1239759692-28617-1-git-send-email-arve@android.com>
	<200904300034.09837.rjw@sisk.pl>
	<d6200be20904291749v55f5e425jcbb570c09a3901d1@mail.gmail.com>
	<200905021414.32565.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200905021414.32565.rjw@sisk.pl>
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

2009/5/2 Rafael J. Wysocki <rjw@sisk.pl>:
> [--snip--]
>> >
>> >> +
>> >> +retry:
>> >> + =A0 =A0 if (suspend_is_blocked()) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (debug_mask & DEBUG_SUSPEND)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info("suspend: abort sus=
pend\n");
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto abort;
>> >
>> > If that were in a loop you could just use 'break' here.
>>
>> do you think this is better:
>> while(1) {
>> =A0 =A0 =A0 =A0 if (exception1) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ...
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 ...
>> =A0 =A0 =A0 =A0 if (exception2) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ...
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>> =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 break;
>> }
>
> I rather thought of
>
> for (;;) {
> =A0 =A0 =A0 =A0 if (exception1) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ...
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 ...
> =A0 =A0 =A0 =A0 if (!exception2)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> =A0 =A0 =A0 =A0 ...
> }

I don't think that is much better, but I changed the first patch to
use a loop anyway. The loop is then removed (as before) in the patch
that adds the stats.

>
> [--snip--]
>> >> +static int suspend_block_suspend(struct sys_device *dev, pm_message_=
t state)
>> >> +{
>> >> + =A0 =A0 int ret =3D suspend_is_blocked() ? -EAGAIN : 0;
>> >> + =A0 =A0 if (debug_mask & DEBUG_SUSPEND)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 pr_info("suspend_block_suspend return %d\n"=
, ret);
>> >> + =A0 =A0 return ret;
>> >> +}
>> >> +
>> >> +static struct sysdev_class suspend_block_sysclass =3D {
>> >> + =A0 =A0 .name =3D "suspend_block",
>> >> + =A0 =A0 .suspend =3D suspend_block_suspend,
>> >> +};
>> >> +static struct sys_device suspend_block_sysdev =3D {
>> >> + =A0 =A0 .cls =3D &suspend_block_sysclass,
>> >> +};
>> >> +
>> >
>> > Hmm. =A0Perhaps add the suspend_is_blocked() check at the beginning of
>> > sysdev_suspend() instead of this? =A0Surely you don't want to suspend
>> > any sysdevs with any suspend blockers active, right?
>>
>> You could make the same argument for any device. Using a sysdev makes
>> the patch easier to apply.
>
> You've lost me here. :-)

You have been making other changes to those files which made it a moving ta=
rget.

> AFAICT, the only purpose of the sysdev class above is to abort suspend if
> suspend_is_blocked() returns 'true'. =A0If that is correct, then IMO you =
could
> achieve the same goal by calling suspend_is_blocked() directly from
> sysdev_suspend(), right before check_wakeup_irqs(). =A0Or am I missing an=
ything?

The stats patch also used it to track wakeup events, but I have added
another call for this to get rid of the sysdev.

-- =

Arve Hj=F8nnev=E5g
