From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: bltk-game regressions on snb laptop
Date: Thu, 18 Apr 2013 10:06:34 +0530
Message-ID: <CAKohpon6t9kruo7=Zbn3Zf8Vin-k-FJd4ymzCi_ZJykR9YiuPQ@mail.gmail.com>
References: <516CFA57.3060709@intel.com>
	<CAKohponOVZgAxdX5yv9qmn_56mgTdXEBPr-7o7_pA5GRF09J0w@mail.gmail.com>
	<516F42EE.6080802@intel.com>
	<CAKohpokju79Fx7TXTD1hKoG0JUmCsRm8Us381bhHeUrBvyOv6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:60908 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754344Ab3DREge (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Apr 2013 00:36:34 -0400
Received: by mail-ob0-f175.google.com with SMTP id va7so2108914obc.6
        for <linux-pm@vger.kernel.org>; Wed, 17 Apr 2013 21:36:34 -0700 (PDT)
In-Reply-To: <CAKohpokju79Fx7TXTD1hKoG0JUmCsRm8Us381bhHeUrBvyOv6w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alex Shi <alex.shi@intel.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, LKP ML <lkp@linux.intel.com>

On 18 April 2013 09:56, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 18 April 2013 06:18, Alex Shi <alex.shi@intel.com> wrote:

>> The bltk-game use cpu to decode video, it has 9 load varied threads.
>> The following is the typical snapshot of asked cpufreq:
>> with your patch
>> [alexs@lkp-sb01 ~]$ cat /sys/.../cpu*/cpufreq/scaling_cur_freq
>> 2201000
>> 800000
>> 800000
>> 800000
>> 800000
>> 800000
>> 2201000
>> 800000
>>
>> Wihtout your patch
>> [alexs@lkp-sb01 ~]$ cat /sys/.../cpu*/cpufreq/scaling_cur_freq
>> 2201000
>> 2201000
>> 2201000
>> 2201000
>> 2201000
>> 2201000
>> 2201000
>> 2201000
>
> I think something wrong is happening without my patch as setting
> related_cpus alone was wrong.

BTW, it looks many of your cpus are staying at higher or max freq and
that's why you are getting better values. And this happened unintentionally
due to a bug in setting related_cpus which my patch fixed.
