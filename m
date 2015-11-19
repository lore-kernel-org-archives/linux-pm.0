From: Len Brown <lenb@kernel.org>
Subject: Re: turbostat patches for 4.3
Date: Thu, 19 Nov 2015 18:46:18 -0500
Message-ID: <CAJvTdKkSKpL=Wpkwrs1CY_Y4kE=hHDVrVOaa7G3ceWJ5CJBLtg@mail.gmail.com>
References: <1447314152-2145-1-git-send-email-lenb@kernel.org>
	<2635043.0vdY80h9bq@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:35312 "EHLO
	mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161416AbbKSXqU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Nov 2015 18:46:20 -0500
Received: by lfdo63 with SMTP id o63so58683074lfd.2
        for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2015 15:46:18 -0800 (PST)
In-Reply-To: <2635043.0vdY80h9bq@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>

linux-next looks fine, go ahead and push it.

all you missed in the refresh was some 80-column formatting
for checkpatch and a version number bump.

thanks,
-Len


On Fri, Nov 13, 2015 at 7:43 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Thursday, November 12, 2015 02:42:28 AM Len Brown wrote:
>> Hello Rafael,
>
> Hi,
>
>> Please pick up this small batch of turbostat patches.
>> As usual, they are available on my turbostat branch.
>>
>> thanks!
>> -Len
>>
>> [PATCH 1/4] tools/power turbostat: simplify Bzy_MHz calculation
>> [PATCH 2/4] tools/power turbostat: bugfix: print MAX_NON_TURBO_RATIO
>> [PATCH 3/4] tools/power turbostat: use new name for MSR_PLATFORM_INFO
>> [PATCH 4/4] x86: remove unused definition of MSR_NHM_PLATFORM_INFO
>
> I pulled from your branch on Wednesday and there were only [1-2/4] on it then.
> That's what went to Linus on that day.
>
> Today, I've noticed that you rebased the branch and it's generating conflicts
> for me when pulled, so instead of pulling from it I've applied [3-4/4] directly
> and I'm going to push them to Linus for -rc2.
>
> Thanks,
> Rafael
>



-- 
Len Brown, Intel Open Source Technology Center
