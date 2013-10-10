From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: =?UTF-8?B?562U5aSNOiBbUEFUQ0hdIGNwdWlkbGU6IHNpcmYgOiBBZGQgY3A=?=
 =?UTF-8?B?dWlkbGUgZm9yIFNpUkZwcmltYUlJIGFuZCBTaVJGYXRsYXNWSQ==?=
Date: Thu, 10 Oct 2013 15:58:04 +0200
Message-ID: <5256B26C.7050802@linaro.org>
References: <1381033577-19818-1-git-send-email-Baohua.Song@csr.com> <52526F8B.6030905@linaro.org> <86130EF012BDF348AA0D464A4F4494780129539EE4@SHAASIEXM01.ASIA.ROOT.PRI> <5253DD3C.90008@linaro.org> <CAGsJ_4xeUBnudhmoXjQ03QbQ4PH4QVDRgFmYGY7kP6S_6qKv=A@mail.gmail.com> <52554771.9000501@linaro.org> <CAGsJ_4zBGNgqg12-U4m7G3G5LsPNw89gs=D==XEU36=wK=KjvA@mail.gmail.com> <52568836.8090507@linaro.org> <CAGsJ_4wexNXzFbOGo5_FwVrHtFZ-XGq-KN0+yast7Jfd5iGO4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:37238 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752326Ab3JJN6I (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Oct 2013 09:58:08 -0400
Received: by mail-wi0-f174.google.com with SMTP id cb5so2169523wib.1
        for <linux-pm@vger.kernel.org>; Thu, 10 Oct 2013 06:58:06 -0700 (PDT)
In-Reply-To: <CAGsJ_4wexNXzFbOGo5_FwVrHtFZ-XGq-KN0+yast7Jfd5iGO4A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: Rongjun Ying <Rongjun.Ying@csr.com>, "rjw@sisk.pl" <rjw@sisk.pl>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Barry Song <Barry.Song@csr.com>, Viresh Kumar <viresh.kumar@linaro.org>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>

On 10/10/2013 03:07 PM, Barry Song wrote:
> 2013/10/10 Daniel Lezcano <daniel.lezcano@linaro.org>:
>> On 10/10/2013 12:24 PM, Barry Song wrote:
>>>
>>> 2013/10/9 Daniel Lezcano <daniel.lezcano@linaro.org>:
>>>>
>>>> On 10/08/2013 03:27 PM, Barry Song wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> +       if (sirf_cpuidle.vcore_regulator)
>>>>>>>>> +               regulator_set_voltage(sirf_cpuidle.vcore_regu=
lator,
>>>>>>>>> volt_old,
>>>>>>>>> +                               SIRFSOC_MAX_VOLTAGE);
>>>>>>>>> +
>>>>>>>>> +       clk_set_parent(sirf_cpuidle.cpu_clk, parent_clk);
>>>>>>>>> +       /* Todo: other C states */
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> It sounds very weird you have this freq/volt/opp code here.
>>>>>>>>
>>>>>>>> If you hit idle, the cpufreq driver didn't put the cpu in the =
state
>>>>>>>> you
>>>>>>>> are trying to
>>>>>>>> bring here ?
>>>>>>>>
>>>>>>>> There isn't a power management unit on this board ?
>>>>>>>>
>>>>>>>
>>>>>>> By SiRF SoC, when enter idle mode, I set the freq to 26MHz and =
min
>>>>>>> voltage.
>>>>>>> That's will save the power consume and reduce leakage current.
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> Really ? :)
>>>>>>
>>>>>> You didn't answer the questions.
>>>>>>
>>>>>> 1. this code shouldn't be here but in cpufreq which is already t=
he case
>>>>>> with
>>>>>> the other patch you sent with this one. So I am convinced if you=
 remove
>>>>>> the
>>>>>> OPP here and let cpufreq to handle that, and keep the cpu_do_idl=
e, you
>>>>>> won't
>>>>>> see any difference with the current code.
>>>>>>
>>>>>> 2. Moreover, removing the OPP, there is only the WFI state which=
 is the
