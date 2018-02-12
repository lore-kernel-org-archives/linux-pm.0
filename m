From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [Query] thermal: Who is using "cooling-{min|max}-level}"
 properties ?
Date: Mon, 12 Feb 2018 09:39:34 +0100
Message-ID: <0b73e1aa-a88f-fe4b-b33a-0f589000e148@linaro.org>
References: <20180207065959.GN28462@vireshk-i7>
 <c7bd6ed5-b93e-3a07-b4a2-4c3b1eef5fac@linaro.org>
 <20180207102446.GS28462@vireshk-i7>
 <11fbba25-7029-8a13-476e-ea2f2de6fbf9@linaro.org>
 <20180209064211.GY28462@vireshk-i7>
 <539699c7-9509-dea2-2b31-c5f6749c99c4@linaro.org>
 <20180209092421.GL28462@vireshk-i7>
 <5722441d-c8be-4d29-fab7-28b4e5716961@linaro.org>
 <20180212061015.GO28462@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:39154 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932532AbeBLIji (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Feb 2018 03:39:38 -0500
Received: by mail-wr0-f196.google.com with SMTP id g4so4428514wrb.6
        for <linux-pm@vger.kernel.org>; Mon, 12 Feb 2018 00:39:38 -0800 (PST)
In-Reply-To: <20180212061015.GO28462@vireshk-i7>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Vincent Guittot <vincent.guittot@linaro.org>, linux-pm@vger.kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org, Punit.Agrawal@arm.com, ionela.voinescu@arm.com

On 12/02/2018 07:10, Viresh Kumar wrote:
> On 09-02-18, 13:14, Daniel Lezcano wrote:
>> Right. The semantic is unclear. The expected cooling-cells value is
>> always 2 (the code ignore values greater than two and yell if it is less
>> than 2). And the cooling-device binding tells there are two states.
> 
> They are fixed to 2 as we don't need to use it differently for now.
> But that's more about how Linux is using this stuff. The binding still
> needs to provide a way to have more cells than just 2.
> 
>> So the question is why do we need a cooling-cells as the information is
>> pointless here (always 2) ?
> 
> To show that the device is a "cooling-device" and I see that
> consistent with everything else in DT, for example: interrupt-cells,
> gpio-cells, clock-cells, reset-cells, dma-cells. The "*-cells"
> properties is used widely to tell what the device can behave as, i.e.
> a cooling-device in our case.

Ah, yes. That's right.

Well I don't know. If that is the way the other drivers are doing, I
suppose we should keep it as it is.

> Now we always use 2 parameters exactly is a different thing all
> together :)
> 
>> I see this field is artificially used to tell the cpufreq driver "please
>> register me as a cooling device". This is inconsistent from my pov.
> 
> But that's how its used for every other controller, what's different
> here ?
> 
>> Furthermore, the thermal-zone with the cooling device binds with the CPU
>> phandle, not the cooling-cells.
> 
> Yeah, because that's the device really.
> 
>> Putting apart the device binding changes discussion for the moment. Why
>> not register the cpufreq driver in all the cases and then drop
> 
> s/cpufreq driver/cpufreq cooling driver/ ??

yes.

>> cooling-cells ? So when the opps are present, its registers in the
>> cpufreq->ready callback.
> 
> How will someone tell if they don't need the cooling infrastructure ?
> Specially for multiplatform thing.

They don't define a cooling device in the DT ?


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
