From: "dbasehore ." <dbasehore@chromium.org>
Subject: Re: [PATCH 0/5] Add suspend-to-idle validation for Intel SoCs
Date: Tue, 7 Jun 2016 17:07:21 -0700
Message-ID: <CAGAzgsqRUBwzk5mkupUqjzB7XWwO5JEWL=ACqCaMrEZ=yxea2Q@mail.gmail.com>
References: <1464842009-21789-1-git-send-email-dbasehore@chromium.org> <20160607074632.GA13858@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f44.google.com ([209.85.213.44]:36350 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbcFHAHX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jun 2016 20:07:23 -0400
Received: by mail-vk0-f44.google.com with SMTP id g67so3665000vkb.3
        for <linux-pm@vger.kernel.org>; Tue, 07 Jun 2016 17:07:22 -0700 (PDT)
In-Reply-To: <20160607074632.GA13858@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>

On Tue, Jun 7, 2016 at 12:46 AM, Pavel Machek <pavel@ucw.cz> wrote:
> On Wed 2016-06-01 21:33:24, dbasehore@chromium.org wrote:
>> From: Derek Basehore <dbasehore@chromium.org>
>>
>> This patch set adds support for catching errors when entering freeze
>> on Intel Skylake SoCs. Support for this can be added to newer SoCs in
>> later patches.
>>
>> Verification is done by waking up the CPU once every X (default 10)
>> seconds to check the residency of S0ix. This can't be verified before
>> attempting to enter S0ix through mwait, so we have to repeatedly
>> verify entry into that state. Successfully entering S0ix is no
>> guarantee that it will be entered on the next attempt, so we have to
>> schedule another check. This has a minimal power impact of <1% of the
>> total system power on our systems.
>
> Dunno. Should this be protected with something like CONFIG_TEST_SLEEP?
> People probably don't want this for production...
>

That depends, if you switch to using suspend to idle instead of
suspend to RAM, would you rather not catch power bugs due to
misconfigured hardware in production?

I agree that it shouldn't be on by default since freeze shouldn't fail
because some IP on the SoC doesn't have firmware loaded (this happens
with i915), but I was just going to leave it off by default instead of
adding yet another config option for a small feature.

> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
