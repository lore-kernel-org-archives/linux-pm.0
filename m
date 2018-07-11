From: noman pouigt <variksla@gmail.com>
Subject: Re: Re: devfreq relation with pm qos
Date: Wed, 11 Jul 2018 10:02:30 -0700
Message-ID: <CAES_P+-=iictJKgHFGN2Mypp_+GMyTOVmZVQw=bSfHbyZMY4QA@mail.gmail.com>
References: <CAES_P+_k=fz3yMnVZni2hEnfSujctnT33zoN9-KsBLBeQaG_sA@mail.gmail.com>
 <CGME20180709213456epcas4p17e5753d1b59856a0df3790d7faef8d73@epcms1p2>
 <CAES_P+_GTRcFya=N20+b+U=HOpv9gcpYkfJW_gU_i_2pH2hmMA@mail.gmail.com> <20180710055847epcms1p2eed3f89ae0220a06051faa83cc8b21ed@epcms1p2>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180710055847epcms1p2eed3f89ae0220a06051faa83cc8b21ed@epcms1p2>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Jul 9, 2018 at 10:58 PM, MyungJoo Ham <myungjoo.ham@samsung.com> wr=
ote:
>> + dev freq maintainters.
>>
>> On Mon, Jul 9, 2018 at 3:37 AM, noman pouigt <variksla@gmail.com> wrote:
>> > folks,
>> >
>> > I am trying to figure out the relationship between PM QOS
>> > with devfreq framework. I see this thread[1] where MyungJoo
>> > talks about QOS and devfreq but that control is through
>> > sysfs but I don't see any relation of pm qos (kernel/power/qos.c)
>> > with devfreq directly as devfreq is not calling any of the QOS
>> > api's. Is this intended?
>> >
>> > Isn't QOS value update using pm_qos_update_request has a
>> > direct relation with devfreq drivers i.e. setting the value to
>> > high or low selects the corresponding voltage and frequency
>> > setting in devfreq framework? I went through the devfreq
>> > drivers and couldn't find that relationship. Is this by design or
>> > I am missing something very obvious?
>> >
>> > [1] https://lwn.net/Articles/484161/
>
> Hello,
>
> Unfortunately, the suggested concept in the referred article was not ever
> accepted in the mainline.

MyungJo, I am trying to understand the relationship of PM QOS with
devfreq drivers. I don't see any relation of PM QOS api's with devfreq driv=
ers
directly as there are no QOS apis used in the devfreq framework.

The only explanation I have is that PM QOS has direct relationship
with CPUFREQ driver and as CPUFREQ driver works with CPU
frequency and that CPU frequency directly affects DEVFREQ drivers
as devfreq driver maps CPU frequency to device frequency and
that is why PM QOS doesn=E2=80=99t have direct relation with PM QOS.

Is my understanding right?

>
> Cheers,
> MyungJo
