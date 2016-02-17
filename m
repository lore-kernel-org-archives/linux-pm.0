From: Ryan <ryanphilips19@googlemail.com>
Subject: Re: suspend resume query
Date: Wed, 17 Feb 2016 15:19:04 +0530
Message-ID: <CANMsd03xShJ4hMajaahTaSQfZyCww+9me-e7X3F2=z1oUPN0Cg@mail.gmail.com>
References: <CANMsd03Y67iVEtUZaWnjywNxVVSvmpQfh72y8uJeqqgP=PrH=g@mail.gmail.com>
	<1455700241.7626.10.camel@suse.com>
	<CANMsd02oPfRZ4dRRF8R61VtN+h62ROfmNCDK=NohKjYWhOL4Hg@mail.gmail.com>
	<1455702015.7626.13.camel@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:35936 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757010AbcBQJtF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 17 Feb 2016 04:49:05 -0500
Received: by mail-ig0-f180.google.com with SMTP id xg9so94884741igb.1
        for <linux-pm@vger.kernel.org>; Wed, 17 Feb 2016 01:49:04 -0800 (PST)
In-Reply-To: <1455702015.7626.13.camel@suse.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Oliver Neukum <oneukum@suse.com>
Cc: linux-pm@vger.kernel.org

Suspend to ram. I am sorry - I did not provide complete information.

Thanks,

On Wed, Feb 17, 2016 at 3:10 PM, Oliver Neukum <oneukum@suse.com> wrote:
> On Wed, 2016-02-17 at 15:07 +0530, Ryan wrote:
>
>> I am referring to suspend-resume in ARM platform. The boot sequence is
>>
>> bootrom
>> bootloaders
>> kernel
>
> That is the standard done on most architectures including x86 and
> x86_64.
>
>> When system is suspended, I am told that when suspend-resume occurs
>> it depends on the bootrom/bootloaders during resume. I did not understand why
>> that should be case. Hence i am asking are there any dependencies between
>> the bootloaders and the suspend-resume on a arm platform.
>
> Suspend to RAM or suspend to disk?
>
>         Regards
>                 Oliver
>
>
