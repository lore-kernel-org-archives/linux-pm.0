From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH][V2] cpuidle: simplify multiple driver support
Date: Wed, 05 Jun 2013 15:00:32 +0200
Message-ID: <51AF3670.6040601@linaro.org>
References: <1369227904-16234-1-git-send-email-daniel.lezcano@linaro.org> <3656140.hejcxbMi3x@vostro.rjw.lan> <51AEF479.3070607@linaro.org> <11636841.b3MnnSDuMT@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bk0-f44.google.com ([209.85.214.44]:63960 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752014Ab3FENAd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 5 Jun 2013 09:00:33 -0400
Received: by mail-bk0-f44.google.com with SMTP id r7so889792bkg.31
        for <linux-pm@vger.kernel.org>; Wed, 05 Jun 2013 06:00:32 -0700 (PDT)
In-Reply-To: <11636841.b3MnnSDuMT@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: patches@linaro.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, Len Brown <lenb@kernel.org>

On 06/05/2013 03:03 PM, Rafael J. Wysocki wrote:
> On Wednesday, June 05, 2013 10:19:05 AM Daniel Lezcano wrote:
>> On 05/28/2013 11:28 PM, Rafael J. Wysocki wrote:
>>> On Tuesday, May 28, 2013 11:08:13 PM Daniel Lezcano wrote:
>>>> On 05/22/2013 03:05 PM, Daniel Lezcano wrote:
>>>>> Commit bf4d1b5ddb78f86078ac6ae0415802d5f0c68f92 brought the multi=
ple driver
>>>>> support. The code added a couple of new API to register the drive=
r per cpu.
>>>>> That led to some code complexity to handle the kernel config opti=
ons when
>>>>> the multiple driver support is enabled or not, which is not reall=
y necessary.
>>>>> The code has to be compatible when the multiple driver support is=
 not enabled,
>>>>> and the multiple driver support has to be compatible with the old=
 api.
>>>>>
>>>>> This patch removes this API, which is not yet used by any driver =
but needed
>>>>> for the HMP cpuidle drivers which will come soon, and replaces it=
s usage
>>>>> by a cpumask pointer in the cpuidle driver structure telling what=
 cpus are
>>>>> handled by the driver. That let the API cpuidle_[un]register_driv=
er to be used
>>>>> for the multipled driver support and also the cpuidle_[un]registe=
r functions,
>>>>> added recently in the cpuidle framework.
>>>>>
>>>>> The current code, a bit poor in comments, has been commented and =
simplified.
>>>>>
>>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>>> ---
>>>>>
>>>>> [V2]:
>>>>>  - fixed bad refcount check
>>>>>  - inverted clockevent notify off order at unregister time
>>>> Hi Rafael,
>>>>
>>>> could you consider this patch for merging ? I took into account
>>>> Francesco's comments.
>>> I'm waiting for Len to have a look at it which may take a few days =
more.
>>
>> Ok, is it possible to queue the patch for 3.11 now ?
>=20
> Actually, can you please separate adding kerneldoc comments from func=
tional
> changes?  That'd make the patch(es) easier to grasp.

Sure.


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

