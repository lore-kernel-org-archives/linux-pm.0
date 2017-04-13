From: Andy Lutomirski <luto@kernel.org>
Subject: Re: RFC: WMI Enhancements
Date: Thu, 13 Apr 2017 10:44:26 -0700
Message-ID: <CALCETrXDzGvRe2t4jfz8ZjYsduHmK94Ks3N5qwwRcY_qXE30jQ@mail.gmail.com>
References: <20170412230854.GA11963@fury> <20170413073228.GB1462@ozzy.nask.waw.pl>
 <CALCETrXkx2QqDtKmajywpvtxqCXzrQ3nuW0aOeY6+Uxa-LOXiQ@mail.gmail.com>
 <dffeb42986e84887b2556987925dbf31@ausx13mpc120.AMER.DELL.COM>
 <CALCETrX8W7Zi2NTAm4kJFbW14HVSYanYQ5sGo78FTgitcWfwAw@mail.gmail.com>
 <0d4e6c4562fb4b85ad4c368ae73dbe06@ausx13mpc120.AMER.DELL.COM>
 <20170413170619.GF2064@fury> <b729acdb12d046d3a27c754ff02482d6@ausx13mpc120.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753005AbdDMRov (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 13 Apr 2017 13:44:51 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id A52E6203F3
        for <linux-pm@vger.kernel.org>; Thu, 13 Apr 2017 17:44:48 +0000 (UTC)
Received: from mail-vk0-f44.google.com (mail-vk0-f44.google.com [209.85.213.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93543203DB
        for <linux-pm@vger.kernel.org>; Thu, 13 Apr 2017 17:44:47 +0000 (UTC)
Received: by mail-vk0-f44.google.com with SMTP id z204so31320098vkd.1
        for <linux-pm@vger.kernel.org>; Thu, 13 Apr 2017 10:44:47 -0700 (PDT)
In-Reply-To: <b729acdb12d046d3a27c754ff02482d6@ausx13mpc120.AMER.DELL.COM>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mario.Limonciello@dell.com
Cc: Darren Hart <dvhart@infradead.org>, Andrew Lutomirski <luto@kernel.org>, =?UTF-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, Corentin Chary <corentin.chary@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Thu, Apr 13, 2017 at 10:39 AM,  <Mario.Limonciello@dell.com> wrote:
>> -----Original Message-----
>> From: Darren Hart [mailto:dvhart@infradead.org]
>> Sent: Thursday, April 13, 2017 12:06 PM
>> To: Limonciello, Mario <Mario_Limonciello@Dell.com>
>> Cc: luto@kernel.org; kernel@kempniu.pl; rjw@rjwysocki.net;
>> len.brown@intel.com; pali.rohar@gmail.com; corentin.chary@gmail.com;
>> andriy.shevchenko@linux.intel.com; linux-kernel@vger.kernel.org; platform-
>> driver-x86@vger.kernel.org; linux-pm@vger.kernel.org
>> Subject: Re: RFC: WMI Enhancements
>>

> Well the "most" interesting to me is the SMBIOS calling interface on the
> regular Dell GUID (WMBA IIRC).  That's what is used to manipulate keyboard
> LED timeouts in dell-laptop (although through direct SMI today).
>
> It's also what is used for other SMBIOS calls like changing random BIOS settings
> that shouldn't be generically exposed in sysfs but should be controlled by
> manageability tools.
>
> Example: turning on/off legacy option ROM or changing legacy boot order.
>

IIUC we basically can't expose the SMI--based interface to this entry
point to userspace because of its use of physical addressing.  It is
reasonably safe to expose the WMI version?  (IOW should be expect that
it doesn't enable kernel-mode or SMM code execution?)

TBH, I've occasionally considered writing a driver to expose SMM code
execution on systems with a known reliable exploit :)