>>>>>> default idle function. Hence the cpuidle driver itself has no in=
terest
>>>>>> and
>>>>>> you can simply remove it, except if you bring another idle state=
 with
>>>>>> the
>>>>>> driver.
>>>>>>
>>>>>> 3. More idle states are often handled through a PMU (Power Manag=
ement
>>>>>> Unit)
>>>>>> giving cpu power off, retention, cluster power down, etc ... Is =
there
>>>>>> one
>>>>>> on
>>>>>> this board ?
>>>>>>
>>>>>> The TRM can help to answer these questions.
>>>>>>
>>>>> Hi Daniel,
>>>>> here the codes actually want to put cpu into lowest freq and lowe=
st
>>>>> voltage. because according to our test, power leakage will be muc=
h
>>>>> lower when cpu is in the status than we put it into WFI directly =
in a
>>>>> higher freq.
>>>>>
>>>>> here it is difficult to say cpufreq will do that automatically as=
 it
>>>>> is decided by cpufreq policy.
>>>>>
>>>>> there is no power management unit which can put prima2 into a
>>>>> different idle status except WFI.
>>>>>
>>>>> any suggestion from you about this chip issue?
>>>>
>>>>
>>>>
>>>> Not so much without further information. Definitively without the =
TRM it
>>>> is
>>>> hard to give any hints on how to go further.
>>>>
>>>> Do you have the ability to do RAM self refresh ? If not, without a=
 power
>>>> management unit on your board, in my opinion you can drop the cpui=
dle
>>>> driver
>>>> because it means you can't do retention or poweroff the core.
>>>
>>>
>>> if dropping the cpuidle, actually the only left mode is WFI. but he=
re
>>> the problem is that WFI is not enough for us due to our chips have
>>> some current leak in WFI. so here the driver is specific to sirf to
>>> fix the current leak in WFI.
>>>
>>> and i also don't think cpufreq will put hardware to low vol and low
>>> freq automatically. at least for performance and user, it is
>>> impossible.
>>
>>
>> Yes and that is the proof the OPP in cpuidle violates the cpufreq go=
vernor
>> decision. Let's pick an example:
>>
>> I don't know your board so I will assume we have 300, 600, 900 MHz.
>>
>> The user set the policy to 'userspace' and sets the freq to 600MHz, =
the
>> cpuidle will change that to 900MHz when exiting idle.
>>
>> The user set the policy to 'performance', cpuidle switch to 300MHz d=
espite
>> the cpufreq governor told 900MHz.
>>
>> The user set the policy to 'ondemand', the cpufreq governor set the =
OPP to
>> 600MHz but cpuidle change it to 300MHz, then 900MHz.
>
> it seems not. cpuidle is the final task. when cpuidle is entering,
> actually other tasks have sleeped.
> btw, rongjun's codes actually save the current cpufreq -> enter lowes=
t
> vol/freq -> WFI -> restore saved cpufreq.
>
> so if the current cpufreq is 600MHz, then the story is
> 1. saving 600MHz
> 2. goto 300MHz
> 3. WFI
> 4. restoring to 600MHz
>
> so there is no conflict with cpufreq considering the whole "save the
> current cpufreq -> enter lowest vol/freq -> WFI -> restore saved
> cpufreq" is in a atomic context.

Ok, may be my comment is inappropriate. I see you change the clock=20
parent to 'osc' to 26MHz. If the cpu is WFI it is clock gated, no ?

>> I am not a cpufreq expert but IMHO that will mess up the cpufreq gov=
ernor,
>> without talking about the freq changes notifiers.
>>
>> Don't you have warning in dmesg ?
>>
>> "Warning: CPU frequency out of sync: cpufreq and timing ..."
>
> i think no.
>
>>
>>
>>> for other policies like ondemand, i'd like to have rongjun
>>> collect some proof by doing some run+sleep +run+sleep... loop to ch=
eck
>>> the actual behaviour.
>>
>>
>> Yeah, that would be nice.
>
> i would hope the test can cover things like "run xx ms -> sleep yy ms
> -> run xx ms -> sleep yy ms" and we change the xx/yy in different tes=
t
> cases to check the result.
>
>
>>
>>
>
> -barry
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

