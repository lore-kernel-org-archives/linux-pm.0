From: Ryan <ryanphilips19@googlemail.com>
Subject: Re: suspend resume query
Date: Wed, 17 Feb 2016 15:07:14 +0530
Message-ID: <CANMsd02oPfRZ4dRRF8R61VtN+h62ROfmNCDK=NohKjYWhOL4Hg@mail.gmail.com>
References: <CANMsd03Y67iVEtUZaWnjywNxVVSvmpQfh72y8uJeqqgP=PrH=g@mail.gmail.com>
	<1455700241.7626.10.camel@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:34231 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756984AbcBQJhP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 17 Feb 2016 04:37:15 -0500
Received: by mail-ig0-f173.google.com with SMTP id g6so53771488igt.1
        for <linux-pm@vger.kernel.org>; Wed, 17 Feb 2016 01:37:15 -0800 (PST)
In-Reply-To: <1455700241.7626.10.camel@suse.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Oliver Neukum <oneukum@suse.com>
Cc: linux-pm@vger.kernel.org

Hi Oliver,

On Wed, Feb 17, 2016 at 2:40 PM, Oliver Neukum <oneukum@suse.com> wrote:
> On Tue, 2016-02-16 at 22:36 +0530, Ryan wrote:
>> Hello,
>>
>> what is the role of bootloaders and bootrom code when system during
>> linux suspend-resume?
>
> Your question is imprecise. I am now assuming you are talking
> about ACPI and S3.
>
> bootloader - none at all. It isn't used.
>
> bootrom - Well, that depends on the vendor.
> The system is suspended in the sense that the CPU is powered
> down by the firmware. The kernel calls an ACPI method. The
> firmware also gets control of the system as a resume from S3
> means a full reset for the CPU and the bootstrap code in the
> firmware runs.
>

I am referring to suspend-resume in ARM platform. The boot sequence is

bootrom
bootloaders
kernel

When system is suspended, I am told that when suspend-resume occurs
it depends on the bootrom/bootloaders during resume. I did not understand why
that should be case. Hence i am asking are there any dependencies between
the bootloaders and the suspend-resume on a arm platform.

Thanks




> I am afraid you need to give more details for a better answer.
>
>         Regards
>                 Oliver
>
>
