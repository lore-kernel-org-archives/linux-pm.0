From: Chanwoo Choi <cwchoi00@gmail.com>
Subject: Re: [RFC v2 0/7] PM / devfreq: draft for OPP suspend impl (even draftier)
Date: Tue, 20 Dec 2016 00:51:59 +0900
Message-ID: <CAGTfZH37dzURemtCHnCDUHXdT6xqcthxXCOLrG+W2QZr3EvD2A@mail.gmail.com>
References: <CGME20161219021836epcas1p37f8c12ca0bc7a404fc206f81331811bb@epcas1p3.samsung.com>
 <1482113787-28422-1-git-send-email-tjakobi@math.uni-bielefeld.de>
 <5857C1FB.2040101@samsung.com> <5857F52A.3010008@math.uni-bielefeld.de>
Reply-To: cwchoi00@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <5857F52A.3010008@math.uni-bielefeld.de>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Markus Reichl <m.reichl@fivetechno.de>, MyungJoo Ham <myungjoo.ham@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi Tobias,

2016-12-19 23:56 GMT+09:00 Tobias Jakobi <tjakobi@math.uni-bielefeld.de>:
> Hello Chanwoo,
>
> thanks for the comments!
>
>
> Chanwoo Choi wrote:
>> Hi Tobias,
>>
>> On 2016=EB=85=84 12=EC=9B=94 19=EC=9D=BC 11:16, Tobias Jakobi wrote:
>>> Hello everyone,
>>>
>>> this is v2 of the RFC. You can find the first version here:
>>> https://www.spinics.net/lists/linux-samsung-soc/msg56331.html
>>>
>>> I'm still unhappy with this approach, for multiple reasons:
>>> - the global boolean -- cpufreq also has it, but I have the feeling tha=
t we don't need it here.
>>
>>> - keeping track of which device was suspended looks convoluted -- some =
reference counting would definitely help here.
>>> - the bus driver (here exynos_bus) sets suspend_freq, but devfreq core =
actually uses it.
>>> - returning -EBUSY from devfreq_{suspend,resume}_device() requires hand=
ling this in the device drivers -- again refcounting could solve this.
>>> - rather a question: do we need the restore on resume -- or should be j=
ust wait for the next update through the governor?
>>> - like Chanwoo already suggested, move setting suspend freq to devfreq_=
suspend_device().
>>
>> I want to separate the two subject as following:
>> - subject1 : Where should devfreq set the suspend-freq for device.
>> - subject2 : How can devfreq support the duplicate call of devfreq_{susp=
end,resume}_device().
>>
>> For subject1:
>> I explain why devfreq need to set the supend-freq in devfreq_suspend_dev=
ice().
>> Following explanation do not include the refcount of suspend and bit ope=
ration.
>>
>> The devfreq has two case to enter the suspend mode for devfreq instance =
as following:
>> case 1. Some device driver call the 'devfreq_suspend/resume_device()' di=
rectly regardless the sequence of suspend mode (echo mem > /sys/power/state=
).
>> case 2. The system enter the suspend mode by using 'echo mem > /sys/powe=
r/state' command.
> You forgot normal system reboot and shutdown, but I guess we can sort
> this into category 2.
>
>> When setting suspend frequency in the devfreq_suspend/resume_device(),
>> this suggestion can cover all cases for suspend freq setting.
>>
>> I make the separate function[1] to set the frequency.
>> [1] https://git.kernel.org/cgit/linux/kernel/git/chanwoo/linux.git/commi=
t/?h=EF=BF=BDvfreq-test&id=EF=BF=BD51e989ccaf0ee23a4278724227e879f8752625
> Looks like I good idea to encapsulate this. Do you think it makes sense
> to base my series on your branch? I think the soonest when this series
> is going to land is 4.11 anyway.

I'm not sure. But, I already sent these patches[1][2] to fix the bug
and update devfreq/devfreq-event driver.
If you mention the base commit[1][2] on cover-letter, I think there is
no problem.
[1] https://lkml.org/lkml/2016/12/15/119
[2] https://lkml.org/lkml/2016/12/15/122

