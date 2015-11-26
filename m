From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [GIT PULL] devfreq for next-RC
Date: Thu, 26 Nov 2015 22:51:18 +0900
Message-ID: <CAJ0PZbQ2Wh6kEjRjGfHhLLsnTcLcxb_iBn9p9auC2V+WTjgcQw@mail.gmail.com>
References: <1633234957.280321448504078990.JavaMail.weblogic@epmlwas08a> <12501801.eCeCJmHOSo@vostro.rjw.lan>
Reply-To: myungjoo.ham@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:33169 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964AbbKZNvd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Nov 2015 08:51:33 -0500
Received: by obbww6 with SMTP id ww6so63246475obb.0
        for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2015 05:51:32 -0800 (PST)
In-Reply-To: <12501801.eCeCJmHOSo@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, rafael.j.wysocki@intel.com, Chanwoo Choi <cw00.choi@samsung.com>

6 of the 8 patches are fixes or style-updates.
Other 2 of 8 (PM / devfreq: Set the freq_table of devfreq device,
MAINTAINERS: Add devfreq-event entry)
are small updates (the first of the two may be seen as a fix to follow
the given API semantics though)

Do you want to pull the 6 clearly-fixes only for the RC?


Cheers,
MyungJoo

On Thu, Nov 26, 2015 at 10:58 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Thursday, November 26, 2015 02:14:40 AM MyungJoo Ham wrote:
>> Dear Rafael,
>>
>> Here goes the pull reqest for next 4.4 RCx.
>>
>>
>> Cheers,
>> MyungJoo
>>
>> The following changes since commit 1ec218373b8ebda821aec00bb156a9c94fad9cd4:
>>
>>   Linux 4.4-rc2 (2015-11-22 16:45:59 -0800)
>>
>> are available in the git repository at:
>>
>>   https://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git tags/pull_req_20151126
>>
>> for you to fetch changes up to 38bb853595404cdd2210268dd508ce303ab836e5:
>>
>>   MAINTAINERS: Add devfreq-event entry (2015-11-26 10:54:18 +0900)
>>
>> ----------------------------------------------------------------
>> Pull request for Rafael on 2015-11-26. Based on 4.4-rc2
>>
>> ----------------------------------------------------------------
>> Chanwoo Choi (7):
>>       PM / devfreq: event: Remove the error log of devfreq_event_get_edev_by_phandle()
>>       PM / devfreq: event: Fix the error and warning from script/checkpatch.pl
>>       PM / devfreq: Add show_one macro to delete the duplicate code
>>       PM / devfreq: Set the freq_table of devfreq device
>>       PM / devfreq: Modify the indentation of trans_stat sysfs for readability
>>       MAINTAINERS: Add missing git repository and directory for devfreq
>>       MAINTAINERS: Add devfreq-event entry
>>
>> MyungJoo Ham (1):
>>       PM / devfreq: Do not show statistics if it's not ready.
>>
>>  MAINTAINERS                     | 13 +++++++
>>  drivers/devfreq/devfreq-event.c | 16 +++------
>>  drivers/devfreq/devfreq.c       | 78 ++++++++++++++++++++++++++++++++---------
>>  include/linux/devfreq.h         |  2 +-
>>  4 files changed, 81 insertions(+), 28 deletions(-)
>
> Is this really 4.4-rc material?
>
> We're quite late in the cycle and I'm not willing to push anything more than
> fixes to Linus at this point.
>
> I can pull this and queue it up for v4.5 if that works for you, though.
>
> Thanks,
> Rafael
>



-- 
MyungJoo Ham, Ph.D.
Frontier CS Lab, S/W Center, Samsung Electronics
