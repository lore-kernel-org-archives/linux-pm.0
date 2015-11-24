From: Chanwoo Choi <cwchoi00@gmail.com>
Subject: Re: Re: Re: [PATCH 6/6] PM / devfreq: Set the min_freq and max_freq
 of devfreq device
Date: Tue, 24 Nov 2015 22:48:33 +0900
Message-ID: <CAGTfZH1=1a4yUO+d+NCj6KM_eSevsL25V1Kh+Y271-CW5ajzaw@mail.gmail.com>
References: <1970403923.135851448270013777.JavaMail.weblogic@epmlwas06a>
Reply-To: cw00.choi@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1970403923.135851448270013777.JavaMail.weblogic@epmlwas06a>
Sender: linux-kernel-owner@vger.kernel.org
To: "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>
Cc: =?UTF-8?B?67CV6rK966+8?= <kyungmin.park@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Nov 23, 2015 at 6:13 PM, MyungJoo Ham <myungjoo.ham@samsung.com> wrote:
>> On Mon, Nov 23, 2015 at 4:21 PM, MyungJoo Ham <myungjoo.ham@samsung.com> wrote:
>> > []
>> >> >
>> >> > The value 0 is used for min/max_freq to declare
>> >> > that min/max_freq is deactivated. Therefore, it is not
>> >> > required to do so; they are not intended to show the hardware
>> >> > configuration as well.
>> >>
>> >> This case consider the devfreq device using OPP because devfreq_set_freq_table()
>> >> get the number of OPP entry in OPP list before setting the min_freq/max_freq.
>> >> If the devfreq device don't use the OPP entry, devfreq_set_freq_table()
>> >> will return without any operation.
>> >>
>> >> IMHO, when devfreq device uses the OPP table including the frequency,
>> >> min_freq/max_freq should show the correct value as CPUFREQ framework.
>> >>
>> >
>> > The side effect of this patch shows up when opp_disable() and opp_enable()
>> > are used.
>>
>> Ah. You're right.
>> I was not considering the the case of using opp_disable() and opp_enable().
>> I'll consider it again including the usage case of opp_diable/opp_enable.
>>
>
> Even without the side effect, what would be the meaning of initializing
> min/max-freq to the device min/max capabilities when the users may
> override it with arbitrary lower/higher values?

Yes, the user can update min_freq/max_freq because this attribute have
the writable permission.

The users might think that min_freq/max_freq provide the users with
the minimum and maximum frequency.
because CPUFREQ show the frequency on scaling_min_freq / scaling_max_freq.
But, right after kernel booting, min_freq/max_freq is zero (0). I
think that it cause the confusion for users.

Regards,
Chanwoo Choi
