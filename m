From: Chanwoo Choi <cwchoi00@gmail.com>
Subject: Re: [PATCH] devfreq: rk3399_dmc: Don't use OPP structures outside of
 RCU locks
Date: Fri, 2 Dec 2016 22:26:33 +0900
Message-ID: <CAGTfZH2WWN1X8uL8+Lt56aZJ=TZar6YBt7jiQUfoPyrWGigzoQ@mail.gmail.com>
References: <CGME20161201103813epcas4p116430ac17cea842a7f09b35f0969ccb0@epcas4p1.samsung.com>
 <22bf6dfc155a6a241c2ee4e2b44a615d0e82064d.1480588658.git.viresh.kumar@linaro.org>
 <584133F9.4080006@samsung.com> <20161202090047.GA22049@vireshk-i7> <CAGTfZH1BHODSgq=ou-63iw2JTBMpzbMkGTmTscALrX3FMG-7AA@mail.gmail.com>
Reply-To: cwchoi00@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:35815 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760262AbcLBN0y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Dec 2016 08:26:54 -0500
Received: by mail-qk0-f196.google.com with SMTP id n204so30397023qke.2
        for <linux-pm@vger.kernel.org>; Fri, 02 Dec 2016 05:26:54 -0800 (PST)
In-Reply-To: <CAGTfZH1BHODSgq=ou-63iw2JTBMpzbMkGTmTscALrX3FMG-7AA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, nm@ti.com, linaro-kernel@lists.linaro.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, Stephen Boyd <sboyd@codeaurora.org>, Kyungmin Park <kyungmin.park@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>

Hi Viresh,

I'm sorry. I sent the mail without any message. It is my mistake.

2016-12-02 22:21 GMT+09:00 Chanwoo Choi <cwchoi00@gmail.com>:
> Hi Viresh,
>
> 2016-12-02 18:00 GMT+09:00 Viresh Kumar <viresh.kumar@linaro.org>:
>> Hi Chanwoo,
>>
>> Thanks for trying to review all these patches.
>>
>> On 02-12-16, 17:42, Chanwoo Choi wrote:
>>> Hi Viresh,
>>>
>>> On 2016=EB=85=84 12=EC=9B=94 01=EC=9D=BC 19:38, Viresh Kumar wrote:
>>> > The OPP structures are abused to the best here, without understanding
>>> > how the OPP core and RCU locks work.
>>> >
>>> > In short, the OPP pointer saved in 'rk3399_dmcfreq' can become invali=
d
>>> > under your nose, as the OPP core may free it.
>>> >
>>> > Fix various abuses around OPP structures and calls.
>>> >
>>> > Compile tested only.
>>> >
>>> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>>> > ---
>>> > I would like it to go via the PM tree. Perhaps that's already the
>>> > default tree for this.
>>> >
>>> >  drivers/devfreq/rk3399_dmc.c | 11 +++++------
>>> >  1 file changed, 5 insertions(+), 6 deletions(-)
>>> >
>>> > diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dm=
c.c
>>> > index 5063ac1a5939..cf14631b1945 100644
>>> > --- a/drivers/devfreq/rk3399_dmc.c
>>> > +++ b/drivers/devfreq/rk3399_dmc.c
>>> > @@ -80,7 +80,6 @@ struct rk3399_dmcfreq {
>>> >     struct regulator *vdd_center;
>>> >     unsigned long rate, target_rate;
>>> >     unsigned long volt, target_volt;
>>> > -   struct dev_pm_opp *curr_opp;
>>> >  };
>>> >
>>> >  static int rk3399_dmcfreq_target(struct device *dev, unsigned long *=
freq,
>>> > @@ -102,9 +101,6 @@ static int rk3399_dmcfreq_target(struct device *d=
ev, unsigned long *freq,
>>> >     target_rate =3D dev_pm_opp_get_freq(opp);
>>> >     target_volt =3D dev_pm_opp_get_voltage(opp);
>>> >
>>> > -   dmcfreq->rate =3D dev_pm_opp_get_freq(dmcfreq->curr_opp);
>>> > -   dmcfreq->volt =3D dev_pm_opp_get_voltage(dmcfreq->curr_opp);
>>> > -
>>> >     rcu_read_unlock();
>>> >
>>> >     if (dmcfreq->rate =3D=3D target_rate)
>>>
>>> dmcfreq->rate is used on here.
>>
>> Are you trying to say that dmcfreq->rate is required to have the right v=
alue as
>> we will be using it here for comparison? If yes, then ...
>>
>>> Maybe struct rk3399_dmcfreq need to add the new 'curr_freq' field.
>>>
>>>
>>> > @@ -165,7 +161,9 @@ static int rk3399_dmcfreq_target(struct device *d=
ev, unsigned long *freq,
>>> >     if (err)
>>> >             dev_err(dev, "Cannot to set vol %lu uV\n", target_volt);
>>> >
>>> > -   dmcfreq->curr_opp =3D opp;
>>> > +   dmcfreq->rate =3D target_rate;
>>> > +   dmcfreq->volt =3D target_volt;
>>
>> This takes care of it for all cases except the first call to target()...

You're right. I could not think of it.

As you mentioned, except the first call to target(), this patch looks
good to me.
On the first call, the target() should change the appropriate freq/voltage
according to the real utilization.

I'm sorry for my confusion. Feel free to add my reviewed tag.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

[snip]

--=20
Best Regards,
Chanwoo Choi
