From: Andy Lutomirski <luto@kernel.org>
Subject: Re: RFC: WMI Enhancements
Date: Thu, 13 Apr 2017 08:44:28 -0700
Message-ID: <CALCETrWQY28h87_4oPGP=TMj8BEOrtC-+2rr2Q6qKb1H3W07tw@mail.gmail.com>
References: <20170412230854.GA11963@fury> <20170413073228.GB1462@ozzy.nask.waw.pl>
 <CALCETrXkx2QqDtKmajywpvtxqCXzrQ3nuW0aOeY6+Uxa-LOXiQ@mail.gmail.com> <201704131739.57956@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750765AbdDMPox (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 13 Apr 2017 11:44:53 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id A922B203C1
        for <linux-pm@vger.kernel.org>; Thu, 13 Apr 2017 15:44:51 +0000 (UTC)
Received: from mail-ua0-f177.google.com (mail-ua0-f177.google.com [209.85.217.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B42F2203AD
        for <linux-pm@vger.kernel.org>; Thu, 13 Apr 2017 15:44:49 +0000 (UTC)
Received: by mail-ua0-f177.google.com with SMTP id h2so8493559uaa.1
        for <linux-pm@vger.kernel.org>; Thu, 13 Apr 2017 08:44:49 -0700 (PDT)
In-Reply-To: <201704131739.57956@pali>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Andy Lutomirski <luto@kernel.org>, =?UTF-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>, Darren Hart <dvhart@infradead.org>, Rafael Wysocki <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Corentin Chary <corentin.chary@gmail.com>, Mario Limonciello <Mario_Limonciello@dell.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Thu, Apr 13, 2017 at 8:39 AM, Pali Rohár <pali.rohar@gmail.com> wrote:
> On Thursday 13 April 2017 17:32:48 Andy Lutomirski wrote:
>> On Thu, Apr 13, 2017 at 12:32 AM, Michał Kępień <kernel@kempniu.pl>
>> wrote:
>> > What we still need, though, is an open source version of
>> > wmiofck.exe.  I am unaware of anything like that existing and
>> > installing the Windows Driver Kit just to run one command which
>> > spits out a single *.h file is not something I would describe as
>> > convenient (been there).
>>
>> I haven't tried to see whether they do what's needed, but there's
>> OpenWBEM and OpenPegasus.
>>
>> Anyway, if such a tool exists, it would be handy to expose the binary
>> MOF data to userspace so the tool could be used to help get WMI
>> working on new platforms.
>
> In this case, when WMI stay in kernel, MOF data could be exported via
> debugfs? I think there is no need to have them in sysfs stable ABI. As
> above usage (get WMI working on new platforms) looks like for debugging
> purpose.
>

That's a reasonable point.
