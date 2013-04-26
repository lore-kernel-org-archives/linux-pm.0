From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] cpuidle: simplify multiple driver support
Date: Fri, 26 Apr 2013 14:13:48 +0200
Message-ID: <517A6F7C.6080308@linaro.org>
References: <1366976529-27731-1-git-send-email-daniel.lezcano@linaro.org> <1903930.d1Bbd950lY@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:36393 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755401Ab3DZMNu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Apr 2013 08:13:50 -0400
Received: by mail-we0-f169.google.com with SMTP id p43so3538985wea.0
        for <linux-pm@vger.kernel.org>; Fri, 26 Apr 2013 05:13:49 -0700 (PDT)
In-Reply-To: <1903930.d1Bbd950lY@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: patches@linaro.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org

On 04/26/2013 02:07 PM, Rafael J. Wysocki wrote:
> On Friday, April 26, 2013 01:42:09 PM Daniel Lezcano wrote:
>> Commit bf4d1b5ddb78f86078ac6ae0415802d5f0c68f92 brought the multiple=
 driver
>> support. The code added a couple of new API to register the driver p=
er cpu.
>> That led to some code complexity to handle the kernel config options=
 when
>> the multiple driver support is enabled or not, which is not really n=
ecessary.
>> The code has to be compatible when the multiple driver support is no=
t enabled,
>> and the multiple driver support has to be compatible with the old ap=
i.
>>
>> This patch removes this API, which is not yet used by any driver but=
 needed
>> for the HMP cpuidle drivers which will come soon, and replaces its u=
sage
>> by a cpumask pointer in the cpuidle driver structure telling what cp=
us are
>> handled by the driver. That let the API cpuidle_[un]register_driver =
to be used
>> for the multipled driver support.
>>
>> The current code, a bit poor in comments, has been commented and sim=
plified.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Honestly, I'd prefer that to go into 3.11.  At this point I want thin=
gs to
> stabilize rather than to stir up.

Yes, sure. That makes sense.

Thanks
-- Daniel


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

