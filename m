From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/4] CPUFreq Fixes for 3.9
Date: Sat, 9 Feb 2013 07:40:26 +0530
Message-ID: <CAKohpomSSKRmhmmYk5dn4d84yk9qSs0U-9S=W=CT0yjjzJJ3=g@mail.gmail.com>
References: <cover.1360232293.git.viresh.kumar@linaro.org>
	<CAKohpokp4YrxKHibewdt+3-WF7P2Fa_bvRidHpjd9SpsT6bPpw@mail.gmail.com>
	<1653071.l2kN4Hy2U6@vostro.rjw.lan>
	<2792362.JXCag4GJsR@vostro.rjw.lan>
	<51159391.2020002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:37293 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760493Ab3BICK1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 Feb 2013 21:10:27 -0500
Received: by mail-ob0-f170.google.com with SMTP id wc20so4583253obb.15
        for <linux-pm@vger.kernel.org>; Fri, 08 Feb 2013 18:10:26 -0800 (PST)
In-Reply-To: <51159391.2020002@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dirk Brandewie <dirk.brandewie@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, valdis.kletnieks@vt.edu, artem.savkov@gmail.com, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-dev@lists.linaro.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, Nathan Zimmer <nzimmer@sgi.com>

On 9 February 2013 05:38, Dirk Brandewie <dirk.brandewie@gmail.com> wrote:
> On 02/08/2013 03:56 PM, Rafael J. Wysocki wrote:
>>
>> On Friday, February 08, 2013 09:02:37 PM Rafael J. Wysocki wrote:
>>>
>>> On Friday, February 08, 2013 08:06:52 PM Viresh Kumar wrote:
>>>>
>>>> On 8 February 2013 18:02, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>>>>>
>>>>> So as I said, please rework the fixes on top of
>>>>> linux-pm.git/pm-cpufreq.
>>>>
>>>>
>>>> I already did. Please check for-rafael branch
>>>
>>>
>>> Cool.  This is the one I'm supposed to apply, then?
>>
>>
>> OK, applied to bleeding-edge.  Hopefully it will be build-tested over the
>> weekend and I can move it to linux-next.
>>
>> I dropped the rwlock/RCU patches from Nathan, though, because I had some
>> doubts about the correctness of the RCU one and the rwlock one alone would
>> conflict with your further changes.

As soon as i read Rafael's mail, i realized Dirk's patch might be broken
and immediately i saw your mail :)

@Rafael: Sorry for not reviewing Nathan's patch well. I didn't knew much about
RCU then. I am going through its lwn articles now ;)
