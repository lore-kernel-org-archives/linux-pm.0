From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: =?UTF-8?B?562U5aSNOiBbUEFUQ0hdIGNwdWlkbGU6IHNpcmYgOiBBZGQgY3A=?=
 =?UTF-8?B?dWlkbGUgZm9yIFNpUkZwcmltYUlJIGFuZCBTaVJGYXRsYXNWSQ==?=
Date: Thu, 10 Oct 2013 12:57:58 +0200
Message-ID: <52568836.8090507@linaro.org>
References: <1381033577-19818-1-git-send-email-Baohua.Song@csr.com> <52526F8B.6030905@linaro.org> <86130EF012BDF348AA0D464A4F4494780129539EE4@SHAASIEXM01.ASIA.ROOT.PRI> <5253DD3C.90008@linaro.org> <CAGsJ_4xeUBnudhmoXjQ03QbQ4PH4QVDRgFmYGY7kP6S_6qKv=A@mail.gmail.com> <52554771.9000501@linaro.org> <CAGsJ_4zBGNgqg12-U4m7G3G5LsPNw89gs=D==XEU36=wK=KjvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:53789 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821Ab3JJK6B (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Oct 2013 06:58:01 -0400
Received: by mail-wg0-f50.google.com with SMTP id f12so2290663wgh.17
        for <linux-pm@vger.kernel.org>; Thu, 10 Oct 2013 03:58:00 -0700 (PDT)
In-Reply-To: <CAGsJ_4zBGNgqg12-U4m7G3G5LsPNw89gs=D==XEU36=wK=KjvA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: Rongjun Ying <Rongjun.Ying@csr.com>, "rjw@sisk.pl" <rjw@sisk.pl>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Barry Song <Barry.Song@csr.com>, Viresh Kumar <viresh.kumar@linaro.org>

On 10/10/2013 12:24 PM, Barry Song wrote:
> 2013/10/9 Daniel Lezcano <daniel.lezcano@linaro.org>:
>> On 10/08/2013 03:27 PM, Barry Song wrote:
>>>>>>>
>>>>>>> +       if (sirf_cpuidle.vcore_regulator)
>>>>>>> +               regulator_set_voltage(sirf_cpuidle.vcore_regula=
tor,
>>>>>>> volt_old,
>>>>>>> +                               SIRFSOC_MAX_VOLTAGE);
>>>>>>> +
>>>>>>> +       clk_set_parent(sirf_cpuidle.cpu_clk, parent_clk);
>>>>>>> +       /* Todo: other C states */
>>>>>>
>>>>>>
>>>>>>
>>>>>> It sounds very weird you have this freq/volt/opp code here.
>>>>>>
>>>>>> If you hit idle, the cpufreq driver didn't put the cpu in the st=
ate you
>>>>>> are trying to
>>>>>> bring here ?
>>>>>>
>>>>>> There isn't a power management unit on this board ?
>>>>>>
>>>>>
>>>>> By SiRF SoC, when enter idle mode, I set the freq to 26MHz and mi=
n
>>>>> voltage.
>>>>> That's will save the power consume and reduce leakage current.
>>>>
>>>>
>>>>
>>>> Really ? :)
>>>>
>>>> You didn't answer the questions.
>>>>
>>>> 1. this code shouldn't be here but in cpufreq which is already the=
 case
>>>> with
>>>> the other patch you sent with this one. So I am convinced if you r=
emove
>>>> the
>>>> OPP here and let cpufreq to handle that, and keep the cpu_do_idle,=
 you
>>>> won't
>>>> see any difference with the current code.
>>>>
>>>> 2. Moreover, removing the OPP, there is only the WFI state which i=
s the
>>>> default idle function. Hence the cpuidle driver itself has no inte=
rest
>>>> and
>>>> you can simply remove it, except if you bring another idle state w=
ith the
>>>> driver.
>>>>
>>>> 3. More idle states are often handled through a PMU (Power Managem=
ent
>>>> Unit)
>>>> giving cpu power off, retention, cluster power down, etc ... Is th=
ere one
>>>> on
>>>> this board ?
>>>>
>>>> The TRM can help to answer these questions.
>>>>
>>> Hi Daniel,
>>> here the codes actually want to put cpu into lowest freq and lowest
>>> voltage. because according to our test, power leakage will be much
>>> lower when cpu is in the status than we put it into WFI directly in=
 a
>>> higher freq.
>>>
>>> here it is difficult to say cpufreq will do that automatically as i=
t
>>> is decided by cpufreq policy.
>>>
>>> there is no power management unit which can put prima2 into a
>>> different idle status except WFI.
>>>
>>> any suggestion from you about this chip issue?
>>
>>
>> Not so much without further information. Definitively without the TR=
M it is
>> hard to give any hints on how to go further.
>>
>> Do you have the ability to do RAM self refresh ? If not, without a p=
ower
>> management unit on your board, in my opinion you can drop the cpuidl=
e driver
>> because it means you can't do retention or poweroff the core.
>
> if dropping the cpuidle, actually the only left mode is WFI. but here
> the problem is that WFI is not enough for us due to our chips have
> some current leak in WFI. so here the driver is specific to sirf to
> fix the current leak in WFI.
>
> and i also don't think cpufreq will put hardware to low vol and low
> freq automatically. at least for performance and user, it is
> impossible.

Yes and that is the proof the OPP in cpuidle violates the cpufreq=20
governor decision. Let's pick an example:

I don't know your board so I will assume we have 300, 600, 900 MHz.

The user set the policy to 'userspace' and sets the freq to 600MHz, the=
=20
cpuidle will change that to 900MHz when exiting idle.

The user set the policy to 'performance', cpuidle switch to 300MHz=20
despite the cpufreq governor told 900MHz.

The user set the policy to 'ondemand', the cpufreq governor set the OPP=
=20
to 600MHz but cpuidle change it to 300MHz, then 900MHz.

I am not a cpufreq expert but IMHO that will mess up the cpufreq=20
governor, without talking about the freq changes notifiers.

Don't you have warning in dmesg ?

"Warning: CPU frequency out of sync: cpufreq and timing ..."

> for other policies like ondemand, i'd like to have rongjun
> collect some proof by doing some run+sleep +run+sleep... loop to chec=
k
> the actual behaviour.

Yeah, that would be nice.

>> Moreover, the OPP stuff, from a POV design, is tied with cpufreq and
>> changing that from cpuidle will violate the decisions of the cpufreq
>> governor.
>>
>> Did you do some measurements without cpuidle but with the cpufreq go=
vernor
>> 'ondemand' and compare that with the cpuidle driver you are submitti=
ng ?
>
> i'd like rongjun will provide measured data on real boards we have
> done before. i think the WFI+low vol+low freq comes from some real
> measurement before.
>
>>
>> Hopefully, Viresh (Cc'ed) can give its opinion.
>>
>>
>> Thanks
>>    -- Daniel
>
> rongjun, pls keep one eye on this thread until we provide enough
> persuasiveness and all problems are clarified here.
>
> -barry
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

