From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 12/47] mfd: ab8500-sysctrl: Register with kernel
 poweroff handler
Date: Mon, 27 Oct 2014 09:42:10 -0700
Message-ID: <20141027164210.GA11974@roeck-us.net>
References: <1413864783-3271-1-git-send-email-linux@roeck-us.net>
 <1413864783-3271-13-git-send-email-linux@roeck-us.net>
 <CACRpkdY8C3rCZsUGgoM+47bwepvPZwdwCv1NPsb0zk9WbHAKOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdY8C3rCZsUGgoM+47bwepvPZwdwCv1NPsb0zk9WbHAKOA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Oct 27, 2014 at 04:59:00PM +0100, Linus Walleij wrote:
> On Tue, Oct 21, 2014 at 6:12 AM, Guenter Roeck <linux@roeck-us.net> w=
rote:
>=20
> > Register with kernel poweroff handler instead of setting pm_power_o=
ff
> > directly. Register with low priority to reflect that the original c=
ode
> > only sets pm_power_off if it was not already set.
> >
> > sysctrl_dev is set prior to poweroff handler registration, and the
> > poweroff handler is unregistered prior to clearing sysrctrl_dev.
> > It is therefore not necessary to check if sysctrl_dev is NULL in th=
e
> > poweroff handler, and the check was removed. Setting sysctrl_dev to=
 NULL
> > in the remove function was also removed as unnecessary. With those =
changes,
> > devm_register_power_off_handler can be used to register the poeroff=
 handler.
> > The now empty remove function was retained since the ab8500_restart=
 function,
> > which is currently unused, would likely need some cleanup if it was=
 ever used.
> >
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: Samuel Ortiz <sameo@linux.intel.com>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> > v2:
> > - Use define to specify poweroff handler priority
> > - Use devm_register_power_off_handler
> > - Use dev_warn instead of dev_err
> > - Since we use devm_register_power_off_handler,
> >   we need to check if sysctrl_dev in the poweroff handler to avoid
> >   a race condition on unload, so this check is no longer removed
>=20
> I can't compile this, I guess because of a dependency on some
> other patch?
>=20
Hi Linus,

can you try v3 ? It has a number of improvements, and POWEROFF_PRIORITY=
_LOW
was replaced with POWER_OFF_PRIORITY_LOW. You will need patch 01/47 of =
the
series as well to get the definition.

>   CC      drivers/mfd/ab8500-sysctrl.o
> ../drivers/mfd/ab8500-sysctrl.c:94:14: error: =E2=80=98POWEROFF_PRIOR=
ITY_LOW=E2=80=99
> undeclared here (not in a function)
>   .priority =3D POWEROFF_PRIORITY_LOW,
>               ^
> ../drivers/mfd/ab8500-sysctrl.c: In function =E2=80=98ab8500_sysctrl_=
probe=E2=80=99:
> ../drivers/mfd/ab8500-sysctrl.c:206:2: error: implicit declaration of
> function =E2=80=98devm_register_power_off_handler=E2=80=99
> [-Werror=3Dimplicit-function-declaration]
>   err =3D devm_register_power_off_handler(sysctrl_dev, &ab8500_powero=
ff_nb);
>=20
> I wanted to provide a Tested-by but I guess I can only give this:
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>=20
Thanks!
Guenter
