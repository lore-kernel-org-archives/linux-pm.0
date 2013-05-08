From: Ilia Mirkin <imirkin@alum.mit.edu>
Subject: Re: 50-second delay when resuming from disk with 3.7.10
Date: Wed, 8 May 2013 16:41:15 -0400
Message-ID: <CAKb7UviDzoBHkdv4ruvbRxWmLGMXUZ-HCd1YQ7513UMH7DtUbQ@mail.gmail.com>
References: <CAKb7UvgV8O_qtOYjz7_mMu-78Q4od_p3G0A_+R44_+LnEXRqUw@mail.gmail.com>
	<CAKb7UvhnbnpbXSZUwc7uiuZkKbWmaT086bgfwTh4AC2mVKY3pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bk0-f41.google.com ([209.85.214.41]:45903 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756467Ab3EHUlR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 May 2013 16:41:17 -0400
Received: by mail-bk0-f41.google.com with SMTP id jc3so1143271bkc.0
        for <linux-pm@vger.kernel.org>; Wed, 08 May 2013 13:41:15 -0700 (PDT)
In-Reply-To: <CAKb7UvhnbnpbXSZUwc7uiuZkKbWmaT086bgfwTh4AC2mVKY3pg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

On Wed, May 8, 2013 at 4:08 PM, Ilia Mirkin <imirkin@alum.mit.edu> wrote:
> On Wed, May 8, 2013 at 4:01 PM, Ilia Mirkin <imirkin@alum.mit.edu> wrote:
>> Hello,
>>
>> I've recently started using swsusp functionality on my laptop
>> (Thinkpad T420s, most recent BIOS - 1.36). I use a custom initrd, (and
>> luks-based encryption), the script does something like decrypt;
>> vgchange -ay; crazy-command-to-find-block-dev > /sys/power/resume.
>> Once that happens, I get switched to a blank tty (but I can Alt-F1 to
>> get back to the original). It then sits there for for about 50 seconds
>> before printing something along the lines of
>>
>> [60.x] freezing user processes
>> restoring image 10%
>> etc
>>
>> which all takes about 5s, at which point the system resumes as
>> expected. I do not see any HD activity (via the LED) during the ~50s
>> until I see the first message about resuming.
>>
>> Glancing at software_resume(), when it's called from resume_store() it
>> will jump to the resuming immediately since resume_store will have set
>> swsusp_resume_device. The only thing that makes sense is that
>> lock_system_sleep() takes 50s to complete... which means that
>> something else is holding the pm_mutex.
>
> Actually that's not it either, because I do see it printing "Starting
> manual resume from disk" fairly immediately...

Ugh, looks like it's when trying to disable the usermode helper. The
print "Preparing processes for restore" happens at the right time, but
the print "Freezing user space processes" happens late. I don't have
any firmware in my initrd -- is that why this is happening? Any way to
defeat this other than making the firmware-wanting things into
modules?

Thanks,

  -ilia
