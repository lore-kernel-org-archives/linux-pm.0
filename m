From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: =?UTF-8?B?562U5aSNOiBbUEFUQ0hdIGNwdWlkbGU6IHNpcmYgOiBBZGQgY3A=?=
 =?UTF-8?B?dWlkbGUgZm9yIFNpUkZwcmltYUlJIGFuZCBTaVJGYXRsYXNWSQ==?=
Date: Wed, 09 Oct 2013 14:09:21 +0200
Message-ID: <52554771.9000501@linaro.org>
References: <1381033577-19818-1-git-send-email-Baohua.Song@csr.com> <52526F8B.6030905@linaro.org> <86130EF012BDF348AA0D464A4F4494780129539EE4@SHAASIEXM01.ASIA.ROOT.PRI> <5253DD3C.90008@linaro.org> <CAGsJ_4xeUBnudhmoXjQ03QbQ4PH4QVDRgFmYGY7kP6S_6qKv=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:45696 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753550Ab3JIMJk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Oct 2013 08:09:40 -0400
Received: by mail-wg0-f50.google.com with SMTP id f12so782213wgh.29
        for <linux-pm@vger.kernel.org>; Wed, 09 Oct 2013 05:09:39 -0700 (PDT)
In-Reply-To: <CAGsJ_4xeUBnudhmoXjQ03QbQ4PH4QVDRgFmYGY7kP6S_6qKv=A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: Rongjun Ying <Rongjun.Ying@csr.com>, "rjw@sisk.pl" <rjw@sisk.pl>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Barry Song <Barry.Song@csr.com>, Viresh Kumar <viresh.kumar@linaro.org>

On 10/08/2013 03:27 PM, Barry Song wrote:
>>>>> +       if (sirf_cpuidle.vcore_regulator)
>>>>> +               regulator_set_voltage(sirf_cpuidle.vcore_regulato=
r,
>>>>> volt_old,
>>>>> +                               SIRFSOC_MAX_VOLTAGE);
>>>>> +
>>>>> +       clk_set_parent(sirf_cpuidle.cpu_clk, parent_clk);
>>>>> +       /* Todo: other C states */
>>>>
>>>>
>>>> It sounds very weird you have this freq/volt/opp code here.
>>>>
>>>> If you hit idle, the cpufreq driver didn't put the cpu in the stat=
e you
>>>> are trying to
>>>> bring here ?
>>>>
>>>> There isn't a power management unit on this board ?
>>>>
>>>
>>> By SiRF SoC, when enter idle mode, I set the freq to 26MHz and min
>>> voltage.
>>> That's will save the power consume and reduce leakage current.
>>
>>
>> Really ? :)
>>
>> You didn't answer the questions.
>>
>> 1. this code shouldn't be here but in cpufreq which is already the c=
ase with
>> the other patch you sent with this one. So I am convinced if you rem=
ove the
>> OPP here and let cpufreq to handle that, and keep the cpu_do_idle, y=
ou won't
>> see any difference with the current code.
>>
>> 2. Moreover, removing the OPP, there is only the WFI state which is =
the
>> default idle function. Hence the cpuidle driver itself has no intere=
st and
>> you can simply remove it, except if you bring another idle state wit=
h the
>> driver.
>>
>> 3. More idle states are often handled through a PMU (Power Managemen=
t Unit)
>> giving cpu power off, retention, cluster power down, etc ... Is ther=
e one on
>> this board ?
>>
>> The TRM can help to answer these questions.
>>
> Hi Daniel,
> here the codes actually want to put cpu into lowest freq and lowest
> voltage. because according to our test, power leakage will be much
> lower when cpu is in the status than we put it into WFI directly in a
> higher freq.
>
> here it is difficult to say cpufreq will do that automatically as it
> is decided by cpufreq policy.
>
> there is no power management unit which can put prima2 into a
> different idle status except WFI.
>
> any suggestion from you about this chip issue?

Not so much without further information. Definitively without the TRM i=
t=20
is hard to give any hints on how to go further.

Do you have the ability to do RAM self refresh ? If not, without a powe=
r=20
management unit on your board, in my opinion you can drop the cpuidle=20
driver because it means you can't do retention or poweroff the core.

Moreover, the OPP stuff, from a POV design, is tied with cpufreq and=20
changing that from cpuidle will violate the decisions of the cpufreq=20
governor.

Did you do some measurements without cpuidle but with the cpufreq=20
governor 'ondemand' and compare that with the cpuidle driver you are=20
submitting ?

Hopefully, Viresh (Cc'ed) can give its opinion.

Thanks
   -- Daniel


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

