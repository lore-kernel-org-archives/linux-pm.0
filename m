From: Chanwoo Choi <cwchoi00@gmail.com>
Subject: Re: [PATCH 3/4] PM / devfreq: Add devfreq_governor_start/stop()
Date: Thu, 14 Feb 2019 23:32:40 +0900
Message-ID: <CAGTfZH1w=T+TY=bpqwHwLnxgzykcfrEv09iZuoUWwKFDAHK7Zw@mail.gmail.com>
References: <20190214013042.254790-1-mka@chromium.org> <20190214013042.254790-4-mka@chromium.org>
 <CAGTfZH0cQhBLDx91VArMQ52z+iJAsfb2Zvk5nJSCqSM=aPhK0A@mail.gmail.com>
Reply-To: cwchoi00@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGTfZH0cQhBLDx91VArMQ52z+iJAsfb2Zvk5nJSCqSM=aPhK0A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Linux PM list <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-tegra@vger.kernel.org, Lukasz Luba <l.luba@partner.samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Matthias,

When I contributed the something to devfreq.c, if the newly added functions
are internal/static, just added the function without 'devfreq_' prefix
in order to distinguish them from the exported function as following:
- find_available_min_freq()
- find_available_max_freq()
- set_freq_table()

So, the governor_start/stop are the static function used only in devfreq.c,
in order to sustain the consistency of function naming, I recommened
that changes them as following:
- devfreq_governor_start -> governor_start
- devfreq_governor_stop -> governor_stop

