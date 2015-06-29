From: Uwe Geuder <linuxkernel2015-ugeuder@snkmail.com>
Subject: Re: resume from swap partition under LVM
Date: Mon, 29 Jun 2015 23:26:04 +0300
Message-ID: <87mvzip8gz.fsf@e6510-131.site>
References: <87pp4gq0bl.fsf@e6510-131.site>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gw01.mail.saunalahti.fi ([195.197.172.115]:47425 "EHLO
	gw01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753473AbbF2U0M (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jun 2015 16:26:12 -0400
In-Reply-To: <87pp4gq0bl.fsf@e6510-131.site>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org

On 28 June 2015 at 00:59, Uwe Geuder
<linuxkernel2015-ugeuder@snkmail.com> wrote: 

> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/power/swsusp.txt?id=refs/tags/v4.1#n411
> reads:
>
>> Q: Can I suspend-to-disk using a swap partition under LVM?
>>
>> A: No. You can suspend successfully, but you'll not be able to
>> resume. uswsusp should be able to work with LVM. See suspend.sf.net.
>
> Is that information still up to date?

I guess I can reply myself. The "No" answer probably refers to the
kernel resuming itself just with the help of the command line
parameters. Of course that is not possible. I did not even think about
that possibility, because I have used LUKS encrypted disks longer than
hibernate/resume...

What I meant is 

echo -n "$major:$minor" > /sys/power/resume

I guess that should work just fine with LVM, shouldn't it.

I'll send a patch to clarify the answer in the FAQ.

Regards,

Uwe Geuder
-- 
Nomovok Ltd.
Tampere, Finland
uwe.gxuder@nomovok.com (bot test: humans correct 1 obvious spelling error)
