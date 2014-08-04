From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH] cpufreq, store_scaling_governor requires policy->rwsem
 to be held for duration of changing governors [v2]
Date: Mon, 04 Aug 2014 13:16:37 -0700
Message-ID: <53DFEA25.5070206@codeaurora.org>
References: <1406634362-811-1-git-send-email-prarit@redhat.com> <2066166.pXm4lKLOID@vostro.rjw.lan> <53DA8389.80804@redhat.com> <1917362.abr2Y4p7vh@vostro.rjw.lan> <53DA8A41.2030601@redhat.com> <53DAA60B.6040802@codeaurora.org> <53DAA749.5080506@redhat.com> <53DAA95B.2040505@codeaurora.org> <53DAB038.3050007@redhat.com> <53DABFA6.6090503@codeaurora.org> <53DACA26.1000908@redhat.com> <53DAE592.2030909@codeaurora.org> <53DB6B81.6050400@redhat.com> <53DBCBE8.6010809@codeaurora.org> <CAKohpom0KycrB8qJDM7yEOHOn76J1sEe90CG+JXERJMcxKnOJA@mail.gmail.com> <53DF7BC4.9070500@redhat.com> <CAKohpomEQ__Q4xTaBgHJyE0Meu4au-cXKCAKCqHWTHLRL+R5OA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:59962 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714AbaHDUQl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 Aug 2014 16:16:41 -0400
In-Reply-To: <CAKohpomEQ__Q4xTaBgHJyE0Meu4au-cXKCAKCqHWTHLRL+R5OA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Prarit Bhargava <prarit@redhat.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lenny Szubowicz <lszubowi@redhat.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, =?UTF-8?B?Um9iZXJ0IFNjaMO2bmU=?= <robert.schoene@tu-dresden.de>

On 08/04/2014 06:38 AM, Viresh Kumar wrote:
> On 4 August 2014 17:55, Prarit Bhargava <prarit@redhat.com> wrote:
>> The issue is the collision between the setup & teardown of the policy's governor
>> sysfs files.
>>
>> On creation the kernel does:
>>
>> down_write(&policy->rwsem)
>> mutex_lock(kernfs_mutex) <- note this is similar to the "old" sysfs_mutex.
>>
>> The opposite happens on a governor switch, specifically the existing governor's
>> exit, and then we get a lockdep warning.
>
> Okay, probably a bit more clarity is what I was looking for. Suppose we try
> to change governor, now tell me what will happen.
>
Viresh, I have a good understanding of what's going on. I was planning 
to fix this after the rest of my patches are done. Didn't want to keep 
too many outstanding unaccepted patches.

The problem is when between one thread trying to cat a governor's file 
(say, sampling_rate) vs the governor getting a POLICY_EXIT.

In the read thread, the sysfs lock is grabbed first and then the policy 
lock is grabbed next. When the governor gets the POLICY_EXIT, we call it 
with the policy lock held and the governor tries to do sysfs remove 
which tries to grab the sysfs lock. Classic deadlock.

Could you please look at my policy free/remove patches? If you can do 
that, I can work on a fix for this. It might also be simpler to fix 
after my patch series (not sure, might be).

Thanks,
Saravana
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
