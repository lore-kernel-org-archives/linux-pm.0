From: Chanwoo Choi <cwchoi00@gmail.com>
Subject: Re: [PATCH v3] PM / devfreq: Restart previous governor if new
 governor fails to start
Date: Sat, 12 Nov 2016 11:18:51 +0900
Message-ID: <CAGTfZH0bDUBabPEZTGgD2U2YGAWkgKkGbsa4gVTdh=bq23Sn=Q@mail.gmail.com>
References: <CGME20161026191715epcas1p311c2c626563a736e14c83fb0504c099e@epcas1p3.samsung.com>
 <1477509425-16936-1-git-send-email-skannan@codeaurora.org>
 <de0f8010-31b2-8cec-f793-393c2199f44d@samsung.com> <5820CE7E.40802@codeaurora.org>
 <5821948B.2010907@samsung.com> <58223AF1.2030605@codeaurora.org>
 <58227CDB.6050907@samsung.com> <58228B9E.2090108@samsung.com>
 <58228C10.3070502@samsung.com> <58238840.90802@codeaurora.org>
 <5823BB01.3090502@samsung.com> <58265352.4030708@codeaurora.org> <CAGTfZH3ocH-noZPomBedTWjD5xmxDSw39bmDV73yZFB1ACgahw@mail.gmail.com>
Reply-To: cwchoi00@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGTfZH3ocH-noZPomBedTWjD5xmxDSw39bmDV73yZFB1ACgahw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

2016-11-12 11:17 GMT+09:00 Chanwoo Choi <cwchoi00@gmail.com>:
> 2016-11-12 8:25 GMT+09:00 Saravana Kannan <skannan@codeaurora.org>:
>> On 11/09/2016 04:10 PM, Chanwoo Choi wrote:
>>>
>>> Hi,
>>>
>>> On 2016=EB=85=84 11=EC=9B=94 10=EC=9D=BC 05:34, Saravana Kannan wrote:
>>>>
>>>> On 11/08/2016 06:38 PM, Chanwoo Choi wrote:
>>>>>
>>>>> On 2016=EB=85=84 11=EC=9B=94 09=EC=9D=BC 11:36, Chanwoo Choi wrote:
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> On 2016=EB=85=84 11=EC=9B=94 09=EC=9D=BC 10:33, Chanwoo Choi wrote:
>>>>>>>
>>>>>>> On 2016=EB=85=84 11=EC=9B=94 09=EC=9D=BC 05:52, Saravana Kannan wro=
te:
>>>>>>>>
>>>>>>>> On 11/08/2016 01:02 AM, Chanwoo Choi wrote:
>>>>>>>>>
>>>>>>>>> Hi,
>>>>>>>>>
>>>>>>>>> On 2016=EB=85=84 11=EC=9B=94 08=EC=9D=BC 03:57, Saravana Kannan w=
rote:
>>>>>>>>>>
>>>>>>>>>> On 10/26/2016 05:06 PM, Chanwoo Choi wrote:
>>>>>>>>>>>
>>>>>>>>>>> Hi,
>>>>>>>>>>>
>>>>>>>>>>> On 2016=EB=85=84 10=EC=9B=94 27=EC=9D=BC 04:17, Saravana Kannan=
 wrote:
