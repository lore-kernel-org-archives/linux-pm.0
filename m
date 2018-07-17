From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [PATCH] devfreq: rk3399_dmc: Fix duplicated opp table on reload.
Date: Tue, 17 Jul 2018 15:17:53 +0200
Message-ID: <CAFqH_52TaDiV6o5SmBhiT6v-qiG8tc=Bs0gPyFQzT1=7utkqGg@mail.gmail.com>
References: <20180615151217.29872-1-enric.balletbo@collabora.com>
 <CAGTfZH16O6u_3QJ2u1eecUnGptSBf1ho47RPefOTmrw+Syxr0w@mail.gmail.com>
 <CGME20180618091029epcas3p498708535c8f8df019bf3785a199d58b4@epcas3p4.samsung.com>
 <CAFqH_51ptafw-Z_8-FqtxbTH9LU560cHoM5TFiF01ZwG_jW3VQ@mail.gmail.com>
 <5B288430.2040600@samsung.com> <65546a48-3291-9836-cb0c-1e65ff7c9d41@collabora.com>
 <5B29A4CE.9060009@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5B29A4CE.9060009@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, cwchoi00@gmail.com, linux-kernel <linux-kernel@vger.kernel.org>, kernel@collabora.com, Kyungmin Park <kyungmin.park@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Missatge de Chanwoo Choi <cw00.choi@samsung.com> del dia dc., 20 de
juny 2018 a les 2:50:
>
> Hi Enric,
>
> On 2018=EB=85=84 06=EC=9B=94 19=EC=9D=BC 17:07, Enric Balletbo i Serra wr=
ote:
> > Hi Chanwoo,
> >
> > On 19/06/18 06:18, Chanwoo Choi wrote:
> >> Hi Enric,
> >>
> >> On 2018=EB=85=84 06=EC=9B=94 18=EC=9D=BC 18:10, Enric Balletbo Serra w=
rote:
> >>> Hi Chanwoo,
> >>>
> >>> Missatge de Chanwoo Choi <cwchoi00@gmail.com> del dia dg., 17 de juny
> >>> 2018 a les 5:23:
> >>>>
> >>>> Hi Enric,
> >>>>
> >>>> 2018-06-16 0:12 GMT+09:00 Enric Balletbo i Serra <enric.balletbo@col=
labora.com>:
> >>>>> The opp table is not removed when the driver is unloaded neither wh=
en
> >>>>> there is an error within probe, so if the driver is reloaded the op=
p
> >>>>> core shows the following warning:
> >>>>>
> >>>>>   rk3399-dmc-freq dmc: _opp_add: duplicate OPPs detected. Existing:=
 freq:
> >>>>>                200000000, volt: 900000, enabled: 1. New: freq: 2000=
00000,
> >>>>>                volt: 900000, enabled: 1
> >>>>>   rk3399-dmc-freq dmc: _opp_add: duplicate OPPs detected. Existing:=
 freq:
> >>>>>                400000000, volt: 900000, enabled: 1. New: freq: 4000=
00000,
> >>>>>                volt: 900000, enabled: 1
> >>>>>   rk3399-dmc-freq dmc: _opp_add: duplicate OPPs detected. Existing:=
 freq:
> >>>>>                666000000, volt: 900000, enabled: 1. New: freq: 6660=
00000,
> >>>>>                volt: 900000, enabled: 1
> >>>>>   rk3399-dmc-freq dmc: _opp_add: duplicate OPPs detected. Existing:=
 freq:
> >>>>>                800000000, volt: 900000, enabled: 1. New: freq: 8000=
00000,
> >>>>>                volt: 900000, enabled: 1
> >>>>>   rk3399-dmc-freq dmc: _opp_add: duplicate OPPs detected. Existing:=
 freq:
