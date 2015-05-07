From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC V2] init: support device of major:minor:offset format
Date: Thu, 7 May 2015 09:04:32 +0200
Message-ID: <CAMuHMdWkfQ0rCuya265iD9=sWHxbvvpYYZqiS-aRjixcGtQv1Q@mail.gmail.com>
References: <1430871854-7096-1-git-send-email-yu.c.chen@intel.com>
	<CAMuHMdW1PEksGjE7mcKoN_n7sdLorLgw9uiJDxxp469C4ru-SQ@mail.gmail.com>
	<554AC303.4060007@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:34755 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752970AbbEGHEd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2015 03:04:33 -0400
In-Reply-To: <554AC303.4060007@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Yu Chen <yu.c.chen@intel.com>
Cc: Mike Snitzer <snitzer@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>

On Thu, May 7, 2015 at 3:42 AM, Yu Chen <yu.c.chen@intel.com> wrote:
> On 05/07/2015 12:49 AM, Geert Uytterhoeven wrote:
>>
>> On Wed, May 6, 2015 at 2:24 AM, Chen Yu <yu.c.chen@intel.com> wrote:
>>>
>>> Distribution like Ubuntu uses klibc rather than uswsusp to resume
>>> system from hibernation, which will treat swap partition/file in
>>> the form of major:minor:offset. For example, 8:3:0 represents a
>>> swap partition in klibc, and klibc's resume process in initrd will
>>> finally echo 8:3:0 to /sys/power/resume for manually restoring.
>>> However in current implementation, 8:3:0 will be treated as an invalid
>>
>>
>> Why can't klibc write the same information as uswsusp?
>
> I agree. However it seems that klibc treats all device/file as such
> fixed format when dealing with hibernation, I guess that might be
> easier for it to implement?
>
>> Why should the kernel adapt to a specific piece of userspace?
>>
>>> device format, and it is found that manual resumming from hibernation
>>> will fail on lastest kernel.
>>
>>
>> Is this a regression, perhaps introduced by commit 283e7ad024115571
>> ("init: stricter checking of major:minor root= values")? If that is the
>> case,
>> please say so.
>>
> yes, it is. I think there's a modified patch for it at:
>
> https://git.kernel.org/cgit/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=for-next&id=cb31ef485dd4c6a205d1064b42027f82076d00c8

OK, thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
