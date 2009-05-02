From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Sat, 2 May 2009 14:14:31 +0200
Message-ID: <200905021414.32565.rjw@sisk.pl>
References: <1239759692-28617-1-git-send-email-arve@android.com>
	<200904300034.09837.rjw@sisk.pl>
	<d6200be20904291749v55f5e425jcbb570c09a3901d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <d6200be20904291749v55f5e425jcbb570c09a3901d1@mail.gmail.com>
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

On Thursday 30 April 2009, Arve Hj=F8nnev=E5g wrote:
> 2009/4/29 Rafael J. Wysocki <rjw@sisk.pl>:
> > On Wednesday 15 April 2009, Arve Hj=F8nnev=E5g wrote:
> >> diff --git a/include/linux/suspend_block.h b/include/linux/suspend_blo=
ck.h
> >> new file mode 100755
> >> index 0000000..7820c60
> >> --- /dev/null
> >> +++ b/include/linux/suspend_block.h
> >
> > suspend_blockers.h perhaps?
> =

> suspend_blocker.h?

Fine by me.

[--snip--]
> >> +config SUSPEND_BLOCK
> >> +     bool "Suspend block"
> >> +     depends on PM
> >> +     select RTC_LIB
> >
> > depends on RTC_LIB
> >
> > select doesn't really work and I don't think it ever will.
> =

> Nothing depends on RTC_LIB, it is only selected.

If nothing in your code needs anything depending on RTC_LIB, why select it?

[--snip--]
> >
> >> +
> >> +retry:
> >> +     if (suspend_is_blocked()) {
> >> +             if (debug_mask & DEBUG_SUSPEND)
> >> +                     pr_info("suspend: abort suspend\n");
> >> +             goto abort;
> >
> > If that were in a loop you could just use 'break' here.
> =

> do you think this is better:
> while(1) {
>         if (exception1) {
>                 ...
>                 break;
>         }
>         ...
>         if (exception2) {
>                 ...
>                 continue;
>         }
>         break;
> }

I rather thought of

for (;;) {
         if (exception1) {
                 ...
                 break;
         }
         ...
         if (!exception2)
                 break;
         ...
}

[--snip--]
> >> +static int suspend_block_suspend(struct sys_device *dev, pm_message_t=
 state)
> >> +{
> >> +     int ret =3D suspend_is_blocked() ? -EAGAIN : 0;
> >> +     if (debug_mask & DEBUG_SUSPEND)
> >> +             pr_info("suspend_block_suspend return %d\n", ret);
> >> +     return ret;
> >> +}
> >> +
> >> +static struct sysdev_class suspend_block_sysclass =3D {
> >> +     .name =3D "suspend_block",
> >> +     .suspend =3D suspend_block_suspend,
> >> +};
> >> +static struct sys_device suspend_block_sysdev =3D {
> >> +     .cls =3D &suspend_block_sysclass,
> >> +};
> >> +
> >
> > Hmm.  Perhaps add the suspend_is_blocked() check at the beginning of
> > sysdev_suspend() instead of this?  Surely you don't want to suspend
> > any sysdevs with any suspend blockers active, right?
> =

> You could make the same argument for any device. Using a sysdev makes
> the patch easier to apply.

You've lost me here. :-)

AFAICT, the only purpose of the sysdev class above is to abort suspend if
suspend_is_blocked() returns 'true'.  If that is correct, then IMO you could
achieve the same goal by calling suspend_is_blocked() directly from
sysdev_suspend(), right before check_wakeup_irqs().  Or am I missing anythi=
ng?

Thanks,
Rafael