> >>>>>                928000000, volt: 900000, enabled: 1. New: freq: 9280=
00000,
> >>>>>                volt: 900000, enabled: 1
> >>>>>
> >>>>> This patch fixes the error path in the probe function and adds a .r=
emove
> >>>>> function to properly cleanup the opp table on unloading.
> >>>>>
> >>>>> Fixes: 5a893e31a636c (PM / devfreq: rockchip: add devfreq driver fo=
r rk3399 dmc)
> >>>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com=
>
> >>>>> ---
> >>>>>
> >>>>>  drivers/devfreq/rk3399_dmc.c | 31 +++++++++++++++++++++++++++----
> >>>>>  1 file changed, 27 insertions(+), 4 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_=
dmc.c
> >>>>> index d5c03e5abe13..e795ad2b3f6b 100644
> >>>>> --- a/drivers/devfreq/rk3399_dmc.c
> >>>>> +++ b/drivers/devfreq/rk3399_dmc.c
> >>>>> @@ -375,8 +375,10 @@ static int rk3399_dmcfreq_probe(struct platfor=
m_device *pdev)
> >>>>>         data->rate =3D clk_get_rate(data->dmc_clk);
> >>>>>
> >>>>>         opp =3D devfreq_recommended_opp(dev, &data->rate, 0);
> >>>>> -       if (IS_ERR(opp))
> >>>>> -               return PTR_ERR(opp);
> >>>>> +       if (IS_ERR(opp)) {
> >>>>> +               ret =3D PTR_ERR(opp);
> >>>>> +               goto err_free_opp;
> >>>>> +       }
> >>>>>
> >>>>>         data->rate =3D dev_pm_opp_get_freq(opp);
> >>>>>         data->volt =3D dev_pm_opp_get_voltage(opp);
> >>>>> @@ -388,13 +390,33 @@ static int rk3399_dmcfreq_probe(struct platfo=
rm_device *pdev)
> >>>>>                                            &rk3399_devfreq_dmc_prof=
ile,
> >>>>>                                            DEVFREQ_GOV_SIMPLE_ONDEM=
AND,
> >>>>>                                            &data->ondemand_data);
> >>>>> -       if (IS_ERR(data->devfreq))
> >>>>> -               return PTR_ERR(data->devfreq);
> >>>>> +       if (IS_ERR(data->devfreq)) {
> >>>>> +               ret =3D PTR_ERR(data->devfreq);
> >>>>> +               goto err_free_opp;
> >>>>> +       }
> >>>>> +
> >>>>>         devm_devfreq_register_opp_notifier(dev, data->devfreq);
> >>>>>
> >>>>>         data->dev =3D dev;
> >>>>>         platform_set_drvdata(pdev, data);
> >>>>>
> >>>>> +       return 0;
> >>>>
> >>>> It looks strange. Because rk3399_dmcfreq_probe() already include
> >>>> 'return 0' when success.
> >>>> What is the base commit of this patch?
> >>>>
> >>>
> >>> Sorry, I am not sure I understand your question, If I am not answerin=
g
> >>> below could you rephrase?
> >>
> >> When I check the rk3399_dmcfreq_probe()[1], as I commented,
> >> rk3399_dmcfreq_probe() already 'return 0' after platform_set_drvdata()=
.
> >> You can check it on link[1].
> >> [1] https://elixir.bootlin.com/linux/v4.18-rc1/source/drivers/devfreq/=
rk3399_dmc.c#L443
> >>
> >> But, this patch add new '+       return 0;' line again in rk3399_dmcfr=
eq_probe().
> >> So, just I asked what is base commit of this patch.
> >>
> >
> > I think that this is just how git did the diff and if you only look at =
the diff
> > is a bit confusing, if you apply the patch on top of mainline you will =
see that
> > there is only one return 0 in the probe function.
>
> Anyway, when I applied it to git, there is no problem.
> Just I have never seen such a case and asked a question.
> Don't care about this anymore. Thanks.
>
> >
> > +       return 0; (this new return ...)
> > +
> > +err_free_opp:
> > +       dev_pm_opp_of_remove_table(&pdev->dev);
> > +       return ret;
> > +}
> > +
> > +static int rk3399_dmcfreq_remove(struct platform_device *pdev)
> > +{
> > +       struct rk3399_dmcfreq *dmcfreq =3D dev_get_drvdata(&pdev->dev);
> > +
> > +       /*
> > +        * Before remove the opp table we need to unregister the opp no=
tifier.
> > +        */
> > +       devm_devfreq_unregister_opp_notifier(dmcfreq->dev, dmcfreq->dev=
freq);
> > +       dev_pm_opp_of_remove_table(dmcfreq->dev);
> > +
> >         return 0; (was this before the patch, but now is in another fun=
ction)
> >
> > Cheers,
> >  Enric
> >
> >>>
> >>> So, once the opp table is added we need an error path to free it if a=
n
> >>> error occurs later. When the probe returns 0, we need to free the opp
> >>> table when we remove the module.
> >>>
> >>>> [snip]
> >>>>
> >>>> Anyway, if probe fail, device driver have to remove registered OPP t=
able.
> >>>> Looks good to me.
> >>>>
> >>>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> >>>>

A gentle ping, although is a fix I think is late and not enough
critical to be merged in this release cycle, there is a chance this
can be queued for 4.19?

Thanks,
 Enric

> >>>
> >>> Thanks,
> >>>  Enric
> >>>
> >>>> --
> >>>> Best Regards,
> >>>> Chanwoo Choi
> >>>> Samsung Electronics
> >>>
> >>>
> >>>
> >>
> >>
> >
> >
> >
>
>
> --
> Best Regards,
> Chanwoo Choi
> Samsung Electronics
