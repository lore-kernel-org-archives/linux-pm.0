From: Frank Lee <tiny.windzz@gmail.com>
Subject: Re: [PATCH] PM / devfreq: consistent indentation
Date: Mon, 21 Jan 2019 10:59:31 +0800
Message-ID: <CAEExFWtQBSg+jbH3fRJn0s5C9wqmPZTOPL=YPfMh-Q3yFd0Ovg@mail.gmail.com>
References: <CGME20190121021940epcms1p57620581b960dba9805dfddee903ccd6c@epcms1p5>
 <20190121021940epcms1p57620581b960dba9805dfddee903ccd6c@epcms1p5> <eb5b190b-0940-1ab1-5d28-0803f31e9448@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <eb5b190b-0940-1ab1-5d28-0803f31e9448@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Jan 21, 2019 at 10:28 AM Chanwoo Choi <cw00.choi@samsung.com> wrote=
:
>
> On 19. 1. 21. =EC=98=A4=EC=A0=84 11:19, MyungJoo Ham wrote:
> > Following up with complaints on inconsistent indentation from
> > Yangtao Li, this fixes indentation inconsistency.
> >
> > In principle, this tries to put arguments aligned to the left
> > including the first argument except for in the case where
> > the first argument is on the far-right side.
Acked-by: Yangtao Li <tiny.windzz@gmail.com>
> >
> > Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> > ---
> >  drivers/devfreq/devfreq.c | 49 +++++++++++++++++++++++----------------=
--------
> >  1 file changed, 24 insertions(+), 25 deletions(-)
>
> Looks better before.
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>
> >
> > diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> > index 4af608a..428a1de 100644
> > --- a/drivers/devfreq/devfreq.c
> > +++ b/drivers/devfreq/devfreq.c
> > @@ -528,7 +528,7 @@ void devfreq_interval_update(struct devfreq *devfre=
q, unsigned int *delay)
> >               mutex_lock(&devfreq->lock);
> >               if (!devfreq->stop_polling)
> >                       queue_delayed_work(devfreq_wq, &devfreq->work,
> > -                           msecs_to_jiffies(devfreq->profile->polling_=
ms));
> > +                             msecs_to_jiffies(devfreq->profile->pollin=
g_ms));
> >       }
> >  out:
> >       mutex_unlock(&devfreq->lock);
> > @@ -537,7 +537,7 @@ EXPORT_SYMBOL(devfreq_interval_update);
> >
> >  /**
> >   * devfreq_notifier_call() - Notify that the device frequency requirem=
ents
> > - *                      has been changed out of devfreq framework.
> > + *                        has been changed out of devfreq framework.
> >   * @nb:              the notifier_block (supposed to be devfreq->nb)
> >   * @type:    not used
> >   * @devp:    not used
> > @@ -683,12 +683,11 @@ struct devfreq *devfreq_add_device(struct device =
*dev,
> >               goto err_out;
> >       }
> >
> > -     devfreq->trans_table =3D
> > -             devm_kzalloc(&devfreq->dev,
> > -                          array3_size(sizeof(unsigned int),
> > -                                      devfreq->profile->max_state,
> > -                                      devfreq->profile->max_state),
> > -                          GFP_KERNEL);
> > +     devfreq->trans_table =3D devm_kzalloc(&devfreq->dev,
> > +                     array3_size(sizeof(unsigned int),
> > +                                 devfreq->profile->max_state,
> > +                                 devfreq->profile->max_state),
> > +                     GFP_KERNEL);
> >       if (!devfreq->trans_table) {
> >               mutex_unlock(&devfreq->lock);
> >               err =3D -ENOMEM;
> > @@ -696,9 +695,9 @@ struct devfreq *devfreq_add_device(struct device *d=
ev,
> >       }
> >
> >       devfreq->time_in_state =3D devm_kcalloc(&devfreq->dev,
> > -                                             devfreq->profile->max_sta=
te,
> > -                                             sizeof(unsigned long),
> > -                                             GFP_KERNEL);
> > +                     devfreq->profile->max_state,
> > +                     sizeof(unsigned long),
> > +                     GFP_KERNEL);
> >       if (!devfreq->time_in_state) {
> >               mutex_unlock(&devfreq->lock);
> >               err =3D -ENOMEM;
> > @@ -1184,7 +1183,7 @@ static ssize_t available_governors_show(struct de=
vice *d,
> >        */
> >       if (df->governor->immutable) {
> >               count =3D scnprintf(&buf[count], DEVFREQ_NAME_LEN,
> > -                                "%s ", df->governor_name);
> > +                               "%s ", df->governor_name);
> >       /*
> >        * The devfreq device shows the registered governor except for
> >        * immutable governors such as passive governor .
> > @@ -1497,8 +1496,8 @@ EXPORT_SYMBOL(devfreq_recommended_opp);
> >
> >  /**
> >   * devfreq_register_opp_notifier() - Helper function to get devfreq no=
tified
> > - *                              for any changes in the OPP availabilit=
y
> > - *                              changes
> > + *                                for any changes in the OPP availabil=
ity
> > + *                                changes
> >   * @dev:     The devfreq user device. (parent of devfreq)
> >   * @devfreq: The devfreq object.
> >   */
> > @@ -1510,8 +1509,8 @@ EXPORT_SYMBOL(devfreq_register_opp_notifier);
> >
> >  /**
> >   * devfreq_unregister_opp_notifier() - Helper function to stop getting=
 devfreq
> > - *                                notified for any changes in the OPP
> > - *                                availability changes anymore.
> > + *                                  notified for any changes in the OP=
P
> > + *                                  availability changes anymore.
> >   * @dev:     The devfreq user device. (parent of devfreq)
> >   * @devfreq: The devfreq object.
> >   *
> > @@ -1530,8 +1529,8 @@ static void devm_devfreq_opp_release(struct devic=
e *dev, void *res)
> >  }
> >
> >  /**
> > - * devm_ devfreq_register_opp_notifier()
> > - *           - Resource-managed devfreq_register_opp_notifier()
> > + * devm_devfreq_register_opp_notifier() - Resource-managed
> > + *                                     devfreq_register_opp_notifier()
> >   * @dev:     The devfreq user device. (parent of devfreq)
> >   * @devfreq: The devfreq object.
> >   */
> > @@ -1559,8 +1558,8 @@ int devm_devfreq_register_opp_notifier(struct dev=
ice *dev,
> >  EXPORT_SYMBOL(devm_devfreq_register_opp_notifier);
> >
> >  /**
> > - * devm_devfreq_unregister_opp_notifier()
> > - *           - Resource-managed devfreq_unregister_opp_notifier()
> > + * devm_devfreq_unregister_opp_notifier() - Resource-managed
> > + *                                       devfreq_unregister_opp_notifi=
er()
> >   * @dev:     The devfreq user device. (parent of devfreq)
> >   * @devfreq: The devfreq object.
> >   */
> > @@ -1579,8 +1578,8 @@ EXPORT_SYMBOL(devm_devfreq_unregister_opp_notifie=
r);
> >   * @list:    DEVFREQ_TRANSITION_NOTIFIER.
> >   */
> >  int devfreq_register_notifier(struct devfreq *devfreq,
> > -                             struct notifier_block *nb,
> > -                             unsigned int list)
> > +                           struct notifier_block *nb,
> > +                           unsigned int list)
> >  {
> >       int ret =3D 0;
> >
> > @@ -1686,9 +1685,9 @@ EXPORT_SYMBOL(devm_devfreq_register_notifier);
> >   * @list:    DEVFREQ_TRANSITION_NOTIFIER.
> >   */
> >  void devm_devfreq_unregister_notifier(struct device *dev,
> > -                             struct devfreq *devfreq,
> > -                             struct notifier_block *nb,
> > -                             unsigned int list)
> > +                                   struct devfreq *devfreq,
> > +                                   struct notifier_block *nb,
> > +                                   unsigned int list)
> >  {
> >       WARN_ON(devres_release(dev, devm_devfreq_notifier_release,
> >                              devm_devfreq_dev_match, devfreq));
> >
>
> --
> Best Regards,
> Chanwoo Choi
> Samsung Electronics
