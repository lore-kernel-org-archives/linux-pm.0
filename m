From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH][V2] cpuidle: simplify multiple driver support
Date: Wed, 05 Jun 2013 10:19:05 +0200
Message-ID: <51AEF479.3070607@linaro.org>
References: <1369227904-16234-1-git-send-email-daniel.lezcano@linaro.org> <51A51CBD.5060301@linaro.org> <3656140.hejcxbMi3x@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bk0-f51.google.com ([209.85.214.51]:51348 "EHLO
	mail-bk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751405Ab3FEITI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 5 Jun 2013 04:19:08 -0400
Received: by mail-bk0-f51.google.com with SMTP id ji2so668932bkc.24
        for <linux-pm@vger.kernel.org>; Wed, 05 Jun 2013 01:19:07 -0700 (PDT)
In-Reply-To: <3656140.hejcxbMi3x@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: patches@linaro.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, Len Brown <lenb@kernel.org>

On 05/28/2013 11:28 PM, Rafael J. Wysocki wrote:
> On Tuesday, May 28, 2013 11:08:13 PM Daniel Lezcano wrote:
>> On 05/22/2013 03:05 PM, Daniel Lezcano wrote:
>>> Commit bf4d1b5ddb78f86078ac6ae0415802d5f0c68f92 brought the multipl=
e driver
>>> support. The code added a couple of new API to register the driver =
per cpu.
>>> That led to some code complexity to handle the kernel config option=
s when
>>> the multiple driver support is enabled or not, which is not really =
necessary.
>>> The code has to be compatible when the multiple driver support is n=
ot enabled,
>>> and the multiple driver support has to be compatible with the old a=
pi.
>>>
>>> This patch removes this API, which is not yet used by any driver bu=
t needed
>>> for the HMP cpuidle drivers which will come soon, and replaces its =
usage
>>> by a cpumask pointer in the cpuidle driver structure telling what c=
pus are
>>> handled by the driver. That let the API cpuidle_[un]register_driver=
 to be used
>>> for the multipled driver support and also the cpuidle_[un]register =
functions,
>>> added recently in the cpuidle framework.
>>>
>>> The current code, a bit poor in comments, has been commented and si=
mplified.
>>>
>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> ---
>>>
>>> [V2]:
>>>  - fixed bad refcount check
>>>  - inverted clockevent notify off order at unregister time
>> Hi Rafael,
>>
>> could you consider this patch for merging ? I took into account
>> Francesco's comments.
> I'm waiting for Len to have a look at it which may take a few days mo=
re.

Ok, is it possible to queue the patch for 3.11 now ?

Thanks
-- Daniel

--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