2019=EB=85=84 2=EC=9B=94 14=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 11:12, =
Chanwoo Choi <cwchoi00@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Hi Matthias,
>
> Looks good to me for making the function to remove the duplicate code.
> But,  When I just tested the kernel build, following warnings occur
> about devfreq_governor_stop().
>
> In file included from ./include/linux/devfreq.h:16:0,
>                  from drivers/devfreq/devfreq.c:23:
> drivers/devfreq/devfreq.c: In function =E2=80=98devfreq_governor_stop=E2=
=80=99:
> drivers/devfreq/devfreq.c:619:17: warning: format =E2=80=98%s=E2=80=99 ex=
pects
> argument of type =E2=80=98char *=E2=80=99, but argument 4 has type =E2=80=
=98int=E2=80=99 [-Wformat=3D]
>    dev_warn(dev, "%s: Governor %s not stopped: %d\n",
>                  ^
> ./include/linux/device.h:1380:22: note: in definition of macro =E2=80=98d=
ev_fmt=E2=80=99
>  #define dev_fmt(fmt) fmt
>                       ^
> drivers/devfreq/devfreq.c:619:3: note: in expansion of macro =E2=80=98dev=
_warn=E2=80=99
>    dev_warn(dev, "%s: Governor %s not stopped: %d\n",
>    ^
> drivers/devfreq/devfreq.c:619:17: warning: format =E2=80=98%d=E2=80=99 ex=
pects a
> matching =E2=80=98int=E2=80=99 argument [-Wformat=3D]
>    dev_warn(dev, "%s: Governor %s not stopped: %d\n",
>                  ^
> ./include/linux/device.h:1380:22: note: in definition of macro =E2=80=98d=
ev_fmt=E2=80=99
>  #define dev_fmt(fmt) fmt
>                       ^
> drivers/devfreq/devfreq.c:619:3: note: in expansion of macro =E2=80=98dev=
_warn=E2=80=99
>    dev_warn(dev, "%s: Governor %s not stopped: %d\n",
>
> 2019=EB=85=84 2=EC=9B=94 14=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 7:16,=
 Matthias Kaehlcke <mka@chromium.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >
> > The following pattern is repeated multiple times:
> >
> > - call governor event handler with DEVFREQ_GOV_START/STOP
> > - check return value
> > - in case of error log a message
> >
> > Add devfreq_governor_start/stop() helper functions with this code
> > and call them instead.
> >
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >  drivers/devfreq/devfreq.c | 96 +++++++++++++++++++++++----------------
> >  1 file changed, 58 insertions(+), 38 deletions(-)
> >
> > diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> > index 7fab6c4cf719b..eb86461648d74 100644
> > --- a/drivers/devfreq/devfreq.c
> > +++ b/drivers/devfreq/devfreq.c
> > @@ -580,6 +580,53 @@ static int devfreq_notifier_call(struct notifier_b=
lock *nb, unsigned long type,
> >         return ret;
> >  }
> >
> > +/**
> > + * devfreq_governor_start() - Start the devfreq governor of the device=
.
> > + * @devfreq:   the devfreq instance
> > + */
> > +static int devfreq_governor_start(struct devfreq *devfreq)
> > +{
> > +       struct device *dev =3D devfreq->dev.parent;
> > +       int err;
> > +
> > +       if (WARN(mutex_is_locked(&devfreq->lock),
> > +                "mutex must *not* be held by the caller\n"))
> > +               return -EINVAL;
> > +
> > +       err =3D devfreq->governor->event_handler(devfreq, DEVFREQ_GOV_S=
TART,
> > +                                              NULL);
> > +       if (err) {
> > +               dev_err(dev, "Governor %s not started: %d\n",
> > +                       devfreq->governor->name, err);
> > +               return err;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +/**
> > + * devfreq_governor_stop() - Stop the devfreq governor of the device.
> > + * @devfreq:   the devfreq instance
> > + */
> > +static int devfreq_governor_stop(struct devfreq *devfreq)
> > +{
> > +       struct device *dev =3D devfreq->dev.parent;
> > +       int err;
> > +
> > +       if (WARN(mutex_is_locked(&devfreq->lock),
> > +                "mutex must *not* be held by the caller\n"))
> > +               return -EINVAL;
> > +
> > +       err =3D devfreq->governor->event_handler(devfreq, DEVFREQ_GOV_S=
TOP, NULL);
> > +       if (err) {
> > +               dev_warn(dev, "%s: Governor %s not stopped: %d\n",
> > +                        devfreq->governor->name, err);
> > +               return err;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> >  /**
> >   * devfreq_dev_release() - Callback for struct device to release the d=
evice.
> >   * @dev:       the devfreq device
> > @@ -720,13 +767,9 @@ struct devfreq *devfreq_add_device(struct device *=
dev,
> >         }
> >
> >         devfreq->governor =3D governor;
> > -       err =3D devfreq->governor->event_handler(devfreq, DEVFREQ_GOV_S=
TART,
> > -                                               NULL);
> > -       if (err) {
> > -               dev_err(dev, "%s: Unable to start governor for the devi=
ce\n",
> > -                       __func__);
> > +       err =3D devfreq_governor_start(devfreq);
> > +       if (err)
> >                 goto err_init;
> > -       }
> >
> >         list_add(&devfreq->node, &devfreq_list);
> >
> > @@ -1029,24 +1072,13 @@ int devfreq_add_governor(struct devfreq_governo=
r *governor)
> >                                 dev_warn(dev,
> >                                          "%s: Governor %s already prese=
nt\n",
> >                                          __func__, devfreq->governor->n=
ame);
> > -                               ret =3D devfreq->governor->event_handle=
r(devfreq,
> > -                                                       DEVFREQ_GOV_STO=
P, NULL);
> > -                               if (ret) {
> > -                                       dev_warn(dev,
> > -                                                "%s: Governor %s stop =
=3D %d\n",
> > -                                                __func__,
> > -                                                devfreq->governor->nam=
e, ret);
> > -                               }
> > +                               ret =3D devfreq_governor_stop(devfreq);
> > +
> >                                 /* Fall through */
> >                         }
> > +
> >                         devfreq->governor =3D governor;
> > -                       ret =3D devfreq->governor->event_handler(devfre=
q,
> > -                                               DEVFREQ_GOV_START, NULL=
);
> > -                       if (ret) {
> > -                               dev_warn(dev, "%s: Governor %s start=3D=
%d\n",
> > -                                        __func__, devfreq->governor->n=
ame,
> > -                                        ret);
> > -                       }
> > +                       devfreq_governor_start(devfreq);
> >                 }
> >         }
> >
> > @@ -1081,7 +1113,6 @@ int devfreq_remove_governor(struct devfreq_govern=
or *governor)
> >                 goto err_out;
> >         }
> >         list_for_each_entry(devfreq, &devfreq_list, node) {
> > -               int ret;
> >                 struct device *dev =3D devfreq->dev.parent;
> >
> >                 if (!strncmp(devfreq->governor_name, governor->name,
> > @@ -1093,13 +1124,8 @@ int devfreq_remove_governor(struct devfreq_gover=
nor *governor)
> >                                 continue;
> >                                 /* Fall through */
> >                         }
> > -                       ret =3D devfreq->governor->event_handler(devfre=
q,
> > -                                               DEVFREQ_GOV_STOP, NULL)=
;
> > -                       if (ret) {
> > -                               dev_warn(dev, "%s: Governor %s stop=3D%=
d\n",
> > -                                        __func__, devfreq->governor->n=
ame,
> > -                                        ret);
> > -                       }
> > +
> > +                       devfreq_governor_stop(devfreq);
> >                         devfreq->governor =3D NULL;
> >                 }
> >         }
> > @@ -1149,19 +1175,13 @@ static ssize_t governor_store(struct device *de=
v, struct device_attribute *attr,
> >         }
> >
> >         if (df->governor) {
> > -               ret =3D df->governor->event_handler(df, DEVFREQ_GOV_STO=
P, NULL);
> > -               if (ret) {
> > -                       dev_warn(dev, "%s: Governor %s not stopped(%d)\=
n",
> > -                                __func__, df->governor->name, ret);
> > +               ret =3D devfreq_governor_stop(df);
> > +               if (ret)
> >                         goto out;
> > -               }
> >         }
> >         df->governor =3D governor;
> >         strncpy(df->governor_name, governor->name, DEVFREQ_NAME_LEN);
> > -       ret =3D df->governor->event_handler(df, DEVFREQ_GOV_START, NULL=
);
> > -       if (ret)
> > -               dev_warn(dev, "%s: Governor %s not started(%d)\n",
> > -                        __func__, df->governor->name, ret);
> > +       ret =3D devfreq_governor_start(df);
> >  out:
> >         mutex_unlock(&devfreq_list_lock);
> >
> > --
> > 2.20.1.791.gb4d0f1c61a-goog
> >
>
>
> --
> Best Regards,
> Chanwoo Choi



--=20
Best Regards,
Chanwoo Choi
