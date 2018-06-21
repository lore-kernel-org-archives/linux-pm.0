From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [PATCH] PM / devfreq: Fix devfreq_add_device() when drivers are
 built as modules.
Date: Thu, 21 Jun 2018 10:04:25 +0200
Message-ID: <CAFqH_539E+TEjPK8QNm7UprfdGz17nxRUtmY7vWCueZsYwyByA@mail.gmail.com>
References: <20180615100452.17466-1-enric.balletbo@collabora.com>
 <CAGTfZH1QkzBjDPfsS23DgVF=EqO1P9RK+YdAnAwt2rDL6eGPTg@mail.gmail.com>
 <CAFqH_5344NDHup+u0QtimTJjKaVVj46YB6UDMKtdMr70JJmkng@mail.gmail.com>
 <CGME20180619082320epcas5p228d76c9e326d24acc1c38b43ff152347@epcas5p2.samsung.com>
 <7eff02c1-3d78-de08-19ab-a4a45c491a86@collabora.com> <5B29A43E.2080402@samsung.com>
 <9186fc15-c884-a67b-e2fb-113721613146@collabora.com> <5B2B5AB4.4020003@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5B2B5AB4.4020003@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, cwchoi00@gmail.com, linux-kernel <linux-kernel@vger.kernel.org>, kernel@collabora.com, Kyungmin Park <kyungmin.park@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Chanwoo,
Missatge de Chanwoo Choi <cw00.choi@samsung.com> del dia dj., 21 de
juny 2018 a les 9:58:
>
> Hi Enric,
>
> On 2018=EB=85=84 06=EC=9B=94 20=EC=9D=BC 19:32, Enric Balletbo i Serra wr=
ote:
> > Hi Chanwoo,
> >
> > On 20/06/18 02:47, Chanwoo Choi wrote:
> >> Hi Enric,
> >>
> >> On 2018=EB=85=84 06=EC=9B=94 19=EC=9D=BC 17:22, Enric Balletbo i Serra=
 wrote:
