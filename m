From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 16/21] cpuidle: avoid unnecessary kzalloc/free of struct cpuidle_device_kobj
Date: Thu, 26 Sep 2013 11:35:01 +0530
Message-ID: <CAKohpokT12boxnnUJ=5Bd8tRh5VKvidd+kxQ6tF+pp1SLcgb4A@mail.gmail.com>
References: <cover.1379779777.git.viresh.kumar@linaro.org>
	<fb67ff6fa01bde06aeab43c4a02da2923615e6ef.1379779777.git.viresh.kumar@linaro.org>
	<52435FE2.20805@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f173.google.com ([209.85.216.173]:55336 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985Ab3IZGFD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Sep 2013 02:05:03 -0400
Received: by mail-qc0-f173.google.com with SMTP id c3so462396qcv.4
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2013 23:05:03 -0700 (PDT)
In-Reply-To: <52435FE2.20805@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 26 September 2013 03:42, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> On 09/22/2013 03:21 AM, Viresh Kumar wrote:
>> We always need to allocate struct cpuidle_device_kobj for all CPUs and so there
>> is no real need to have a pointer to it inside struct cpuidle_device.
>>
>> This patch makes a object instance of struct cpuidle_device_kobj inside struct
>> cpuidle_device instead of a pointer.
>>
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> nack, it was made in purpose for kobject_init_and_add.
>
> see commit 728ce22b696f9f1404a74d7b2279a65933553a1b

Ahh.. sorry for missing that one :(

Now that I understand why it was introduced, I am thinking if
we can make hotplug path a bit fast? By not freeing sysfs stuff
and only hiding it for time being? And so we wouldn't be required
to do unnecessary initialisations while coming back?

Would that be worth it?
