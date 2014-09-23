From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2 2/3] power: gpio-charger: add device tree support
Date: Tue, 23 Sep 2014 08:59:43 -0700
Message-ID: <CAD=FV=Wc-V6nYTSTPJe4mtyCvGH2CpOhOY37XDFQTP97hXOi_g@mail.gmail.com>
References: <1411329923-15912-1-git-send-email-heiko@sntech.de>
	<1411329923-15912-3-git-send-email-heiko@sntech.de>
	<CAD=FV=W6q7wMDWWDkwdC_KF4EHJt2q8afxSGCpPEC+Nk2Jp2Ag@mail.gmail.com>
	<1549304.qklrgkYl3q@phil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1549304.qklrgkYl3q@phil>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Cc: sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Heiko,

On Tue, Sep 23, 2014 at 5:03 AM, Heiko St=C3=BCbner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org> w=
rote:
> Am Montag, 22. September 2014, 09:48:33 schrieb Doug Anderson:
>> > @@ -196,6 +255,7 @@ static struct platform_driver gpio_charger_dri=
ver =3D {
>> >
>> >                 .name =3D "gpio-charger",
>> >                 .owner =3D THIS_MODULE,
>> >                 .pm =3D &gpio_charger_pm_ops,
>> >
>> > +               .of_match_table =3D of_match_ptr(gpio_charger_matc=
h),
>>
>> Given that you don't have any #ifdefs with "CONFIG_OF", I think
>> gpio_charger_match will always exist.  It seems like you should remo=
ve
>> the of_match_ptr or add some #ifdefs.  I can't quite keep up with wh=
at
>> the currently suggested best practice is here, though.
>
> I've kept the of_match_ptr in v3. The dt parsing functions (of_read_f=
oo,...)
> define stubs for the !CONFIG_OF case which we use here in this case a=
nd
> of_match_ptr is also defined differently for both OF and !OF, so it f=
eels like
> it should be there ;-)

=2E..I was thinking you'd get a compile-time warning about
gpio_charger_match not being used.  ...but I can't seem to trigger it
with my compiler settings.  In any case, I'm fairly certain that in
the !CONFIG_OF case (plus non-module case) that "gpio_charger_match"
will be defined but not used in your code.

I was under the impression that of_match_ptr was defined differently
for OF and !OF so that you could use it in the case where the
structure itself (gpio_charger_match) had #ifdefs around it...
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
