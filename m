From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 00/10] CPUFreq: Fixes & Cleanups for 3.12
Date: Sat, 3 Aug 2013 18:58:35 +0530
Message-ID: <CAKohpok_ZYB3J0QUJMPxBbmRZ9RssYOTYm0KSwAqyH53ydZcRg@mail.gmail.com>
References: <cover.1375530162.git.viresh.kumar@linaro.org>
	<1976834.StkbCTGYhN@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:64611 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752056Ab3HCN2f (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 3 Aug 2013 09:28:35 -0400
Received: by mail-ob0-f182.google.com with SMTP id wo10so2980675obc.13
        for <linux-pm@vger.kernel.org>; Sat, 03 Aug 2013 06:28:35 -0700 (PDT)
In-Reply-To: <1976834.StkbCTGYhN@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com, l.majewski@samsung.com

On 3 August 2013 17:37, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Saturday, August 03, 2013 05:19:18 PM Viresh Kumar wrote:
>> Hi Rafael,
>>
>> This patchset tries to fix & cleanup many existing cpufreq core issues. First
>> four patches tries to cleanup basic problems in cpufreq core. Its first patch
>> was earlier sent separately but now is part of this series.
>>
>> Fifth patch was also sent earlier as reply to your patches and was reviewed by
>> Srivatsa. Sixth patch was picked from Lukasz's patchset on introducing software
>> "boost" feature in core. It will be used by this patchset.
>>
>> And last four are the most significant part of this set. They try to make many
>> things simple and robust.
>>
>> This is rebased of your bleeding-edge branch + two patches from you:
>> 18a6b03 cpufreq: Avoid double kobject_put() for the same kobject in error code path
>> d0cde63 cpufreq: Do not hold driver module references for additional policy CPUs
>> abe513f Merge branch 'acpi-sleep-next' into linux-next
>>
>> They are also pushed in my cpufreq-next branch
>
> How much testing has that received so far?

I planned to add this information but forgot at the last moment. It
was partially
tested. As it was mostly developed over the weekend I wasn't able to do much
of testing. I posted it to get early comments, and testing would complete by
beginning of next week.

--
viresh