>
>
>>       devfreq_suspend_device(struct devfreq *devfreq) {
>>               /* Enter the suspend mode */
>>               devfreq->governor->event_handler(devfreq, DEVFREQ_GOV_SUSP=
END, NULL);
>>
>>               /* Set the suspend-freq */
>>               devfreq_set_target(devfreq, devfreq->suspend_freq, 0);
>>       }
>>
>>       devfreq_resume_device(struct devfreq *devfreq) {
>>               /* Set the resume freq */
>>               devfreq_set_target(devfreq, devfreq->resume_freq, 0);
>>
>>               /* Wakeup from suspend mode */
>>               devfreq->governor->event_handler(devfreq, DEVFREQ_GOV_RESU=
ME, NULL);
>>       }
>>
>> And,
>> devfreq_suspend() call the devfreq_suspend_device() for all registered d=
evfreq instance.
>>
>>       void devfreq_suspend(void)
>>       {
>>               mutex_lock(&devfreq_list_lock);
>>
>>               list_for_each_entry(devfreq, &devfreq_list, node) {
>>                       ret =3Devfreq_suspend_device(devfreq);
>>                       if (ret < 0)
>>                               dev_warn(&devfreq->dev, "%s: governor susp=
end failed\n", __func__);
>>               }
>>
>>               mutex_unlock(&devfreq_list_lock);
>>       }
>>
>>       void devfreq_resume(void)
>>       {
>>               mutex_lock(&devfreq_list_lock);
>>
>>               list_for_each_entry(devfreq, &devfreq_list, node) {
>>                       ret =3Devfreq_resume_device(devfreq);
>>                       if (ret < 0)
>>                               dev_warn(&devfreq->dev, "%s: governor resu=
me failed\n", __func__);
>>               }
>>
>>               mutex_unlock(&devfreq_list_lock);
>>       }
> OK, so you rather see the main logic moved into
> devfreq_{resume,suspend}_device().
>
> What about my other questions?
> - resume freq, yes or no?
> - is the core/driver mismatch with respect to setting/using suspend_freq
> an issue? (not functional, but for the design)

I think that suspend-freq support is enough without resume-freq. After
wakeup from suspend mode, the devfreq will decide the proper frequency
level on first time of governor.

>
>
>
>> For subject2:
>> - subject2 : How can devfreq support the duplicate call of devfreq_{susp=
end,resume}_device().
>> devfreq_{suspend,resume}_device() have to check whether devfreq device i=
s already suspended or not
>> with refcount or enum devfreq_flag_bits.
> I think that with a bitflag we cannot avoid having some extra logic in
> the device drivers to handle whatever error code we return from
> devfreq_{resume,suspend}_device().
>
> I'll take the refcount route for now.

OK. I recommend that you better to implement the refcount in
devfreq_{suspend,resume}_device().

>
>
>> If devfreq_{suspend,resume}_device() support it, devfreq_suspend/resume(=
) don't need to consider duplicate call.
>>
>>>
>>> Concerning refcounting, I'm a bit unsure what we wanna count here? Usua=
lly we count usage. If usage goes from zero to one, we do something (alloc)=
, and when it goes back from one to zero (free).
>>> If we keep the current semantics however we have to count number of sus=
pends. That's kinda unintuitive if you ask me.
> What about this question? So you want me to refcount number of suspend?
>
> Or should we refcount usage, i.e. we start with refcount=3D1 and allow
> refcounts<=3D1 (also negative).

I prefer that the refcount start from zero(0). When calling the
devfreq_suspend_device(), the refcount should be increased. This way
support the all of case when calling the devfreq_suspend_device() on
various time.

devfreq_suspend_device(struct devfreq *devfreq)
       if (devfreq->suspend_count > 0) {
             devfreq->suspend_count++;
             return 0;
       }
       devfreq->suspend_count++;

       // ......


devfreq_resume_device(struct devfreq *devfreq)
       if (devfreq->suspend_count >0) {
             devfreq->suspend_count--;
       } else {
             return -EINVAL;
      }

       // ......


>
> Again, this is more a design than a functional issue.
>
>
> I'll try to post a v3 in the next days. Not sure when though, with
> Christmas upcoming and all :)

OK.

[snip]

--=20
Best Regards,
Chanwoo Choi
