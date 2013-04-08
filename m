From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 7/9] intel: cpuidle: remove stop/start critical timings
Date: Mon, 08 Apr 2013 21:27:25 +0200
Message-ID: <51631A1D.3090705@linaro.org>
References: <1364991322-20585-1-git-send-email-daniel.lezcano@linaro.org> <5161DC9C.3020703@linaro.org> <51630115.6040205@linaro.org> <6514915.cyFSTtqpte@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:64556 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935574Ab3DHT12 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Apr 2013 15:27:28 -0400
Received: by mail-wi0-f173.google.com with SMTP id ez12so2943559wid.6
        for <linux-pm@vger.kernel.org>; Mon, 08 Apr 2013 12:27:27 -0700 (PDT)
In-Reply-To: <6514915.cyFSTtqpte@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <len.brown@intel.com>, deepthi@linux.vnet.ibm.com, linaro-kernel@lists.linaro.org, linux@arm.linux.org.uk, swarren@wwwdotorg.org, linux-pm@vger.kernel.org, patches@linaro.org, nsekhar@ti.com, rnayak@ti.com, josephl@nvidia.com, linux-tegra@vger.kernel.org, horms+renesas@verge.net.au, linux-arm-kernel@lists.infradead.org, lenb@kernel.org

On 04/08/2013 09:27 PM, Rafael J. Wysocki wrote:
> On Monday, April 08, 2013 07:40:37 PM Daniel Lezcano wrote:
>> On 04/07/2013 10:52 PM, Daniel Lezcano wrote:
>>> On 04/05/2013 12:31 AM, Rafael J. Wysocki wrote:
>>>> On Wednesday, April 03, 2013 02:15:20 PM Daniel Lezcano wrote:
>>>>> The start/stop_critical_timings are called from arch/x86/kernel/p=
rocess.c
>>>>> in the cpu_idle loop function.
>>>>>
>>>>> Remove the ones in the cpuidle driver.
>>>>>
>>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>> For this one I need an ACK from Len.
>>>>
>>>> Len, any objections?
>>>
>>> Len ? ping ...
>>
>> Rafael,
>>
>> this patch is not dependent from any patch in the series, is it poss=
ible
>> you apply the patchset except this patch ?
>>
>> May be you can apply it later when Len acks it, or I can resend it, =
no ?
>>
>> I have a lot of code consolidation patches awaiting for this patchse=
t to
>> be merged.
>=20
> OK, I'll take the rest of your patches in this series (except for [1/=
9]
> which also is not depended on by anything AFAICS).

Thanks Rafael.

  -- Daniel

--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