> >>> Hi Chanwoo,
> >>>
> >>> On 18/06/18 11:02, Enric Balletbo Serra wrote:
> >>>> Hi Chanwoo,
> >>>> Missatge de Chanwoo Choi <cwchoi00@gmail.com> del dia dg., 17 de jun=
y
> >>>> 2018 a les 5:50:
> >>>>>
> >>>>> Hi Enric,
> >>>>>
> >>>>> This issue will happen on the position to use find_devfreq_governor=
()
> >>>>> as following:
> >>>>> - devfreq_add_governora() and governor_store()
> >>>>>
> >>>>> If device driver with module type after loaded want to change the
> >>>>> scaling governor,
> >>>>> new governor might be not yet loaded. So, devfreq bettero to consid=
er this case
> >>>>> in the find_devfreq_governor().
> >>>>>
> >>>> Ok, I'll move there and send a v2.
> >>>>
> >>>
> >>> I tried your suggestion but I found one problem, if I move the code i=
n
> >>> find_devfreq_governor it end up with a deadlock. The reason is the fo=
llowing calls.
> >>>
> >>> devfreq_add_device
> >>>   find_devfreq_governor (!!!)
> >>>     request_module
> >>>        devfreq_simple_ondemand_init
> >>>           devfreq_add_governor
> >>>              find_devfreq_governor (DEADLOCK)
> >>>
> >>> So I am wondering if shouldn't be more easy fix the issue in both pla=
ces,
> >>> devfreq_add_device and governor_store.
> >>>
> >>> To devfreq_add_device
> >>>
> >>> devfreq_add_device
> >>>   governor =3D find_devfreq_governor
> >>>   if (IS_ERR(governor) {
> >>
> >> In this error case, you have to unlock the mutex
> >> before calling the request_module(). I added the pseudo code
> >> of my opinion.
> >>
> >>>      request_module
> >>>      governor =3D find_devfreq_governor
> >>>      if (IS_ERR(governor)
> >>>        return ERR_PTR(governor)
> >>>   }
> >>>
> >>> And the same for governor_store
> >>>
> >>> governor_store
> >>>   governor =3D find_devfreq_governor
> >>>   if (IS_ERR(governor) {
> >>>      request_module
> >>>      governor =3D find_devfreq_governor
> >>>      if (IS_ERR(governor)
> >>>        return ERR_PTR(governor)
> >>>   }
> >>>
> >>> Maybe all  can go in a new function try_find_devfreq_governor_then_re=
quest
> >>
> >> How about modify the find_devfreq_governor() as following?
> >> I think that it is possible because previous find_devfreq_governor()
> >> always check whether mutex is locked or not.
> >>
> >>      find_devfreq_governor() {
> >>
> >>              // check whether mutex is locked or not
> >>              if (!mutex_is_lock(&devfreq_list_lock)) {
> >>                      WARN(...)
> >>                      return -EINVAL
> >>              }
> >>
> >>              // find the registered governor with list_for_each_entry
> >>
> >>              if (governor is not loaded) {
> >>                      mutex_unlock()
> >>                      request_module()
> >
> > Then the problem is that the find_devfreq_governor is reentrant because=
 the init
> > function of the governor calls devfreq_add_governor and find_devfreq_go=
vernor
> > again. E.g for simpleondemand governor you will get this loop.
> >
> > find_devfreq_governor
> >   -> request_module
> >       -> devfreq_simple_ondemand_init
> >          -> devfreq_add_governor
> >             -> find_devfreq_governor
> >                -> request_module
> >                   -> devfreq_simple_ondemand_init
> >                      -> devfreq_add_governor
> >                         -> find_devfreq_governor
> >                            -> request_module
> >                               ...
> >
> > Makes sense or I am missing something and there is a way to quit from t=
his loop?
>
> You're right. Sorry, my wrong opinion steals your time.
>

Not a problem :) I learned while we discussed regarding the different
options. I will send a v2 then

Thanks,
 Enric

> >
> > FWIW I checked how the cpufreq driver does this as it should have the s=
ame
> > problem. The find_governor function is just a simple search and instead=
 of
> > integrating the request_module inside the find_governor function they h=
ave a
> > cpu_parse_governor that calls request module from the userspace call an=
d from
> > the init call.
>
> Also, I checked the cpufreq's case. We better to make the separate functi=
on
> like cpufreq_parse_governor() in cpufreq subsystem.
>
> >
> > store_scaling_governor
> >   -> cpu_parse_governor
> >      -> request_module
> >
> > cpufreq_add_dev_interface
> >   -> cpu_freq_init_policy
> >      -> cpu_parse_governor
> >         -> request_module
> >
> > Thanks,
> > - Enric
> >
> >>                      mutex_lock()
> >>              }
> >>
> >>      }
> >>
> >>
> >>>
> >>> Other suggestions?
> >>>
> >>> - Enric
> >>>
> >>>> Thanks
> >>>>  Enric.
> >>>>
> >>>>
> >>>>> 2018-06-15 19:04 GMT+09:00 Enric Balletbo i Serra
> >>>>> <enric.balletbo@collabora.com>:
> >>>>>> When the devfreq driver and the governor driver are built as modul=
es,
> >>>>>> the call to devfreq_add_device() fails because the governor driver=
 is
> >>>>>> not loaded at the time the devfreq driver loads. The devfreq drive=
r has
> >>>>>> a build dependency on the governor but also should have a runtime
> >>>>>> dependency. We need to make sure that the governor driver is loade=
d
> >>>>>> before the devfreq driver.
> >>>>>>
> >>>>>> This patch fixes this bug in devfreq_add_device(). First tries to =
find
> >>>>>> the governor, and then, if was not found, it requests the module a=
nd
> >>>>>> tries again.
> >>>>>>
> >>>>>> Fixes: 1b5c1be2c88e (PM / devfreq: map devfreq drivers to governor=
 using name)
> >>>>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.co=
m>
> >>>>>> ---
> >>>>>>
> >>>>>>  drivers/devfreq/devfreq.c | 36 +++++++++++++++++++++++++++++++---=
--
> >>>>>>  1 file changed, 31 insertions(+), 5 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> >>>>>> index fe2af6aa88fc..1d917f043e30 100644
> >>>>>> --- a/drivers/devfreq/devfreq.c
> >>>>>> +++ b/drivers/devfreq/devfreq.c
> >>>>>> @@ -11,6 +11,7 @@
> >>>>>>   */
> >>>>>>
> >>>>>>  #include <linux/kernel.h>
> >>>>>> +#include <linux/kmod.h>
> >>>>>>  #include <linux/sched.h>
> >>>>>>  #include <linux/errno.h>
> >>>>>>  #include <linux/err.h>
> >>>>>> @@ -648,10 +649,35 @@ struct devfreq *devfreq_add_device(struct de=
vice *dev,
> >>>>>>
> >>>>>>         governor =3D find_devfreq_governor(devfreq->governor_name)=
;
> >>>>>>         if (IS_ERR(governor)) {
> >>>>>> -               dev_err(dev, "%s: Unable to find governor for the =
device\n",
> >>>>>> -                       __func__);
> >>>>>> -               err =3D PTR_ERR(governor);
> >>>>>> -               goto err_init;
> >>>>>> +               list_del(&devfreq->node);
> >>>>>> +               mutex_unlock(&devfreq_list_lock);
> >>>>>> +
> >>>>>> +               /*
> >>>>>> +                * If the governor is not found, then request the =
module and
> >>>>>> +                * try again. This can happen when both drivers (t=
he governor
> >>>>>> +                * driver and the driver that calls devfreq_add_de=
vice) are
> >>>>>> +                * built as modules.
> >>>>>> +                */
> >>>>>> +               if (!strncmp(devfreq->governor_name,
> >>>>>> +                            DEVFREQ_GOV_SIMPLE_ONDEMAND, DEVFREQ_=
NAME_LEN))
> >>>>>> +                       err =3D request_module("governor_%s", "sim=
pleondemand");
> >>>>>> +               else
> >>>>>> +                       err =3D request_module("governor_%s",
> >>>>>> +                                            devfreq->governor_nam=
e);
> >>>>>> +               if (err)
> >>>>>> +                       goto err_unregister;
> >>>>>> +
> >>>>>> +               mutex_lock(&devfreq_list_lock);
> >>>>>> +               list_add(&devfreq->node, &devfreq_list);
> >>>>>> +
> >>>>>> +               governor =3D find_devfreq_governor(devfreq->govern=
or_name);
> >>>>>> +               if (IS_ERR(governor)) {
> >>>>>> +                       dev_err(dev,
> >>>>>> +                               "%s: Unable to find governor for t=
he device\n",
> >>>>>> +                               __func__);
> >>>>>> +                       err =3D PTR_ERR(governor);
> >>>>>> +                       goto err_init;
> >>>>>> +               }
> >>>>>>         }
> >>>>>>
> >>>>>>         devfreq->governor =3D governor;
> >>>>>> @@ -669,7 +695,7 @@ struct devfreq *devfreq_add_device(struct devi=
ce *dev,
> >>>>>>  err_init:
> >>>>>>         list_del(&devfreq->node);
> >>>>>>         mutex_unlock(&devfreq_list_lock);
> >>>>>> -
> >>>>>> +err_unregister:
> >>>>>>         device_unregister(&devfreq->dev);
> >>>>>>  err_dev:
> >>>>>>         if (devfreq)
> >>>>>> --
> >>>>>> 2.17.1
> >>>>>>
> >>>>>
> >>>>>
> >>>>>
> >>>>> --
> >>>>> Best Regards,
> >>>>> Chanwoo Choi
> >>>>> Samsung Electronics
> >>>>
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
