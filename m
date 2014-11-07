From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [GIT PULL] ARM DT idle states updates
Date: Fri, 07 Nov 2014 11:43:29 +0100
Message-ID: <545CA251.2040007@linaro.org>
References: <20141104123013.GA16832@red-moon> <545CA1E7.5050203@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:45527 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634AbaKGKnd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 7 Nov 2014 05:43:33 -0500
Received: by mail-wg0-f48.google.com with SMTP id m15so3371992wgh.7
        for <linux-pm@vger.kernel.org>; Fri, 07 Nov 2014 02:43:32 -0800 (PST)
In-Reply-To: <545CA1E7.5050203@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: khilman@linaro.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 11/07/2014 11:41 AM, Daniel Lezcano wrote:
> On 11/04/2014 01:30 PM, Lorenzo Pieralisi wrote:
>> Hi Daniel,
>>
>> please consider pulling the three patches below for 3.19.
>>
>> First two are updates on idle states bindings and parsing code to ad=
d
>> states descriptions and status property, the last one is just a clea=
n-up
>> patch, to remove leftovers from the last merge window.
>
> Hi Lorenzo,
>
> could you please send these three patches along with this pull reques=
t ?

Please ignore. I saw the three patches :)

Sorry for the noise.

   -- Daniel

>>
>> Thanks a lot,
>> Lorenzo
>>
>> The following changes since commit
>> 0df1f2487d2f0d04703f142813d53615d62a1da4:
>>
>>    Linux 3.18-rc3 (2014-11-02 15:01:51 -0800)
>>
>> are available in the git repository at:
>>
>>    git://linux-arm.org/linux-2.6-lp.git
>> for-upstream/dt-idle-states-updates
>>
>> for you to fetch changes up to 6e13873494078ac26862144ca2345546ca905=
c41:
>>
>>    drivers: cpuidle: remove cpuidle-arm64 duplicate error messages
>> (2014-11-04 12:09:27 +0000)
>>
>> ----------------------------------------------------------------
>> Lorenzo Pieralisi (3):
>>        drivers: cpuidle: add status property to ARM idle states
>>        drivers: cpuidle: add idle-state-name description to ARM idle
>> states
>>        drivers: cpuidle: remove cpuidle-arm64 duplicate error messag=
es
>>
>>   .../devicetree/bindings/arm/idle-states.txt          | 20
>> ++++++++++++++++++++
>>   drivers/cpuidle/cpuidle-arm64.c                      | 13 ++------=
-----
>>   drivers/cpuidle/dt_idle_states.c                     | 10 ++++++++=
+-
>>   3 files changed, 31 insertions(+), 12 deletions(-)
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pm" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

