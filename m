From: =?iso-8859-1?Q?Ren=E9_Moll?= <Rene.Moll@xsens.com>
Subject: RE: [PATCH] power: reset: add PowerPath poweroff support
Date: Thu, 7 Aug 2014 15:54:48 +0000
Message-ID: <8B68774BB69A844693005BA12A50F1146D4B11@XSMBXSVR01.xsens-tech.local>
References: <8B68774BB69A844693005BA12A50F1146D4AE3@XSMBXSVR01.xsens-tech.local>
 <53E385F6.2020903@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from filter1.ibarracuda.nl ([83.247.7.10]:54935 "EHLO
	filter1.ibarracuda.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932274AbaHGPy4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 Aug 2014 11:54:56 -0400
In-Reply-To: <53E385F6.2020903@nvidia.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Frans Klaver <Frans.Klaver@xsens.com>, Mikko Perttunen <mperttunen@nvidia.com>

Thanks for your response, I will do some refactoring based on your
comments. Also see the inline replies.

> -----Original Message-----
> From: Mikko Perttunen [mailto:mperttunen@nvidia.com]
> Sent: Thursday, August 07, 2014 3:58 PM
> To: Ren=E9 Moll; linux-pm@vger.kernel.org
> Cc: Sebastian Reichel; Dmitry Eremin-Solenikov; David Woodhouse; Fran=
s
> Klaver
> Subject: Re: [PATCH] power: reset: add PowerPath poweroff support
>=20
> Not my subsystem, but some general points..
>=20
> On 07/08/14 15:44, Ren=E9 Moll wrote:
> >
> > Signed-off-by: Ren=E9 Moll <rene.moll@xsens.com>
>=20
> Please add a commit message. You should describe the hardware, it's
> capabilities and what features this driver implements.
>=20

Since the driver already has documentation embedded,
this seemed a bit overkill to me.

> > + * the Free Software Foundation, either version 3 of the License, =
or
> > + * (at your option) any later version.
>=20
> The kernel is GPL v2.
>=20

Ok, I will correct this.

> > + * The driver requires a non-shared, edge-triggered interrupt on t=
he
> > + trigger
> > + * GPIO.
>=20
> You should add a description of the hardware and device tree node alo=
ng
> with properties (like this one!) under Documentation/devicetree/bindi=
ngs/...
> Don't refer to Linux-specific driver implementation details, though.
>=20

Good point, will add this.

> > +       dev_info(data->dev, "executing shutdown\n");
> > +
> > +       call_usermodehelper(shutdown_argv[0], shutdown_argv,
> > +               shutdown_envp, UMH_NO_WAIT);
>=20
> Any reason not to use orderly_poweroff()?
>=20

I was not aware of that function, which indeed does exactly what I need=
=2E
I will change this.

> > +       powerpath_poweroff_default(data);
> > +
> > +       for (i =3D 0; i < ARRAY_SIZE(data->gpio); i++) {
> > +               data->gpio[i] =3D gpiod_get(&pdev->dev, name[i]);
> > +
> > +               if (IS_ERR(data->gpio[i])) {
> > +                       ret =3D PTR_ERR(data->gpio[i]);
> > +                       dev_err(&pdev->dev,
> > +                               "unable to claim the following gpio=
: %s\n",
> > +                               name[i]);
> > +                       goto err;
> > +               }
> > +       }
>=20
> If an error occurs mid-loop, this can leave some gpios get'ted. I rec=
ommend
> switching to devm_gpiod_get.
>=20

devm_* functions do not seem to common to me and are sparsely documente=
d,
therefore I preferred the regular functions. This error jump should go =
to=20
err_io and the clean-up loop must check if the gpio entry is actually f=
illed in

> > +static struct platform_driver powerpath_poweroff_driver =3D {
> > +       .probe =3D powerpath_poweroff_probe,
> > +       .remove =3D powerpath_poweroff_remove,
> > +       .driver =3D {
> > +               .name =3D "powerpath-poweroff",
> > +               .owner =3D THIS_MODULE,
> > +               .of_match_table =3D of_powerpath_poweroff_match,
> > +       },
> > +       .suspend =3D powerpath_poweroff_suspend,
> > +       .resume =3D powerpath_poweroff_resume,
> > +       .shutdown =3D powerpath_poweroff_shutdown,
>=20
> Based on other drivers, looks like what you're supposed to do is stor=
e a
> function pointer in `pm_power_off'.=20

I will use that instead of the shutdown pointer.

> [...] Also, no need to specify suspend and
> resume if you don't implement them anyway.
>=20

Actually, this is recommended in Documentation/SubmittingDrivers.txt

> > +static int powerpath_poweroff_notify_panic(struct notifier_block *=
nb,
> > +       unsigned long code, void *unused) {
> > +       powerpath_poweroff_panic =3D 1;
> > +       return NOTIFY_DONE;
> > +}
> > +
> > +static struct notifier_block powerpath_poweroff_panic_nb =3D {
> > +       .notifier_call =3D powerpath_poweroff_notify_panic, };
> > +
> > +static int __init powerpath_poweroff_platform_init(void)
> > +{
> > +       powerpath_poweroff_panic =3D 0;
> > +
> > +       atomic_notifier_chain_register(&panic_notifier_list,
> > +               &powerpath_poweroff_panic_nb);
> > +
> > +       return platform_driver_register(&powerpath_poweroff_driver)=
;
> > +}
> > +
> > +static void __exit powerpath_poweroff_platform_exit(void)
> > +{
> > +       atomic_notifier_chain_unregister(&panic_notifier_list,
> > +               &powerpath_poweroff_panic_nb);
> > +
> > +       platform_driver_unregister(&powerpath_poweroff_driver);
> > +}
> > +
> > +module_init(powerpath_poweroff_platform_init);
> > +module_exit(powerpath_poweroff_platform_exit);
>=20
> You can leave a lot of this out by using module_platform_driver()
>=20

I am aware of that macro, however where to place the notifier calls.
The register call could be placed in the probe function. The unregister=
 call
should then go to the remove function, which you suggested to remove :)

Personally I think this is neater as a panic is a system state, which w=
e
want to know and react upon, but is not part of the driver itself.

> > +
> > +MODULE_AUTHOR("Ren=E9 Moll <rene.moll@xsens.com>");
> > +MODULE_DESCRIPTION("PowerPath power-off driver");
> MODULE_LICENSE("GPL
> > +v2");
> > +
> > --
> > 1.9.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pm"=
 in
> > the body of a message to majordomo@vger.kernel.org More majordomo
> info
> > at  http://vger.kernel.org/majordomo-info.html
> >
>=20
> Thanks for contributing!
>=20
> Cheers,
> Mikko
