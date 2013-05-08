From: Ilia Mirkin <imirkin@alum.mit.edu>
Subject: 50-second delay when resuming from disk with 3.7.10
Date: Wed, 8 May 2013 16:01:12 -0400
Message-ID: <CAKb7UvgV8O_qtOYjz7_mMu-78Q4od_p3G0A_+R44_+LnEXRqUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bk0-f54.google.com ([209.85.214.54]:39409 "EHLO
	mail-bk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752143Ab3EHUBO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 May 2013 16:01:14 -0400
Received: by mail-bk0-f54.google.com with SMTP id y8so1119318bkt.13
        for <linux-pm@vger.kernel.org>; Wed, 08 May 2013 13:01:12 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Hello,

I've recently started using swsusp functionality on my laptop
(Thinkpad T420s, most recent BIOS - 1.36). I use a custom initrd, (and
luks-based encryption), the script does something like decrypt;
vgchange -ay; crazy-command-to-find-block-dev > /sys/power/resume.
Once that happens, I get switched to a blank tty (but I can Alt-F1 to
get back to the original). It then sits there for for about 50 seconds
before printing something along the lines of

[60.x] freezing user processes
restoring image 10%
etc

which all takes about 5s, at which point the system resumes as
expected. I do not see any HD activity (via the LED) during the ~50s
until I see the first message about resuming.

Glancing at software_resume(), when it's called from resume_store() it
will jump to the resuming immediately since resume_store will have set
swsusp_resume_device. The only thing that makes sense is that
lock_system_sleep() takes 50s to complete... which means that
something else is holding the pm_mutex.

Does this make sense? My next step is to start sticking printk's all
over the place... anything else I should be looking at? I know it's an
old-ish kernel, if this is something that was likely fixed in newer
kernels, please let me know.

Thanks,

  -ilia
