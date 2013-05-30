From: Giacomo Perale <giacomo.perale@gmail.com>
Subject: Re: [regression,bisected] restore of disks after suspend-to-disk
 broken in 3.9.x
Date: Thu, 30 May 2013 10:04:07 +0200
Message-ID: <CAPm-kmtwxgDO24UmtmZ44-P2W-80tK11k1aE8M4Ty3t3LKu14Q@mail.gmail.com>
References: <CAPm-kmsTNz4niGXsWyhLwwBkQ48gHdq1vjPvSKKwQ0kbhHm=JQ@mail.gmail.com>
	<1369631226.2159.5.camel@rzhang1-mobl4>
	<CAPm-kmu4WmAKX4N5GTsG-J+oq95pLxB9=iLMf2dyK-p6RbwFXQ@mail.gmail.com>
	<1369878386.3368.16.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:53176 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966927Ab3E3IEI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 May 2013 04:04:08 -0400
In-Reply-To: <1369878386.3368.16.camel@rzhang1-mobl4>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

2013/5/30 Zhang Rui <rui.zhang@intel.com>:
> On Mon, 2013-05-27 at 22:07 +0200, Giacomo Perale wrote:
>> 2013/5/27 Zhang Rui <rui.zhang@intel.com>:
>> > On Sun, 2013-05-26 at 15:51 +0200, Giacomo Perale wrote:
>> >> Hello,
>> >>
>> >> after upgrading from 3.8.7 to 3.9.x I noticed some slightly longer
>> >> delays when resuming from suspend-to-disk and a few new error messages
>> >> in the logs:
>> >>
>> >>
>> >> Not having connected the issue with the previous error messages I
>> >> initially blamed the disk and replaced it with a new one thinking it
>> >> was broken, but the problem persisted so I started a bisection run
>> >> that pointed to this commit:
>> >>
>> >>
>> >> b8bb6cb999858043489c1ddef08eed2127559169 is the first bad commit
>> >> commit b8bb6cb999858043489c1ddef08eed2127559169
>> >> Author: Zhang Rui <rui.zhang@intel.com>
>> >> Date:   Thu Nov 22 15:45:02 2012 +0800
>> >>
>> >>     step_wise: Unify the code for both throttle and dethrottle
>> >>
>> >>     Signed-off-by: Zhang Rui <rui.zhang@intel.com>
>> >>
>> > I do not see how this would affect the sata hibernation/resume.
>> > but anyway, would you please try the four patches in comment #10, #11,
>> > #12 and #13 in
>> > https://bugzilla.kernel.org/show_bug.cgi?id=58301
>> > and check if they help?
>> >
>> > thanks,
>> > rui
>> >
>>
>> No luck, with git head and those four patches hibernation is
>> completely broken, the system doesn't even shut down, it just loses
>> the disks (I'm attaching what I could get from /proc/kmsg to this
>> email).
>>
> then can you please try the patch at
> https://patchwork.kernel.org/patch/2633071/
> on top of the four patches and see if it helps?
>
> thanks,
> rui
>

Do you mean without Rafael's patch?

Giacomo
