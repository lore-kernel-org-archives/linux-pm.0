From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [RFT][PATCH v2 0/2] PM / QoS: Device resume latency framework fix
Date: Wed, 8 Nov 2017 11:09:48 +0200
Message-ID: <e6630875-b145-cedd-e204-9048c104b96b@ti.com>
References: <5770848.Kdi5IjVKeE@aspire.rjw.lan>
 <2520927.XkLgALY3I0@aspire.rjw.lan>
 <CAMuHMdU-BMmznrtR6S+uppWdsiXjWZKwQYemb+_q89r852KFjg@mail.gmail.com>
 <2157585.74BgekV60d@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fllnx209.ext.ti.com ([198.47.19.16]:64547 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750812AbdKHJK5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Nov 2017 04:10:57 -0500
In-Reply-To: <2157585.74BgekV60d@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Reinette Chatre <reinette.chatre@intel.com>, Ramesh Thomas <ramesh.thomas@intel.com>, Alex Shi <alex.shi@linaro.org>

On 07/11/17 03:08, Rafael J. Wysocki wrote:
> On Monday, November 6, 2017 2:46:48 PM CET Geert Uytterhoeven wrote:
>> Hi Rafael,
>>
>> On Fri, Nov 3, 2017 at 12:42 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>> On Thursday, November 2, 2017 12:00:27 AM CET Rafael J. Wysocki wrote:
>>>> This series is a replacement for commit 0cc2b4e5a020 (PM / QoS: Fix device
>>>> resume latency PM QoS) that had to be reverted due to problems introduced by it.
>>>>
>>>> This time the genpd PM QoS governor is first updated to be more consistent
>>>> and the PM QoS changes are made on top of that which simplifies the second
>>>> patch quite a bit.
>>>>
>>>> This is based on the linux-next branch from linux-pm.git as of now (should
>>>> also apply to the current mainline just fine).
>>>>
>>>> Please test if you can or let me know if you have any comments.
>>>
>>> The v2 removes a couple of redundant checks from the first patch (and add
>>> comments to explain why the checks are not needed) and fixes up the
>>> "no constraint" value collision with a valid constraint multiplied by
>>> NSEC_PER_USEC in the second patch.
>>>
>>> Please test if possible and let me know about any issues.
>>
>> With this series, the 3 issues I reported before do not happen.
>>
>> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>
>> Thank you.
> 
> Thanks!
> 
> Rafael
> 

The latest patches (#1 v3 and #2 v4) seem to work fine in my sanity 
tests also.

Tested-by: Tero Kristo <t-kristo@ti.com>
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
