From: keita kobayashi <keita.kobayashi.ym@renesas.com>
Subject: Re: [RFC/PATCH 0/6] Add CPUIdle support for Renesas SoCs
Date: Fri, 13 Mar 2015 14:01:39 +0900
Message-ID: <55026F33.4020000@renesas.com>
References: <1425444946-3084-1-git-send-email-keita.kobayashi.ym@renesas.com> <54F89A23.1060008@linaro.org> <54F97599.7050904@renesas.com> <20150309152155.GC456@linaro.org> <54FDBD0A.5060001@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:28754 "EHLO
	relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750853AbbCMFCB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2015 01:02:01 -0400
In-Reply-To: <54FDBD0A.5060001@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Lina Iyer <lina.iyer@linaro.org>, horms@verge.net.au, rjw@rjwysocki.net, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, magnus.damm@gmail.com

Hi Daniel, Lina

Sorry for late reply.

(2015/03/10 0:32), Daniel Lezcano wrote:

> On 03/09/2015 04:21 PM, Lina Iyer wrote:
>> On Fri, Mar 06 2015 at 02:38 -0700, keita kobayashi wrote:
>>> Hi Daniel
> 
> [ ... ]
> 
>>>>
>>>> Hi Keita,
>>>>
>>>> the platform approach to pass private data from the arch specific to
>>>> the cpuidle driver no longer accepted. Unfortunately, there is no
>>>> alternate solution upstream.
>>>>
>>>> But hopefully, there is a patchset [1] submitted for upstreaming
>>>> which unify arm32/64 into a single generic cpuidle driver and use the
>>>> DT to define the idle functions to be used.
>>>>
>>>> I suggest you have a look at this patchset if it can fit your need.
>>>>
>>>>   -- Daniel
>>>>
>>>> [1] https://lkml.org/lkml/2015/3/3/271
>>>
>>> Thank you for information.
>>> I will take a look at the patch series.
>>
>> Hi Kieta,
>>
>> Please also have a look at the v15 of the cpuidle support for QCOM SoC.
>> Sent just now.  It is based on [1].
> > Lina's patchset is available at:
> 
> https://www.mail-archive.com/devicetree@vger.kernel.org/msg64700.html
> 
> Thanks
>   -- Daniel
> 

Thank you for information.
I will confirm it.

Regards.
Keita Kobayashi
