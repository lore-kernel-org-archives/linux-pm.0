From: Chanwoo Choi <cwchoi00@gmail.com>
Subject: Re: [PATCH v1 & v6 1/2] PM/devfreq: add suspend frequency support
Date: Sat, 17 Dec 2016 23:50:03 +0900
Message-ID: <CAGTfZH34MvFGGuPgt=qUM6FMmi+Z80akY5ZH1k6gXdzg19fh9Q@mail.gmail.com>
References: <CGME20161124061416epcms1p44a0152bca14312f1229cab835ea0297f@epcms1p4>
 <20161124061416epcms1p44a0152bca14312f1229cab835ea0297f@epcms1p4>
 <58368C91.8030502@rock-chips.com> <5836927B.9010205@samsung.com>
 <5836980F.6050006@rock-chips.com> <5836A1E0.1070707@samsung.com>
 <5836A622.20007@rock-chips.com> <5836B2C2.6090308@samsung.com> <5836B8D1.9050707@samsung.com>
Reply-To: cwchoi00@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34610 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756616AbcLQOuY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 17 Dec 2016 09:50:24 -0500
In-Reply-To: <5836B8D1.9050707@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: hl <hl@rock-chips.com>, "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "dbasehore@chromium.org" <dbasehore@chromium.org>, "dianders@chromium.org" <dianders@chromium.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>

Hi Lin,

2016-11-24 18:54 GMT+09:00 Chanwoo Choi <cw00.choi@samsung.com>:
> Hi Lin,
>
> On 2016=EB=85=84 11=EC=9B=94 24=EC=9D=BC 18:28, Chanwoo Choi wrote:
>> Hi Lin,
>>
>> On 2016=EB=85=84 11=EC=9B=94 24=EC=9D=BC 17:34, hl wrote:
>>> Hi Chanwoo Choi,
>>>
>>>
>>> On 2016=E5=B9=B411=E6=9C=8824=E6=97=A5 16:16, Chanwoo Choi wrote:
>>>> Hi Lin,
>>>>
>>>> On 2016=EB=85=84 11=EC=9B=94 24=EC=9D=BC 16:34, hl wrote:
>>>>> Hi Chanwoo Choi,
>>>>>
>>>>>      I think the dev_pm_opp_get_suspend_opp() have implement most of
>>>>> the funtion, all we need is just define the node in dts, like followi=
ng:
>>>>>
>>>>> &dmc_opp_table {
>>>>>      opp06 {
>>>>>          opp-suspend;
>>>>>      };
>>>>> };
>>>> Two approaches use the 'opp-suspend' property.
>>>>
>>>> I think that the method to support suspend-opp have to
>>>> guarantee following conditions:
>>>> - Support the all of devfreq's governors.
>>>     As MyungJoo Ham suggestion, i will set the suspend frequency in dev=
freq_suspend_device(),
>>> which will ingore governor.
>>
>> Other approach already support the all of governors.
>> Before calling the mail, I discussed with Myungjoo Ham.
>> Myungjoo prefer to use the devfreq_suspend/devfreq_resume().
>
> It is not correct expression. We need to wait the reply from Myungjoo
> to clarify this.
>
>>
>> To Myungjoo,
>> Please add your opinion how to support the suspend frequency.
>
>>
>>>> - Devfreq framework have the responsibility to change the
>>>>    frequency/voltage for suspend-opp. If we uses the
>>>>    new devfreq_suspend(), each devfreq device don't care
>>>>    how to support the suspend-opp. Just the developer of each
>>>>    devfreq device need to add 'opp-suspend' propet to OPP entry in DT =
file.
>>> Why should support change the voltage in devfreq framework, i think it =
shuold be handle in
>>> specific driver, i think the devfreq only handle it can get the right f=
requency, then pass it to
>>
>> No, the frequency should be handled by governor or framework.
>> The each devfreq device has no any responsibility of next frequency/volt=
age.
>> The governor and core of devfreq can decide the next frequency/voltage.
>> You can refer to the cpufreq subsystem.
>>
>>> specific driver, i think the voltage should handle in the devfreq->prof=
ile->target();
>>
>> The call of devfreq->profile->target() have to be handled by devfreq fra=
mework.
>> If user want to set the suspend frequency, user can add the 'suspend-opp=
' property.
>> It think this way is easy.
>>
>> But,
>> If the each devfreq device want to decide the next frequency/voltage onl=
y for
>> suspend state. We can check the cpufreq subsystem.
>>
>> If specific devfreq device want to handle the suspend frequency,
>> each devfreq will add the own suspend/resume functions as following:
>>
>>       struct devfreq_dev_profile {
>>               int (*suspend)(struct devfreq *dev);    // new function po=
inter
>>               int (*resume)(struct devfreq *dev);     // new function po=
inter
>>       } a_profile;
>>
>>       a_profile =3D devfreq_generic_suspend;
>>
>>       The devfreq framework will provide the devfreq_generic_suspend() f=
unticon.
>>               int devfreq_generic_suspend(struce devfreq *dev) {
>>                       ...
>>                       devfreq->profile->target(..., devfreq->suspend_fre=
q);
>>                       ...
>>               }
>>
>>       or
>>
>>       a_profile =3D a_devfreq_suspend; // specific function of each devf=
req device
>>
>>       The devfreq_suspend() will call 'devfreq->profile->suspend()' func=
tion
>>       instead of devfreq->profile->target();
>>
>>       The devfreq call the 'devfreq->profile->suspend()'
>>       to support the suspend frequency.
>>
>> Regards,
>> Chanwoo Choi
>
> The key difference between two approaches:
>
> Your approach:
> - The each developer should add the 'opp-suspend' property to the dts fil=
e.
> - The each devfreq should call the devfreq_suspend_device()
>   to support the suspend frequency.
>
>   If each devfreq doesn't call the devfreq_suspend_device(), devfreq fram=
ework
>   can support the suspend frequency.
>
> Other approach:
> - The each developer only should add the 'opp-suspend' property to the dt=
s file
>   without the additional behavior.
>
> In the cpufreq subsystem,
> When support the suspend frequency of cpufreq, we just add 'opp-suspend' =
property
> without the additional behavior.

