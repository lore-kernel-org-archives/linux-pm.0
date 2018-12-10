From: Frank Lee <tiny.windzz@gmail.com>
Subject: Re: [PATCH v3] cpuidle: big.LITTLE: add of_node_put()
Date: Tue, 11 Dec 2018 00:27:49 +0800
Message-ID: <CAEExFWta3+EfvGODb58R8_3-=iMwJet0iGPY9zu8LmWFEMV2Fg@mail.gmail.com>
References: <20181120161451.21149-1-tiny.windzz@gmail.com> <ed0c146f-0a47-ef56-f919-4887d6a69001@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ed0c146f-0a47-ef56-f919-4887d6a69001@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@rjwysocki.net, lorenzo.pieralisi@arm.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Dec 10, 2018 at 7:59 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Yangtao,
>
>
> On 20/11/2018 17:14, Yangtao Li wrote:
> > of_find_node_by_path() acquires a reference to the node
> > returned by it and that reference needs to be dropped by its caller.
> > bl_idle_init() doesn't do that, so fix it.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> > Changes in v3:
> > -update changelog
> > ---
> >  drivers/cpuidle/cpuidle-big_little.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpuidle/cpuidle-big_little.c b/drivers/cpuidle/cpu=
idle-big_little.c
> > index db2ede565f1a..650f063ef809 100644
> > --- a/drivers/cpuidle/cpuidle-big_little.c
> > +++ b/drivers/cpuidle/cpuidle-big_little.c
> > @@ -174,8 +174,12 @@ static int __init bl_idle_init(void)
> >       /*
> >        * Initialize the driver just for a compliant set of machines
> >        */
> > -     if (!of_match_node(compatible_machine_match, root))
> > +     if (!of_match_node(compatible_machine_match, root)){
> > +             of_node_put(root);
> >               return -ENODEV;
> > +     }
> > +
> > +     of_node_put(root);
>
> Don't duplicate the of_node_put.
>
> I suggest:
>
> const struct of_device_id *match_id;
>
> [ ... ]
>
>
> match_id =3D of_match_node(compatible_machine_match, root);
>
> of_node_put(root);
>
> if (!match_id)
>         return -ENODEV;
>
>
Thank you for your suggestion, the new one has been sent.

Yours,
Yangtao
> >       if (!mcpm_is_available())
> >               return -EUNATCH;
> >
>
>
> --
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
