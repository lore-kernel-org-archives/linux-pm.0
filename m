From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 4/7] cpuidle: calxeda: add support to use PSCI calls
Date: Mon, 29 Jul 2013 16:46:40 +0200
Message-ID: <51F68050.5070107@linaro.org>
References: <1375048598-15637-1-git-send-email-robherring2@gmail.com> <1375048598-15637-5-git-send-email-robherring2@gmail.com> <51F678DB.3030308@linaro.org> <51F67EA8.8010603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ea0-f173.google.com ([209.85.215.173]:45897 "EHLO
	mail-ea0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751928Ab3G2Oqk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jul 2013 10:46:40 -0400
Received: by mail-ea0-f173.google.com with SMTP id g10so2982735eak.32
        for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2013 07:46:39 -0700 (PDT)
In-Reply-To: <51F67EA8.8010603@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, Rob Herring <rob.herring@calxeda.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org

On 07/29/2013 04:39 PM, Rob Herring wrote:
> On 07/29/2013 09:14 AM, Daniel Lezcano wrote:
>> On 07/28/2013 11:56 PM, Rob Herring wrote:
>>> From: Rob Herring <rob.herring@calxeda.com>
>>>
>>> This updates the Calxeda cpuidle driver to use PSCI calls to powerg=
ate
>>> cores. This is needed to enable cpuidle for the ECX-2000.
>>>
>>> This could possibly become a generic PSCI driver, but there are no =
other
>>> PSCI users in the kernel other than mach-virt.
>>>
>>> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
>>> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
>>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> Cc: linux-pm@vger.kernel.org
>>> ---
>>
>> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>=20
> Thanks.
>=20
>>
>> Rob,
>>
>> Shall I take the patch in my tree ?
>=20
> No, there are interdependencies with the rest of the series, so I pla=
n
> to send to arm-soc.

Ok, thanks.


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

