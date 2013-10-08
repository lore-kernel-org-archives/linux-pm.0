From: Barry Song <21cnbao@gmail.com>
Subject: =?UTF-8?Q?Re=3A_=E7=AD=94=E5=A4=8D=3A_=5BPATCH=5D_cpuidle=3A_sirf_=3A_Add_cpuidle_for_?=
	=?UTF-8?Q?SiRFprimaII_and_SiRFatlasVI?=
Date: Tue, 8 Oct 2013 21:27:13 +0800
Message-ID: <CAGsJ_4xeUBnudhmoXjQ03QbQ4PH4QVDRgFmYGY7kP6S_6qKv=A@mail.gmail.com>
References: <1381033577-19818-1-git-send-email-Baohua.Song@csr.com>
 <52526F8B.6030905@linaro.org> <86130EF012BDF348AA0D464A4F4494780129539EE4@SHAASIEXM01.ASIA.ROOT.PRI>
 <5253DD3C.90008@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:33721 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752603Ab3JHN1f (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Oct 2013 09:27:35 -0400
Received: by mail-qc0-f180.google.com with SMTP id p19so5885429qcv.25
        for <linux-pm@vger.kernel.org>; Tue, 08 Oct 2013 06:27:34 -0700 (PDT)
In-Reply-To: <5253DD3C.90008@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Rongjun Ying <Rongjun.Ying@csr.com>, "rjw@sisk.pl" <rjw@sisk.pl>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, DL-SHA-WorkGroupLinux <DL-SHA-WorkGroupLinux@internal.csr.com>, Barry Song <Barry.Song@csr.com>

>>>> +       if (sirf_cpuidle.vcore_regulator)
>>>> +               regulator_set_voltage(sirf_cpuidle.vcore_regulator,
>>>> volt_old,
>>>> +                               SIRFSOC_MAX_VOLTAGE);
>>>> +
>>>> +       clk_set_parent(sirf_cpuidle.cpu_clk, parent_clk);
>>>> +       /* Todo: other C states */
>>>
>>>
>>> It sounds very weird you have this freq/volt/opp code here.
>>>
>>> If you hit idle, the cpufreq driver didn't put the cpu in the state you
>>> are trying to
>>> bring here ?
>>>
>>> There isn't a power management unit on this board ?
>>>
>>
>> By SiRF SoC, when enter idle mode, I set the freq to 26MHz and min
>> voltage.
>> That's will save the power consume and reduce leakage current.
>
>
> Really ? :)
>
> You didn't answer the questions.
>
> 1. this code shouldn't be here but in cpufreq which is already the case with
> the other patch you sent with this one. So I am convinced if you remove the
> OPP here and let cpufreq to handle that, and keep the cpu_do_idle, you won't
> see any difference with the current code.
>
> 2. Moreover, removing the OPP, there is only the WFI state which is the
> default idle function. Hence the cpuidle driver itself has no interest and
> you can simply remove it, except if you bring another idle state with the
> driver.
>
> 3. More idle states are often handled through a PMU (Power Management Unit)
> giving cpu power off, retention, cluster power down, etc ... Is there one on
> this board ?
>
> The TRM can help to answer these questions.
>
Hi Daniel,
here the codes actually want to put cpu into lowest freq and lowest
voltage. because according to our test, power leakage will be much
lower when cpu is in the status than we put it into WFI directly in a
higher freq.

here it is difficult to say cpufreq will do that automatically as it
is decided by cpufreq policy.

there is no power management unit which can put prima2 into a
different idle status except WFI.

any suggestion from you about this chip issue?

-barry