I'm missing the use-case when using the devfreq_suspend_device()
before entering the suspend mode. We should consider the case when
devfreq device
calls the devfreq_suspend_device() directly. Because devfreq_suspend_device=
()
is exported function, each devfreq device call this function on the fly
without entering the suspend mode.

I correct my opinion. Your approach is necessary. I'm sorry to confuse you.
So, I make the following patch. This patch set the suspend frequency
in devfreq_suspend_device() after stoping the governor.
It consider the all governors of devfreq.

What do you think?
If you are ok, I'll send this patch with your author.

 int devfreq_suspend_device(struct devfreq *devfreq)
 {
+      int ret =3D 0;
+
        if (!devfreq)
        return -EINVAL;

        if (!devfreq->governor)
             return 0;

-      return devfreq->governor->event_handler(devfreq,
+     ret =3D devfreq->governor->event_handler(devfreq,
                    DEVFREQ_GOV_SUSPEND, NULL);
+      if (ret < 0) {
+           dev_err(devfreq->dev.parent, "failed to suspend governor\n");
+           return ret;
+      }
+
+      if (devfreq->suspend_freq) {
+           ret =3D devfreq->profile->target(devfreq->dev.parent,
+                                      &devfreq->suspend_freq, 0);
+           if (ret < 0) {
+                  dev_err(devfreq->dev.parent,
+                             "failed to set suspend-freq\n");
+                  return ret;
+           }
+           dev_dbg(devfreq->dev.parent, "Setting suspend-freq: %lu\n",
+                          devfreq->suspend_freq);
+      }
+
+      return 0;
 }
 EXPORT_SYMBOL(devfreq_suspend_device);

--=20
Best Regards,
Chanwoo Choi
