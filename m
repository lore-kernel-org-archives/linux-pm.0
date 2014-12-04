From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v14 03/10] qcom: spm: Add Subsystem Power Manager driver
Date: Thu, 04 Dec 2014 09:52:39 +0100
Message-ID: <548020D7.8030003@linaro.org>
References: <1417541958-56907-1-git-send-email-lina.iyer@linaro.org> <547ED3BD.5090209@linaro.org> <20141203143122.GH499@linaro.org> <2596381.rFt35NU3oS@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:51118 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753042AbaLDIwm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Dec 2014 03:52:42 -0500
Received: by mail-wi0-f171.google.com with SMTP id bs8so33931559wib.10
        for <linux-pm@vger.kernel.org>; Thu, 04 Dec 2014 00:52:41 -0800 (PST)
In-Reply-To: <2596381.rFt35NU3oS@wuerfel>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Lina Iyer <lina.iyer@linaro.org>
Cc: khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org

On 12/03/2014 09:35 PM, Arnd Bergmann wrote:
> On Wednesday 03 December 2014 07:31:22 Lina Iyer wrote:
>>>>> +static int __init qcom_spm_init(void)
>>>>> +{
>>>>> +    int ret;
>>>>> +
>>>>> +    /*
>>>>> +     * cpuidle driver need to registered before the cpuidle devi=
ce
>>>>> +     * for any cpu. Register the device for the the cpuidle driv=
er.
>>>>> +     */
>>>>> +    ret =3D platform_device_register(&qcom_cpuidle_drv);
>>>>> +    if (ret)
>>>>> +        return ret;
>>>> Stephen pointed out that we would have the platform device lying a=
round
>>>> on a non-QCOM device when using multi_v7_defconfig.
>>>
>>> Perhaps I am missing the point, but this is not supposed to happen,=
 no ?
>>>
>> This would happen, since the file would compile on multi_v7 and we w=
ould
>> initialize and register this device regardless. The cpuidle-qcom.c
>> driver probe would bail out looking for a matching compatible proper=
ty.
>> So we would not register a cpuidle driver but the device would lay
>> around.
>
> I think the problem is registering a platform_device. I've complained
> about this before, but it still seems to get copied all over the
> place. Please don't do this but have a driver that looks at DT to
> figure out whether to access hardware or not.

We did this approach but, I can remember why, someone was complaining=20
about it also :)

The platform device/driver paradigm allowed us to split the arch=20
specific parts by passing the pm ops through the platform data.

Would make sense to have a single common place for the ARM arch where w=
e=20
initialize the platform device for cpuidle ?



--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