>>>>>>>>>>>>
>>>>>>>>>>>> If the new governor fails to start, switch back to old governo=
r
>>>>>>>>>>>> so that the
>>>>>>>>>>>> devfreq state is not left in some weird limbo.
>>>>>>>>>>>>
>>>>>>>>>>>> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
>>>>>>>>>>>> ---
>>>>>>>>>>>> * Fix NULL deref for real this time.
>>>>>>>>>>>> * Addressed some style preferences.
>>>>>>>>>>>>
>>>>>>>>>>>>      drivers/devfreq/devfreq.c | 13 +++++++++++--
>>>>>>>>>>>>      1 file changed, 11 insertions(+), 2 deletions(-)
>>>>>>>>>>>>
>>>>>>>>>>>> diff --git a/drivers/devfreq/devfreq.c
>>>>>>>>>>>> b/drivers/devfreq/devfreq.c
>>>>>>>>>>>> index bf3ea76..77c41a5 100644
>>>>>>>>>>>> --- a/drivers/devfreq/devfreq.c
>>>>>>>>>>>> +++ b/drivers/devfreq/devfreq.c
>>>>>>>>>>>> @@ -919,7 +919,7 @@ static ssize_t governor_store(struct devic=
e
>>>>>>>>>>>> *dev, struct device_attribute *attr,
>>>>>>>>>>>>          struct devfreq *df =3D to_devfreq(dev);
>>>>>>>>>>>>          int ret;
>>>>>>>>>>>>          char str_governor[DEVFREQ_NAME_LEN + 1];
>>>>>>>>>>>> -    struct devfreq_governor *governor;
>>>>>>>>>>>> +    const struct devfreq_governor *governor, *prev_governor;
>>>>>>>>>>>>
>>>>>>>>>>>>          ret =3D sscanf(buf, "%" __stringify(DEVFREQ_NAME_LEN)=
 "s",
>>>>>>>>>>>> str_governor);
>>>>>>>>>>>>          if (ret !=3D 1)
>>>>>>>>>>>> @@ -944,12 +944,21 @@ static ssize_t governor_store(struct dev=
ice
>>>>>>>>>>>> *dev, struct device_attribute *attr,
>>>>>>>>>>>>                  goto out;
>>>>>>>>>>>>              }
>>>>>>>>>>>>          }
>>>>>>>>>>>> +    prev_governor =3D df->governor;
>>>>>>>>>>>>          df->governor =3D governor;
>>>>>>>>>>>>          strncpy(df->governor_name, governor->name,
>>>>>>>>>>>> DEVFREQ_NAME_LEN);
>>>>>>>>>>>>          ret =3D df->governor->event_handler(df, DEVFREQ_GOV_S=
TART,
>>>>>>>>>>>> NULL);
>>>>>>>>>>>> -    if (ret)
>>>>>>>>>>>> +    if (ret) {
>>>>>>>>>>>>              dev_warn(dev, "%s: Governor %s not started(%d)\n"=
,
>>>>>>>>>>>>                   __func__, df->governor->name, ret);
>>>>>>>>>>>> +        if (prev_governor) {
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> I think that prev_governor is always set. You don't need to che=
ck
>>>>>>>>>>> it.
>>>>>>>>>>> Why do check it?
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Not true. Even higher up in this function, we check if df->gover=
nor
>>>>>>>>>> !=3D NULL. Simple example would be that the default governor pas=
sed in while
>>>>>>>>>> adding the device isn't compiled in.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> I don't understand. If device is not registered by
>>>>>>>>> devfreq_add_device(),
>>>>>>>>> you don't change the governor by using governor_store().
>>>>>>>>>
>>>>>>>>> If you can change the governor through governor_store(),
>>>>>>>>> it means that the devfreq instance was added without any problem.
>>>>>>>>> The added devfreq instance must have the sepecific governor
>>>>>>>>> on df->governor variable.
>>>>>>>>>
>>>>>>>>> So, I think that df->governor is always set and then prev_governo=
r
>>>>>>>>> is always set.
>>>>>>>>
>>>>>>>>
>>>>>>>> Read the code more closely. add_device doesn't (and shouldn't) fai=
l
>>>>>>>> if the governor isn't present. After that, the governor could be c=
hanged
>>>>>>>> from user space.
>>>>>>>
>>>>>>>
>>>>>>> If governor is not present during devfreq_add_device(),
>>>>>>> the devfreq instance is not able to register the devfreq framework.
>>>>>>> So, the user never touch the sysfs[1] to change the governor
>>>>>>> because the sysfs[1] is not created by devfreq framework.
>>>>>>> [1] /sys/class/devfreq/[device name]/governor
>>>>>>>
>>>>>>> In summary, if governor is not present during devfreq_add_device(),
>>>>>>> the devfreq framework doesn't create tye sysfs[1] for governor.
>>>>>>>
>>>>>>> The user-space never change the governor through sysfs[1]
>>>>>>> because there is no any sysfs entry[1].
>>>>>>
>>>>>>
>>>>>> I checked the code of devfreq_add_device().
>>>>>> As you mentioned, if there is no governor,
>>>>>> devfreq_add_device() don't pass wihtout calling the
>>>>>> devfreq->governor->even_handler().
>>>>>
>>>>>
>>>>> Wrong expression / don't pass -> pass
>>>>>
>>>>
>>>> I think it's correct as is. Just because the governor isn't there (or
>>>> hasn't registered yet) doesn't mean the device add should fail.
>>>>
>>>> That aside, do you care to ack this patch for the way the code is
>>>> currently?
>>>
>>>
>>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>>
>>
>> Thanks
>>
>>> After fixing the bug of devfreq_add_device(),
>>> I'll remove the unneeded 'if statement' of prev_governor in
>>> governor_store.
>>>
>>
>> As mentioned earlier, I don't think it's a bug. It's fine as is.
>
> No. I think it is a bug. The goal of devfreq should handle the frequency/=
voltage
> with governor. If governor is not necessary of the specific device, the d=
evice
> driver don't need to use the devfreq.
>
> The default governor is always available and necessary of the device driv=
er.

The default governor have to be always available and necessary of the
device driver.


--=20
Best Regards,
Chanwoo Choi
